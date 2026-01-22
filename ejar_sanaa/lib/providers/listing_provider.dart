import 'package:flutter/foundation.dart';
import 'package:ejar_sanaa/models/listing_model.dart';

class ListingProvider with ChangeNotifier {
  List<Listing> _listings = [];
  List<Listing> _filteredListings = [];
  
  // Filters
  String? _selectedType;
  String? _selectedDistrict;
  double? _minPrice;
  double? _maxPrice;
  int? _minRooms;
  String? _waterSource;
  String? _electricityType;
  String? _sunlightDirection;
  bool? _hasExternalMajlis;
  
  List<Listing> get listings => _filteredListings.isNotEmpty ? _filteredListings : _listings;
  List<Listing> get allListings => _listings;
  
  // Getters for filters
  String? get selectedType => _selectedType;
  String? get selectedDistrict => _selectedDistrict;
  double? get minPrice => _minPrice;
  double? get maxPrice => _maxPrice;
  int? get minRooms => _minRooms;
  String? get waterSource => _waterSource;
  String? get electricityType => _electricityType;
  String? get sunlightDirection => _sunlightDirection;
  bool? get hasExternalMajlis => _hasExternalMajlis;
  
  // Load listings (في المستقبل من API أو قاعدة بيانات)
  Future<void> loadListings() async {
    // بيانات تجريبية للاختبار
    _listings = [
      Listing(
        id: '1',
        type: 'apartment',
        title: 'شقة للايجار في السبعين',
        description: 'شقة جميلة ومناسبة للعائلة',
        district: 'sabaeen',
        neighborhood: 'الأصبحي',
        street: 'شارع الزبيري',
        locationDescription: 'قرب مسجد وسوق',
        buildingType: 'شقة في عمارة',
        floor: 'first',
        roomCount: 3,
        rooms: [
          RoomDetail(name: 'غرفة 1', length: 4, width: 3.5),
          RoomDetail(name: 'غرفة 2', length: 3.5, width: 3),
          RoomDetail(name: 'غرفة 3', length: 3, width: 2.5),
        ],
        hasKitchen: true,
        kitchenSize: '3 × 2.5 م',
        bathroomCount: 2,
        hasExternalMajlis: true,
        externalMajlisHasBathroom: true,
        waterSource: 'government',
        waterIndependence: 'independent',
        electricityType: 'commercial',
        electricityIndependence: 'independent',
        hasSolarPanels: true,
        sunlightDirection: 'south',
        price: 50000,
        currency: 'ريال يمني',
        priceIncludesUtilities: false,
        deposit: 50000,
        advance: 50000,
        negotiable: true,
        requiresGuarantee: true,
        guaranteeType: 'تجاري',
        isCommercial: false,
        contactPhone: '+967712345678',
        sellerType: 'owner',
        sellerName: 'أحمد محمد',
        images: [],
        isFeatured: true,
      ),
    ];
    _filteredListings = _listings;
    notifyListeners();
  }
  
  // Add new listing
  Future<void> addListing(Listing listing) async {
    _listings.add(listing);
    applyFilters();
    notifyListeners();
  }
  
  // Get listing by ID
  Listing? getListingById(String id) {
    try {
      return _listings.firstWhere((listing) => listing.id == id);
    } catch (e) {
      return null;
    }
  }
  
  // Apply filters
  void applyFilters({
    String? type,
    String? district,
    double? minPrice,
    double? maxPrice,
    int? minRooms,
    String? waterSource,
    String? electricityType,
    String? sunlightDirection,
    bool? hasExternalMajlis,
  }) {
    _selectedType = type ?? _selectedType;
    _selectedDistrict = district ?? _selectedDistrict;
    _minPrice = minPrice ?? _minPrice;
    _maxPrice = maxPrice ?? _maxPrice;
    _minRooms = minRooms ?? _minRooms;
    _waterSource = waterSource ?? _waterSource;
    _electricityType = electricityType ?? _electricityType;
    _sunlightDirection = sunlightDirection ?? _sunlightDirection;
    _hasExternalMajlis = hasExternalMajlis ?? _hasExternalMajlis;
    
    _filteredListings = _listings.where((listing) {
      // Filter by type
      if (_selectedType != null && listing.type != _selectedType) {
        return false;
      }
      
      // Filter by district
      if (_selectedDistrict != null && listing.district != _selectedDistrict) {
        return false;
      }
      
      // Filter by price
      if (_minPrice != null && listing.price < _minPrice!) {
        return false;
      }
      if (_maxPrice != null && listing.price > _maxPrice!) {
        return false;
      }
      
      // Filter by rooms
      if (_minRooms != null && (listing.roomCount ?? 0) < _minRooms!) {
        return false;
      }
      
      // Filter by water source
      if (_waterSource != null && listing.waterSource != _waterSource) {
        return false;
      }
      
      // Filter by electricity type
      if (_electricityType != null && listing.electricityType != _electricityType) {
        return false;
      }
      
      // Filter by sunlight direction
      if (_sunlightDirection != null && listing.sunlightDirection != _sunlightDirection) {
        return false;
      }
      
      // Filter by external majlis
      if (_hasExternalMajlis != null && listing.hasExternalMajlis != _hasExternalMajlis) {
        return false;
      }
      
      return true;
    }).toList();
    
    notifyListeners();
  }
  
  // Clear filters
  void clearFilters() {
    _selectedType = null;
    _selectedDistrict = null;
    _minPrice = null;
    _maxPrice = null;
    _minRooms = null;
    _waterSource = null;
    _electricityType = null;
    _sunlightDirection = null;
    _hasExternalMajlis = null;
    _filteredListings = _listings;
    notifyListeners();
  }
}
