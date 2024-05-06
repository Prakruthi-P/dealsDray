import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;


class SplashScreen extends StatefulWidget {
  final Widget? child;
  const SplashScreen({Key? key, this.child}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {

  void _addDevice() async {
    try {
      // Construct the request body
      Map<String, dynamic> requestBody = {
        "deviceType": "andriod", // typo: should be "android"
        "deviceId": "C6179909526098",
        "deviceName": "Samsung-MT200",
        "deviceOSVersion": "2.3.6",
        "deviceIPAddress": "11.433.445.66",
        "lat": 9.9312,
        "long": 76.2673,
        "buyer_gcmid": "",
        "buyer_pemid": "",
        "app": {
          "version": "1.20.5",
          "installTimeStamp": "2022-02-10T12:33:30.696Z",
          "uninstallTimeStamp": "2022-02-10T12:33:30.696Z",
          "downloadTimeStamp": "2022-02-10T12:33:30.696Z"
        }
      };

      // Make the POST request
      var response = await http.post(
        Uri.parse('http://devapiv3.dealsdray.com/api/v2/user/device/add'),
        headers: {
          'Content-Type': 'application/json',
        },
        body: jsonEncode(requestBody),
      );

      // Check if the request was successful (status code 200)
      if (response.statusCode == 200) {
        // Handle successful response here
        print('Device added successfully');
      } else {
        // Handle error response here
        print('Failed to add device: ${response.statusCode}');
      }
    } catch (e) {
      // Handle exceptions
      print('Error: $e');
    }
  }

  @override
  void initState() {
    _addDevice();
    Future.delayed(Duration(seconds: 1), () {
      Navigator.pushAndRemoveUntil(
        context as BuildContext,
        MaterialPageRoute(builder: (context) => widget.child!),
            (route) => false,
      );
    });
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Container(
          color: Colors.white,
          child: Stack(
            alignment: Alignment.center,
            children: [
              SingleChildScrollView(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Container(
                      height: MediaQuery.of(context).size.height * 0.8,
                      width: MediaQuery.of(context).size.width,
                      child: Image.asset(
                        "assets/images/splashScreen.jpeg",
                        fit: BoxFit.fill,
                      ),
                    ),
                    Image.asset("assets/images/dealsdray_logo.jpeg"),
                  ],
                ),
              ),
              // Show a small dotted faded red circular progress indicator
              Opacity(
                opacity: 0.5,
                child: CircularProgressIndicator(
                  valueColor: AlwaysStoppedAnimation<Color>(Colors.red),
                  strokeWidth: 4.0,
                  backgroundColor: Colors.white,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
