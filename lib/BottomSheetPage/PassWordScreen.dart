import 'package:flutter/material.dart';

class PasswordCreationBottomSheet extends StatefulWidget {
  final VoidCallback onNext;
  final VoidCallback onBack;

  PasswordCreationBottomSheet({required this.onNext, required this.onBack});

  @override
  _PasswordCreationBottomSheetState createState() =>
      _PasswordCreationBottomSheetState();
}

class _PasswordCreationBottomSheetState
    extends State<PasswordCreationBottomSheet> {
  bool _isPasswordVisible = false;
  bool _isRePasswordVisible = false;
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _rePasswordController = TextEditingController();
  String? _errorMessage;

  void _togglePasswordVisibility() {
    setState(() {
      _isPasswordVisible = !_isPasswordVisible;
    });
  }

  void _toggleRePasswordVisibility() {
    setState(() {
      _isRePasswordVisible = !_isRePasswordVisible;
    });
  }

  void _validateAndProceed() {
    final password = _passwordController.text;
    final rePassword = _rePasswordController.text;

    if (password.isEmpty || rePassword.isEmpty) {
      setState(() {
        _errorMessage = "Both fields are required.";
      });
    } else if (password.length < 8 ||
        !RegExp(r'[!@#\$&*~]').hasMatch(password)) {
      setState(() {
        _errorMessage =
            "Password must be at least 8 characters long and include at least 1 special character.";
      });
    } else if (password != rePassword) {
      setState(() {
        _errorMessage = "Passwords do not match.";
      });
    } else {
      setState(() {
        _errorMessage = null;
      });
      widget.onNext();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.vertical(top: Radius.circular(30)),
      ),
      padding: EdgeInsets.symmetric(horizontal: 16),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(height: 5),
          Row(
            children: [
              IconButton(
                icon: Icon(Icons.arrow_back),
                onPressed: widget.onBack,
                padding: EdgeInsets.zero,
                constraints: BoxConstraints(),
              ),
              Text(
                "Create a password",
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
            ],
          ),
          SizedBox(height: 6),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text("Enter password", style: TextStyle(fontSize: 14)),
              SizedBox(height: 5),
              TextField(
                controller: _passwordController,
                obscureText: !_isPasswordVisible,
                decoration: InputDecoration(
                  hintText: "Enter password",
                  suffixIcon: IconButton(
                    icon: Icon(
                      _isPasswordVisible
                          ? Icons.visibility
                          : Icons.visibility_off,
                    ),
                    onPressed: _togglePasswordVisibility,
                  ),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
              ),
              SizedBox(height: 6),
              Text("Re-enter password", style: TextStyle(fontSize: 14)),
              SizedBox(height: 8),
              TextField(
                controller: _rePasswordController,
                obscureText: !_isRePasswordVisible,
                decoration: InputDecoration(
                  hintText: "Re-enter password",
                  suffixIcon: IconButton(
                    icon: Icon(
                      _isRePasswordVisible
                          ? Icons.visibility
                          : Icons.visibility_off,
                    ),
                    onPressed: _toggleRePasswordVisibility,
                  ),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
              ),
              SizedBox(height: 6),
              Text(
                "*Your password must include at least 8 characters, inclusive of at least 1 special character",
                style: TextStyle(fontSize: 12, color: Colors.grey),
              ),
              if (_errorMessage != null)
                Padding(
                  padding: const EdgeInsets.only(top: 10),
                  child: Text(
                    _errorMessage!,
                    style: TextStyle(color: Colors.red, fontSize: 12),
                  ),
                ),
            ],
          ),
          SizedBox(height: 6),
          Row(
            children: [
              Expanded(
                child: ElevatedButton(
                  onPressed: _validateAndProceed,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Color(0xFF007AFF),
                    padding: EdgeInsets.symmetric(vertical: 16),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                  child: Text(
                    "Proceed",
                    style: TextStyle(fontSize: 16, color: Colors.white),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    _passwordController.dispose();
    _rePasswordController.dispose();
    super.dispose();
  }
}
