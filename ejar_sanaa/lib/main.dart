import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:provider/provider.dart';
import 'package:go_router/go_router.dart';
import 'package:ejar_sanaa/core/theme/app_theme.dart';
import 'package:ejar_sanaa/core/constants/districts.dart';
import 'package:ejar_sanaa/providers/listing_provider.dart';
import 'package:ejar_sanaa/screens/splash_screen.dart';
import 'package:ejar_sanaa/screens/home_screen.dart';
import 'package:ejar_sanaa/screens/listing_details_screen.dart';
import 'package:ejar_sanaa/screens/add_listing_screen.dart';
import 'package:ejar_sanaa/screens/search_screen.dart';

void main() {
  runApp(const EjarSanaaApp());
}

class EjarSanaaApp extends StatelessWidget {
  const EjarSanaaApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => ListingProvider()),
      ],
      child: MaterialApp.router(
        title: 'إيجار صنعاء',
        debugShowCheckedModeBanner: false,
        
        // RTL Support
        localizationsDelegates: const [
          GlobalMaterialLocalizations.delegate,
          GlobalWidgetsLocalizations.delegate,
          GlobalCupertinoLocalizations.delegate,
        ],
        supportedLocales: const [
          Locale('ar', 'YE'), // Arabic - Yemen
          Locale('en', 'US'), // English
        ],
        locale: const Locale('ar', 'YE'),
        
        // Theme
        theme: AppTheme.lightTheme,
        
        // Router
        routerConfig: _router,
      ),
    );
  }
}

// Router Configuration
final GoRouter _router = GoRouter(
  initialLocation: '/splash',
  routes: [
    GoRoute(
      path: '/splash',
      builder: (context, state) => const SplashScreen(),
    ),
    GoRoute(
      path: '/home',
      builder: (context, state) => const HomeScreen(),
    ),
    GoRoute(
      path: '/listing/:id',
      builder: (context, state) {
        final id = state.pathParameters['id'] ?? '';
        return ListingDetailsScreen(listingId: id);
      },
    ),
    GoRoute(
      path: '/add-listing',
      builder: (context, state) => const AddListingScreen(),
    ),
    GoRoute(
      path: '/search',
      builder: (context, state) => const SearchScreen(),
    ),
  ],
);
