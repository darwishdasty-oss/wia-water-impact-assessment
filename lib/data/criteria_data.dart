/// ============================================================================
///  criteria_data.dart - المعايير الـ 38 + التوصيات التلقائية
///  WIA v1.0.0
/// ============================================================================

import '../models/models.dart';

/// 14 معيار بيئي
final List<Criterion> envRaw = [
  Criterion(code: 'E01', name: 'جودة المياه السطحية والجوفية', dimension: 'ENV',
      description: 'تركيز الملوثات والأكسجين المذاب والعكارة وpH'),
  Criterion(code: 'E02', name: 'النظم البيئية المائية', dimension: 'ENV',
      description: 'هجرة الأسماك، الموائل المائية، السلسلة الغذائية'),
  Criterion(code: 'E03', name: 'التنوع البيولوجي', dimension: 'ENV',
      description: 'فقدان أو تغير في الأنواع الحيوانية والنباتية'),
  Criterion(code: 'E04', name: 'التربة والانجراف', dimension: 'ENV',
      description: 'تعرية التربة، فقدان الخصوبة، ترسب الطمي'),
  Criterion(code: 'E05', name: 'جودة الهواء', dimension: 'ENV',
      description: 'انبعاثات المعدات، الغبار أثناء الإنشاء'),
  Criterion(code: 'E06', name: 'إدارة النفايات', dimension: 'ENV',
      description: 'مخلفات البناء، مياه الصرف، المواد الكيميائية'),
  Criterion(code: 'E07', name: 'الأراضي الرطبة', dimension: 'ENV',
      description: 'تجفيف مستنقعات، إزالة غابات، تعطيل سلاسل غذائية'),
  Criterion(code: 'E08', name: 'تغيّر المناخ', dimension: 'ENV',
      description: 'غازات الاحتباس الحراري، البصمة الكربونية'),
  Criterion(code: 'E09', name: 'المياه الجوفية', dimension: 'ENV',
      description: 'رفع أو خفض منسوب المياه الجوفية'),
  Criterion(code: 'E10', name: 'الرواسب وإدارة الطمي', dimension: 'ENV',
      description: 'ترسب خلف السد، إطماء الخزان'),
  Criterion(code: 'E11', name: 'التلوث الضوضائي', dimension: 'ENV',
      description: 'ضجيج المعدات، التفجيرات، تأثير على الحياة البرية'),
  Criterion(code: 'E12', name: 'المنظر الطبيعي', dimension: 'ENV',
      description: 'تغير الطبوغرافيا، تشويه المناظر الطبيعية'),
  Criterion(code: 'E13', name: 'الغطاء النباتي', dimension: 'ENV',
      description: 'إزالة الغابات، فقدان المراعي'),
  Criterion(code: 'E14', name: 'الأنواع المهددة', dimension: 'ENV',
      description: 'تهديد الموائل الحرجة وفق IUCN Red List'),
];

/// 12 معيار اجتماعي
final List<Criterion> socRaw = [
  Criterion(code: 'S01', name: 'التهجير وإعادة التوطين', dimension: 'SOC',
      description: 'عدد المتأثرين، التعويض، جودة مواقع البديل'),
  Criterion(code: 'S02', name: 'سبل العيش', dimension: 'SOC',
      description: 'فقدان الزراعة، صيد الأسماك، الرعي'),
  Criterion(code: 'S03', name: 'الموروث الثقافي', dimension: 'SOC',
      description: 'مواقع أثرية، مقامات، طقوس مرتبطة بالمكان'),
  Criterion(code: 'S04', name: 'الصحة والسلامة', dimension: 'SOC',
      description: 'الأمراض المنقولة بالمياه، الإصابات، السلامة الإنشائية'),
  Criterion(code: 'S05', name: 'فرص العمل', dimension: 'SOC',
      description: 'عمالة محلية، تدريب، نقل المهارات'),
  Criterion(code: 'S06', name: 'العدالة والنوع الاجتماعي', dimension: 'SOC',
      description: 'تأثير متمايز على النساء والفئات المهمشة'),
  Criterion(code: 'S07', name: 'الشعوب الأصلية', dimension: 'SOC',
      description: 'موافقة حرة مسبقة، حقوق ملكية تقليدية'),
  Criterion(code: 'S08', name: 'المشاركة المجتمعية', dimension: 'SOC',
      description: 'آليات الشكاوى، الاستشارة، الإفصاح'),
  Criterion(code: 'S09', name: 'الأمن المائي', dimension: 'SOC',
      description: 'إدارة مخاطر الفيضانات، إنذار مبكر'),
  Criterion(code: 'S10', name: 'الوصول العادل للمياه', dimension: 'SOC',
      description: 'حصص مائية، أولوية، رسوم'),
  Criterion(code: 'S11', name: 'الأراضي والملكية', dimension: 'SOC',
      description: 'نزع الملكية، سعر التعويض، بدائل'),
  Criterion(code: 'S12', name: 'النزاعات الاجتماعية', dimension: 'SOC',
      description: 'صراع بين مستخدمين، بين القرى، على الحدود'),
];

/// 12 معيار اقتصادي
final List<Criterion> ecoRaw = [
  Criterion(code: 'C01', name: 'تحليل التكلفة/العائد', dimension: 'ECO',
      description: 'القيمة الحالية الصافية، معدل العائد الداخلي'),
  Criterion(code: 'C02', name: 'تكاليف الإنشاء', dimension: 'ECO',
      description: 'CAPEX، انحرافات عن الموازنة، تكاليف طارئة'),
  Criterion(code: 'C03', name: 'تكاليف التشغيل', dimension: 'ECO',
      description: 'OPEX السنوي، عمر افتراضي، تجديدات'),
  Criterion(code: 'C04', name: 'خلق فرص العمل', dimension: 'ECO',
      description: 'وظائف مرحلة الإنشاء، وظائف دائمة'),
  Criterion(code: 'C05', name: 'الإنتاجية الزراعية', dimension: 'ECO',
      description: 'كمية المياه، إنتاجية الهكتار'),
  Criterion(code: 'C06', name: 'الطاقة الكهرومائية', dimension: 'ECO',
      description: 'قدرة MW، GWh سنوي، عامل السعة'),
  Criterion(code: 'C07', name: 'إمدادات المياه', dimension: 'ECO',
      description: 'حجم m³/يوم، عدد المستفيدين، سعر البيع'),
  Criterion(code: 'C08', name: 'السياحة والترفيه', dimension: 'ECO',
      description: 'مسطحات مائية، أنشطة، إيرادات'),
  Criterion(code: 'C09', name: 'الثروة السمكية', dimension: 'ECO',
      description: 'إنتاج الأسماك، تربية الأحياء المائية'),
  Criterion(code: 'C10', name: 'قيمة الأراضي', dimension: 'ECO',
      description: 'ارتفاع/انخفاض الأسعار حول المشروع'),
  Criterion(code: 'C11', name: 'الاستدامة المالية', dimension: 'ECO',
      description: 'قدرة الجهة المشغلة على التغطية الذاتية'),
  Criterion(code: 'C12', name: 'الفوائد الإقليمية', dimension: 'ECO',
      description: 'تحفيز سلاسل قيمة، صادرات، ميزان تجاري'),
];

Dimension buildEnv() {
  final list = envRaw.map((c) => c).toList();
  // أوزان افتراضية متساوية
  final w = 100.0 / list.length;
  for (final c in list) {
    c.weight = w;
  }
  return Dimension(code: 'ENV', nameAr: 'البيئي', nameEn: 'Environmental',
      criteria: list, globalWeight: 40);
}

Dimension buildSoc() {
  final list = socRaw.map((c) => c).toList();
  final w = 100.0 / list.length;
  for (final c in list) {
    c.weight = w;
  }
  return Dimension(code: 'SOC', nameAr: 'الاجتماعي', nameEn: 'Social',
      criteria: list, globalWeight: 30);
}

Dimension buildEco() {
  final list = ecoRaw.map((c) => c).toList();
  final w = 100.0 / list.length;
  for (final c in list) {
    c.weight = w;
  }
  return Dimension(code: 'ECO', nameAr: 'الاقتصادي', nameEn: 'Economic',
      criteria: list, globalWeight: 30);
}

/// توليد الأبعاد الافتراضية
Dimension makeEnv() => buildEnv();
Dimension makeSoc() => buildSoc();
Dimension makeEco() => buildEco();

/// ========================================================
/// التوصيات التلقائية بناءً على شدة الأثر
/// ========================================================

class Recommendation {
  final Criterion criterion;
  final String severity;
  final String priority;     // حرجة / إلزامية / مستحسنة / تحسينية
  final String action;
  final String timeline;
  final String reference;

  const Recommendation({
    required this.criterion,
    required this.severity,
    required this.priority,
    required this.action,
    required this.timeline,
    required this.reference,
  });
}

List<Recommendation> generateRecommendations(Criterion c) {
  final score = c.rawScore;
  final cat = c.category;
  String priority, action, timeline, reference;

  if (score > 75) {
    priority = 'حرجة';
    action = 'تنفيذ خطة تخفيف عاجلة، مراجعة شاملة للمشروع، تعيين فريق رقابة';
    timeline = 'خلال 7 أيام، متابعة أسبوعية';
    reference = 'IFC PS 1 / WB ESF Standard 1';
  } else if (score > 50) {
    priority = 'إلزامية';
    action = 'تطبيق خطة تخفيف محددة، توثيق الإجراءات، إشراك أصحاب المصلحة';
    timeline = 'خلال 30 يوم، متابعة شهرية';
    reference = 'IFC PS 2-8 (حسب الموضوع)';
  } else if (score > 25) {
    priority = 'مستحسنة';
    action = 'تطبيق إجراءات تحسين ومراقبة مستمرة';
    timeline = 'خلال 90 يوم، متابعة فصلية';
    reference = 'FAO EIA Guidelines';
  } else {
    priority = 'تحسينية';
    action = 'متابعة دورية، تحسين عند الحاجة';
    timeline = 'متابعة سنوية';
    reference = 'ICOLD Best Practices';
  }

  // إضافة توصية خاصة لكل كود
  final specificAction = _specificAction(c.code, action);
  final specificReference = _specificReference(c.code, reference);

  return [
    Recommendation(
      criterion: c,
      severity: cat,
      priority: priority,
      action: specificAction,
      timeline: timeline,
      reference: specificReference,
    ),
  ];
}

String _specificAction(String code, String defaultAction) {
  final map = {
    'E01': 'إنشاء محطات رصد جودة المياه، معالجة الملوثات، ضمان الحد الأدنى من التدفق البيئي',
    'E02': 'بناء ممرات للأسماك، إعادة تأهيل الموائل، مراقبة التنوع البيولوجي',
    'E03': 'إنشاء محميات طبيعية، برامج إكثار للأنواع المهددة',
    'E04': 'تقنيات التحكم في التعرية، إعادة التشجير، إدارة مستجمعات المياه',
    'E05': 'استخدام معدات منخفضة الانبعاثات، رش المياه ضد الغبار',
    'E06': 'خطة إدارة نفايات متكاملة، إعادة التدوير، التخلص الآمن',
    'E07': 'تعويض بيئي للأراضي الرطبة، إنشاء بدائل',
    'E08': 'استخدام الطاقة المتجددة، كفاءة الطاقة، حساب البصمة الكربونية',
    'E09': 'مراقبة منسوب المياه الجوفية، ضمان عدم التأثير على الآبار',
    'E10': 'تصميم أنظمة تصريف الطمي، تنظيف دوري',
    'E11': 'استخدام كاتمات الصوت، جدولة التفجيرات بعيداً عن الموائل',
    'E12': 'تصميم معماري متناسق مع البيئة، إعادة التشجير بعد الإنشاء',
    'E13': 'تعويض الغطاء النباتي، إعادة التشجير',
    'E14': 'برامج حماية للأنواع المهددة، تقييم IUCN',
    'S01': 'خطة إعادة توطين شاملة، تعويض عادل، استشارة المتأثرين',
    'S02': 'برامج بديلة لكسب الرزق، تدريب مهني، تعويض الدخل',
    'S03': 'توثيق وحماية المواقع التراثية، نقل الطقوس والموروث',
    'S04': 'مرافق صحية، برامج توعية، تأمين سلامة عمال الإنشاء',
    'S05': 'أولوية التوظيف المحلي، برامج تدريب، تطوير مهارات',
    'S06': 'تحليل النوع الاجتماعي، ضمان مشاركة المرأة، برامج للفئات المهمشة',
    'S07': 'موافقة حرة مسبقة ومستنيرة (FPIC)، حماية الحقوق التقليدية',
    'S08': 'آلية شكاوى فعالة، اجتماعات تشاورية، إفصاح كامل',
    'S09': 'نظام إنذار مبكر، خطة طوارئ للفيضانات',
    'S10': 'تخصيص حصص عادلة، تسعير تفضيلي للفقراء',
    'S11': 'تعويض عادل، نزع ملكية شفاف، بدائل',
    'S12': 'آليات حل النزاعات، وساطة، محاكم متخصصة',
    'C01': 'إعادة حساب BCR وNPV بمعدلات خصم مختلفة',
    'C02': 'مراجعة الموازنة، احتياطي طوارئ 10-15%',
    'C03': 'خطة صيانة طويلة المدى، تجديد المعدات',
    'C04': 'تشغيل العمالة المحلية، برامج تدريب وتأهيل',
    'C05': 'تقنيات ري حديثة، تحسين إنتاجية الهكتار',
    'C06': 'تحسين عامل السعة، صيانة دورية للتوربينات',
    'C07': 'ضمان إمداد مستمر، تسعير مناسب، صيانة الشبكة',
    'C08': 'تطوير السياحة البيئية، إنشاء مرافق ترفيهية',
    'C09': 'تربية الأحياء المائية، إدارة مصايد مستدامة',
    'C10': 'تحليل سوق الأراضي، خطط تنمية محلية',
    'C11': 'نموذج مالي مستدام، مصادر دخل متعددة',
    'C12': 'تحفيز الاستثمار المحلي، شراكات، تصدير',
  };
  return map[code] ?? defaultAction;
}

String _specificReference(String code, String defaultRef) {
  final map = {
    'E01': 'WB EHS Guidelines for Water and Sanitation',
    'E02': 'IFC PS 6 - Biodiversity Conservation',
    'E03': 'IFC PS 6 - Critical Habitat',
    'E04': 'FAO Soil Conservation Guidelines',
    'E05': 'WB EHS - Air Emissions',
    'E06': 'IFC PS 3 - Resource Efficiency',
    'E07': 'Ramsar Convention',
    'E08': 'IPCC Guidelines + WB Carbon Finance',
    'E09': 'FAO Groundwater Management',
    'E10': 'ICOLD Sediment Management',
    'E11': 'WB EHS - Noise',
    'E12': 'Landscape Institute Guidelines',
    'E13': 'UNCCD - Land Degradation',
    'S01': 'IFC PS 5 - Land Acquisition',
    'S02': 'IFC PS 5 - Livelihoods',
    'S03': 'IFC PS 8 - Cultural Heritage',
    'S04': 'IFC PS 2/4 - Health & Safety',
    'S05': 'ILO + IFC PS 2',
    'S06': 'WB ESF - Gender',
    'S07': 'IFC PS 7 - Indigenous Peoples',
    'S08': 'IFC PS 1 - Stakeholder Engagement',
    'S09': 'UNISDR Sendai Framework',
    'S10': 'UN Water - Human Right to Water',
    'S11': 'IFC PS 5',
    'S12': 'WB Conflict Sensitivity',
    'C01': 'WB Economics of Dam Projects',
    'C02': 'WB Capital Cost Guidelines',
    'C03': 'ICOLD Operation & Maintenance',
    'C04': 'WB Employment Impact',
    'C05': 'FAO Irrigation Manual',
    'C06': 'IEA Hydropower Roadmap',
    'C07': 'WB Water Supply Handbook',
    'C08': 'UNWTO Tourism Guidelines',
    'C09': 'FAO Aquaculture',
    'C10': 'WB Land Markets',
    'C11': 'WB PPP Framework',
    'C12': 'WB Trade & Regional Integration',
  };
  return map[code] ?? defaultRef;
}