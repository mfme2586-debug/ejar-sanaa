/// نموذج بيانات الإعلان (Listing Model)
class Listing {
  final String id;
  final String type; // نوع الإيجار (apartment, villa, etc.)
  final String title;
  final String description;
  
  // الموقع
  final String district; // المديرية
  final String? neighborhood; // الحي
  final String? street; // الحارة
  final String? locationDescription; // وصف الموقع
  
  // نوع العقار
  final String? buildingType; // عمارة / شقة واحدة / مجموعة شقق
  final String? floor; // الدور
  final int? roomCount; // عدد الغرف
  final List<RoomDetail>? rooms; // تفاصيل الغرف (الطول × العرض)
  final bool hasKitchen; // يوجد مطبخ
  final String? kitchenSize; // حجم المطبخ
  final int? bathroomCount; // عدد الحمامات
  
  // المجلس الخارجي
  final bool hasExternalMajlis; // يوجد مجلس خارجي
  final bool externalMajlisHasBathroom; // المجلس الخارجي مع حمام
  
  // الماء
  final String? waterSource; // مصدر الماء
  final String? waterIndependence; // مستقل / مشترك
  final String? waterTankCapacity; // سعة الخزان
  
  // الكهرباء
  final String? electricityType; // نوع الكهرباء
  final String? electricityIndependence; // مستقل / مشترك
  final bool hasSolarPanels; // يوجد ألواح شمسية
  
  // الشمس (مهم جداً)
  final String? sunlightDirection; // اتجاه الشمس
  
  // السعر والشروط
  final double price; // السعر
  final String currency; // العملة (ريال قديم/جديد/دولار/ريال سعودي)
  final bool priceIncludesUtilities; // السعر شامل الماء والكهرباء
  final double? deposit; // التأمين
  final double? advance; // المقدم (شهر / 3 أشهر)
  final bool hasBrokerage; // يوجد ساعية (دلالة)
  final bool negotiable; // قابل للتفاوض
  final bool requiresGuarantee; // مطلوب ضمانة
  final String? guaranteeType; // نوع الضمانة (تجاري / وظيفي)
  final bool isCommercial; // تجاري / غير تجاري
  
  // التواصل
  final String contactPhone;
  final String sellerType; // مالك / وكيل / دلال
  final String? sellerName; // اسم البائع
  
  // الصور
  final List<String> images; // روابط الصور
  
  // معلومات إضافية
  final DateTime createdAt;
  final DateTime? updatedAt;
  final bool isActive;
  final bool isFeatured;
  
  Listing({
    required this.id,
    required this.type,
    required this.title,
    this.description = '',
    required this.district,
    this.neighborhood,
    this.street,
    this.locationDescription,
    this.buildingType,
    this.floor,
    this.roomCount,
    this.rooms,
    this.hasKitchen = false,
    this.kitchenSize,
    this.bathroomCount,
    this.hasExternalMajlis = false,
    this.externalMajlisHasBathroom = false,
    this.waterSource,
    this.waterIndependence,
    this.waterTankCapacity,
    this.electricityType,
    this.electricityIndependence,
    this.hasSolarPanels = false,
    this.sunlightDirection,
    required this.price,
    this.currency = 'ريال يمني',
    this.priceIncludesUtilities = false,
    this.deposit,
    this.advance,
    this.hasBrokerage = false,
    this.negotiable = false,
    this.requiresGuarantee = false,
    this.guaranteeType,
    this.isCommercial = false,
    required this.contactPhone,
    required this.sellerType,
    this.sellerName,
    this.images = const [],
    DateTime? createdAt,
    this.updatedAt,
    this.isActive = true,
    this.isFeatured = false,
  }) : createdAt = createdAt ?? DateTime.now();
  
  // من JSON
  factory Listing.fromJson(Map<String, dynamic> json) {
    return Listing(
      id: json['id'] as String,
      type: json['type'] as String,
      title: json['title'] as String,
      description: json['description'] as String? ?? '',
      district: json['district'] as String,
      neighborhood: json['neighborhood'] as String?,
      street: json['street'] as String?,
      locationDescription: json['locationDescription'] as String?,
      buildingType: json['buildingType'] as String?,
      floor: json['floor'] as String?,
      roomCount: json['roomCount'] as int?,
      rooms: json['rooms'] != null
          ? (json['rooms'] as List).map((r) => RoomDetail.fromJson(r)).toList()
          : null,
      hasKitchen: json['hasKitchen'] as bool? ?? false,
      kitchenSize: json['kitchenSize'] as String?,
      bathroomCount: json['bathroomCount'] as int?,
      hasExternalMajlis: json['hasExternalMajlis'] as bool? ?? false,
      externalMajlisHasBathroom: json['externalMajlisHasBathroom'] as bool? ?? false,
      waterSource: json['waterSource'] as String?,
      waterIndependence: json['waterIndependence'] as String?,
      waterTankCapacity: json['waterTankCapacity'] as String?,
      electricityType: json['electricityType'] as String?,
      electricityIndependence: json['electricityIndependence'] as String?,
      hasSolarPanels: json['hasSolarPanels'] as bool? ?? false,
      sunlightDirection: json['sunlightDirection'] as String?,
      price: (json['price'] as num).toDouble(),
      currency: json['currency'] as String? ?? 'ريال يمني',
      priceIncludesUtilities: json['priceIncludesUtilities'] as bool? ?? false,
      deposit: json['deposit'] != null ? (json['deposit'] as num).toDouble() : null,
      advance: json['advance'] != null ? (json['advance'] as num).toDouble() : null,
      hasBrokerage: json['hasBrokerage'] as bool? ?? false,
      negotiable: json['negotiable'] as bool? ?? false,
      requiresGuarantee: json['requiresGuarantee'] as bool? ?? false,
      guaranteeType: json['guaranteeType'] as String?,
      isCommercial: json['isCommercial'] as bool? ?? false,
      contactPhone: json['contactPhone'] as String,
      sellerType: json['sellerType'] as String,
      sellerName: json['sellerName'] as String?,
      images: json['images'] != null ? List<String>.from(json['images']) : [],
      createdAt: json['createdAt'] != null ? DateTime.parse(json['createdAt']) : DateTime.now(),
      updatedAt: json['updatedAt'] != null ? DateTime.parse(json['updatedAt']) : null,
      isActive: json['isActive'] as bool? ?? true,
      isFeatured: json['isFeatured'] as bool? ?? false,
    );
  }
  
  // إلى JSON
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'type': type,
      'title': title,
      'description': description,
      'district': district,
      'neighborhood': neighborhood,
      'street': street,
      'locationDescription': locationDescription,
      'buildingType': buildingType,
      'floor': floor,
      'roomCount': roomCount,
      'rooms': rooms?.map((r) => r.toJson()).toList(),
      'hasKitchen': hasKitchen,
      'kitchenSize': kitchenSize,
      'bathroomCount': bathroomCount,
      'hasExternalMajlis': hasExternalMajlis,
      'externalMajlisHasBathroom': externalMajlisHasBathroom,
      'waterSource': waterSource,
      'waterIndependence': waterIndependence,
      'waterTankCapacity': waterTankCapacity,
      'electricityType': electricityType,
      'electricityIndependence': electricityIndependence,
      'hasSolarPanels': hasSolarPanels,
      'sunlightDirection': sunlightDirection,
      'price': price,
      'currency': currency,
      'priceIncludesUtilities': priceIncludesUtilities,
      'deposit': deposit,
      'advance': advance,
      'hasBrokerage': hasBrokerage,
      'negotiable': negotiable,
      'requiresGuarantee': requiresGuarantee,
      'guaranteeType': guaranteeType,
      'isCommercial': isCommercial,
      'contactPhone': contactPhone,
      'sellerType': sellerType,
      'sellerName': sellerName,
      'images': images,
      'createdAt': createdAt.toIso8601String(),
      'updatedAt': updatedAt?.toIso8601String(),
      'isActive': isActive,
      'isFeatured': isFeatured,
    };
  }
}

/// تفاصيل الغرفة (الطول × العرض)
class RoomDetail {
  final String name; // اسم الغرفة (غرفة 1، غرفة 2، مجلس)
  final double? length; // الطول (بالأمتار)
  final double? width; // العرض (بالأمتار)
  
  RoomDetail({
    required this.name,
    this.length,
    this.width,
  });
  
  String getSizeText() {
    if (length != null && width != null) {
      return '${length} × ${width} م';
    }
    return 'غير محدد';
  }
  
  factory RoomDetail.fromJson(Map<String, dynamic> json) {
    return RoomDetail(
      name: json['name'] as String,
      length: json['length'] != null ? (json['length'] as num).toDouble() : null,
      width: json['width'] != null ? (json['width'] as num).toDouble() : null,
    );
  }
  
  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'length': length,
      'width': width,
    };
  }
}
