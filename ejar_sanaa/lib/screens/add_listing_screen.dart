import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:go_router/go_router.dart';
import 'package:ejar_sanaa/core/theme/app_theme.dart';
import 'package:ejar_sanaa/core/constants/districts.dart';
import 'package:ejar_sanaa/models/listing_model.dart';
import 'package:ejar_sanaa/providers/listing_provider.dart';

class AddListingScreen extends StatefulWidget {
  const AddListingScreen({super.key});

  @override
  State<AddListingScreen> createState() => _AddListingScreenState();
}

class _AddListingScreenState extends State<AddListingScreen> {
  int _currentStep = 0;
  
  // Form Data
  String? _selectedType;
  String _title = '';
  String _description = '';
  String? _selectedDistrict;
  String? _neighborhood;
  String? _street;
  String? _locationDescription;
  String? _buildingType;
  String? _floor;
  int? _roomCount;
  bool _hasKitchen = false;
  String? _kitchenSize;
  int? _bathroomCount;
  bool _hasExternalMajlis = false;
  bool _externalMajlisHasBathroom = false;
  String? _waterSource;
  String? _waterIndependence;
  String? _electricityType;
  String? _electricityIndependence;
  bool _hasSolarPanels = false;
  String? _sunlightDirection;
  double? _price;
  String _currency = 'ريال يمني';
  bool _priceIncludesUtilities = false;
  double? _deposit;
  double? _advance;
  bool _hasBrokerage = false;
  bool _negotiable = false;
  bool _requiresGuarantee = false;
  String? _guaranteeType;
  bool _isCommercial = false;
  String _contactPhone = '';
  String _sellerType = 'owner';
  String? _sellerName;

  final PageController _pageController = PageController();
  final List<GlobalKey<FormState>> _formKeys = [
    GlobalKey<FormState>(),
    GlobalKey<FormState>(),
    GlobalKey<FormState>(),
    GlobalKey<FormState>(),
  ];

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  void _nextStep() {
    if (_formKeys[_currentStep].currentState?.validate() ?? false) {
      if (_currentStep < 3) {
        setState(() => _currentStep++);
        _pageController.nextPage(
          duration: const Duration(milliseconds: 300),
          curve: Curves.easeInOut,
        );
      } else {
        _submitListing();
      }
    }
  }

  void _previousStep() {
    if (_currentStep > 0) {
      setState(() => _currentStep--);
      _pageController.previousPage(
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
    }
  }

  Future<void> _submitListing() async {
    if (_selectedType == null || _price == null || _contactPhone.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('الرجاء إكمال جميع الحقول المطلوبة')),
      );
      return;
    }

    final listing = Listing(
      id: DateTime.now().millisecondsSinceEpoch.toString(),
      type: _selectedType!,
      title: _title,
      description: _description,
      district: _selectedDistrict ?? '',
      neighborhood: _neighborhood,
      street: _street,
      locationDescription: _locationDescription,
      buildingType: _buildingType,
      floor: _floor,
      roomCount: _roomCount,
      hasKitchen: _hasKitchen,
      kitchenSize: _kitchenSize,
      bathroomCount: _bathroomCount,
      hasExternalMajlis: _hasExternalMajlis,
      externalMajlisHasBathroom: _externalMajlisHasBathroom,
      waterSource: _waterSource,
      waterIndependence: _waterIndependence,
      electricityType: _electricityType,
      electricityIndependence: _electricityIndependence,
      hasSolarPanels: _hasSolarPanels,
      sunlightDirection: _sunlightDirection,
      price: _price!,
      currency: _currency,
      priceIncludesUtilities: _priceIncludesUtilities,
      deposit: _deposit,
      advance: _advance,
      hasBrokerage: _hasBrokerage,
      negotiable: _negotiable,
      requiresGuarantee: _requiresGuarantee,
      guaranteeType: _guaranteeType,
      isCommercial: _isCommercial,
      contactPhone: _contactPhone,
      sellerType: _sellerType,
      sellerName: _sellerName,
    );

    await context.read<ListingProvider>().addListing(listing);
    
    if (mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('تم إضافة الإعلان بنجاح')),
      );
      context.go('/home');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('إضافة إعلان جديد'),
        leading: IconButton(
          icon: const Icon(Icons.close),
          onPressed: () => context.pop(),
        ),
      ),
      body: Column(
        children: [
          // Progress Indicator
          Padding(
            padding: const EdgeInsets.all(16),
            child: Row(
              children: List.generate(4, (index) {
                return Expanded(
                  child: Container(
                    margin: const EdgeInsets.symmetric(horizontal: 4),
                    height: 4,
                    decoration: BoxDecoration(
                      color: index <= _currentStep
                          ? AppTheme.primaryColor
                          : AppTheme.borderColor,
                      borderRadius: BorderRadius.circular(2),
                    ),
                  ),
                );
              }),
            ),
          ),
          
          // Steps Content
          Expanded(
            child: PageView(
              controller: _pageController,
              physics: const NeverScrollableScrollPhysics(),
              children: [
                _buildStep1(),
                _buildStep2(),
                _buildStep3(),
                _buildStep4(),
              ],
            ),
          ),
          
          // Navigation Buttons
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: Colors.white,
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.05),
                  blurRadius: 10,
                  offset: const Offset(0, -2),
                ),
              ],
            ),
            child: Row(
              children: [
                if (_currentStep > 0)
                  Expanded(
                    child: OutlinedButton(
                      onPressed: _previousStep,
                      child: const Text('السابق'),
                    ),
                  ),
                if (_currentStep > 0) const SizedBox(width: 12),
                Expanded(
                  child: ElevatedButton(
                    onPressed: _nextStep,
                    child: Text(_currentStep < 3 ? 'التالي' : 'نشر الإعلان'),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildStep1() {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Form(
        key: _formKeys[0],
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'ما نوع الإيجار؟',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 16),
            Wrap(
              spacing: 12,
              runSpacing: 12,
              children: RentalTypes.types.map((type) {
                final isSelected = _selectedType == type['id'];
                return GestureDetector(
                  onTap: () => setState(() => _selectedType = type['id'] as String),
                  child: Container(
                    width: (MediaQuery.of(context).size.width - 60) / 3,
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: isSelected ? AppTheme.primaryColor.withOpacity(0.1) : Colors.white,
                      border: Border.all(
                        color: isSelected ? AppTheme.primaryColor : AppTheme.borderColor,
                        width: isSelected ? 2 : 1,
                      ),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Column(
                      children: [
                        Text(type['icon'] as String, style: const TextStyle(fontSize: 32)),
                        const SizedBox(height: 8),
                        Text(
                          type['name'] as String,
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
                            color: isSelected ? AppTheme.primaryColor : AppTheme.textColor,
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              }).toList(),
            ),
            const SizedBox(height: 24),
            TextFormField(
              decoration: const InputDecoration(
                labelText: 'عنوان الإعلان *',
                hintText: 'مثال: شقة للايجار في السبعين',
              ),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'الرجاء إدخال عنوان الإعلان';
                }
                return null;
              },
              onSaved: (value) => _title = value ?? '',
              onChanged: (value) => _title = value,
            ),
            const SizedBox(height: 16),
            TextFormField(
              decoration: const InputDecoration(
                labelText: 'وصف الإعلان (اختياري)',
                hintText: 'وصف مختصر عن العقار...',
              ),
              maxLines: 3,
              onChanged: (value) => _description = value,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildStep2() {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Form(
        key: _formKeys[1],
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'الموقع',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 16),
            DropdownButtonFormField<String>(
              decoration: const InputDecoration(labelText: 'المديرية *'),
              value: _selectedDistrict,
              items: Districts.districts.map((district) {
                return DropdownMenuItem(
                  value: district['id'] as String,
                  child: Text(district['name'] as String),
                );
              }).toList(),
              onChanged: (value) => setState(() => _selectedDistrict = value),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'الرجاء اختيار المديرية';
                }
                return null;
              },
            ),
            const SizedBox(height: 16),
            TextFormField(
              decoration: const InputDecoration(labelText: 'الحي / الحارة'),
              onChanged: (value) => _neighborhood = value,
            ),
            const SizedBox(height: 16),
            TextFormField(
              decoration: const InputDecoration(labelText: 'وصف الموقع'),
              maxLines: 2,
              onChanged: (value) => _locationDescription = value,
            ),
            const SizedBox(height: 24),
            const Text(
              'تفاصيل العقار',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 16),
            TextFormField(
              decoration: const InputDecoration(labelText: 'نوع المبنى'),
              onChanged: (value) => _buildingType = value,
            ),
            const SizedBox(height: 16),
            DropdownButtonFormField<String>(
              decoration: const InputDecoration(labelText: 'الدور'),
              value: _floor,
              items: [
                Floors.ground,
                Floors.first,
                Floors.second,
                Floors.third,
                Floors.fourth,
              ].map((floor) {
                return DropdownMenuItem(
                  value: floor,
                  child: Text(Floors.getName(floor)),
                );
              }).toList(),
              onChanged: (value) => setState(() => _floor = value),
            ),
            const SizedBox(height: 16),
            TextFormField(
              decoration: const InputDecoration(labelText: 'عدد الغرف'),
              keyboardType: TextInputType.number,
              onChanged: (value) {
                _roomCount = value.isNotEmpty ? int.tryParse(value) : null;
              },
            ),
            const SizedBox(height: 16),
            SwitchListTile(
              title: const Text('يوجد مطبخ'),
              value: _hasKitchen,
              onChanged: (value) => setState(() => _hasKitchen = value),
            ),
            if (_hasKitchen) ...[
              const SizedBox(height: 8),
              TextFormField(
                decoration: const InputDecoration(labelText: 'حجم المطبخ (مثال: 3 × 2.5 م)'),
                onChanged: (value) => _kitchenSize = value,
              ),
            ],
            const SizedBox(height: 16),
            TextFormField(
              decoration: const InputDecoration(labelText: 'عدد الحمامات'),
              keyboardType: TextInputType.number,
              onChanged: (value) {
                _bathroomCount = value.isNotEmpty ? int.tryParse(value) : null;
              },
            ),
            const SizedBox(height: 16),
            SwitchListTile(
              title: const Text('يوجد مجلس خارجي'),
              value: _hasExternalMajlis,
              onChanged: (value) => setState(() => _hasExternalMajlis = value),
            ),
            if (_hasExternalMajlis)
              SwitchListTile(
                title: const Text('المجلس الخارجي مع حمام'),
                value: _externalMajlisHasBathroom,
                onChanged: (value) => setState(() => _externalMajlisHasBathroom = value),
              ),
          ],
        ),
      ),
    );
  }

  Widget _buildStep3() {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Form(
        key: _formKeys[2],
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'الخدمات',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 16),
            const Text('الماء 💧', style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600)),
            DropdownButtonFormField<String>(
              decoration: const InputDecoration(labelText: 'مصدر الماء'),
              value: _waterSource,
              items: [
                WaterSources.government,
                WaterSources.tank,
                WaterSources.waterTruck,
              ].map((source) {
                return DropdownMenuItem(
                  value: source,
                  child: Text(WaterSources.getName(source)),
                );
              }).toList(),
              onChanged: (value) => setState(() => _waterSource = value),
            ),
            const SizedBox(height: 16),
            DropdownButtonFormField<String>(
              decoration: const InputDecoration(labelText: 'الماء'),
              value: _waterIndependence,
              items: const [
                DropdownMenuItem(value: 'independent', child: Text('مستقل')),
                DropdownMenuItem(value: 'shared', child: Text('مشترك')),
              ],
              onChanged: (value) => setState(() => _waterIndependence = value),
            ),
            const SizedBox(height: 24),
            const Text('الكهرباء ⚡', style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600)),
            DropdownButtonFormField<String>(
              decoration: const InputDecoration(labelText: 'نوع الكهرباء'),
              value: _electricityType,
              items: [
                ElectricityTypes.government,
                ElectricityTypes.commercial,
                ElectricityTypes.solar,
              ].map((type) {
                return DropdownMenuItem(
                  value: type,
                  child: Text(ElectricityTypes.getName(type)),
                );
              }).toList(),
              onChanged: (value) => setState(() => _electricityType = value),
            ),
            const SizedBox(height: 16),
            DropdownButtonFormField<String>(
              decoration: const InputDecoration(labelText: 'الكهرباء'),
              value: _electricityIndependence,
              items: const [
                DropdownMenuItem(value: 'independent', child: Text('مستقل')),
                DropdownMenuItem(value: 'shared', child: Text('مشترك')),
              ],
              onChanged: (value) => setState(() => _electricityIndependence = value),
            ),
            const SizedBox(height: 16),
            SwitchListTile(
              title: const Text('يوجد ألواح شمسية'),
              value: _hasSolarPanels,
              onChanged: (value) => setState(() => _hasSolarPanels = value),
            ),
            const SizedBox(height: 24),
            const Text('دخول الشمس ☀️', style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600)),
            DropdownButtonFormField<String>(
              decoration: const InputDecoration(labelText: 'اتجاه الشمس'),
              value: _sunlightDirection,
              items: [
                SunlightDirections.south,
                SunlightDirections.east,
                SunlightDirections.west,
                SunlightDirections.north,
              ].map((direction) {
                return DropdownMenuItem(
                  value: direction,
                  child: Text(SunlightDirections.getName(direction)),
                );
              }).toList(),
              onChanged: (value) => setState(() => _sunlightDirection = value),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildStep4() {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Form(
        key: _formKeys[3],
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'السعر والتواصل',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 16),
            TextFormField(
              decoration: const InputDecoration(labelText: 'السعر الشهري *'),
              keyboardType: TextInputType.number,
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'الرجاء إدخال السعر';
                }
                if (double.tryParse(value) == null) {
                  return 'الرجاء إدخال رقم صحيح';
                }
                return null;
              },
              onChanged: (value) {
                _price = value.isNotEmpty ? double.tryParse(value) : null;
              },
            ),
            const SizedBox(height: 16),
            SwitchListTile(
              title: const Text('السعر شامل الماء والكهرباء'),
              value: _priceIncludesUtilities,
              onChanged: (value) => setState(() => _priceIncludesUtilities = value),
            ),
            const SizedBox(height: 16),
            TextFormField(
              decoration: const InputDecoration(labelText: 'التأمين (اختياري)'),
              keyboardType: TextInputType.number,
              onChanged: (value) {
                _deposit = value.isNotEmpty ? double.tryParse(value) : null;
              },
            ),
            const SizedBox(height: 16),
            SwitchListTile(
              title: const Text('قابل للتفاوض'),
              value: _negotiable,
              onChanged: (value) => setState(() => _negotiable = value),
            ),
            const SizedBox(height: 16),
            SwitchListTile(
              title: const Text('يوجد ساعية (دلالة)'),
              value: _hasBrokerage,
              onChanged: (value) => setState(() => _hasBrokerage = value),
            ),
            const SizedBox(height: 24),
            const Text(
              'معلومات التواصل',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 16),
            TextFormField(
              decoration: const InputDecoration(labelText: 'رقم الهاتف *'),
              keyboardType: TextInputType.phone,
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'الرجاء إدخال رقم الهاتف';
                }
                return null;
              },
              onChanged: (value) => _contactPhone = value,
            ),
            const SizedBox(height: 16),
            DropdownButtonFormField<String>(
              decoration: const InputDecoration(labelText: 'صفة البائع *'),
              value: _sellerType,
              items: [
                SellerTypes.owner,
                SellerTypes.agent,
                SellerTypes.broker,
              ].map((type) {
                return DropdownMenuItem(
                  value: type,
                  child: Text(SellerTypes.getName(type)),
                );
              }).toList(),
              onChanged: (value) => setState(() => _sellerType = value ?? 'owner'),
            ),
            const SizedBox(height: 16),
            TextFormField(
              decoration: const InputDecoration(labelText: 'اسم البائع (اختياري)'),
              onChanged: (value) => _sellerName = value,
            ),
          ],
        ),
      ),
    );
  }
}
