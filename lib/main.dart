/// ============================================================================
///  main.dart - نقطة الدخول مع دعم اللغات
///  WIA v4.1
/// ============================================================================

import 'package:flutter/material.dart';
import 'i18n/strings.dart';
import 'models/models.dart';
import 'data/criteria_data.dart';
import 'screens/dashboard_screen.dart';
import 'screens/project_info_screen.dart';
import 'screens/dimension_form_screen.dart';
import 'screens/results_screen.dart';
import 'screens/weight_settings_screen.dart';
import 'screens/about_screen.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const WIAApp());
}

class WIAApp extends StatefulWidget {
  const WIAApp({super.key});

  @override
  State<WIAApp> createState() => _WIAAppState();
}

class _WIAAppState extends State<WIAApp> {
  AppLang _lang = AppLang.arabic;

  void _toggleLang() {
    setState(() {
      _lang = _lang == AppLang.arabic ? AppLang.english : AppLang.arabic;
    });
  }

  @override
  Widget build(BuildContext context) {
    final t = T(_lang);
    return MaterialApp(
      title: t.appName,
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        useMaterial3: true,
        colorSchemeSeed: const Color(0xFF1F4E78),
        brightness: Brightness.light,
      ),
      builder: (context, child) {
        return Directionality(
          textDirection: _lang.isRtl ? TextDirection.rtl : TextDirection.ltr,
          child: child!,
        );
      },
      home: MainApp(lang: _lang, onLangToggle: _toggleLang),
    );
  }
}

class MainApp extends StatefulWidget {
  final AppLang lang;
  final VoidCallback onLangToggle;

  const MainApp({super.key, required this.lang, required this.onLangToggle});

  @override
  State<MainApp> createState() => _MainAppState();
}

class _MainAppState extends State<MainApp> {
  int _currentIndex = 0;

  // نماذج البيانات - فارغة افتراضياً
  late ProjectInfo _projectInfo;
  late FacilityData _facility;
  late Dimension _env, _soc, _eco;

  @override
  void initState() {
    super.initState();
    _projectInfo = ProjectInfo();  // فارغ
    _facility = FacilityData();     // فارغ
    _env = makeEnv();
    _soc = makeSoc();
    _eco = makeEco();
  }

  void _refresh() => setState(() {});

  @override
  Widget build(BuildContext context) {
    final composite = compositeIndex(_env, _soc, _eco);

    return Scaffold(
      body: IndexedStack(
        index: _currentIndex,
        children: [
          DashboardScreen(
            lang: widget.lang,
            projectInfo: _projectInfo,
            facility: _facility,
            env: _env, soc: _soc, eco: _eco,
            composite: composite,
            onLangToggle: widget.onLangToggle,
            onEnvTap: () => _openDimension(_env, const Color(0xFF2E7D32)),
            onSocTap: () => _openDimension(_soc, const Color(0xFF2E75B6)),
            onEcoTap: () => _openDimension(_eco, const Color(0xFFEF6C00)),
            onInfoTap: _openProjectInfo,
            onWeightsTap: _openWeights,
            onResultsTap: () => setState(() => _currentIndex = 2),
          ),
          ProjectInfoScreen(
            lang: widget.lang,
            info: _projectInfo,
            facility: _facility,
            onUpdate: _refresh,
          ),
          ResultsScreen(
            lang: widget.lang,
            projectInfo: _projectInfo,
            env: _env, soc: _soc, eco: _eco,
            composite: composite,
            onEnvTap: () => _openDimension(_env, const Color(0xFF2E7D32)),
            onSocTap: () => _openDimension(_soc, const Color(0xFF2E75B6)),
            onEcoTap: () => _openDimension(_eco, const Color(0xFFEF6C00)),
            onWeightsTap: _openWeights,
            onLangToggle: widget.onLangToggle,
          ),
          AboutScreen(lang: widget.lang, onLangToggle: widget.onLangToggle),
        ],
      ),
      bottomNavigationBar: NavigationBar(
        selectedIndex: _currentIndex,
        onDestinationSelected: (i) => setState(() => _currentIndex = i),
        destinations: [
          NavigationDestination(
            icon: const Icon(Icons.dashboard_outlined),
            selectedIcon: const Icon(Icons.dashboard),
            label: T(widget.lang).navHome,
          ),
          NavigationDestination(
            icon: const Icon(Icons.info_outline),
            selectedIcon: const Icon(Icons.info),
            label: T(widget.lang).navProject,
          ),
          NavigationDestination(
            icon: const Icon(Icons.analytics_outlined),
            selectedIcon: const Icon(Icons.analytics),
            label: T(widget.lang).navResults,
          ),
          NavigationDestination(
            icon: const Icon(Icons.help_outline),
            selectedIcon: const Icon(Icons.help),
            label: T(widget.lang).navAbout,
          ),
        ],
      ),
    );
  }

  Future<void> _openDimension(Dimension dim, Color color) async {
    await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => DimensionFormScreen(lang: widget.lang, dimension: dim, color: color),
      ),
    );
    _refresh();
  }

  Future<void> _openProjectInfo() async {
    await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => ProjectInfoScreen(lang: widget.lang, info: _projectInfo, facility: _facility, onUpdate: _refresh),
      ),
    );
    _refresh();
  }

  Future<void> _openWeights() async {
    await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => WeightSettingsScreen(lang: widget.lang, env: _env, soc: _soc, eco: _eco, onUpdate: _refresh),
      ),
    );
    _refresh();
  }
}