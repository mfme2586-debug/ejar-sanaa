import 'package:flutter/material.dart';
import 'package:ejar_sanaa/core/theme/app_theme.dart';
import 'package:ejar_sanaa/core/constants/districts.dart';
import 'package:ejar_sanaa/models/listing_model.dart';
import 'package:intl/intl.dart';

class ListingCard extends StatelessWidget {
  final Listing listing;
  final VoidCallback onTap;

  const ListingCard({
    super.key,
    required this.listing,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final formatter = NumberFormat('#,###');
    final priceText = '${formatter.format(listing.price)} ${listing.currency}';
    
    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Image
            ClipRRect(
              borderRadius: const BorderRadius.vertical(top: Radius.circular(16)),
              child: Container(
                height: 200,
                width: double.infinity,
                color: AppTheme.borderColor.withOpacity(0.3),
                child: listing.images.isNotEmpty
                    ? Image.network(
                        listing.images.first,
                        fit: BoxFit.cover,
                        errorBuilder: (context, error, stackTrace) => _buildPlaceholder(),
                      )
                    : _buildPlaceholder(),
              ),
            ),
            
            Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Title
                  Text(
                    listing.title,
                    style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: AppTheme.textColor,
                    ),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(height: 8),
                  
                  // Location
                  Row(
                    children: [
                      const Icon(Icons.location_on, size: 16, color: AppTheme.secondaryColor),
                      const SizedBox(width: 4),
                      Text(
                        Districts.getDistrictName(listing.district),
                        style: const TextStyle(
                          fontSize: 14,
                          color: AppTheme.textColor,
                        ),
                      ),
                      if (listing.neighborhood != null) ...[
                        const Text(' - ', style: TextStyle(color: AppTheme.textColor)),
                        Text(
                          listing.neighborhood!,
                          style: const TextStyle(
                            fontSize: 14,
                            color: AppTheme.textColor,
                          ),
                        ),
                      ],
                    ],
                  ),
                  const SizedBox(height: 12),
                  
                  // Features Icons
                  Wrap(
                    spacing: 12,
                    runSpacing: 8,
                    children: [
                      if (listing.roomCount != null)
                        _buildFeatureIcon(Icons.bed, '${listing.roomCount} غرف'),
                      if (listing.bathroomCount != null)
                        _buildFeatureIcon(Icons.bathroom, '${listing.bathroomCount} حمام'),
                      if (listing.hasExternalMajlis)
                        _buildFeatureIcon(Icons.deck, 'مجلس خارجي'),
                      if (listing.sunlightDirection != null)
                        _buildFeatureIcon(Icons.wb_sunny, _getSunlightIcon(listing.sunlightDirection!)),
                      if (listing.waterSource != null)
                        _buildFeatureIcon(Icons.water_drop, _getWaterIcon(listing.waterSource!)),
                      if (listing.electricityType != null)
                        _buildFeatureIcon(Icons.bolt, _getElectricityIcon(listing.electricityType!)),
                    ],
                  ),
                  const SizedBox(height: 12),
                  
                  // Price
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        priceText,
                        style: const TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: AppTheme.primaryColor,
                        ),
                      ),
                      if (listing.negotiable)
                        Container(
                          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                          decoration: BoxDecoration(
                            color: AppTheme.successColor.withOpacity(0.1),
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: const Text(
                            'قابل للتفاوض',
                            style: TextStyle(
                              fontSize: 12,
                              color: AppTheme.successColor,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildPlaceholder() {
    return Container(
      color: AppTheme.borderColor.withOpacity(0.2),
      child: const Icon(
        Icons.home,
        size: 60,
        color: AppTheme.textColor,
      ),
    );
  }

  Widget _buildFeatureIcon(IconData icon, String label) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Icon(icon, size: 18, color: AppTheme.secondaryColor),
        const SizedBox(width: 4),
        Text(
          label,
          style: const TextStyle(
            fontSize: 12,
            color: AppTheme.textColor,
          ),
        ),
      ],
    );
  }

  String _getSunlightIcon(String direction) {
    switch (direction) {
      case 'south':
        return '☀️ مشمس';
      case 'east':
        return '🌅 شرقي';
      case 'west':
        return '🌇 غربي';
      case 'north':
        return '☁️ ظليل';
      default:
        return 'شمس';
    }
  }

  String _getWaterIcon(String source) {
    switch (source) {
      case 'government':
        return '💧 حكومي';
      case 'tank':
        return '💧 خزان';
      default:
        return '💧';
    }
  }

  String _getElectricityIcon(String type) {
    switch (type) {
      case 'government':
        return '⚡ حكومي';
      case 'commercial':
        return '⚡ تجاري';
      case 'solar':
        return '⚡ شمسي';
      default:
        return '⚡';
    }
  }
}
