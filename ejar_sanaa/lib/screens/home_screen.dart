import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:go_router/go_router.dart';
import 'package:ejar_sanaa/core/theme/app_theme.dart';
import 'package:ejar_sanaa/core/constants/districts.dart';
import 'package:ejar_sanaa/providers/listing_provider.dart';
import 'package:ejar_sanaa/widgets/listing_card.dart';
import 'package:ejar_sanaa/widgets/category_card.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<ListingProvider>().loadListings();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('إيجار صنعاء'),
        actions: [
          IconButton(
            icon: const Icon(Icons.search),
            onPressed: () => context.push('/search'),
          ),
        ],
      ),
      body: RefreshIndicator(
        onRefresh: () async {
          await context.read<ListingProvider>().loadListings();
        },
        child: SingleChildScrollView(
          physics: const AlwaysScrollableScrollPhysics(),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Search Bar
              Padding(
                padding: const EdgeInsets.all(16),
                child: GestureDetector(
                  onTap: () => context.push('/search'),
                  child: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(color: AppTheme.borderColor),
                    ),
                    child: Row(
                      children: const [
                        Icon(Icons.search, color: AppTheme.textColor),
                        SizedBox(width: 12),
                        Text(
                          'ابحث عن إيجار...',
                          style: TextStyle(
                            fontSize: 16,
                            color: AppTheme.textColor,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              
              // Categories
              const Padding(
                padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                child: Text(
                  'الفئات',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: AppTheme.textColor,
                  ),
                ),
              ),
              SizedBox(
                height: 120,
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  itemCount: RentalTypes.types.length,
                  itemBuilder: (context, index) {
                    final type = RentalTypes.types[index];
                    return CategoryCard(
                      icon: type['icon'] as String,
                      label: type['name'] as String,
                      onTap: () {
                        // Navigate to search with filter
                        context.push('/search?type=${type['id']}');
                      },
                    );
                  },
                ),
              ),
              
              const SizedBox(height: 24),
              
              // Featured Listings
              const Padding(
                padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                child: Text(
                  'الإعلانات المميزة',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: AppTheme.textColor,
                  ),
                ),
              ),
              
              // Listings List
              Consumer<ListingProvider>(
                builder: (context, provider, child) {
                  final listings = provider.listings;
                  
                  if (listings.isEmpty) {
                    return const Padding(
                      padding: EdgeInsets.all(32),
                      child: Center(
                        child: Text(
                          'لا توجد إعلانات متاحة حالياً',
                          style: TextStyle(
                            fontSize: 16,
                            color: AppTheme.textColor,
                          ),
                        ),
                      ),
                    );
                  }
                  
                  return ListView.builder(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: listings.length,
                    itemBuilder: (context, index) {
                      final listing = listings[index];
                      return ListingCard(
                        listing: listing,
                        onTap: () {
                          context.push('/listing/${listing.id}');
                        },
                      );
                    },
                  );
                },
              ),
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () => context.push('/add-listing'),
        backgroundColor: AppTheme.primaryColor,
        icon: const Icon(Icons.add, color: Colors.white),
        label: const Text(
          'إضافة إعلان',
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }
}
