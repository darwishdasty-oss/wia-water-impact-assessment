/// ============================================================================
///  strings.dart - نظام الترجمة (عربي + إنجليزي)
///  WIA v4.1
/// ============================================================================

enum AppLang { arabic, english }

extension AppLangExt on AppLang {
  bool get isRtl => this == AppLang.arabic;
  String get code => this == AppLang.arabic ? 'ar' : 'en';
  String get name => this == AppLang.arabic ? 'العربية' : 'English';
}

/// الترجمة - مفتاح واحد، قيمتان (عربي + إنجليزي)
class T {
  final AppLang lang;

  T(this.lang);

  // التطبيق
  String get appName => lang == AppLang.arabic ? 'نظام تقييم الأثر المائي' : 'Water Impact Assessment';
  String get appSubtitle => lang == AppLang.arabic ? 'WIA - للمنشآت المائية' : 'WIA - Water Facilities';
  String get version => lang == AppLang.arabic ? 'الإصدار 4.1' : 'Version 4.1';

  // القائمة السفلية
  String get navHome => lang == AppLang.arabic ? 'الرئيسية' : 'Home';
  String get navProject => lang == AppLang.arabic ? 'المشروع' : 'Project';
  String get navResults => lang == AppLang.arabic ? 'النتائج' : 'Results';
  String get navAbout => lang == AppLang.arabic ? 'حول' : 'About';

  // الرئيسية
  String get dashboard => lang == AppLang.arabic ? 'لوحة المعلومات' : 'Dashboard';
  String get projectInfo => lang == AppLang.arabic ? 'بيانات المشروع' : 'Project Info';
  String get impactProfile => lang == AppLang.arabic ? 'ملف الأثر' : 'Impact Profile';
  String get compositeIndex => lang == AppLang.arabic ? 'المؤشر المركّب' : 'Composite Index';
  String get viewResults => lang == AppLang.arabic ? 'عرض النتائج التفصيلية' : 'View Detailed Results';
  String get adjustWeights => lang == AppLang.arabic ? 'ضبط الأوزان' : 'Adjust Weights';
  String get dimensionsTitle => lang == AppLang.arabic ? 'الأبعاد (اضغط لإدخال التقييم)' : 'Dimensions (tap to edit)';
  String get severityDistribution => lang == AppLang.arabic ? 'توزيع شدة المعايير' : 'Severity Distribution';
  String get emptyProject => lang == AppLang.arabic ? 'مشروع جديد' : 'New Project';

  // الأبعاد
  String get envDim => lang == AppLang.arabic ? 'البُعد البيئي' : 'Environmental';
  String get socDim => lang == AppLang.arabic ? 'البُعد الاجتماعي' : 'Social';
  String get ecoDim => lang == AppLang.arabic ? 'البُعد الاقتصادي' : 'Economic';

  // بيانات المشروع
  String get projectDataTitle => lang == AppLang.arabic ? 'بيانات المشروع والمنشأة' : 'Project & Facility Data';
  String get projectInfoSection => lang == AppLang.arabic ? 'معلومات المشروع' : 'Project Information';
  String get facilityDataSection => lang == AppLang.arabic ? 'البيانات الفنية للمنشأة' : 'Facility Technical Data';
  String get economicDataSection => lang == AppLang.arabic ? 'البيانات الاقتصادية' : 'Economic Data';
  String get edit => lang == AppLang.arabic ? 'تعديل' : 'Edit';
  String get save => lang == AppLang.arabic ? 'حفظ' : 'Save';
  String get saved => lang == AppLang.arabic ? '✓ تم حفظ البيانات' : '✓ Data saved';
  String get dash => lang == AppLang.arabic ? '—' : '—';

  // الحقول
  String get projectName => lang == AppLang.arabic ? 'اسم المشروع' : 'Project Name';
  String get facilityType => lang == AppLang.arabic ? 'نوع المنشأة' : 'Facility Type';
  String get location => lang == AppLang.arabic ? 'الموقع' : 'Location';
  String get owner => lang == AppLang.arabic ? 'الجهة المالكة' : 'Owner';
  String get consultant => lang == AppLang.arabic ? 'الاستشاري' : 'Consultant';
  String get manager => lang == AppLang.arabic ? 'مدير المشروع' : 'Project Manager';
  String get startDate => lang == AppLang.arabic ? 'تاريخ البدء' : 'Start Date';
  String get issueDate => lang == AppLang.arabic ? 'تاريخ الإصدار' : 'Issue Date';
  String get versionField => lang == AppLang.arabic ? 'الإصدار' : 'Version';

  // البيانات الفنية
  String get primaryUse => lang == AppLang.arabic ? 'الاستخدام الأساسي' : 'Primary Use';
  String get storageCapacity => lang == AppLang.arabic ? 'السعة التخزينية (م³)' : 'Storage Capacity (m³)';
  String get canalLength => lang == AppLang.arabic ? 'طول القناة (كم)' : 'Canal Length (km)';
  String get pipeDiameter => lang == AppLang.arabic ? 'قطر الأنبوب (مم)' : 'Pipe Diameter (mm)';
  String get installedCapacity => lang == AppLang.arabic ? 'القدرة المركّبة (MW)' : 'Installed Capacity (MW)';
  String get designDischarge => lang == AppLang.arabic ? 'تصريف التصميم (م³/ث)' : 'Design Discharge (m³/s)';
  String get catchmentArea => lang == AppLang.arabic ? 'مساحة الحوض (كم²)' : 'Catchment Area (km²)';
  String get operatingLevel => lang == AppLang.arabic ? 'مستوى التشغيل (م)' : 'Operating Level (m)';
  String get damHeight => lang == AppLang.arabic ? 'ارتفاع السد (م)' : 'Dam Height (m)';
  String get damCrestLength => lang == AppLang.arabic ? 'طول القمة (م)' : 'Dam Crest Length (m)';
  String get affectedArea => lang == AppLang.arabic ? 'المساحة المتأثرة (هكتار)' : 'Affected Area (ha)';
  String get displacedPersons => lang == AppLang.arabic ? 'الأشخاص النازحون' : 'Displaced Persons';

  // الاقتصادية
  String get budget => lang == AppLang.arabic ? 'الميزانية (مليون USD)' : 'Budget (Million USD)';
  String get projectLife => lang == AppLang.arabic ? 'عمر المشروع (سنة)' : 'Project Life (Years)';
  String get discountRate => lang == AppLang.arabic ? 'سعر الخصم (%)' : 'Discount Rate (%)';
  String get energyPrice => lang == AppLang.arabic ? 'سعر الطاقة (USD/ك.و.س)' : 'Energy Price (USD/kWh)';
  String get waterPrice => lang == AppLang.arabic ? 'سعر المياه (USD/م³)' : 'Water Price (USD/m³)';
  String get constructionStart => lang == AppLang.arabic ? 'بداية البناء (سنة)' : 'Construction Start (Year)';
  String get operationStart => lang == AppLang.arabic ? 'بداية التشغيل (سنة)' : 'Operation Start (Year)';

  // نموذج المعيار
  String get importance => lang == AppLang.arabic ? 'الأهمية' : 'Importance';
  String get magnitude => lang == AppLang.arabic ? 'الحجم' : 'Magnitude';
  String get extent => lang == AppLang.arabic ? 'المدى المكاني' : 'Spatial Extent';
  String get duration => lang == AppLang.arabic ? 'المدى الزمني' : 'Duration';
  String get reversibility => lang == AppLang.arabic ? 'القابلية للعكس' : 'Reversibility';
  String get score => lang == AppLang.arabic ? 'النتيجة' : 'Score';
  String get recommendations => lang == AppLang.arabic ? 'التوصيات التلقائية' : 'Auto Recommendations';
  String get priority => lang == AppLang.arabic ? 'الأولوية' : 'Priority';
  String get action => lang == AppLang.arabic ? 'الإجراء' : 'Action';
  String get timeline => lang == AppLang.arabic ? 'الجدول الزمني' : 'Timeline';
  String get reference => lang == AppLang.arabic ? 'المرجع' : 'Reference';
  String get importanceHint => lang == AppLang.arabic ? '1 = منخفضة، 5 = بالغة' : '1 = Low, 5 = Critical';
  String get magnitudeHint => lang == AppLang.arabic ? '0 = لا أثر، 10 = كارثي' : '0 = None, 10 = Severe';
  String get extentHint => lang == AppLang.arabic ? '1 = محلي، 5 = إقليمي' : '1 = Local, 5 = Regional';
  String get durationHint => lang == AppLang.arabic ? '1 = مؤقت، 5 = دائم' : '1 = Temporary, 5 = Permanent';
  String get reversibilityHint => lang == AppLang.arabic ? '1 = عكسي، 5 = غير عكسي' : '1 = Reversible, 5 = Irreversible';

  // التصنيفات
  String get catLow => lang == AppLang.arabic ? 'منخفض' : 'Low';
  String get catMedium => lang == AppLang.arabic ? 'متوسط' : 'Medium';
  String get catHigh => lang == AppLang.arabic ? 'مرتفع' : 'High';
  String get catCritical => lang == AppLang.arabic ? 'حرج' : 'Critical';
  String get catLowDesc => lang == AppLang.arabic ? 'منخفض (0-25)' : 'Low (0-25)';
  String get catMediumDesc => lang == AppLang.arabic ? 'متوسط (26-50)' : 'Medium (26-50)';
  String get catHighDesc => lang == AppLang.arabic ? 'مرتفع (51-75)' : 'High (51-75)';
  String get catCriticalDesc => lang == AppLang.arabic ? 'حرج (>75)' : 'Critical (>75)';

  // الأولويات
  String get priCritical => lang == AppLang.arabic ? 'حرجة' : 'Critical';
  String get priMandatory => lang == AppLang.arabic ? 'إلزامية' : 'Mandatory';
  String get priRecommended => lang == AppLang.arabic ? 'مستحسنة' : 'Recommended';
  String get priOptional => lang == AppLang.arabic ? 'تحسينية' : 'Optional';

  // النتائج
  String get resultsTitle => lang == AppLang.arabic ? 'النتائج والتحليل' : 'Results & Analysis';
  String get radarChart => lang == AppLang.arabic ? 'ملف الأثر - رسم رادار' : 'Impact Profile - Radar';
  String get weightPie => lang == AppLang.arabic ? 'توزيع الأوزان بين الأبعاد' : 'Weight Distribution';
  String get dimensionDetails => lang == AppLang.arabic ? 'تفاصيل الأبعاد' : 'Dimension Details';
  String get severityByDim => lang == AppLang.arabic ? 'توزيع المعايير حسب الشدة' : 'Severity Distribution';
  String get top10 => lang == AppLang.arabic ? 'أعلى 10 معايير تأثيراً (مرجّحة)' : 'Top 10 Impact Criteria (weighted)';
  String get criticalRecs => lang == AppLang.arabic ? 'التوصيات للمعايير الحرجة والمرتفعة' : 'Recommendations for Critical & High';
  String get noCritical => lang == AppLang.arabic ? '✓ لا توجد معايير حرجة أو مرتفعة' : '✓ No critical or high criteria';

  // ضبط الأوزان
  String get weightSettings => lang == AppLang.arabic ? 'ضبط الأوزان' : 'Weight Settings';
  String get dimWeight => lang == AppLang.arabic ? 'الوزن العام للبُعد' : 'Dimension Global Weight';
  String get criteriaWeights => lang == AppLang.arabic ? 'أوزان المعايير داخل البُعد (المجموع = 100%)' : 'Criteria Weights (Sum = 100%)';
  String get total => lang == AppLang.arabic ? 'المجموع' : 'Total';
  String get normalize => lang == AppLang.arabic ? 'تطبيع' : 'Normalize';
  String get equal => lang == AppLang.arabic ? 'متساوية' : 'Equal';
  String get defaultWeights => lang == AppLang.arabic ? 'ENV 40% / SOC 30% / ECO 30%' : 'ENV 40% / SOC 30% / ECO 30%';
  String get equalWeights => lang == AppLang.arabic ? 'متساوية (33.3% لكل بُعد)' : 'Equal (33.3% each)';
  String get resetCriteria => lang == AppLang.arabic ? 'إعادة تعيين أوزان المعايير' : 'Reset Criteria Weights';
  String get normalizeAll => lang == AppLang.arabic ? 'تطبيع المجموع إلى 100%' : 'Normalize to 100%';

  // حول
  String get appInfo => lang == AppLang.arabic ? 'معلومات التطبيق' : 'App Information';
  String get editor => lang == AppLang.arabic ? 'محرر التطبيق' : 'App Editor';
  String get developer => lang == AppLang.arabic ? 'المطور' : 'Developer';
  String get features => lang == AppLang.arabic ? 'الميزات الكاملة' : 'Full Features';
  String get methodology => lang == AppLang.arabic ? 'المنهجية' : 'Methodology';
  String get references => lang == AppLang.arabic ? 'المرجعيات' : 'References';
  String get license => lang == AppLang.arabic ? 'الترخيص' : 'License';

  // عام
  String get yes => lang == AppLang.arabic ? 'نعم' : 'Yes';
  String get no => lang == AppLang.arabic ? 'لا' : 'No';
  String get ok => lang == AppLang.arabic ? 'موافق' : 'OK';
  String get cancel => lang == AppLang.arabic ? 'إلغاء' : 'Cancel';
  String get back => lang == AppLang.arabic ? 'رجوع' : 'Back';
  String get language => lang == AppLang.arabic ? 'اللغة' : 'Language';
  String get switchLang => lang == AppLang.arabic ? 'EN' : 'عربي';
  String get reset => lang == AppLang.arabic ? 'إعادة تعيين' : 'Reset';
  String get saveAndBack => lang == AppLang.arabic ? 'حفظ والعودة' : 'Save & Back';
}