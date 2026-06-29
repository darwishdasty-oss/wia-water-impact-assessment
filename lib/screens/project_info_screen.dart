/// شاشة بيانات المشروع + اللغات
import 'package:flutter/material.dart';
import '../i18n/strings.dart';
import '../models/models.dart';

class ProjectInfoScreen extends StatefulWidget {
  final AppLang lang;
  final ProjectInfo info;
  final FacilityData facility;
  final VoidCallback onUpdate;

  const ProjectInfoScreen({
    super.key,
    required this.lang,
    required this.info,
    required this.facility,
    required this.onUpdate,
  });

  @override
  State<ProjectInfoScreen> createState() => _ProjectInfoScreenState();
}

class _ProjectInfoScreenState extends State<ProjectInfoScreen> {
  final Map<String, TextEditingController> _ctrls = {};
  bool _editMode = false;

  @override
  void initState() {
    super.initState();
    _initControllers();
  }

  void _initControllers() {
    final f = widget.facility;
    final i = widget.info;
    _ctrls['projectName'] = TextEditingController(text: i.name);
    _ctrls['facilityType'] = TextEditingController(text: i.facilityType);
    _ctrls['location'] = TextEditingController(text: i.location);
    _ctrls['owner'] = TextEditingController(text: i.owner);
    _ctrls['consultant'] = TextEditingController(text: i.consultant);
    _ctrls['manager'] = TextEditingController(text: i.manager);
    _ctrls['startDate'] = TextEditingController(text: i.startDate);
    _ctrls['issueDate'] = TextEditingController(text: i.issueDate);
    _ctrls['version'] = TextEditingController(text: i.version);

    _ctrls['primaryUse'] = TextEditingController(text: f.primaryUse);
    _ctrls['storageCapacity'] = TextEditingController(text: f.storageCapacityM3.toStringAsFixed(0));
    _ctrls['canalLength'] = TextEditingController(text: f.canalLengthKm.toStringAsFixed(1));
    _ctrls['pipeDiameter'] = TextEditingController(text: f.pipeDiameterMm.toStringAsFixed(0));
    _ctrls['installedCapacity'] = TextEditingController(text: f.installedCapacityMw.toStringAsFixed(0));
    _ctrls['designDischarge'] = TextEditingController(text: f.designDischargeM3s.toStringAsFixed(1));
    _ctrls['catchmentArea'] = TextEditingController(text: f.catchmentAreaKm2.toStringAsFixed(1));
    _ctrls['operatingLevel'] = TextEditingController(text: f.operatingLevelM.toStringAsFixed(1));
    _ctrls['damHeight'] = TextEditingController(text: f.damHeightM.toStringAsFixed(1));
    _ctrls['damCrestLength'] = TextEditingController(text: f.damCrestLengthM.toStringAsFixed(0));
    _ctrls['affectedArea'] = TextEditingController(text: f.affectedAreaHa.toStringAsFixed(1));
    _ctrls['displacedPersons'] = TextEditingController(text: f.displacedPersons.toString());
    _ctrls['budget'] = TextEditingController(text: f.budgetMusd.toStringAsFixed(0));
    _ctrls['projectLife'] = TextEditingController(text: f.projectLifeYears.toString());
    _ctrls['discountRate'] = TextEditingController(text: f.discountRatePct.toStringAsFixed(1));
    _ctrls['energyPrice'] = TextEditingController(text: f.energyPriceUsdKwh.toStringAsFixed(3));
    _ctrls['waterPrice'] = TextEditingController(text: f.waterPriceUsdM3.toStringAsFixed(2));
    _ctrls['constructionStart'] = TextEditingController(text: f.constructionStart.toString());
    _ctrls['operationStart'] = TextEditingController(text: f.operationStart.toString());
  }

  @override
  void dispose() {
    for (final c in _ctrls.values) c.dispose();
    super.dispose();
  }

  void _save() {
    final i = widget.info;
    i.name = _ctrls['projectName']!.text;
    i.facilityType = _ctrls['facilityType']!.text;
    i.location = _ctrls['location']!.text;
    i.owner = _ctrls['owner']!.text;
    i.consultant = _ctrls['consultant']!.text;
    i.manager = _ctrls['manager']!.text;
    i.startDate = _ctrls['startDate']!.text;
    i.issueDate = _ctrls['issueDate']!.text;
    i.version = _ctrls['version']!.text;

    final f = widget.facility;
    f.primaryUse = _ctrls['primaryUse']!.text;
    f.storageCapacityM3 = double.tryParse(_ctrls['storageCapacity']!.text) ?? 0;
    f.canalLengthKm = double.tryParse(_ctrls['canalLength']!.text) ?? 0;
    f.pipeDiameterMm = double.tryParse(_ctrls['pipeDiameter']!.text) ?? 0;
    f.installedCapacityMw = double.tryParse(_ctrls['installedCapacity']!.text) ?? 0;
    f.designDischargeM3s = double.tryParse(_ctrls['designDischarge']!.text) ?? 0;
    f.catchmentAreaKm2 = double.tryParse(_ctrls['catchmentArea']!.text) ?? 0;
    f.operatingLevelM = double.tryParse(_ctrls['operatingLevel']!.text) ?? 0;
    f.damHeightM = double.tryParse(_ctrls['damHeight']!.text) ?? 0;
    f.damCrestLengthM = double.tryParse(_ctrls['damCrestLength']!.text) ?? 0;
    f.affectedAreaHa = double.tryParse(_ctrls['affectedArea']!.text) ?? 0;
    f.displacedPersons = int.tryParse(_ctrls['displacedPersons']!.text) ?? 0;
    f.budgetMusd = double.tryParse(_ctrls['budget']!.text) ?? 0;
    f.projectLifeYears = int.tryParse(_ctrls['projectLife']!.text) ?? 50;
    f.discountRatePct = double.tryParse(_ctrls['discountRate']!.text) ?? 8;
    f.energyPriceUsdKwh = double.tryParse(_ctrls['energyPrice']!.text) ?? 0.07;
    f.waterPriceUsdM3 = double.tryParse(_ctrls['waterPrice']!.text) ?? 0.5;
    f.constructionStart = int.tryParse(_ctrls['constructionStart']!.text) ?? 2025;
    f.operationStart = int.tryParse(_ctrls['operationStart']!.text) ?? 2028;

    widget.onUpdate();
    setState(() => _editMode = false);
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(T(widget.lang).saved), duration: const Duration(seconds: 2)),
    );
  }

  @override
  Widget build(BuildContext context) {
    final t = T(widget.lang);
    return Scaffold(
      appBar: AppBar(
        title: Text(t.projectDataTitle),
        backgroundColor: const Color(0xFF6D4C41),
        foregroundColor: Colors.white,
        actions: [
          IconButton(
            icon: Icon(_editMode ? Icons.close : Icons.edit),
            onPressed: () => setState(() => _editMode = !_editMode),
            tooltip: t.edit,
          ),
          if (_editMode) IconButton(icon: const Icon(Icons.save), onPressed: _save, tooltip: t.save),
        ],
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          _sectionHeader(t.projectInfoSection, Icons.folder, const Color(0xFF6D4C41)),
          _field(t.projectName, 'projectName', Icons.title, isText: true),
          _dropdownField(t.facilityType, 'facilityType', Icons.business, const [
            'سد كبير', 'سد متوسط', 'سد صغير', 'سد ركامي',
            'قناة ري رئيسية', 'قناة ري فرعية', 'قناة تصريف',
            'هدار', 'خزان سطحي', 'محطة ضخ', 'خط أنابيب',
            'Large Dam', 'Medium Dam', 'Small Dam', 'Embankment Dam',
            'Main Canal', 'Secondary Canal', 'Drainage Canal',
            'Weir', 'Reservoir', 'Pumping Station', 'Pipeline',
          ]),
          _field(t.location, 'location', Icons.location_on, isText: true),
          _field(t.owner, 'owner', Icons.account_balance, isText: true),
          _field(t.consultant, 'consultant', Icons.business_center, isText: true),
          _field(t.manager, 'manager', Icons.person, isText: true),
          _field(t.startDate, 'startDate', Icons.calendar_today, isText: true),
          _field(t.issueDate, 'issueDate', Icons.event, isText: true),
          _field(t.versionField, 'version', Icons.numbers, isText: true),

          const SizedBox(height: 24),
          _sectionHeader(t.facilityDataSection, Icons.engineering, const Color(0xFF1F4E78)),
          _field(t.primaryUse, 'primaryUse', Icons.business, isText: true),
          _field(t.storageCapacity, 'storageCapacity', Icons.water),
          _field(t.canalLength, 'canalLength', Icons.straighten),
          _field(t.pipeDiameter, 'pipeDiameter', Icons.circle_outlined),
          _field(t.installedCapacity, 'installedCapacity', Icons.flash_on),
          _field(t.designDischarge, 'designDischarge', Icons.waves),
          _field(t.catchmentArea, 'catchmentArea', Icons.terrain),
          _field(t.operatingLevel, 'operatingLevel', Icons.height),
          _field(t.damHeight, 'damHeight', Icons.architecture),
          _field(t.damCrestLength, 'damCrestLength', Icons.straighten),
          _field(t.affectedArea, 'affectedArea', Icons.crop_square),
          _field(t.displacedPersons, 'displacedPersons', Icons.people),

          const SizedBox(height: 24),
          _sectionHeader(t.economicDataSection, Icons.attach_money, const Color(0xFFEF6C00)),
          _field(t.budget, 'budget', Icons.account_balance_wallet),
          _field(t.projectLife, 'projectLife', Icons.calendar_view_week),
          _field(t.discountRate, 'discountRate', Icons.percent),
          _field(t.energyPrice, 'energyPrice', Icons.bolt),
          _field(t.waterPrice, 'waterPrice', Icons.water_drop),
          _field(t.constructionStart, 'constructionStart', Icons.engineering),
          _field(t.operationStart, 'operationStart', Icons.play_arrow),

          const SizedBox(height: 24),
          if (_editMode)
            ElevatedButton.icon(
              onPressed: _save,
              icon: const Icon(Icons.save),
              label: Text(t.save, style: const TextStyle(fontSize: 16)),
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF6D4C41),
                foregroundColor: Colors.white,
                padding: const EdgeInsets.all(14),
              ),
            ),
        ],
      ),
    );
  }

  Widget _sectionHeader(String title, IconData icon, Color color) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(color: color.withOpacity(0.15), borderRadius: BorderRadius.circular(8)),
            child: Icon(icon, color: color),
          ),
          const SizedBox(width: 12),
          Text(title, style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: color)),
        ],
      ),
    );
  }

  Widget _field(String label, String key, IconData icon, {bool isText = false}) {
    final c = _ctrls[key]!;
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Card(
        child: ListTile(
          dense: true,
          leading: Icon(icon, color: const Color(0xFF1F4E78), size: 20),
          title: Text(label, style: const TextStyle(fontSize: 13)),
          subtitle: _editMode
              ? TextField(
                  controller: c,
                  keyboardType: isText ? TextInputType.text : TextInputType.number,
                  decoration: const InputDecoration(isDense: true, border: OutlineInputBorder()),
                  onChanged: (_) => setState(() {}),
                )
              : Text(c.text.isEmpty ? T(widget.lang).dash : c.text, style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w500)),
        ),
      ),
    );
  }

  Widget _dropdownField(String label, String key, IconData icon, List<String> options) {
    final c = _ctrls[key]!;
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Card(
        child: ListTile(
          dense: true,
          leading: Icon(icon, color: const Color(0xFF1F4E78), size: 20),
          title: Text(label, style: const TextStyle(fontSize: 13)),
          subtitle: _editMode
              ? DropdownButtonFormField<String>(
                  value: c.text.isNotEmpty && options.contains(c.text) ? c.text : null,
                  items: options.map((o) => DropdownMenuItem(value: o, child: Text(o))).toList(),
                  onChanged: (v) => setState(() => c.text = v ?? ''),
                  decoration: const InputDecoration(isDense: true, border: OutlineInputBorder()),
                )
              : Text(c.text.isEmpty ? T(widget.lang).dash : c.text, style: const TextStyle(fontSize: 14)),
        ),
      ),
    );
  }
}