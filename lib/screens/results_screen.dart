/// شاشة النتائج مع اللغات
import 'package:flutter/material.dart';
import '../i18n/strings.dart';
import '../models/models.dart';
import '../widgets/charts.dart';
import '../data/criteria_data.dart';

class ResultsScreen extends StatelessWidget {
  final AppLang lang;
  final ProjectInfo projectInfo;
  final Dimension env, soc, eco;
  final double composite;
  final VoidCallback onEnvTap;
  final VoidCallback onSocTap;
  final VoidCallback onEcoTap;
  final VoidCallback onWeightsTap;
  final VoidCallback onLangToggle;

  const ResultsScreen({
    super.key,
    required this.lang,
    required this.projectInfo,
    required this.env, required this.soc, required this.eco,
    required this.composite,
    required this.onEnvTap,
    required this.onSocTap,
    required this.onEcoTap,
    required this.onWeightsTap,
    required this.onLangToggle,
  });

  @override
  Widget build(BuildContext context) {
    final t = T(lang);
    return Scaffold(
      appBar: AppBar(
        title: Text(t.resultsTitle),
        backgroundColor: const Color(0xFF1F4E78),
        foregroundColor: Colors.white,
        actions: [
          IconButton(
            icon: Text(t.switchLang, style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
            onPressed: onLangToggle,
          ),
          IconButton(icon: const Icon(Icons.tune), onPressed: onWeightsTap, tooltip: t.adjustWeights),
        ],
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          _compositeCard(t),
          const SizedBox(height: 16),

          Card(
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                children: [
                  Text(t.radarChart, style: const TextStyle(fontSize: 14, fontWeight: FontWeight.bold)),
                  const SizedBox(height: 8),
                  RadarChart(envScore: env.totalWeighted, socScore: soc.totalWeighted, ecoScore: eco.totalWeighted),
                ],
              ),
            ),
          ),
          const SizedBox(height: 16),

          Card(
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                children: [
                  Text(t.weightPie, style: const TextStyle(fontSize: 14, fontWeight: FontWeight.bold)),
                  const SizedBox(height: 12),
                  SimplePieChart(segments: [
                    (label: 'ENV', value: env.globalWeight, color: const Color(0xFF2E7D32)),
                    (label: 'SOC', value: soc.globalWeight, color: const Color(0xFF2E75B6)),
                    (label: 'ECO', value: eco.globalWeight, color: const Color(0xFFEF6C00)),
                  ]),
                ],
              ),
            ),
          ),
          const SizedBox(height: 16),

          Text(t.dimensionDetails, style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
          const SizedBox(height: 8),
          _dimBar(t.envDim, env.totalWeighted, env.globalWeight, const Color(0xFF2E7D32), Icons.eco, onEnvTap),
          const SizedBox(height: 8),
          _dimBar(t.socDim, soc.totalWeighted, soc.globalWeight, const Color(0xFF2E75B6), Icons.people, onSocTap),
          const SizedBox(height: 8),
          _dimBar(t.ecoDim, eco.totalWeighted, eco.globalWeight, const Color(0xFFEF6C00), Icons.attach_money, onEcoTap),

          const SizedBox(height: 16),

          Text(t.severityByDim, style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
          const SizedBox(height: 8),
          _distCard(t.envDim, env.severityDistribution),
          const SizedBox(height: 8),
          _distCard(t.socDim, soc.severityDistribution),
          const SizedBox(height: 8),
          _distCard(t.ecoDim, eco.severityDistribution),

          const SizedBox(height: 16),

          Text(t.top10, style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
          const SizedBox(height: 8),
          _top10(),

          const SizedBox(height: 16),

          _criticalRecommendations(t),
        ],
      ),
    );
  }

  Widget _compositeCard(T t) {
    return Card(
      color: Color(scoreColorArgb(composite)),
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            Text(t.compositeIndex, style: const TextStyle(color: Colors.white, fontSize: 14)),
            const SizedBox(height: 8),
            Text(composite.toStringAsFixed(2),
                style: const TextStyle(color: Colors.white, fontSize: 56, fontWeight: FontWeight.bold)),
            const SizedBox(height: 4),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
              decoration: BoxDecoration(color: Colors.white.withOpacity(0.3), borderRadius: BorderRadius.circular(16)),
              child: Text(_category(t, composite),
                  style: const TextStyle(color: Colors.white, fontSize: 20, fontWeight: FontWeight.bold)),
            ),
            const SizedBox(height: 8),
            Text(
              '= (${env.totalWeighted.toStringAsFixed(1)} × ${env.globalWeight.toStringAsFixed(0)}% + '
              '${soc.totalWeighted.toStringAsFixed(1)} × ${soc.globalWeight.toStringAsFixed(0)}% + '
              '${eco.totalWeighted.toStringAsFixed(1)} × ${eco.globalWeight.toStringAsFixed(0)}%) / 100',
              style: const TextStyle(color: Colors.white70, fontSize: 10, fontFamily: 'monospace'),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }

  Widget _dimBar(String title, double score, double weight, Color color, IconData icon, VoidCallback onTap) {
    return Card(
      child: InkWell(
        onTap: onTap,
        child: Padding(
          padding: const EdgeInsets.all(12),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      Icon(icon, color: color),
                      const SizedBox(width: 8),
                      Text(title, style: const TextStyle(fontSize: 14, fontWeight: FontWeight.bold)),
                    ],
                  ),
                  Text('${score.toStringAsFixed(2)} (W: ${weight.toStringAsFixed(0)}%)',
                      style: const TextStyle(fontSize: 11, color: Colors.black54)),
                ],
              ),
              const SizedBox(height: 8),
              HorizontalBar(label: '', value: score, maxValue: 100, color: color),
              const SizedBox(height: 4),
              Align(
                alignment: Alignment.centerLeft,
                child: Text(_category(T(lang), score),
                    style: TextStyle(color: color, fontSize: 12, fontWeight: FontWeight.bold)),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _distCard(String title, Map<String, int> dist) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(title, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 13)),
            const SizedBox(height: 8),
            SeverityDistributionBar(
              low: dist['منخفض'] ?? 0,
              medium: dist['متوسط'] ?? 0,
              high: dist['مرتفع'] ?? 0,
              critical: dist['حرج'] ?? 0,
            ),
          ],
        ),
      ),
    );
  }

  Widget _top10() {
    final all = <Criterion>[];
    all.addAll(env.criteria);
    all.addAll(soc.criteria);
    all.addAll(eco.criteria);
    all.sort((a, b) => b.weightedScore.compareTo(a.weightedScore));

    return Card(
      child: Column(
        children: [
          for (int i = 0; i < (all.length > 10 ? 10 : all.length); i++)
            ListTile(
              dense: true,
              leading: CircleAvatar(
                backgroundColor: Color(scoreColorArgb(all[i].rawScore)),
                radius: 14,
                child: Text('${i + 1}', style: const TextStyle(color: Colors.white, fontSize: 11, fontWeight: FontWeight.bold)),
              ),
              title: Text(all[i].name, style: const TextStyle(fontSize: 13)),
              subtitle: Text('${all[i].code} • ${all[i].dimension} • W: ${all[i].weight.toStringAsFixed(1)}%',
                  style: const TextStyle(fontSize: 10)),
              trailing: Text(all[i].weightedScore.toStringAsFixed(2),
                  style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 14)),
            ),
        ],
      ),
    );
  }

  Widget _criticalRecommendations(T t) {
    final all = <Criterion>[];
    all.addAll(env.criteria);
    all.addAll(soc.criteria);
    all.addAll(eco.criteria);
    final critical = all.where((c) => c.category == 'حرج' || c.category == 'مرتفع').toList();
    critical.sort((a, b) => b.rawScore.compareTo(a.rawScore));

    return Card(
      color: const Color(0xFFFFF3F0),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                const Icon(Icons.warning_amber, color: Color(0xFFF8696B)),
                const SizedBox(width: 8),
                Text(t.criticalRecs, style: const TextStyle(fontSize: 14, fontWeight: FontWeight.bold, color: Color(0xFFF8696B))),
              ],
            ),
            const SizedBox(height: 8),
            if (critical.isEmpty)
              Padding(
                padding: const EdgeInsets.all(8),
                child: Text(t.noCritical, style: const TextStyle(color: Color(0xFF63BE7B))),
              )
            else
              ...critical.map((c) {
                final recs = generateRecommendations(c);
                final rec = recs[0];
                return Card(
                  color: Colors.white,
                  child: ExpansionTile(
                    leading: CircleAvatar(
                      backgroundColor: Color(scoreColorArgb(c.rawScore)),
                      child: Text(c.rawScore.toStringAsFixed(0),
                          style: const TextStyle(color: Colors.white, fontSize: 11)),
                    ),
                    title: Text('${c.code} - ${c.name}', style: const TextStyle(fontSize: 13, fontWeight: FontWeight.bold)),
                    subtitle: Text('${rec.priority} • ${rec.timeline}', style: const TextStyle(fontSize: 10)),
                    childrenPadding: const EdgeInsets.all(8),
                    children: [
                      _miniRow(t.action, rec.action),
                      _miniRow(t.reference, rec.reference),
                    ],
                  ),
                );
              }),
          ],
        ),
      ),
    );
  }

  Widget _miniRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 2),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('$label:', style: const TextStyle(fontSize: 11, fontWeight: FontWeight.bold)),
          Text(value, style: const TextStyle(fontSize: 11)),
        ],
      ),
    );
  }

  String _category(T t, double score) {
    if (score <= 25) return t.catLow;
    if (score <= 50) return t.catMedium;
    if (score <= 75) return t.catHigh;
    return t.catCritical;
  }
}