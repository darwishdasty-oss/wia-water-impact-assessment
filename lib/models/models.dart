/// ============================================================================
///  models.dart - نماذج البيانات الشاملة
///  WIA - Water Impact Assessment v1.0.0
/// ============================================================================

class Criterion {
  String code;
  String name;
  String description;
  String dimension; // ENV / SOC / ECO

  // Leopold Matrix
  double importance;     // 1-5
  double magnitude;       // 0-10
  double extent;          // 1-5
  double duration;        // 1-5
  double reversibility;   // 1-5

  // الوزن داخل البُعد (0-100)
  double weight;

  Criterion({
    required this.code,
    required this.name,
    required this.description,
    required this.dimension,
    this.importance = 3,
    this.magnitude = 5,
    this.extent = 3,
    this.duration = 3,
    this.reversibility = 3,
    this.weight = 0,
  });

  /// Leopold Matrix: Score = (I/5) × (M/10) × ((E+D+R)/15) × 100
  double get rawScore {
    if (importance <= 0 || magnitude <= 0) return 0;
    return (importance / 5) * (magnitude / 10) *
        ((extent + duration + reversibility) / 15) * 100;
  }

  /// النتيجة المرجّحة
  double get weightedScore => rawScore * weight / 100;

  String get category {
    final s = rawScore;
    if (s <= 25) return 'منخفض';
    if (s <= 50) return 'متوسط';
    if (s <= 75) return 'مرتفع';
    return 'حرج';
  }
}

class Dimension {
  String code;          // ENV / SOC / ECO
  String nameAr;
  String nameEn;
  List<Criterion> criteria;
  double globalWeight;  // 0-100, default: ENV=40, SOC=30, ECO=30

  Dimension({
    required this.code,
    required this.nameAr,
    required this.nameEn,
    required this.criteria,
    this.globalWeight = 33.33,
  });

  /// مجموع الأوزان المرجّحة داخل البُعد
  double get totalWeighted {
    double sum = 0;
    for (final c in criteria) {
      sum += c.weightedScore;
    }
    return sum;
  }

  String get category {
    final s = totalWeighted;
    if (s <= 25) return 'منخفض';
    if (s <= 50) return 'متوسط';
    if (s <= 75) return 'مرتفع';
    return 'حرج';
  }

  /// توزيع الشدة
  Map<String, int> get severityDistribution {
    final dist = {'منخفض': 0, 'متوسط': 0, 'مرتفع': 0, 'حرج': 0};
    for (final c in criteria) {
      dist[c.category] = (dist[c.category] ?? 0) + 1;
    }
    return dist;
  }
}

/// بيانات المشروع
class ProjectInfo {
  String name;
  String facilityType;
  String location;
  String owner;
  String consultant;
  String manager;
  String startDate;
  String issueDate;
  String version;

  ProjectInfo({
    this.name = '',
    this.facilityType = '',
    this.location = '',
    this.owner = '',
    this.consultant = '',
    this.manager = '',
    this.startDate = '',
    this.issueDate = '',
    this.version = '1.0',
  });
}

/// بيانات المنشأة الفنية (البيانات الخام)
class FacilityData {
  String primaryUse;
  double storageCapacityM3;
  double canalLengthKm;
  double pipeDiameterMm;
  double installedCapacityMw;
  double designDischargeM3s;
  double catchmentAreaKm2;
  double operatingLevelM;
  double damHeightM;
  double damCrestLengthM;
  double affectedAreaHa;
  int displacedPersons;
  double budgetMusd;
  int projectLifeYears;
  double discountRatePct;
  double energyPriceUsdKwh;
  double waterPriceUsdM3;
  int constructionStart;
  int operationStart;

  FacilityData({
    this.primaryUse = '',
    this.storageCapacityM3 = 0,
    this.canalLengthKm = 0,
    this.pipeDiameterMm = 0,
    this.installedCapacityMw = 0,
    this.designDischargeM3s = 0,
    this.catchmentAreaKm2 = 0,
    this.operatingLevelM = 0,
    this.damHeightM = 0,
    this.damCrestLengthM = 0,
    this.affectedAreaHa = 0,
    this.displacedPersons = 0,
    this.budgetMusd = 0,
    this.projectLifeYears = 50,
    this.discountRatePct = 8,
    this.energyPriceUsdKwh = 0.07,
    this.waterPriceUsdM3 = 0.5,
    this.constructionStart = 2025,
    this.operationStart = 2028,
  });
}

/// تصنيف
String scoreCategory(double score) {
  if (score <= 25) return 'منخفض';
  if (score <= 50) return 'متوسط';
  if (score <= 75) return 'مرتفع';
  return 'حرج';
}

int scoreColorArgb(double score) {
  if (score <= 25) return 0xFF63BE7B;
  if (score <= 50) return 0xFFFFEB84;
  if (score <= 75) return 0xFFF8B26B;
  return 0xFFF8696B;
}

/// المؤشر المركّب (ENV 40% + SOC 30% + ECO 30%)
double compositeIndex(Dimension env, Dimension soc, Dimension eco) {
  return env.totalWeighted * env.globalWeight / 100 +
         soc.totalWeighted * soc.globalWeight / 100 +
         eco.totalWeighted * eco.globalWeight / 100;
}