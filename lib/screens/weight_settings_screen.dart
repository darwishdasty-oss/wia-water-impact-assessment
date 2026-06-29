/// شاشة ضبط الأوزان مع اللغات
import 'package:flutter/material.dart';
import '../i18n/strings.dart';
import '../models/models.dart';

class WeightSettingsScreen extends StatefulWidget {
  final AppLang lang;
  final Dimension env, soc, eco;
  final VoidCallback onUpdate;

  const WeightSettingsScreen({
    super.key,
    required this.lang,
    required this.env,
    required this.soc,
    required this.eco,
    required this.onUpdate,
  });

  @override
  State<WeightSettingsScreen> createState() => _WeightSettingsScreenState();
}

class _WeightSettingsScreenState extends State<WeightSettingsScreen> {
  int _selectedTab = 0;

  @override
  Widget build(BuildContext context) {
    final t = T(widget.lang);
    return Scaffold(
      appBar: AppBar(
        title: Text(t.weightSettings),
        backgroundColor: const Color(0xFFFFA000),
        foregroundColor: Colors.white,
        actions: [
          PopupMenuButton<String>(
            onSelected: (v) {
              if (v == 'equal_global') {
                widget.env.globalWeight = 33.33;
                widget.soc.globalWeight = 33.33;
                widget.eco.globalWeight = 33.33;
                _normalizeGlobals();
              } else if (v == 'default_global') {
                widget.env.globalWeight = 40;
                widget.soc.globalWeight = 30;
                widget.eco.globalWeight = 30;
              } else if (v == 'reset_criteria') {
                _resetCriteriaWeights();
              } else if (v == 'normalize') {
                _normalizeGlobals();
              }
              widget.onUpdate();
              setState(() {});
            },
            itemBuilder: (_) => [
              PopupMenuItem(value: 'default_global', child: Text(t.defaultWeights)),
              PopupMenuItem(value: 'equal_global', child: Text(t.equalWeights)),
              PopupMenuItem(value: 'normalize', child: Text(t.normalizeAll)),
              PopupMenuItem(value: 'reset_criteria', child: Text(t.resetCriteria)),
            ],
          ),
        ],
      ),
      body: Column(
        children: [
          Row(
            children: [
              _tabBtn(t.envDim, widget.env, const Color(0xFF2E7D32), 0),
              _tabBtn(t.socDim, widget.soc, const Color(0xFF2E75B6), 1),
              _tabBtn(t.ecoDim, widget.eco, const Color(0xFFEF6C00), 2),
            ],
          ),
          const Divider(height: 1),
          Expanded(child: _buildTab(t)),
        ],
      ),
    );
  }

  Widget _tabBtn(String label, Dimension dim, Color color, int idx) {
    final selected = _selectedTab == idx;
    return Expanded(
      child: InkWell(
        onTap: () => setState(() => _selectedTab = idx),
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 12),
          decoration: BoxDecoration(
            color: selected ? color.withOpacity(0.15) : Colors.transparent,
            border: Border(bottom: BorderSide(color: selected ? color : Colors.transparent, width: 3)),
          ),
          child: Column(
            children: [
              Text(label, style: TextStyle(color: color, fontWeight: selected ? FontWeight.bold : FontWeight.normal)),
              Text('${dim.globalWeight.toStringAsFixed(1)}%',
                  style: TextStyle(fontSize: 11, color: color)),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildTab(T t) {
    Dimension dim;
    Color color;
    if (_selectedTab == 0) { dim = widget.env; color = const Color(0xFF2E7D32); }
    else if (_selectedTab == 1) { dim = widget.soc; color = const Color(0xFF2E75B6); }
    else { dim = widget.eco; color = const Color(0xFFEF6C00); }

    final totalW = dim.criteria.fold(0.0, (s, c) => s + c.weight);

    return ListView(
      padding: const EdgeInsets.all(16),
      children: [
        Card(
          color: color.withOpacity(0.1),
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(t.dimWeight, style: TextStyle(fontWeight: FontWeight.bold, color: color, fontSize: 14)),
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                      decoration: BoxDecoration(color: color, borderRadius: BorderRadius.circular(8)),
                      child: Text('${dim.globalWeight.toStringAsFixed(1)}%',
                          style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 16)),
                    ),
                  ],
                ),
                const SizedBox(height: 8),
                SliderTheme(
                  data: SliderTheme.of(context).copyWith(activeTrackColor: color, thumbColor: color),
                  child: Slider(
                    value: dim.globalWeight, min: 0, max: 100, divisions: 100,
                    label: '${dim.globalWeight.toStringAsFixed(0)}%',
                    onChanged: (v) {
                      setState(() => dim.globalWeight = v);
                      widget.onUpdate();
                    },
                  ),
                ),
              ],
            ),
          ),
        ),

        const SizedBox(height: 16),
        Text(t.criteriaWeights, style: const TextStyle(fontSize: 14, fontWeight: FontWeight.bold)),
        const SizedBox(height: 4),
        Row(
          children: [
            Expanded(
              child: Text('${t.total}: ${totalW.toStringAsFixed(1)}%',
                  style: TextStyle(fontSize: 12, color: (totalW - 100).abs() < 0.5 ? const Color(0xFF63BE7B) : const Color(0xFFF8696B), fontWeight: FontWeight.bold)),
            ),
            TextButton.icon(
              icon: const Icon(Icons.balance, size: 14),
              label: Text(t.normalize, style: const TextStyle(fontSize: 12)),
              onPressed: () { _normalizeCriteria(dim); widget.onUpdate(); setState(() {}); },
            ),
            TextButton.icon(
              icon: const Icon(Icons.refresh, size: 14),
              label: Text(t.equal, style: const TextStyle(fontSize: 12)),
              onPressed: () { _equalizeCriteria(dim); widget.onUpdate(); setState(() {}); },
            ),
          ],
        ),
        const SizedBox(height: 8),
        ...dim.criteria.map((c) => _criterionWeightCard(c, color)),
      ],
    );
  }

  Widget _criterionWeightCard(Criterion c, Color color) {
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 4),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                  decoration: BoxDecoration(color: color, borderRadius: BorderRadius.circular(4)),
                  child: Text(c.code, style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 10)),
                ),
                const SizedBox(width: 8),
                Expanded(child: Text(c.name, style: const TextStyle(fontSize: 13))),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                  decoration: BoxDecoration(color: Colors.grey[200], borderRadius: BorderRadius.circular(6)),
                  child: Text('${c.weight.toStringAsFixed(1)}%',
                      style: TextStyle(color: color, fontWeight: FontWeight.bold, fontSize: 12)),
                ),
              ],
            ),
            SliderTheme(
              data: SliderTheme.of(context).copyWith(activeTrackColor: color, thumbColor: color),
              child: Slider(
                value: c.weight, min: 0, max: 100, divisions: 100,
                onChanged: (v) { setState(() => c.weight = v); widget.onUpdate(); },
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _normalizeGlobals() {
    final total = widget.env.globalWeight + widget.soc.globalWeight + widget.eco.globalWeight;
    if (total > 0) {
      widget.env.globalWeight = widget.env.globalWeight / total * 100;
      widget.soc.globalWeight = widget.soc.globalWeight / total * 100;
      widget.eco.globalWeight = widget.eco.globalWeight / total * 100;
    }
  }

  void _normalizeCriteria(Dimension dim) {
    final total = dim.criteria.fold(0.0, (s, c) => s + c.weight);
    if (total > 0) for (final c in dim.criteria) c.weight = c.weight / total * 100;
  }

  void _equalizeCriteria(Dimension dim) {
    final w = 100.0 / dim.criteria.length;
    for (final c in dim.criteria) c.weight = w;
  }

  void _resetCriteriaWeights() {
    _equalizeCriteria(widget.env);
    _equalizeCriteria(widget.soc);
    _equalizeCriteria(widget.eco);
  }
}