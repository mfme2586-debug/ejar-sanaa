/// مديريات أمانة العاصمة صنعاء (10 مديريات)
class Districts {
  static const List<Map<String, dynamic>> districts = [
    {
      'id': 'azal',
      'name': 'آزال',
      'nameEn': 'Azal',
      'neighborhoods': [], // سيتم إضافتها لاحقاً
    },
    {
      'id': 'tahrir',
      'name': 'التحرير',
      'nameEn': 'Tahrir',
      'neighborhoods': [],
    },
    {
      'id': 'thawra',
      'name': 'الثورة',
      'nameEn': 'Thawra',
      'neighborhoods': [],
    },
    {
      'id': 'sabaeen',
      'name': 'السبعين',
      'nameEn': 'Sabaeen',
      'neighborhoods': [],
    },
    {
      'id': 'safiya',
      'name': 'الصافية',
      'nameEn': 'Safiya',
      'neighborhoods': [],
    },
    {
      'id': 'wahda',
      'name': 'الوحدة',
      'nameEn': 'Wahda',
      'neighborhoods': [],
    },
    {
      'id': 'boni_hareth',
      'name': 'بني الحارث',
      'nameEn': 'Boni Hareth',
      'neighborhoods': [],
    },
    {
      'id': 'shoob',
      'name': 'شعوب',
      'nameEn': 'Shoob',
      'neighborhoods': [],
    },
    {
      'id': 'old_sanaa',
      'name': 'صنعاء القديمة',
      'nameEn': 'Old Sana\'a',
      'neighborhoods': [],
    },
    {
      'id': 'maeen',
      'name': 'معين',
      'nameEn': 'Maeen',
      'neighborhoods': [],
    },
  ];

  static String getDistrictName(String id) {
    final district = districts.firstWhere(
      (d) => d['id'] == id,
      orElse: () => {'name': 'غير محدد'},
    );
    return district['name'];
  }

  static List<String> getNeighborhoods(String districtId) {
    final district = districts.firstWhere(
      (d) => d['id'] == districtId,
      orElse: () => {'neighborhoods': []},
    );
    return List<String>.from(district['neighborhoods'] ?? []);
  }
}

/// أنواع الإيجارات المتاحة
class RentalTypes {
  static const List<Map<String, dynamic>> types = [
    {
      'id': 'apartment',
      'name': 'شقة',
      'icon': '🏠',
      'nameEn': 'Apartment',
    },
    {
      'id': 'villa',
      'name': 'فيلا',
      'icon': '🏡',
      'nameEn': 'Villa',
    },
    {
      'id': 'building',
      'name': 'عمارة',
      'icon': '🏢',
      'nameEn': 'Building',
    },
    {
      'id': 'shop',
      'name': 'محل',
      'icon': '🏪',
      'nameEn': 'Shop',
    },
    {
      'id': 'basement',
      'name': 'بدروم',
      'icon': '⬇️',
      'nameEn': 'Basement',
    },
    {
      'id': 'wedding_hall',
      'name': 'صالون أعراس',
      'icon': '🎉',
      'nameEn': 'Wedding Hall',
    },
    {
      'id': 'land',
      'name': 'قطعة أرض / حوش',
      'icon': '📐',
      'nameEn': 'Land / Yard',
    },
    {
      'id': 'car',
      'name': 'سيارة',
      'icon': '🚗',
      'nameEn': 'Car',
    },
    {
      'id': 'motorcycle',
      'name': 'دراجة نارية',
      'icon': '🏍️',
      'nameEn': 'Motorcycle',
    },
    {
      'id': 'stall',
      'name': 'بسطة',
      'icon': '🛒',
      'nameEn': 'Stall',
    },
    {
      'id': 'other',
      'name': 'أخرى',
      'icon': '📋',
      'nameEn': 'Other',
    },
  ];

  static String getTypeName(String id) {
    final type = types.firstWhere(
      (t) => t['id'] == id,
      orElse: () => {'name': 'أخرى'},
    );
    return type['name'];
  }

  static String getTypeIcon(String id) {
    final type = types.firstWhere(
      (t) => t['id'] == id,
      orElse: () => {'icon': '📋'},
    );
    return type['icon'];
  }
}

/// مصادر الماء
class WaterSources {
  static const String government = 'government'; // حكومي
  static const String tank = 'tank'; // خزان
  static const String waterTruck = 'water_truck'; // وايتات
  static const String well = 'well'; // بئر
  
  static String getName(String source) {
    switch (source) {
      case government:
        return 'حكومي';
      case tank:
        return 'خزان';
      case waterTruck:
        return 'وايتات';
      case well:
        return 'بئر';
      default:
        return 'غير محدد';
    }
  }
}

/// أنواع الكهرباء
class ElectricityTypes {
  static const String government = 'government'; // حكومي
  static const String commercial = 'commercial'; // تجاري (مولدات)
  static const String solar = 'solar'; // شمسي
  static const String hybrid = 'hybrid'; // مختلط
  
  static String getName(String type) {
    switch (type) {
      case government:
        return 'حكومي';
      case commercial:
        return 'تجاري (مولدات)';
      case solar:
        return 'شمسي';
      case hybrid:
        return 'مختلط';
      default:
        return 'غير محدد';
    }
  }
}

/// اتجاهات الشمس (مهم جداً في صنعاء)
class SunlightDirections {
  static const String south = 'south'; // جنوبي - مشمس جداً
  static const String east = 'east'; // شرقي - مشمس صباحاً
  static const String west = 'west'; // غربي - مشمس مساءً
  static const String north = 'north'; // شمالي - ظليل
  static const String mixed = 'mixed'; // مختلط
  
  static String getName(String direction) {
    switch (direction) {
      case south:
        return 'جنوبي (مشمس جداً) 🌞';
      case east:
        return 'شرقي (مشمس صباحاً) 🌅';
      case west:
        return 'غربي (مشمس مساءً) 🌇';
      case north:
        return 'شمالي (ظليل) ☁️';
      case mixed:
        return 'مختلط';
      default:
        return 'غير محدد';
    }
  }
}

/// الأدوار
class Floors {
  static const String ground = 'ground'; // أرضي
  static const String first = 'first'; // أول
  static const String second = 'second'; // ثاني
  static const String third = 'third'; // ثالث
  static const String fourth = 'fourth'; // رابع
  static const String higher = 'higher'; // أعلى
  
  static String getName(String floor) {
    switch (floor) {
      case ground:
        return 'أرضي';
      case first:
        return 'أول';
      case second:
        return 'ثاني';
      case third:
        return 'ثالث';
      case fourth:
        return 'رابع';
      case higher:
        return 'أعلى';
      default:
        return 'غير محدد';
    }
  }
}

/// أنواع المالك/البائع
class SellerTypes {
  static const String owner = 'owner'; // مالك
  static const String agent = 'agent'; // وكيل
  static const String broker = 'broker'; // دلال
  
  static String getName(String type) {
    switch (type) {
      case owner:
        return 'مالك';
      case agent:
        return 'وكيل';
      case broker:
        return 'دلال';
      default:
        return 'غير محدد';
    }
  }
}
