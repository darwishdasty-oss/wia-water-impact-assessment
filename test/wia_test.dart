// Unit tests for the WIA assessment engine: criteria catalogue integrity,
// Leopold-matrix scoring arithmetic, weight normalisation, dimension
// aggregation, the composite index, severity classification, and the
// recommendation tiers.
import 'package:flutter_test/flutter_test.dart';
import 'package:wia_water_impact_assessment/data/criteria_data.dart';
import 'package:wia_water_impact_assessment/models/models.dart';

void main() {
  group('criteria catalogue', () {
    test('contains 38 criteria across three dimensions', () {
      final env = buildEnv(), soc = buildSoc(), eco = buildEco();
      expect(env.criteria, hasLength(14));
      expect(soc.criteria, hasLength(12));
      expect(eco.criteria, hasLength(12));
      expect(env.criteria.length + soc.criteria.length + eco.criteria.length, 38);
    });

    test('criterion codes are unique and well-formed', () {
      final env = buildEnv(), soc = buildSoc(), eco = buildEco();
      final codes =
          [...env.criteria, ...soc.criteria, ...eco.criteria].map((c) => c.code).toList();
      expect(codes.toSet(), hasLength(38));
      expect(codes.where((c) => c.startsWith('E')), hasLength(14));
      expect(codes.where((c) => c.startsWith('S')), hasLength(12));
      expect(codes.where((c) => c.startsWith('C')), hasLength(12));
    });

    test('global dimension weights default to 40 / 30 / 30', () {
      expect(buildEnv().globalWeight, 40);
      expect(buildSoc().globalWeight, 30);
      expect(buildEco().globalWeight, 30);
    });

    test('within-dimension weights are normalised to 100', () {
      for (final dim in [buildEnv(), buildSoc(), buildEco()]) {
        final sum = dim.criteria.map((c) => c.weight).reduce((a, b) => a + b);
        expect(sum, closeTo(100, 1e-9));
      }
    });

    test('every criterion has a non-empty name and description', () {
      final all = [...buildEnv().criteria, ...buildSoc().criteria, ...buildEco().criteria];
      for (final c in all) {
        expect(c.name.trim(), isNotEmpty, reason: 'name of ${c.code}');
        expect(c.description.trim(), isNotEmpty, reason: 'description of ${c.code}');
      }
    });
  });

  group('Leopold matrix scoring', () {
    Criterion make({
      double importance = 3,
      double magnitude = 5,
      double extent = 3,
      double duration = 3,
      double reversibility = 3,
      double weight = 0,
    }) {
      return Criterion(
        code: 'T01',
        name: 'test',
        description: 'test',
        dimension: 'ENV',
        importance: importance,
        magnitude: magnitude,
        extent: extent,
        duration: duration,
        reversibility: reversibility,
        weight: weight,
      );
    }

    test('rawScore follows (I/5)(M/10)((E+D+R)/15)*100', () {
      expect(
        make(importance: 5, magnitude: 10, extent: 5, duration: 5, reversibility: 5).rawScore,
        closeTo(100, 1e-9),
      );
      expect(make().rawScore, closeTo(18, 1e-9));
    });

    test('rawScore is zero for non-positive importance or magnitude', () {
      expect(make(importance: 0).rawScore, 0);
      expect(make(magnitude: 0).rawScore, 0);
      expect(make(importance: -1, magnitude: 10).rawScore, 0);
    });

    test('weightedScore applies the within-dimension weight', () {
      final c = make(
          importance: 5, magnitude: 10, extent: 5, duration: 5, reversibility: 5, weight: 25);
      expect(c.weightedScore, closeTo(25, 1e-9));
    });

    test('severity thresholds and categories', () {
      expect(scoreCategory(0), 'منخفض');
      expect(scoreCategory(25), 'منخفض');
      expect(scoreCategory(25.01), 'متوسط');
      expect(scoreCategory(50), 'متوسط');
      expect(scoreCategory(75), 'مرتفع');
      expect(scoreCategory(75.01), 'حرج');
      expect(
        make(importance: 5, magnitude: 10, extent: 5, duration: 5, reversibility: 5).category,
        'حرج',
      );
    });
  });

  group('dimension aggregation', () {
    test('default catalogue scores 18 per dimension', () {
      expect(buildEnv().totalWeighted, closeTo(18, 1e-9));
      expect(buildSoc().totalWeighted, closeTo(18, 1e-9));
      expect(buildEco().totalWeighted, closeTo(18, 1e-9));
    });

    test('severity distribution counts every criterion', () {
      final dist = buildEnv().severityDistribution;
      expect(dist.values.reduce((a, b) => a + b), 14);
      expect(dist['منخفض'], 14);
    });
  });

  group('composite index', () {
    test('combines dimensions with 40 / 30 / 30 global weights', () {
      final idx = compositeIndex(buildEnv(), buildSoc(), buildEco());
      expect(idx, closeTo(18, 1e-9));
    });

    test('increases when a criterion is amplified', () {
      final baseline = compositeIndex(buildEnv(), buildSoc(), buildEco());
      final env = buildEnv();
      env.criteria.first.importance = 5;
      env.criteria.first.magnitude = 10;
      env.criteria.first.extent = 5;
      env.criteria.first.duration = 5;
      env.criteria.first.reversibility = 5;
      expect(compositeIndex(env, buildSoc(), buildEco()), greaterThan(baseline));
    });
  });

  group('recommendations', () {
    test('critical impacts trigger the highest tier', () {
      final c = Criterion(
        code: 'E01',
        name: 'surface water quality',
        description: 'test',
        dimension: 'ENV',
        importance: 5,
        magnitude: 10,
        extent: 5,
        duration: 5,
        reversibility: 5,
      );
      final rec = generateRecommendations(c).single;
      expect(rec.priority, 'حرجة');
      expect(rec.reference, 'WB EHS Guidelines for Water and Sanitation');
    });

    test('negligible impacts trigger the lowest tier', () {
      final c = Criterion(
        code: 'C11',
        name: 'financial sustainability',
        description: 'test',
        dimension: 'ECO',
        importance: 1,
        magnitude: 1,
        extent: 1,
        duration: 1,
        reversibility: 1,
      );
      final rec = generateRecommendations(c).single;
      expect(rec.priority, 'تحسينية');
      expect(rec.reference, 'WB PPP Framework');
    });

    test('every criterion maps to a specific action and reference', () {
      final all = [...buildEnv().criteria, ...buildSoc().criteria, ...buildEco().criteria];
      for (final c in all) {
        final rec = generateRecommendations(c).single;
        expect(rec.action.trim(), isNotEmpty, reason: 'action for ${c.code}');
        expect(rec.reference.trim(), isNotEmpty, reason: 'reference for ${c.code}');
        expect(rec.severity.trim(), isNotEmpty, reason: 'severity for ${c.code}');
      }
    });
  });

  group('presentation helpers', () {
    test('score colours follow the severity scale', () {
      expect(scoreColorArgb(10), 0xFF63BE7B);
      expect(scoreColorArgb(40), 0xFFFFEB84);
      expect(scoreColorArgb(65), 0xFFF8B26B);
      expect(scoreColorArgb(90), 0xFFF8696B);
    });

    test('facility data expose sensible financial defaults', () {
      final f = FacilityData();
      expect(f.projectLifeYears, 50);
      expect(f.discountRatePct, 8);
      expect(f.energyPriceUsdKwh, 0.07);
      expect(f.waterPriceUsdM3, 0.5);
    });
  });
}
