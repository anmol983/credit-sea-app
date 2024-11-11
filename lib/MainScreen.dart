import 'package:credit_sea/FeatureScreen/FeatureSection2.dart';
import 'package:flutter/material.dart';
import 'package:credit_sea/FeatureScreen/FeatureSection1.dart';
import 'package:credit_sea/FeatureScreen/FeatureSection3.dart';
import 'package:credit_sea/BottomSheetPage/OtpScreen.dart';
import 'package:credit_sea/BottomSheetPage/MobileNumberEntryScreen.dart';
import 'package:credit_sea/BottomSheetPage/PassWordScreen.dart';
import 'package:credit_sea/BottomSheetPage/SiginScreen.dart';
import 'dart:math';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: MainScreen(),
    );
  }
}

class MainScreen extends StatefulWidget {
  @override
  _MainScreenState createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  final PageController _pageController = PageController();
  final PageController _featureSectionController = PageController();
  final Random _random = Random();
  double _currentFeaturePage = 0.0;
  int _currentBottomSheetPage = 0;
  String mobileNumber = '';

  @override
  void initState() {
    super.initState();
    _pageController.addListener(_onBottomSheetPageChanged);
    _featureSectionController.addListener(_onFeatureSectionScrolled);
  }

  @override
  void dispose() {
    _pageController.removeListener(_onBottomSheetPageChanged);
    _featureSectionController.removeListener(_onFeatureSectionScrolled);
    _pageController.dispose();
    _featureSectionController.dispose();
    super.dispose();
  }

  void _onBottomSheetPageChanged() {
    int newPage = _pageController.page?.round() ?? 0;
    if (newPage != _currentBottomSheetPage) {
      setState(() {
        _currentBottomSheetPage = newPage;
        _currentFeaturePage = newPage.toDouble();
      });
      _featureSectionController.animateToPage(
        newPage,
        duration: Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
    }
  }

  void _onFeatureSectionScrolled() {
    setState(() {
      _currentFeaturePage = _featureSectionController.page ?? 0.0;
    });
  }

  void _goToNextPage() {
    if (_currentBottomSheetPage < 3) {
      _pageController.nextPage(
        duration: Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
    }
  }

  void _goToPreviousPage() {
    if (_currentBottomSheetPage > 0) {
      _pageController.previousPage(
        duration: Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
    }
  }

  Widget _buildDotIndicator(int index) {
    double selectedness = (_currentFeaturePage - index).abs().clamp(0.0, 1.0);
    double size = 8 + (8 * (1 - selectedness));

    return AnimatedContainer(
      duration: Duration(milliseconds: 300),
      margin: EdgeInsets.symmetric(horizontal: 4),
      height: 8,
      width: size,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(4),
      ),
    );
  }

  void updateMobileNumber(String phone) {
    setState(() {
      mobileNumber = phone;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFF1D4E8E),
      body: Column(
        children: [
          Expanded(
            child: PageView(
              controller: _featureSectionController,
              physics: BouncingScrollPhysics(),
              children: [
                FeatureSection(),
                FeatureSection2(),
                FeatureSection3(),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(bottom: 5.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: List.generate(3, (index) => _buildDotIndicator(index)),
            ),
          ),
          Container(
            height: 400,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.vertical(
                top: Radius.circular(30),
              ),
              border: Border(
                top: BorderSide(
                  color: Color(0xFF33ACB1),
                  width: 5.0,
                ),
              ),
            ),
            child: ClipRRect(
              borderRadius: BorderRadius.vertical(top: Radius.circular(30)),
              child: PageView(
                controller: _pageController,
                physics: NeverScrollableScrollPhysics(),
                children: [
                  MobileNumberInputBottomSheet(
                    onNext: _goToNextPage,
                    onMobileNumberChanged: updateMobileNumber,
                  ),
                  OTPVerificationPage(
                    mobileNumber: mobileNumber,
                    onNext: _goToNextPage,
                    onBack: _goToPreviousPage,
                  ),
                  PasswordCreationBottomSheet(
                      onNext: _goToNextPage, onBack: _goToPreviousPage),
                  SignInPage(),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
