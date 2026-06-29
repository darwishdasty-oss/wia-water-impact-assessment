/// شاشة "حول التطبيق" - مع محرر التطبيق
import 'package:flutter/material.dart';
import '../i18n/strings.dart';

class AboutScreen extends StatelessWidget {
  final AppLang lang;
  final VoidCallback onLangToggle;

  const AboutScreen({super.key, required this.lang, required this.onLangToggle});

  @override
  Widget build(BuildContext context) {
    final t = T(lang);
    return Scaffold(
      appBar: AppBar(
        title: Text(t.navAbout),
        backgroundColor: const Color(0xFF6D4C41),
        foregroundColor: Colors.white,
        actions: [
          IconButton(
            icon: Text(t.switchLang, style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
            onPressed: onLangToggle,
          ),
        ],
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          Card(
            child: Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                children: [
                  const Icon(Icons.water_drop, size: 64, color: Color(0xFF1F4E78)),
                  const SizedBox(height: 12),
                  const Text('WIA', style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold)),
                  Text(t.appSubtitle, style: const TextStyle(fontSize: 14, color: Colors.black54)),
                  const SizedBox(height: 4),
                  Text(t.version, style: const TextStyle(fontSize: 12, color: Colors.black45)),
                ],
              ),
            ),
          ),

          const SizedBox(height: 16),

          // بطاقة محرر التطبيق
          Card(
            color: const Color(0xFFE3F2FD),
            elevation: 4,
            child: Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                children: [
                  Row(
                    children: [
                      Container(
                        padding: const EdgeInsets.all(12),
                        decoration: BoxDecoration(
                          color: const Color(0xFF1565C0),
                          borderRadius: BorderRadius.circular(50),
                        ),
                        child: const Icon(Icons.person, color: Colors.white, size: 28),
                      ),
                      const SizedBox(width: 16),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(t.editor,
                                style: const TextStyle(fontSize: 12, color: Color(0xFF1565C0))),
                            const SizedBox(height: 4),
                            const Text(
                              'Dr. Abbas Ahmad Hebah',
                              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Color(0xFF0D47A1)),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),

          const SizedBox(height: 16),

          _section(t.features,
            lang == AppLang.arabic
              ? '• 38 معيار تقييمي (14 بيئي + 12 اجتماعي + 12 اقتصادي)\n'
                '• بيانات المشروع والمنشأة الكاملة\n'
                '• ضبط أوزان الأبعاد والمعايير\n'
                '• نتائج تلقائية مع Leopold Matrix\n'
                '• رسوم بيانية (رادار + Pie + أعمدة)\n'
                '• توصيات تلقائية للمعايير الحرجة\n'
                '• دعم اللغة العربية والإنجليزية\n'
                '• 4 شاشات تفاعلية'
              : '• 38 criteria (14 ENV + 12 SOC + 12 ECO)\n'
                '• Full project & facility data entry\n'
                '• Adjustable weights for dimensions & criteria\n'
                '• Auto Leopold Matrix calculation\n'
                '• Charts: Radar + Pie + Horizontal Bars\n'
                '• Auto recommendations for critical criteria\n'
                '• Arabic & English language support\n'
                '• 4 interactive screens'),

          _section(t.methodology,
            lang == AppLang.arabic
              ? 'مصفوفة Leopold المعدّلة:\nScore = (I/5) × (M/10) × ((E+D+R)/15) × 100\n'
                'التصنيفات:\n'
                '• منخفض (0-25)  • متوسط (26-50)\n'
                '• مرتفع (51-75) • حرج (>75)'
              : 'Modified Leopold Matrix:\nScore = (I/5) × (M/10) × ((E+D+R)/15) × 100\n'
                'Categories:\n'
                '• Low (0-25)    • Medium (26-50)\n'
                '• High (51-75)  • Critical (>75)'),

          _section(t.references,
            '• World Bank ESF (2017)\n'
            '• IFC Performance Standards (2012)\n'
            '• EU EIA Directive 2014/52/EU\n'
            '• FAO Environmental Assessment Guidelines\n'
            '• ICOLD World Register of Dams\n'
            '• Leopold et al. (1971) USGS Circular 645\n'
            '• IUCN Red List of Threatened Species'),

          _section(t.license,
            lang == AppLang.arabic
              ? '© 2025 WIA Project\nللاستخدام التعليمي والمهني\n\nتحرير: د.عباس احمد هبه'
              : '© 2025 WIA Project\nFor educational & professional use\n\nEditor: Dr. Abbas Ahmad Hebah'),
        ],
      ),
    );
  }

  Widget _section(String title, String content) {
    return Card(
      margin: const EdgeInsets.only(bottom: 12),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(title, style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Color(0xFF1F4E78))),
            const SizedBox(height: 8),
            Text(content, style: const TextStyle(fontSize: 13, height: 1.5)),
          ],
        ),
      ),
    );
  }
}