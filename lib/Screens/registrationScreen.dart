import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';

class RegistrationScreen extends StatefulWidget {
  const RegistrationScreen({super.key});

  @override
  State<RegistrationScreen> createState() => _RegistrationScreenState();
}

class _RegistrationScreenState extends State<RegistrationScreen> {
  TextEditingController phoneNumberController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController referralCodeController = TextEditingController();

  GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  bool _isFormValid = false; // Track form validation status
  bool _showPassword=false;

  String? _validatePhoneNumber(String? value) {
    // Check if the phone number is empty
    if (value == null || value.isEmpty) {
      return 'Please enter a phone number';
    }
    // Check if the phone number is valid
    if (!RegExp(r'^[0-9]{10}$').hasMatch(value)) {
      return 'Please enter a valid 10-digit phone number';
    }
    return null; // Return null if the phone number is valid
  }
  String? _validateEmail(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please enter your email';
    }
    // Check if the email format is valid
    if (!RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$').hasMatch(value)) {
      return 'Please enter a valid email address';
    }
    return null; // Return null if the email is valid
  }  
  String? _validatePassword(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please enter a password';
    }

    // Check if the password meets minimum length requirement
    if (value.length < 6) {
      return 'Password must be at least 6 characters long';
    }

    // Check if the password contains at least one uppercase letter
    if (!value.contains(RegExp(r'[A-Z]'))) {
      return 'Password must contain at least one uppercase letter';
    }

    // Check if the password contains at least one lowercase letter
    if (!value.contains(RegExp(r'[a-z]'))) {
      return 'Password must contain at least one lowercase letter';
    }

    // Check if the password contains at least one digit
    if (!value.contains(RegExp(r'[0-9]'))) {
      return 'Password must contain at least one digit';
    }

    // Check if the password contains at least one special character from [@, !, #, _, $]
    if (!value.contains(RegExp(r'[@!#_\$]'))) {
      return 'Password must contain at least one special character [@, !, #, _, \$]';
    }

    return null; // Return null if the password meets all requirements
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: Icon(
          Icons.arrow_back_ios_new,
          color: Colors.black,
          size: 30,
        ),
      ),
      body: Center(
        child: Container(
          width: MediaQuery.sizeOf(context).width * .5,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Opacity(
                opacity: 0.5,
                child: Image.asset(
                  "assets/images/dealsdray_logo.jpeg",
                ),
              ),
              SizedBox(height: 10),
              Text(
                "Let's Begin!",
                textAlign: TextAlign.start,
                style: TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                  fontSize: 30,
                ),
              ),
              SizedBox(height: 10),
              Text(
                "Please provide your credentials to proceed",
                textAlign: TextAlign.start,
                style: TextStyle(
                  color: Colors.grey,
                ),
              ),
              SizedBox(height: 10),
              Form(
                key: _formKey,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    TextFormField(
                      controller: phoneNumberController,
                      decoration: const InputDecoration(
                        hintText: "Your Phone Number",
                        hintStyle: TextStyle(
                          color: Colors.grey,
                          fontSize: 15,
                          fontWeight: FontWeight.bold,
                        ),
                        filled: true,
                        fillColor: Colors.white,
                      ),
                      inputFormatters: [
                        FilteringTextInputFormatter.allow(RegExp(r'[0-9]')), // Allow only numbers
                      ],
                      keyboardType: TextInputType.number,
                      validator: _validatePhoneNumber,
                      onChanged: (value) {
                        setState(() {
                          // Set the form validation status
                          _isFormValid = _formKey.currentState!.validate();
                        });
                      },
                    ),
                    TextFormField(
                      controller: emailController,
                      decoration: const InputDecoration(
                        hintText: "Your email",
                        hintStyle: TextStyle(
                          color: Colors.grey,
                          fontSize: 15,
                          fontWeight: FontWeight.bold,
                        ),
                        filled: true,
                        fillColor: Colors.white,
                      ),
                      validator: _validateEmail,
                      onChanged: (value) {
                        setState(() {
                          // Set the form validation status
                          _isFormValid = _formKey.currentState!.validate();
                        });
                      },
                    ),
                    TextFormField(
                      controller: passwordController,
                      obscureText: _showPassword?false:true,
                      decoration:  InputDecoration(
                        suffixIcon:   IconButton(onPressed: (){
                          setState(() {
                            _showPassword=!_showPassword;

                          });
                        },
                            icon: _showPassword? Icon(Icons.visibility_off):Icon(Icons.visibility)),
                        hintText: "Create Password",
                        hintStyle: TextStyle(
                          color: Colors.grey,
                          fontSize: 15,
                          fontWeight: FontWeight.bold,
                        ),
                        filled: true,
                        fillColor: Colors.white,
                      ),
                      validator: _validatePassword,
                      onChanged: (value) {
                        setState(() {
                          // Set the form validation status
                          _isFormValid = _formKey.currentState!.validate();
                        });
                      },
                    ),
                    TextFormField(
                      controller: referralCodeController,
                      decoration: const InputDecoration(
                        hintText: "Referral Code (Optional)",
                        hintStyle: TextStyle(
                          color: Colors.grey,
                          fontSize: 15,
                          fontWeight: FontWeight.bold,
                        ),
                        filled: true,
                        fillColor: Colors.white,
                      ),


                    ),
                    SizedBox(height: 20),
                    SizedBox(
                      width: 50,
                      height: 50,
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          padding: EdgeInsets.all(20),
                          backgroundColor: Colors.red,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(5), // Set the border radius here
                          ),
                        ),
                        onPressed: _isFormValid
                            ? () {
                          // Form is valid, handle submission here
                          _registerUser;
                          Navigator.pushNamed(
                            context,
                            "/loginScreen"
                          );
                        }
                            : null, // Disable button if form is not valid
                        child: Icon(Icons.arrow_forward,
                        color: Colors.white,)
                        ),
                      ),

                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );

  }
  void _registerUser() async {
    try {
      var url = Uri.parse('http://devapiv3.dealsdray.com/api/v2/user/email/referral');
      var response = await http.post(
        url,
        headers: {
          'Content-Type': 'application/json',
        },
        body: jsonEncode({
          "email": emailController.text,
          "password": passwordController.text,
          "referralCode": referralCodeController.text,
          "userId": "62a833766ec5dafd6780fc856", // Increment user ID here
        }),
      );

      if (response.statusCode == 200) {
        // Handle success
        print('Registration successful');
        // Navigate to next screen
        Navigator.pushNamed(context, '/loginScreen');
        // Increment user ID for next registration

      } else {
        // Handle errors
        print('Registration failed: ${response.statusCode}');
        // Show error message to user
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Registration failed: ${response.reasonPhrase}'),
          ),
        );
      }
    } catch (e) {
      // Handle exceptions
      print('Error: $e');
      // Show error message to user
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Error: $e'),
        ),
      );
    }
  }

}
