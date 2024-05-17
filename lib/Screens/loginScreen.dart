import 'dart:async';
import 'dart:convert';
import 'package:dealsdray/Constants/toast.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:dealsdray/Screens/otpScreen.dart';
import 'package:http/http.dart' as http;



class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  TextEditingController phoneNumberController = TextEditingController();
  GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  bool _isPhoneSelected = true;
  bool _isFormValid = false; // Track form validation status
  bool _isDataValid=false;

  Future<bool> fetchData(String mobile) async {
    // Create a proxy client
    try {
      // Make HTTP GET request using the proxy client
      final response = await http.post(Uri.parse("http://devapiv3.dealsdray.com/api/v2/user/otp"));

      if (response.statusCode == 200) {
        print("success");
        // Decode response JSON
        List<dynamic> jsonData = json.decode(response.body);
        // Process data
        List<dynamic> formattedData = jsonData.map((data) {
          return {
            "mobileNumber": data['mobileNumber'],
          };
        }).toList();
        print("formatted Data:$formattedData");

        if (formattedData.isNotEmpty && formattedData[0]["mobileNumber"]==mobile) {
          setState(() {
            _isFormValid=true;
          });
          showToast(message: "Thanks");
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) =>
                  OTPScreen(
                    phoneNumber: mobile,
                  ),
            ),
          );// Disable button if form is not valid

          return true; // Return true if data is fetched successfully and not empty
        } else {
          setState(() {
            _isDataValid = false;

          });
          showToast(message: "Please register");
          Navigator.pushNamed(context,"/registrationScreen");
          // showToast(message: "No data found");
          return false; // Return false if data is empty
        }
      } else {
        showToast(message: "Please enter correct credential");
        return false; // Return false for non-200 status code
      }
    } catch (e) {
      print(e);
      showToast(message: "execption");
      return false; // Return false for any exceptions
    }
  }
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
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: (){Navigator.pushNamed(context, "/loginScreen");},
          icon:Icon(Icons.arrow_back_ios_new,
          color: Colors.black,
          size: 30,
        ),
        )
      ),
      body: Center(
        child: SingleChildScrollView(
          child: Container(
            width: MediaQuery.sizeOf(context).width,
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
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    GestureDetector(
                      onTap: () {
                        setState(() {
                          _isPhoneSelected = true;
                        });
                      },
                      child: Container(
                        decoration: BoxDecoration(
                          color: _isPhoneSelected ? Colors.red : Colors.grey[300],
                          borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(30),
                            bottomLeft: Radius.circular(30),
                          ),
                        ),
                        padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 10),
                        child: Text(
                          'Phone',
                          style: TextStyle(
                            color: _isPhoneSelected ? Colors.white : Colors.black,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                    GestureDetector(
                      onTap: () {
                        setState(() {
                          _isPhoneSelected = false;
                        });
                      },
                      child: Container(
                        decoration: BoxDecoration(
                          color: !_isPhoneSelected ? Colors.red : Colors.grey[300],
                          borderRadius: BorderRadius.only(
                            topRight: Radius.circular(30),
                            bottomRight: Radius.circular(30),
                          ),
                        ),
                        padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 10),
                        child: Text(
                          'Email',
                          style: TextStyle(
                            color: !_isPhoneSelected ? Colors.white : Colors.black,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 10),
                Text(
                  "Glad to see you !",
                  textAlign: TextAlign.start,
                  style: TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                    fontSize: 30,
                  ),
                ),
                SizedBox(height: 10),
                Text(
                  "Please provide your phone number ",
                  textAlign: TextAlign.start,
                  style: TextStyle(
                    color: Colors.grey,
                  ),
                ),
                SizedBox(height: 10),
                Form(
                  key: _formKey,
                  child: Column(
                    children: [
                      SizedBox(
                        width:MediaQuery.of(context).size.width*0.7,
                        child: TextFormField(
                          controller: phoneNumberController,
                          decoration: const InputDecoration(
                            hintText: "Phone",
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
                      ),
                      SizedBox(height: 20),
                      SizedBox(
                        width: MediaQuery.of(context).size.width *0.7,
                        child: ElevatedButton(
                            child: Text(
                              "SEND CODE",
                              style: TextStyle(
                                color: Colors.white,
                              ),
                            ),
                          style: ElevatedButton.styleFrom(
                            padding: EdgeInsets.all(20),
                            backgroundColor: Colors.red,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(5), // Set the border radius here
                            ),
                          ),
                          onPressed: _isFormValid ? () {
                            // Form is valid, handle submission here
                            final String mobileNumber = phoneNumberController.text;
                           //fetchData(mobileNumber);
                            mobileNumber == "9011470243" ? Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) =>
                                    OTPScreen(
                                      phoneNumber: mobileNumber,
                                    ),
                              ),): Navigator.pushNamed(context,"/registrationScreen"); // Disable button if form is not valid
                           }:null,
          
                        ),
                      ),
                  ]
                )
                ),
          
              ],
            ),
          ),
        ),

      ),
        );


  }
  void _makeOTPRequest(String mobileNumber) async {
    try {
      final String deviceId = "62b341aeb0ab5ebe28a758a3"; // You may change this if needed

      // Make a POST request to the API
      final Uri url = Uri.parse('http://devapiv3.dealsdray.com/api/v2/user/otp');
      final response = await http.post(
        url,
        headers: {
          'Content-Type': 'application/json',
        },
        body: jsonEncode({
          "mobileNumber": mobileNumber,
          "deviceId": deviceId,
        }),
      );

      if (response.statusCode == 200) {
        // Handle success
        print('OTP request successful');
        // Navigate to OTP screen
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => OTPScreen(
              phoneNumber: mobileNumber,
            ),
          ),
        );
      } else {
        // Handle errors
        print('OTP request failed: ${response.statusCode}');
        // Show error message to user
      }
    } catch (error) {
      // Handle exceptions
      print('Error: $error');
      // Show error message to user
    }
  }
}
