import 'package:flutter/material.dart';
import 'package:intl_phone_field/intl_phone_field.dart';

class MobileNumberInputBottomSheet extends StatefulWidget {
  final VoidCallback onNext;
  final Function(String) onMobileNumberChanged;

  MobileNumberInputBottomSheet({
    required this.onNext,
    required this.onMobileNumberChanged,
  });

  @override
  _MobileNumberInputBottomSheetState createState() =>
      _MobileNumberInputBottomSheetState();
}

class _MobileNumberInputBottomSheetState
    extends State<MobileNumberInputBottomSheet> {
  bool isChecked = false;
  String phoneNumber = "";

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.vertical(top: Radius.circular(30)),
      ),
      padding: EdgeInsets.symmetric(horizontal: 16, vertical: 20),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Center(
            child: Text(
              "Welcome to Credit Sea!",
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          SizedBox(height: 20),
          Text(
            "Mobile Number",
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w600,
              color: Colors.black87,
            ),
          ),
          SizedBox(height: 10),
          IntlPhoneField(
            decoration: InputDecoration(
              hintText: "Please enter your mobile no.",
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8),
                borderSide: BorderSide(color: Colors.grey),
              ),
              contentPadding: EdgeInsets.symmetric(horizontal: 12),
            ),
            initialCountryCode: 'IN',
            onChanged: (phone) {
              phoneNumber = phone.completeNumber;
              widget.onMobileNumberChanged(phoneNumber);
            },
            dropdownDecoration: BoxDecoration(
              color: Colors.grey[200],
              borderRadius: BorderRadius.circular(0),
              border: Border.all(color: Colors.grey),
              shape: BoxShape.rectangle,
            ),
            dropdownTextStyle: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w600,
              color: Colors.black87,
            ),
            flagsButtonPadding: EdgeInsets.only(left: 0),
          ),
          SizedBox(height: 10),
          Row(
            children: [
              Checkbox(
                value: isChecked,
                activeColor: Colors.green,
                onChanged: (value) {
                  setState(() {
                    isChecked = value!;
                  });
                },
              ),
              Expanded(
                child: RichText(
                  text: TextSpan(
                    style: TextStyle(color: Colors.black87, fontSize: 14),
                    children: [
                      TextSpan(text: "By continuing, you agree to our "),
                      TextSpan(
                        text: "privacy policies",
                        style: TextStyle(
                          decoration: TextDecoration.underline,
                          color: Colors.blue,
                        ),
                      ),
                      TextSpan(text: " and "),
                      TextSpan(
                        text: "Terms & Conditions.",
                        style: TextStyle(
                          decoration: TextDecoration.underline,
                          color: Colors.blue,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
          SizedBox(height: 20),
          ElevatedButton(
            onPressed: isChecked
                ? () {
                    widget.onNext();
                  }
                : null,
            child: Text(
              "Request OTP",
              style: TextStyle(
                  color: Colors.white,
                  fontSize: 16,
                  fontWeight: FontWeight.bold),
            ),
            style: ElevatedButton.styleFrom(
              minimumSize: Size(double.infinity, 50),
              backgroundColor: Color(0xFF0075FF),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8),
              ),
            ),
          ),
          SizedBox(height: 20),
          Center(
            child: TextButton(
              onPressed: () {},
              child: Text(
                "Existing User? Sign in",
                style: TextStyle(color: Colors.blue, fontSize: 14),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
