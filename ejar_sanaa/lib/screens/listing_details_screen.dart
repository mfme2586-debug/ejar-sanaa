import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:ejar_sanaa/core/theme/app_theme.dart';
import 'package:ejar_sanaa/core/constants/districts.dart';
import 'package:ejar_sanaa/models/listing_model.dart';
import 'package:ejar_sanaa/providers/listing_provider.dart';
import 'package:intl/intl.dart';

class ListingDetailsScreen extends StatelessWidget {
  final String listingId;

  const ListingDetailsScreen({
    super.key,
    required this.listingId,
  });

  @override
  Widget build(BuildContext context) {
    final listing = context.watch<ListingProvider>().getListingById(listingId);

    if (listing == null) {
      return Scaffold(
        appBar: AppBar(title: const Text('تفاصيل الإعلان')),
        body: const Center(
          child: Text('الإعلان غير موجود'),
        ),
      );
    }

    return Scaffold(
      appBar: AppBar(title: const Text('تفاصيل الإعلان')),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Image Gallery
            _buildImageGallery(listing),
            
            // Content
            Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Title & Price
                  _buildTitleAndPrice(listing),
                  const SizedBox(height: 24),
                  
                  // Location Section
                  _buildSection(
                    title: 'الموقع',
                    icon: Icons.location_on,
                    child: _buildLocationSection(listing),
                  ),
                  const SizedBox(height: 24),
                  
                  // Property Details
                  _buildSection(
                    title: 'تفاصيل العقار',
                    icon: Icons.home,
                    child: _buildPropertyDetails(listing),
                  ),
                  const SizedBox(height: 24),
                  
                  // Services (Water & Electricity)
                  _buildSection(
                    title: 'الخدمات',
                    icon: Icons.build,
                    child: _buildServicesSection(listing),
                  ),
                  const SizedBox(height: 24),
                  
                  // Financial Terms
                  _buildSection(
                    title: 'الشروط المالية',
                    icon: Icons.account_balance_wallet,
                    child: _buildFinancialSection(listing),
                  ),
                  const SizedBox(height: 24),
                ],
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: _buildContactBar(context, listing),
    );
  }

  Widget _buildImageGallery(Listing listing) {
    return Container(
      height: 300,
      width: double.infinity,
      color: AppTheme.borderColor.withOpacity(0.3),
      child: listing.images.isNotEmpty
          ? Image.network(
              listing.images.first,
              fit: BoxFit.cover,
              errorBuilder: (context, error, stackTrace) => _buildPlaceholder(),
            )
          : _buildPlaceholder(),
    );
  }

  Widget _buildPlaceholder() {
    return Container(
      color: AppTheme.borderColor.withOpacity(0.2),
      child: const Icon(
        Icons.home,
        size: 80,
        color: AppTheme.textColor,
      ),
    );
  }

  Widget _buildTitleAndPrice(Listing listing) {
    final formatter = NumberFormat('#,###');
    final priceText = '${formatter.format(listing.price)} ${listing.currency}';
    
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          listing.title,
          style: const TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
            color: AppTheme.textColor,
          ),
        ),
        const SizedBox(height: 8),
        Text(
          priceText,
          style: const TextStyle(
            fontSize: 28,
            fontWeight: FontWeight.bold,
            color: AppTheme.primaryColor,
          ),
        ),
        if (listing.priceIncludesUtilities)
          const Text(
            'السعر شامل الماء والكهرباء',
            style: TextStyle(
              fontSize: 14,
              color: AppTheme.successColor,
            ),
          ),
        if (!listing.priceIncludesUtilities)
          const Text(
            'السعر غير شامل الماء والكهرباء',
            style: TextStyle(
              fontSize: 14,
              color: AppTheme.textColor,
            ),
          ),
      ],
    );
  }

  Widget _buildSection({required String title, required IconData icon, required Widget child}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Icon(icon, color: AppTheme.primaryColor),
            const SizedBox(width: 8),
            Text(
              title,
              style: const TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: AppTheme.textColor,
              ),
            ),
          ],
        ),
        const SizedBox(height: 12),
        child,
      ],
    );
  }

  Widget _buildLocationSection(Listing listing) {
    return Column(
      children: [
        _buildDetailRow('المديرية', Districts.getDistrictName(listing.district)),
        if (listing.neighborhood != null)
          _buildDetailRow('الحي', listing.neighborhood!),
        if (listing.street != null)
          _buildDetailRow('الحارة', listing.street!),
        if (listing.locationDescription != null)
          _buildDetailRow('وصف الموقع', listing.locationDescription!),
      ],
    );
  }

  Widget _buildPropertyDetails(Listing listing) {
    return Column(
      children: [
        if (listing.buildingType != null)
          _buildDetailRow('نوع العقار', listing.buildingType!),
        if (listing.floor != null)
          _buildDetailRow('الدور', Floors.getName(listing.floor!)),
        if (listing.roomCount != null)
          _buildDetailRow('عدد الغرف', '${listing.roomCount} غرف'),
        if (listing.rooms != null && listing.rooms!.isNotEmpty) ...[
          const SizedBox(height: 8),
          const Text(
            'تفاصيل الغرف:',
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w600,
              color: AppTheme.textColor,
            ),
          ),
          ...listing.rooms!.map((room) => Padding(
                padding: const EdgeInsets.only(top: 4, right: 16),
                child: Text(
                  '${room.name}: ${room.getSizeText()}',
                  style: const TextStyle(fontSize: 14, color: AppTheme.textColor),
                ),
              )),
        ],
        if (listing.hasKitchen)
          _buildDetailRow('المطبخ', listing.kitchenSize ?? 'يوجد مطبخ'),
        if (listing.bathroomCount != null)
          _buildDetailRow('عدد الحمامات', '${listing.bathroomCount} حمام'),
        if (listing.hasExternalMajlis)
          _buildDetailRow(
            'المجلس الخارجي',
            listing.externalMajlisHasBathroom ? 'يوجد مع حمام' : 'يوجد',
          ),
        if (listing.sunlightDirection != null)
          _buildDetailRow('دخول الشمس', SunlightDirections.getName(listing.sunlightDirection!)),
      ],
    );
  }

  Widget _buildServicesSection(Listing listing) {
    return Column(
      children: [
        if (listing.waterSource != null) ...[
          _buildDetailRow('مصدر الماء', WaterSources.getName(listing.waterSource!)),
          if (listing.waterIndependence != null)
            _buildDetailRow(
              'الماء',
              listing.waterIndependence == 'independent' ? 'مستقل' : 'مشترك',
            ),
        ],
        if (listing.electricityType != null) ...[
          _buildDetailRow('نوع الكهرباء', ElectricityTypes.getName(listing.electricityType!)),
          if (listing.electricityIndependence != null)
            _buildDetailRow(
              'الكهرباء',
              listing.electricityIndependence == 'independent' ? 'مستقل' : 'مشترك',
            ),
        ],
        if (listing.hasSolarPanels)
          _buildDetailRow('الطاقة الشمسية', 'يوجد ألواح شمسية'),
      ],
    );
  }

  Widget _buildFinancialSection(Listing listing) {
    final formatter = NumberFormat('#,###');
    
    return Column(
      children: [
        if (listing.deposit != null)
          _buildDetailRow('التأمين', '${formatter.format(listing.deposit!)} ${listing.currency}'),
        if (listing.advance != null)
          _buildDetailRow('المقدم', '${formatter.format(listing.advance!)} ${listing.currency}'),
        if (listing.hasBrokerage)
          _buildDetailRow('الساعية (الدلالة)', 'يوجد'),
        _buildDetailRow('قابل للتفاوض', listing.negotiable ? 'نعم' : 'لا'),
        if (listing.requiresGuarantee)
          _buildDetailRow(
            'الضمانة',
            listing.guaranteeType ?? 'مطلوب ضمانة',
          ),
        _buildDetailRow('النوع', listing.isCommercial ? 'تجاري' : 'سكني'),
      ],
    );
  }

  Widget _buildDetailRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: 120,
            child: Text(
              label,
              style: const TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w600,
                color: AppTheme.textColor,
              ),
            ),
          ),
          Expanded(
            child: Text(
              value,
              style: const TextStyle(
                fontSize: 14,
                color: AppTheme.textColor,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildContactBar(BuildContext context, Listing listing) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 10,
            offset: const Offset(0, -2),
          ),
        ],
      ),
      child: Row(
        children: [
          Expanded(
            child: OutlinedButton.icon(
              onPressed: () => _launchWhatsApp(listing.contactPhone),
              icon: const Icon(Icons.chat),
              label: const Text('واتساب'),
              style: OutlinedButton.styleFrom(
                padding: const EdgeInsets.symmetric(vertical: 14),
              ),
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: ElevatedButton.icon(
              onPressed: () => _makePhoneCall(listing.contactPhone),
              icon: const Icon(Icons.phone),
              label: const Text('اتصال'),
              style: ElevatedButton.styleFrom(
                padding: const EdgeInsets.symmetric(vertical: 14),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Future<void> _makePhoneCall(String phoneNumber) async {
    final uri = Uri(scheme: 'tel', path: phoneNumber);
    if (await canLaunchUrl(uri)) {
      await launchUrl(uri);
    }
  }

  Future<void> _launchWhatsApp(String phoneNumber) async {
    final cleanPhone = phoneNumber.replaceAll(RegExp(r'[^\d]'), '');
    final uri = Uri.parse('https://wa.me/$cleanPhone');
    if (await canLaunchUrl(uri)) {
      await launchUrl(uri, mode: LaunchMode.externalApplication);
    }
  }
}
