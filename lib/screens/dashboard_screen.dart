/// ============================================================================
///  dashboard_screen.dart - لوحة المعلومات (مع دعم اللغات)
/// ============================================================================

import 'package:flutter/material.dart';
import '../i18n/strings.dart';
import '../models/models.dart';
import '../widgets/charts.dart';

class DashboardScreen extends StatelessWidget {
  final AppLang lang;
  final ProjectInfo projectInfo;
  final FacilityData facility;
  final Dimension env, soc, eco;
  final double composite;
  final VoidCallback onEnvTap;
  final VoidCallback onSocTap;
  final VoidCallback onEcoTap;
  final VoidCallback onInfoTap;
  final VoidCallback onWeightsTap;
  final VoidCallback onResultsTap;
  final VoidCallback onLangToggle;

  const DashboardScreen({
    super.key,
    required this.lang,
    required this.projectInfo,
    required this.facility,
    required this.env, required this.soc, required this.eco,
    required this.composite,
    required this.onEnvTap,
    required this.onSocTap,
    required this.onEcoTap,
    required this.onInfoTap,
    required this.onWeightsTap,
    required this.onResultsTap,
    required this.onLangToggle,
  });

  @override
  Widget build(BuildContext context) {
    final t = T(lang);
    final cat = _category(lang, composite);
    final catColor = Color(_categoryColor(composite));

    return Scaffold(
      appBar: AppBar(
        title: Text(t.dashboard),
        backgroundColor: const Color(0xFF1F4E78),
        foregroundColor: Colors.white,
        actions: [
          IconButton(
            icon: Text(t.switchLang, style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
            onPressed: onLangToggle,
            tooltip: t.language,
          ),
          IconButton(icon: const Icon(Icons.settings), onPressed: onWeightsTap, tooltip: t.adjustWeights),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // بطاقة المشروع
            Card(
              color: const Color(0xFFE8F4FD),
              child: InkWell(
                onTap: onInfoTap,
                child: Padding(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          const Icon(Icons.folder_special, color: Color(0xFF1F4E78), size: 32),
                          const SizedBox(width: 12),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text('Project', style: TextStyle(fontSize: 11, color: Colors.grey[700])),
                                Text(
                                  projectInfo.name.isEmpty ? t.emptyProject : projectInfo.name,
                                  style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Color(0xFF1F4E78)),
                                ),
                              ],
                            ),
                          ),
                          const Icon(Icons.edit, color: Colors.grey),
                        ],
                      ),
                      if (projectInfo.facilityType.isNotEmpty)
                        Padding(
                          padding: const EdgeInsets.only(top: 8),
                          child: Text('${t.facilityType}: ${projectInfo.facilityType}',
                              style: const TextStyle(fontSize: 13)),
                        ),
                      if (projectInfo.location.isNotEmpty)
                        Text('${t.location}: ${projectInfo.location}',
                            style: const TextStyle(fontSize: 13)),
                    ],
                  ),
                ),
              ),
            ),

            const SizedBox(height: 16),

            // المؤشر المركّب
            Card(
              color: catColor,
              child: Padding(
                padding: const EdgeInsets.all(20),
                child: Column(
                  children: [
                    Text(t.compositeIndex,
                        style: const TextStyle(color: Colors.white, fontSize: 14)),
                    const SizedBox(height: 8),
                    Text(composite.toStringAsFixed(2),
                        style: const TextStyle(color: Colors.white, fontSize: 48, fontWeight: FontWeight.bold)),
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 4),
                      decoration: BoxDecoration(
                        color: Colors.white.withOpacity(0.3),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Text(cat, style: const TextStyle(color: Colors.white, fontSize: 16, fontWeight: FontWeight.bold)),
                    ),
                    const SizedBox(height: 8),
                    Text('(40% ENV + 30% SOC + 30% ECO)',
                        style: const TextStyle(color: Colors.white70, fontSize: 11)),
                  ],
                ),
              ),
            ),

            const SizedBox(height: 16),

            // Radar
            Card(
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  children: [
                    Text(t.impactProfile, style: const TextStyle(fontSize: 14, fontWeight: FontWeight.bold)),
                    const SizedBox(height: 8),
                    RadarChart(envScore: env.totalWeighted, socScore: soc.totalWeighted, ecoScore: eco.totalWeighted),
                  ],
                ),
              ),
            ),

            const SizedBox(height: 16),

            Text(t.dimensionsTitle, style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
            const SizedBox(height: 8),

            _dimCard(t.envDim, env.totalWeighted, env.criteria.length,
                Icons.eco, const Color(0xFF2E7D32), onEnvTap),
            const SizedBox(height: 8),

            _dimCard(t.socDim, soc.totalWeighted, soc.criteria.length,
                Icons.people, const Color(0xFF2E75B6), onSocTap),
            const SizedBox(height: 8),

            _dimCard(t.ecoDim, eco.totalWeighted, eco.criteria.length,
                Icons.attach_money, const Color(0xFFEF6C00), onEcoTap),

            const SizedBox(height: 16),

            Text(t.severityDistribution, style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
            const SizedBox(height: 8),
            _distributionCard(t.envDim, env.severityDistribution, lang),
            const SizedBox(height: 8),
            _distributionCard(t.socDim, soc.severityDistribution, lang),
            const SizedBox(height: 8),
            _distributionCard(t.ecoDim, eco.severityDistribution, lang),

            const SizedBox(height: 16),

            Row(
              children: [
                Expanded(
                  child: OutlinedButton.icon(
                    onPressed: onInfoTap,
                    icon: const Icon(Icons.edit),
                    label: Text(t.projectInfo, style: const TextStyle(fontSize: 11)),
                  ),
                ),
                const SizedBox(width: 8),
                Expanded(
                  child: OutlinedButton.icon(
                    onPressed: onWeightsTap,
                    icon: const Icon(Icons.tune),
                    label: Text(t.adjustWeights, style: const TextStyle(fontSize: 11)),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 8),
            ElevatedButton.icon(
              onPressed: onResultsTap,
              icon: const Icon(Icons.analytics),
              label: Text(t.viewResults),
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF1F4E78),
                foregroundColor: Colors.white,
                padding: const EdgeInsets.all(14),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _dimCard(String title, double score, int count, IconData icon, Color color, VoidCallback onTap) {
    return Card(
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(8),
        child: Padding(
          padding: const EdgeInsets.all(12),
          child: Row(
            children: [
              Container(
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(color: color.withOpacity(0.15), borderRadius: BorderRadius.circular(8)),
                child: Icon(icon, color: color, size: 24),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(title, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 15)),
                    Text('$count', style: const TextStyle(fontSize: 11, color: Colors.black54)),
                    const SizedBox(height: 6),
                    Stack(
                      children: [
                        Container(
                          height: 8,
                          decoration: BoxDecoration(color: Colors.grey[200], borderRadius: BorderRadius.circular(4)),
                        ),
                        FractionallySizedBox(
                          widthFactor: (score / 100).clamp(0, 1),
                          child: Container(
                            height: 8,
                            decoration: BoxDecoration(color: color, borderRadius: BorderRadius.circular(4)),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              const SizedBox(width: 8),
              Column(
                children: [
                  Text(score.toStringAsFixed(1), style: TextStyle(color: color, fontSize: 18, fontWeight: FontWeight.bold)),
                  Text(_category(lang, score), style: TextStyle(color: color, fontSize: 10)),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _distributionCard(String title, Map<String, int> dist, AppLang lang) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(title, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 13)),
            const SizedBox(height: 8),
            SeverityDistributionBar(
              low: dist[T(AppLang.arabic).catLow] ?? 0,
              medium: dist[T(AppLang.arabic).catMedium] ?? 0,
              high: dist[T(AppLang.arabic).catHigh] ?? 0,
              critical: dist[T(AppLang.arabic).catCritical] ?? 0,
            ),
          ],
        ),
      ),
    );
  }

  String _category(AppLang lang, double score) {
    final t = T(lang);
    if (score <= 25) return t.catLow;
    if (score <= 50) return t.catMedium;
    if (score <= 75) return t.catHigh;
    return t.catCritical;
  }

  int _categoryColor(double score) {
    if (score <= 25) return 0xFF63BE7B;
    if (score <= 50) return 0xFFFFEB84;
    if (score <= 75) return 0xFFF8B26B;
    return 0xFFF8696B;
  }
}