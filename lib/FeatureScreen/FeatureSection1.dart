import 'package:flutter/material.dart';

class FeatureSection extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Container(
        color: Color(0xFF0F4B92),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 65.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(height: 70),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.asset(
                    'images/image1.png',
                    width: 80,
                  ),
                  SizedBox(width: 2),
                  Text.rich(
                    TextSpan(
                      children: [
                        TextSpan(
                          text: 'Credit',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 40,
                            fontWeight: FontWeight.normal,
                          ),
                        ),
                        TextSpan(
                          text: 'S',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 40,
                            fontWeight: FontWeight.w100,
                          ),
                        ),
                        TextSpan(
                          text: 'ea',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 28,
                            fontWeight: FontWeight.w100,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              SizedBox(height: 15), // Reduced space between logo and images
              Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      _imageWidget(
                          'images/car.png'), // Replace with your car image
                      _imageWidget(
                          'images/bike.png'), // Replace with your motorcycle image
                    ],
                  ),
                  SizedBox(height: 20), // Decreased space between image rows
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      _imageWidget(
                          'images/lappy.png'), // Replace with your laptop image
                      _imageWidget(
                          'images/mobile.png'), // Replace with your phone image
                    ],
                  ),
                ],
              ),
              SizedBox(height: 20),
              Text(
                "Flexible Loan Options",
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 18,
                  fontWeight: FontWeight.w600,
                ),
              ),
              SizedBox(height: 4),
              Text(
                "Loan types to cater to different financial needs",
                style: TextStyle(
                  color: Colors.white70,
                  fontSize: 12,
                ),
                textAlign: TextAlign.center,
              ),
              SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }

  Widget _imageWidget(String imagePath) {
    return Center(
      child: Image.asset(
        imagePath, // Path to your image
        width: 80, // Adjust image size
        height: 80, // Adjust image size
      ),
    );
  }
}
