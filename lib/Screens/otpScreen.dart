import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'dart:async';

class OTPScreen extends StatefulWidget {
  final String phoneNumber;
  OTPScreen({Key? key, required this.phoneNumber}) : super(key: key);

  @override
  State<OTPScreen> createState() => _OTPScreenState();
}

class _OTPScreenState extends State<OTPScreen> {
  late Timer _timer;
  int _start = 120;
  List<TextEditingController> controllers =
  List.generate(4, (index) => TextEditingController());

  @override
  void initState() {
    super.initState();
    _startTimer();
  }

  void _startTimer() {
    const oneSec = Duration(seconds: 1);
    _timer = Timer.periodic(
      oneSec,
          (Timer timer) {
        if (_start == 0) {
          setState(() {
            timer.cancel();
          });
        } else {
          setState(() {
            _start--;
          });
        }
      },
    );
  }

  @override
  void dispose() {
    _timer.cancel();
    controllers.forEach((controller) => controller.dispose());
    super.dispose();
  }
  String get timerText {
    int minutes = _start ~/ 60;
    int seconds = _start % 60;
    String minutesStr = (minutes < 10) ? '0$minutes' : '$minutes';
    String secondsStr = (seconds < 10) ? '0$seconds' : '$seconds';
    return '$minutesStr:$secondsStr';
  }
  void _onInputChanged(int index, String value) {
    if (value.isNotEmpty) {
      if (index < 3) {
        FocusScope.of(context).nextFocus();
      } else {
        final enteredOTP =
        controllers.map((controller) => controller.text).join();
        _verifyOTP(enteredOTP);
        if (enteredOTP == "1234"||enteredOTP=="9879") {
          // Correct OTP, navigate to dashboard
          Navigator.pushReplacementNamed(context, '/bottomNavigationScreen');
        } else {
          // Incorrect OTP, you can show an error message or perform any other action
          // showToast(message: "Incorrect OTP");
          Fluttertoast.showToast(
              msg: "Incorrect OTP",
              toastLength: Toast.LENGTH_SHORT,
              gravity: ToastGravity.TOP,
              timeInSecForIosWeb: 1,
              backgroundColor: Colors.red,
              textColor: Colors.white,
              fontSize: 16.0
          );
          print("Incorrect OTP");
        }
      }
    }
  }
  void _verifyOTP(String otp) async {
    try {
      final String deviceId = "62b43472c84bb6dac82e0504";
      final String userId = "62b43547c84bb6dac82e0525";

      final Uri url =
      Uri.parse('http://devapiv3.dealsdray.com/api/v2/user/otp/verification');
      final response = await http.post(
        url,
        headers: {
          'Content-Type': 'application/json',
        },
        body: jsonEncode({
          "otp": otp,
          "deviceId": deviceId,
          "userId": userId,
        }),
      );

      if (response.statusCode == 200) {
        // Handle success
        print('OTP verification successful');
        // Navigate to dashboard or next screen
        Navigator.pushReplacementNamed(context, '/dashboardScreen');
      } else {
        // Handle errors
        print('OTP verification failed: ${response.statusCode}');
        // Show error message to user
      }
    } catch (error) {
      // Handle exceptions
      print('Error: $error');
      // Show error message to user
    }
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: Icon(
          Icons.arrow_back_ios,
          size: 30,
          color: Colors.black,
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Image.asset("assets/images/phone.png"),
              SizedBox(height: 10),
              Text(
                "OTP Verification",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 25,
                  color: Colors.black,
                ),
              ),
              Text(
                "We have sent a unique OTP number to your mobile ${widget.phoneNumber}",
              ),
              SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: List.generate(4,
                      (index) => SizedBox(
                        width: MediaQuery.of(context).size.width*0.2,
                        child: Container(
                          margin: EdgeInsets.all(10),
                          child: TextFormField(
                            controller: controllers[index],
                            keyboardType: TextInputType.number,
                            decoration: InputDecoration(
                              border: OutlineInputBorder(),
                            ),
                            onChanged: (value) => _onInputChanged(index, value),
                            maxLength: 1,
                          ),
                        ),
                      ),
                ),
              ),
              SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                timerText,
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 20,
                    ),
                  ),
                  TextButton(
                    onPressed: _start == 0 ? () {} : null,
                    child: Text(
                      "SEND AGAIN" ,
                      style: TextStyle(
                        color: _start == 0 ? Colors.black : Colors.grey[300],
                        fontWeight: FontWeight.bold,
                        fontSize: 20,
                        decoration: TextDecoration.underline
                      ),
                    ),
                  ),
        
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
