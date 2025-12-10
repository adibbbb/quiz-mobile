import 'dart:ui';
import '../../../commons.dart';
import 'package:flutter/material.dart';

class SiswaLevelComplateView extends StatefulWidget {
  const SiswaLevelComplateView({super.key});

  @override
  State<SiswaLevelComplateView> createState() => _SiswaLevelComplateViewState();
}

class _SiswaLevelComplateViewState extends State<SiswaLevelComplateView> {
  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    final screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      body: Stack(
        children: [
          // Background image
          Container(
            width: double.infinity,
            height: double.infinity,
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage(AppImages.imgBgHome),
                fit: BoxFit.cover,
              ),
            ),
          ),
          // Blur effect
          Positioned.fill(
            child: BackdropFilter(
              filter: ImageFilter.blur(sigmaX: 5, sigmaY: 5),
              child: Container(color: Colors.black.withOpacity(0)),
            ),
          ),

          Center(
            child: Container(
              width: screenWidth * 0.9,
              height: screenHeight * 0.9,
              decoration: BoxDecoration(
                color: Colors.white.withOpacity(0.85), // semi-transparan
                borderRadius: BorderRadius.circular(73),
              ),
              child: Padding(
                padding: const EdgeInsets.fromLTRB(50, 100, 50, 50),
                child: Column(
                  children: [
                    Image.asset(AppImages.imgLevelComplate, height: 150),
                    Text('SCORE', style: AppStyles.montserrat64Bold.copyWith(color: AppColors.orange),)
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
