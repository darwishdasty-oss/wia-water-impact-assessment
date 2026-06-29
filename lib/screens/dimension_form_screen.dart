/// شاشة إدخال معايير بُعد (مع اللغات)
import 'package:flutter/material.dart';
import '../i18n/strings.dart';
import '../models/models.dart';
import '../data/criteria_data.dart';

class DimensionFormScreen extends StatefulWidget {
  final AppLang lang;
  final Dimension dimension;
  final Color color;

  const DimensionFormScreen({
    super.key,
    required this.lang,
    required this.dimension,
    required this.color,
  });

  @override
  State<DimensionFormScreen> createState() => _DimensionFormScreenState();
}

class _DimensionFormScreenState extends State<DimensionFormScreen> {
  int _selectedIdx = 0;

  @override
  Widget build(BuildContext context) {
    final t = T(widget.lang);
    final dim = widget.dimension;
    final c = dim.criteria[_selectedIdx];
    final recs = generateRecommendations(c);

    return Scaffold(
      appBar: AppBar(
        title: Text('${t.envDim}${dim.code == "SOC" ? t.socDim : dim.code == "ECO" ? t.ecoDim : t.envDim}'),
        backgroundColor: widget.color,
        foregroundColor: Colors.white,
        actions: [
          IconButton(
            icon: const Icon(Icons.refresh),
            tooltip: t.reset,
            onPressed: () {
              setState(() {
                for (final cr in dim.criteria) {
                  cr.importance = 3; cr.magnitude = 5;
                  cr.extent = 3; cr.duration = 3; cr.reversibility = 3;
                }
              });
            },
          ),
        ],
      ),
      body: Column(
        children: [
          Container(
            padding: const EdgeInsets.all(12),
            color: widget.color.withOpacity(0.1),
            child: Row(
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(t.total, style: TextStyle(fontSize: 11, color: Colors.grey[700])),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          Text(dim.totalWeighted.toStringAsFixed(2),
                              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: widget.color)),
                          const SizedBox(width: 8),
                          Container(
                            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                            decoration: BoxDecoration(
                              color: Color(scoreColorArgb(dim.totalWeighted)),
                              borderRadius: BorderRadius.circular(8),
                            ),
                            child: Text(_category(widget.lang, dim.totalWeighted),
                                style: const TextStyle(color: Colors.white, fontSize: 11, fontWeight: FontWeight.bold)),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                Text('${dim.criteria.length}', style: const TextStyle(fontSize: 12, color: Colors.black54)),
              ],
            ),
          ),

          Expanded(
            child: Row(
              children: [
                Container(
                  width: 80,
                  color: Colors.grey[100],
                  child: ListView.builder(
                    itemCount: dim.criteria.length,
                    itemBuilder: (_, i) {
                      final cc = dim.criteria[i];
                      final selected = i == _selectedIdx;
                      return GestureDetector(
                        onTap: () => setState(() => _selectedIdx = i),
                        child: Container(
                          margin: const EdgeInsets.symmetric(horizontal: 4, vertical: 2),
                          padding: const EdgeInsets.symmetric(vertical: 6, horizontal: 4),
                          decoration: BoxDecoration(
                            color: selected ? widget.color.withOpacity(0.2) : Colors.white,
                            borderRadius: BorderRadius.circular(6),
                            border: Border.all(
                              color: selected ? widget.color : Colors.grey.shade300,
                              width: selected ? 2 : 1,
                            ),
                          ),
                          child: Column(
                            children: [
                              Text(cc.code, style: TextStyle(fontWeight: FontWeight.bold, fontSize: 10, color: widget.color)),
                              const SizedBox(height: 4),
                              Container(
                                width: 28, height: 28,
                                decoration: BoxDecoration(color: Color(scoreColorArgb(cc.rawScore)), shape: BoxShape.circle),
                                child: Center(
                                  child: Text(cc.rawScore.toStringAsFixed(0),
                                      style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 11)),
                                ),
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  ),
                ),

                Expanded(
                  child: ListView(
                    padding: const EdgeInsets.all(12),
                    children: [
                      _criterionHeader(c),
                      const SizedBox(height: 8),
                      _sliderRow(t.importance, c.importance, 1, 5, t.importanceHint, (v) => setState(() => c.importance = v)),
                      _sliderRow(t.magnitude, c.magnitude, 0, 10, t.magnitudeHint, (v) => setState(() => c.magnitude = v)),
                      _sliderRow(t.extent, c.extent, 1, 5, t.extentHint, (v) => setState(() => c.extent = v)),
                      _sliderRow(t.duration, c.duration, 1, 5, t.durationHint, (v) => setState(() => c.duration = v)),
                      _sliderRow(t.reversibility, c.reversibility, 1, 5, t.reversibilityHint, (v) => setState(() => c.reversibility = v)),

                      const SizedBox(height: 12),
                      _scoreCard(c, t),

                      const SizedBox(height: 12),
                      _recommendationCard(recs[0], t),
                    ],
                  ),
                ),
              ],
            ),
          ),

          BottomAppBar(
            color: widget.color.withOpacity(0.1),
            child: TextButton.icon(
              onPressed: () => Navigator.pop(context),
              icon: const Icon(Icons.check_circle, size: 24),
              label: Text(t.saveAndBack, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 14)),
              style: TextButton.styleFrom(foregroundColor: widget.color),
            ),
          ),
        ],
      ),
    );
  }

  Widget _criterionHeader(Criterion c) {
    return Card(
      color: widget.color.withOpacity(0.1),
      child: Padding(
        padding: const EdgeInsets.all(10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 3),
                  decoration: BoxDecoration(color: widget.color, borderRadius: BorderRadius.circular(4)),
                  child: Text(c.code, style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 11)),
                ),
                const SizedBox(width: 8),
                Expanded(child: Text(c.name, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 14))),
              ],
            ),
            const SizedBox(height: 4),
            Text(c.description, style: const TextStyle(fontSize: 12, color: Colors.black87)),
          ],
        ),
      ),
    );
  }

  Widget _sliderRow(String label, double value, double min, double max, String hint,
      ValueChanged<double> onChanged) {
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 4),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(label, style: const TextStyle(fontWeight: FontWeight.w500, fontSize: 12)),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                  decoration: BoxDecoration(color: widget.color, borderRadius: BorderRadius.circular(4)),
                  child: Text(value.toStringAsFixed(0),
                      style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 12)),
                ),
              ],
            ),
            Text(hint, style: const TextStyle(fontSize: 10, color: Colors.black54)),
            SliderTheme(
              data: SliderTheme.of(context).copyWith(
                activeTrackColor: widget.color, thumbColor: widget.color,
                overlayColor: widget.color.withOpacity(0.2),
              ),
              child: Slider(
                value: value, min: min, max: max,
                divisions: (max - min).toInt(),
                onChanged: onChanged,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _scoreCard(Criterion c, T t) {
    return Card(
      color: Color(scoreColorArgb(c.rawScore)).withOpacity(0.3),
      child: Padding(
        padding: const EdgeInsets.all(12),
        child: Column(
          children: [
            Text('${t.score} (Leopold Matrix)', style: const TextStyle(fontSize: 12, fontWeight: FontWeight.bold)),
            const SizedBox(height: 4),
            Text(c.rawScore.toStringAsFixed(2),
                style: TextStyle(fontSize: 32, fontWeight: FontWeight.bold, color: widget.color)),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 3),
              decoration: BoxDecoration(color: Color(scoreColorArgb(c.rawScore)), borderRadius: BorderRadius.circular(10)),
              child: Text(_category(widget.lang, c.rawScore),
                  style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 12)),
            ),
            const SizedBox(height: 6),
            Text(
              '= (${c.importance.toStringAsFixed(0)}/5) × (${c.magnitude.toStringAsFixed(0)}/10) × '
              '(${c.extent.toStringAsFixed(0)}+${c.duration.toStringAsFixed(0)}+${c.reversibility.toStringAsFixed(0)})/15 × 100',
              style: const TextStyle(fontSize: 9, fontFamily: 'monospace'),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }

  Widget _recommendationCard(Recommendation rec, T t) {
    return Card(
      color: const Color(0xFFFFF9E6),
      child: Padding(
        padding: const EdgeInsets.all(12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Icon(Icons.lightbulb, color: _priorityColor(rec.priority), size: 20),
                const SizedBox(width: 8),
                Text(t.recommendations, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 13)),
              ],
            ),
            const SizedBox(height: 8),
            _recRow(t.priority, _translatePriority(rec.priority, t), _priorityColor(rec.priority)),
            _recRow(t.action, rec.action, Colors.black87),
            _recRow(t.timeline, rec.timeline, Colors.black87),
            _recRow(t.reference, rec.reference, const Color(0xFF1F4E78)),
          ],
        ),
      ),
    );
  }

  Widget _recRow(String label, String value, Color color) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 2),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: 90,
            child: Text('$label:', style: TextStyle(fontSize: 11, fontWeight: FontWeight.bold, color: color)),
          ),
          Expanded(child: Text(value, style: const TextStyle(fontSize: 11))),
        ],
      ),
    );
  }

  Color _priorityColor(String priority) {
    switch (priority) {
      case 'حرجة': case 'Critical': return const Color(0xFFF8696B);
      case 'إلزامية': case 'Mandatory': return const Color(0xFFF8B26B);
      case 'مستحسنة': case 'Recommended': return const Color(0xFFFFEB84);
      default: return const Color(0xFF63BE7B);
    }
  }

  String _translatePriority(String p, T t) {
    switch (p) {
      case 'حرجة': return t.priCritical;
      case 'إلزامية': return t.priMandatory;
      case 'مستحسنة': return t.priRecommended;
      default: return t.priOptional;
    }
  }

  String _category(AppLang lang, double score) {
    final t = T(lang);
    if (score <= 25) return t.catLow;
    if (score <= 50) return t.catMedium;
    if (score <= 75) return t.catHigh;
    return t.catCritical;
  }
}