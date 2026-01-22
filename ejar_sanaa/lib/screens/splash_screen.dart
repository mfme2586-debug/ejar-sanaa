import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:ejar_sanaa/core/theme/app_theme.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    _navigateToHome();
  }

  Future<void> _navigateToHome() async {
    await Future.delayed(const Duration(seconds: 2));
    if (mounted) {
      context.go('/home');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.primaryColor,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Logo or Icon
            Container(
              width: 120,
              height: 120,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(30),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.2),
                    blurRadius: 20,
                    offset: const Offset(0, 10),
                  ),
                ],
              ),
              child: const Icon(
                Icons.home_outlined,
                size: 70,
                color: AppTheme.primaryColor,
              ),
            ),
            const SizedBox(height: 30),
            
            // App Name
            const Text(
              'إيجار صنعاء',
              style: TextStyle(
                fontSize: 32,
                fontWeight: FontWeight.bold,
                color: Colors.white,
                fontFamily: 'Cairo',
              ),
            ),
            const SizedBox(height: 10),
            
            // Tagline
            const Text(
              'إيجارك أسهل... الأقرب... الأوضح',
              style: TextStyle(
                fontSize: 16,
                color: Colors.white70,
                fontFamily: 'Cairo',
              ),
            ),
            const SizedBox(height: 50),
            
            // Loading Indicator
            const CircularProgressIndicator(
              valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
            ),
          ],
        ),
      ),
    );
  }
}
