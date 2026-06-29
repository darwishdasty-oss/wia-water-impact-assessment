/// ============================================================================
///  charts.dart - رسوم بيانية بسيطة (CustomPainter)
///  WIA v4.0
/// ============================================================================

import 'package:flutter/material.dart';

/// رسم بياني أفقي (Horizontal Bar)
class HorizontalBar extends StatelessWidget {
  final String label;
  final double value;
  final double maxValue;
  final Color color;
  final String? subtitle;
  final String? unit;

  const HorizontalBar({
    super.key,
    required this.label,
    required this.value,
    required this.maxValue,
    required this.color,
    this.subtitle,
    this.unit,
  });

  @override
  Widget build(BuildContext context) {
    final pct = maxValue > 0 ? (value / maxValue).clamp(0.0, 1.0) : 0.0;
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(child: Text(label, style: const TextStyle(fontWeight: FontWeight.w500, fontSize: 13))),
              Text('${value.toStringAsFixed(1)}${unit ?? ''}',
                  style: TextStyle(color: color, fontWeight: FontWeight.bold, fontSize: 14)),
            ],
          ),
          if (subtitle != null)
            Text(subtitle!, style: const TextStyle(fontSize: 11, color: Colors.black54)),
          const SizedBox(height: 4),
          Stack(
            children: [
              Container(
                height: 16,
                decoration: BoxDecoration(color: Colors.grey[200], borderRadius: BorderRadius.circular(8)),
              ),
              FractionallySizedBox(
                widthFactor: pct,
                child: Container(
                  height: 16,
                  decoration: BoxDecoration(color: color, borderRadius: BorderRadius.circular(8)),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

/// توزيع الفئات (Stacked Bar)
class SeverityDistributionBar extends StatelessWidget {
  final int low;
  final int medium;
  final int high;
  final int critical;

  const SeverityDistributionBar({
    super.key,
    required this.low,
    required this.medium,
    required this.high,
    required this.critical,
  });

  @override
  Widget build(BuildContext context) {
    final total = low + medium + high + critical;
    if (total == 0) {
      return const SizedBox(height: 20, child: Text('لا توجد بيانات'));
    }
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // الشريط
        ClipRRect(
          borderRadius: BorderRadius.circular(6),
          child: Row(
            children: [
              Expanded(flex: low, child: Container(height: 24, color: const Color(0xFF63BE7B))),
              Expanded(flex: medium, child: Container(height: 24, color: const Color(0xFFFFEB84))),
              Expanded(flex: high, child: Container(height: 24, color: const Color(0xFFF8B26B))),
              Expanded(flex: critical, child: Container(height: 24, color: const Color(0xFFF8696B))),
            ],
          ),
        ),
        const SizedBox(height: 8),
        // المفتاح
        Wrap(
          spacing: 12,
          runSpacing: 4,
          children: [
            _legend(const Color(0xFF63BE7B), 'منخفض', low),
            _legend(const Color(0xFFFFEB84), 'متوسط', medium),
            _legend(const Color(0xFFF8B26B), 'مرتفع', high),
            _legend(const Color(0xFFF8696B), 'حرج', critical),
          ],
        ),
      ],
    );
  }

  Widget _legend(Color color, String label, int count) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(width: 12, height: 12, decoration: BoxDecoration(color: color, borderRadius: BorderRadius.circular(2))),
        const SizedBox(width: 4),
        Text('$label ($count)', style: const TextStyle(fontSize: 11)),
      ],
    );
  }
}

/// Pie Chart بسيط
class SimplePieChart extends StatelessWidget {
  final List<({String label, double value, Color color})> segments;

  const SimplePieChart({super.key, required this.segments});

  @override
  Widget build(BuildContext context) {
    final total = segments.fold(0.0, (sum, s) => sum + s.value);
    if (total == 0) return const SizedBox.shrink();

    return Column(
      children: [
        SizedBox(
          width: 160,
          height: 160,
          child: CustomPaint(painter: _PiePainter(segments: segments, total: total)),
        ),
        const SizedBox(height: 12),
        Wrap(
          spacing: 12,
          runSpacing: 4,
          children: segments.map((s) {
            final pct = (s.value / total * 100).toStringAsFixed(1);
            return Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Container(width: 12, height: 12, color: s.color),
                const SizedBox(width: 4),
                Text('${s.label} ($pct%)', style: const TextStyle(fontSize: 11)),
              ],
            );
          }).toList(),
        ),
      ],
    );
  }
}

class _PiePainter extends CustomPainter {
  final List<({String label, double value, Color color})> segments;
  final double total;

  _PiePainter({required this.segments, required this.total});

  @override
  void paint(Canvas canvas, Size size) {
    final center = Offset(size.width / 2, size.height / 2);
    final radius = size.width / 2 - 4;
    double startAngle = -1.5708; // -90°

    for (final seg in segments) {
      final sweep = (seg.value / total) * 6.2832; // 2π
      final paint = Paint()
        ..color = seg.color
        ..style = PaintingStyle.fill;
      canvas.drawArc(Rect.fromCircle(center: center, radius: radius), startAngle, sweep, true, paint);

      // حدود
      final border = Paint()
        ..color = Colors.white
        ..style = PaintingStyle.stroke
        ..strokeWidth = 2;
      canvas.drawArc(Rect.fromCircle(center: center, radius: radius), startAngle, sweep, true, border);

      startAngle += sweep;
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}

/// رسم بياني رادار (للأبعاد الثلاثة)
class RadarChart extends StatelessWidget {
  final double envScore;
  final double socScore;
  final double ecoScore;

  const RadarChart({
    super.key,
    required this.envScore,
    required this.socScore,
    required this.ecoScore,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 220,
      height: 220,
      child: CustomPaint(painter: _RadarPainter(envScore, socScore, ecoScore)),
    );
  }
}

class _RadarPainter extends CustomPainter {
  final double env, soc, eco;

  _RadarPainter(this.env, this.soc, this.eco);

  @override
  void paint(Canvas canvas, Size size) {
    final center = Offset(size.width / 2, size.height / 2);
    final radius = size.width / 2 - 30;

    // شبكة (5 مستويات)
    final gridPaint = Paint()
      ..color = Colors.grey.shade300
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1;

    for (int i = 1; i <= 5; i++) {
      final r = radius * (i / 5);
      canvas.drawCircle(center, r, gridPaint);
    }

    // المحاور (3 محاور: 90°, 210°, 330°)
    final axisPaint = Paint()
      ..color = Colors.grey.shade400
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1;
    for (int i = 0; i < 3; i++) {
      final angle = -1.5708 + i * 2.094; // -90° + i*120°
      final end = Offset(
        center.dx + radius * 0.95 * 1.5 * (i == 0 ? 0 : (i == 1 ? -0.866 : 0.866)),
        center.dy + radius * 0.95 * (i == 0 ? -1.5 : 0.75),
      );
      canvas.drawLine(center, end, axisPaint);
    }

    // المضلع
    final values = [env, soc, eco];
    final path = Path();
    for (int i = 0; i < 3; i++) {
      final v = (values[i] / 100).clamp(0.0, 1.0);
      final angle = -1.5708 + i * 2.094;
      final point = Offset(
        center.dx + radius * v * 1.5 * (i == 0 ? 0 : (i == 1 ? -0.866 : 0.866)),
        center.dy + radius * v * (i == 0 ? -1.5 : 0.75),
      );
      if (i == 0) {
        path.moveTo(point.dx, point.dy);
      } else {
        path.lineTo(point.dx, point.dy);
      }
    }
    path.close();

    final fillPaint = Paint()
      ..color = const Color(0xFF1F4E78).withOpacity(0.3)
      ..style = PaintingStyle.fill;
    final strokePaint = Paint()
      ..color = const Color(0xFF1F4E78)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 2;

    canvas.drawPath(path, fillPaint);
    canvas.drawPath(path, strokePaint);

    // النقاط
    final dotPaint = Paint()..color = const Color(0xFF1F4E78);
    for (int i = 0; i < 3; i++) {
      final v = (values[i] / 100).clamp(0.0, 1.0);
      final point = Offset(
        center.dx + radius * v * 1.5 * (i == 0 ? 0 : (i == 1 ? -0.866 : 0.866)),
        center.dy + radius * v * (i == 0 ? -1.5 : 0.75),
      );
      canvas.drawCircle(point, 4, dotPaint);
    }

    // التسميات
    final tp = TextPainter(textDirection: TextDirection.ltr);
    void drawLabel(String text, Offset pos, {Color color = Colors.black}) {
      tp.text = TextSpan(text: text, style: TextStyle(color: color, fontSize: 12, fontWeight: FontWeight.bold));
      tp.layout();
      tp.paint(canvas, Offset(pos.dx - tp.width / 2, pos.dy - tp.height / 2));
    }
    drawLabel('البيئي', Offset(center.dx, center.dy - radius * 1.5 - 12), color: const Color(0xFF2E7D32));
    drawLabel('الاجتماعي', Offset(center.dx - radius * 0.866 * 1.5 - 20, center.dy + radius * 0.75), color: const Color(0xFF2E75B6));
    drawLabel('الاقتصادي', Offset(center.dx + radius * 0.866 * 1.5 + 20, center.dy + radius * 0.75), color: const Color(0xFFEF6C00));
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}