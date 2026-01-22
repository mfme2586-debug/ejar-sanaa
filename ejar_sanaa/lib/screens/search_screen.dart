import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:go_router/go_router.dart';
import 'package:ejar_sanaa/core/theme/app_theme.dart';
import 'package:ejar_sanaa/core/constants/districts.dart';
import 'package:ejar_sanaa/providers/listing_provider.dart';
import 'package:ejar_sanaa/widgets/listing_card.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key});

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  final TextEditingController _searchController = TextEditingController();
  String? _selectedType;
  String? _selectedDistrict;
  RangeValues _priceRange = const RangeValues(0, 200000);
  int? _minRooms;
  String? _selectedWater;
  String? _selectedElectricity;
  String? _selectedSunlight;

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  void _applyFilters() {
    context.read<ListingProvider>().applyFilters(
          type: _selectedType,
          district: _selectedDistrict,
          minPrice: _priceRange.start,
          maxPrice: _priceRange.end,
          minRooms: _minRooms,
          waterSource: _selectedWater,
          electricityType: _selectedElectricity,
          sunlightDirection: _selectedSunlight,
        );
  }

  @override
  Widget build(BuildContext context) {
    final provider = context.watch<ListingProvider>();
    
    return Scaffold(
      appBar: AppBar(title: const Text('البحث والفلاتر')),
      body: Column(
        children: [
          // Search Bar
          Padding(
            padding: const EdgeInsets.all(16),
            child: TextField(
              controller: _searchController,
              decoration: const InputDecoration(
                hintText: 'ابحث عن...',
                prefixIcon: Icon(Icons.search),
              ),
              onChanged: (_) => _applyFilters(),
            ),
          ),
          
          // Filters Section
          Expanded(
            flex: 1,
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Type Filter
                  _buildSectionTitle('نوع الإيجار'),
                  Wrap(
                    spacing: 8,
                    runSpacing: 8,
                    children: RentalTypes.types.map((type) {
                      final isSelected = _selectedType == type['id'];
                      return FilterChip(
                        label: Text('${type['icon']} ${type['name']}'),
                        selected: isSelected,
                        onSelected: (selected) {
                          setState(() {
                            _selectedType = selected ? type['id'] as String : null;
                          });
                          _applyFilters();
                        },
                      );
                    }).toList(),
                  ),
                  const SizedBox(height: 24),
                  
                  // District Filter
                  _buildSectionTitle('المديرية'),
                  Wrap(
                    spacing: 8,
                    runSpacing: 8,
                    children: Districts.districts.map((district) {
                      final isSelected = _selectedDistrict == district['id'];
                      return FilterChip(
                        label: Text(district['name']),
                        selected: isSelected,
                        onSelected: (selected) {
                          setState(() {
                            _selectedDistrict = selected ? district['id'] as String : null;
                          });
                          _applyFilters();
                        },
                      );
                    }).toList(),
                  ),
                  const SizedBox(height: 24),
                  
                  // Price Range
                  _buildSectionTitle('السعر'),
                  RangeSlider(
                    values: _priceRange,
                    min: 0,
                    max: 200000,
                    divisions: 20,
                    labels: RangeLabels(
                      '${_priceRange.start.toInt()}',
                      '${_priceRange.end.toInt()}',
                    ),
                    onChanged: (values) {
                      setState(() {
                        _priceRange = values;
                      });
                      _applyFilters();
                    },
                  ),
                  const SizedBox(height: 24),
                  
                  // Rooms Filter
                  _buildSectionTitle('عدد الغرف'),
                  Wrap(
                    spacing: 8,
                    children: [1, 2, 3, 4, 5].map((count) {
                      final isSelected = _minRooms == count;
                      return FilterChip(
                        label: Text('$count+ غرف'),
                        selected: isSelected,
                        onSelected: (selected) {
                          setState(() {
                            _minRooms = selected ? count : null;
                          });
                          _applyFilters();
                        },
                      );
                    }).toList(),
                  ),
                  const SizedBox(height: 24),
                  
                  // Water Filter
                  _buildSectionTitle('مصدر الماء'),
                  Wrap(
                    spacing: 8,
                    children: [
                      _buildFilterOption('حكومي', 'government', _selectedWater, (value) {
                        setState(() => _selectedWater = value);
                        _applyFilters();
                      }),
                      _buildFilterOption('خزان', 'tank', _selectedWater, (value) {
                        setState(() => _selectedWater = value);
                        _applyFilters();
                      }),
                      _buildFilterOption('مستقل', 'independent', _selectedWater, (value) {
                        setState(() => _selectedWater = value);
                        _applyFilters();
                      }),
                    ],
                  ),
                  const SizedBox(height: 24),
                  
                  // Electricity Filter
                  _buildSectionTitle('نوع الكهرباء'),
                  Wrap(
                    spacing: 8,
                    children: [
                      _buildFilterOption('حكومي', 'government', _selectedElectricity, (value) {
                        setState(() => _selectedElectricity = value);
                        _applyFilters();
                      }),
                      _buildFilterOption('تجاري', 'commercial', _selectedElectricity, (value) {
                        setState(() => _selectedElectricity = value);
                        _applyFilters();
                      }),
                      _buildFilterOption('شمسي', 'solar', _selectedElectricity, (value) {
                        setState(() => _selectedElectricity = value);
                        _applyFilters();
                      }),
                    ],
                  ),
                  const SizedBox(height: 24),
                  
                  // Sunlight Filter (مهم جداً)
                  _buildSectionTitle('دخول الشمس ☀️'),
                  Wrap(
                    spacing: 8,
                    children: [
                      _buildFilterOption('جنوبي (مشمس)', 'south', _selectedSunlight, (value) {
                        setState(() => _selectedSunlight = value);
                        _applyFilters();
                      }),
                      _buildFilterOption('شرقي', 'east', _selectedSunlight, (value) {
                        setState(() => _selectedSunlight = value);
                        _applyFilters();
                      }),
                      _buildFilterOption('غربي', 'west', _selectedSunlight, (value) {
                        setState(() => _selectedSunlight = value);
                        _applyFilters();
                      }),
                    ],
                  ),
                  const SizedBox(height: 24),
                  
                  // Clear Filters Button
                  Center(
                    child: OutlinedButton.icon(
                      onPressed: () {
                        setState(() {
                          _selectedType = null;
                          _selectedDistrict = null;
                          _priceRange = const RangeValues(0, 200000);
                          _minRooms = null;
                          _selectedWater = null;
                          _selectedElectricity = null;
                          _selectedSunlight = null;
                        });
                        provider.clearFilters();
                      },
                      icon: const Icon(Icons.clear),
                      label: const Text('مسح الفلاتر'),
                    ),
                  ),
                ],
              ),
            ),
          ),
          
          // Results List
          Expanded(
            flex: 2,
            child: provider.listings.isEmpty
                ? const Center(
                    child: Text('لا توجد نتائج'),
                  )
                : ListView.builder(
                    itemCount: provider.listings.length,
                    itemBuilder: (context, index) {
                      final listing = provider.listings[index];
                      return ListingCard(
                        listing: listing,
                        onTap: () => context.push('/listing/${listing.id}'),
                      );
                    },
                  ),
          ),
        ],
      ),
    );
  }

  Widget _buildSectionTitle(String title) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: Text(
        title,
        style: const TextStyle(
          fontSize: 18,
          fontWeight: FontWeight.bold,
          color: AppTheme.textColor,
        ),
      ),
    );
  }

  Widget _buildFilterOption(String label, String value, String? selected, ValueChanged<String?> onChanged) {
    final isSelected = selected == value;
    return FilterChip(
      label: Text(label),
      selected: isSelected,
      onSelected: (selected) {
        onChanged(selected ? value : null);
      },
    );
  }
}
