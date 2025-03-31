import 'package:country_code_picker_plus/country_code_picker_plus.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'otp_screen.dart';

class WelcomeScreen extends StatefulWidget {
  @override
  _WelcomeScreenState createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen> {

  final _formKey = GlobalKey<FormState>();
  final TextEditingController _mobileController = TextEditingController();
  String _countryCode = '+91';

  // Future<void> _sendOTP() async {
  //   if (_formKey.currentState!.validate()) {
  //     String fullMobileNumber = '$_countryCode${_mobileController.text.trim()}';
  //
  //     try {
  //       await FirebaseAuth.instance.verifyPhoneNumber(
  //         phoneNumber: fullMobileNumber,
  //
  //         verificationCompleted: (PhoneAuthCredential credential) async {
  //           try {
  //             UserCredential userCredential =
  //             await FirebaseAuth.instance.signInWithCredential(credential);
  //
  //             if (userCredential.user != null) {
  //               ScaffoldMessenger.of(context).showSnackBar(
  //                 SnackBar(content: Text("Phone number verified successfully!")),
  //               );
  //
  //               if (!mounted) return; // Ensure widget is still in tree
  //               Navigator.pushReplacement(
  //                 context,
  //                 MaterialPageRoute(
  //                   builder: (context) => OTPScreen(
  //                     mobile: fullMobileNumber,
  //                     verificationId: credential.verificationId ?? '',
  //                   ),
  //                 ),
  //               );
  //             }
  //           } catch (e) {
  //             ScaffoldMessenger.of(context).showSnackBar(
  //               SnackBar(content: Text("Auto-verification failed. Please enter OTP manually.")),
  //             );
  //           }
  //         },
  //
  //         verificationFailed: (FirebaseAuthException e) {
  //           ScaffoldMessenger.of(context).showSnackBar(
  //             SnackBar(content: Text('Verification failed: ${e.message}')),
  //           );
  //         },
  //
  //         codeSent: (String verificationId, int? resendToken) {
  //           if (!mounted) return; // Ensure widget is still in tree
  //           Navigator.push(
  //             context,
  //             MaterialPageRoute(
  //               builder: (context) => OTPScreen(
  //                 mobile: fullMobileNumber,
  //                 verificationId: verificationId,
  //               ),
  //             ),
  //           );
  //         },
  //
  //         codeAutoRetrievalTimeout: (String verificationId) {
  //           ScaffoldMessenger.of(context).showSnackBar(
  //             SnackBar(content: Text("OTP auto-retrieval timed out. Please enter OTP manually.")),
  //           );
  //         },
  //         timeout: const Duration(seconds: 60), // Set timeout duration
  //       );
  //     } catch (e) {
  //       print("Error: $e");
  //       ScaffoldMessenger.of(context).showSnackBar(
  //         SnackBar(content: Text('Failed to send OTP. Please try again.')),
  //       );
  //     }
  //   }
  // }


  // final _formKey = GlobalKey<FormState>();
  // final TextEditingController _mobileController = TextEditingController();
  // String _countryCode = '+91';
  //
  // Future<void> _sendOTP() async {
  //   if (_formKey.currentState!.validate()) {
  //     String fullMobileNumber = '$_countryCode${_mobileController.text.toString()}';
  //
  //     try {
  //       await FirebaseAuth.instance.verifyPhoneNumber(
  //         phoneNumber: fullMobileNumber,
  //
  //         // Auto-verification on some devices
  //         verificationCompleted: (PhoneAuthCredential credential) async{
  //           await FirebaseAuth.instance.signInWithCredential(credential);
  //           ScaffoldMessenger.of(context).showSnackBar(
  //             SnackBar(content: Text("Phone number verified successfully!")),
  //           );
  //           Navigator.pushReplacement(
  //             context,
  //             MaterialPageRoute(builder: (context) => OTPScreen(mobile: fullMobileNumber, verificationId: '')),
  //           );
  //         },
  //
  //         // If verification fails
  //         verificationFailed: (FirebaseAuthException e) {
  //           ScaffoldMessenger.of(context).showSnackBar(
  //             SnackBar(content: Text('Verification failed: ${e.message}')),
  //           );
  //         },
  //
  //         // If OTP is sent
  //         codeSent: (String verificationId, int? resendToken) {
  //           Navigator.push(
  //             context,
  //             MaterialPageRoute(
  //               builder: (context) => OTPScreen(
  //                 mobile: fullMobileNumber,
  //                 verificationId: verificationId,
  //               ),
  //             ),
  //           );
  //         },
  //
  //         // If auto-verification times out
  //         codeAutoRetrievalTimeout: (String verificationId) {
  //           ScaffoldMessenger.of(context).showSnackBar(
  //             SnackBar(content: Text("OTP auto-retrieval timed out. Please enter OTP manually.")),
  //           );
  //         },
  //       );
  //     } catch (e) {
  //       ScaffoldMessenger.of(context).showSnackBar(
  //         SnackBar(content: Text('Failed to send OTP. Please try again.')),
  //       );
  //     }
  //   }
  // }


  Future<void> _sendOTP() async {
    if (_formKey.currentState!.validate()) {
      String fullMobileNumber = '$_countryCode${_mobileController.text.trim()}';
      print(_countryCode);
      print(fullMobileNumber);

      try {
        await FirebaseAuth.instance.verifyPhoneNumber(
          phoneNumber: fullMobileNumber,
          timeout: const Duration(seconds: 60), // Timeout duration

          // Auto Verification (For some numbers, Google auto-verifies without OTP)
          verificationCompleted: (PhoneAuthCredential credential) async {
            try {
              UserCredential userCredential =
              await FirebaseAuth.instance.signInWithCredential(credential);

              if (userCredential.user != null) {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text("Phone number verified successfully!")),
                );

                if (!mounted) return;
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                    builder: (context) => OTPScreen(
                      mobile: fullMobileNumber,
                      verificationId: "", // No need for OTP entry in auto-verification
                    ),
                  ),
                );
              }
            } catch (e) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text("Auto-verification failed. Please enter OTP manually.")),
              );
            }
          },

          // Error Handling for OTP Sending
          verificationFailed: (FirebaseAuthException e) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text('Verification failed: ${e.message}')),
            );
          },

          // OTP Sent Successfully
          codeSent: (String verificationId, int? resendToken) {
            if (!mounted) return;
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => OTPScreen(
                  mobile: fullMobileNumber,
                  verificationId: verificationId, // Pass correct verificationId
                ),
              ),
            );
          },

          // If Auto-Retrieval Fails
          codeAutoRetrievalTimeout: (String verificationId) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text("OTP auto-retrieval timed out. Please enter OTP manually.")),
            );
          },
        );
      } catch (e) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Failed to send OTP: $e')),
        );
      }
    }
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Form(
                    key: _formKey,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(height: 50),
                        Text(
                          "Welcome, Sign In",
                          style: TextStyle(fontSize: 26.0, fontWeight: FontWeight.bold),
                        ),
                        SizedBox(height: 20),
                        Row(
                          children: [
                            CountryCodePicker(
                              mode: CountryCodePickerMode.dialog,
                              initialSelection: 'IN',
                              showFlag: true,
                              showDropDownButton: true,
                              onChanged: (country) {
                                setState(() {
                                  _countryCode = country.dialCode!;
                                });
                              },
                            ),
                            Expanded(
                              child: TextFormField(
                                controller: _mobileController,
                                keyboardType: TextInputType.phone,
                                maxLength: 10,
                                decoration: InputDecoration(
                                  hintText: "Mobile number",
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(8.0),
                                  ),
                                ),
                                validator: (value) {
                                  if (value == null ||
                                      value.isEmpty ||
                                      value.length != 10 ||
                                      !RegExp(r'^[0-9]+$').hasMatch(value)) {
                                    return 'Invalid mobile number. Please try again.';
                                  }
                                  return null;
                                },
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: 10),
                        Wrap(
                          children: [
                            Text(
                              "By signing in you accept our ",
                              style: TextStyle(fontSize: 15),
                            ),
                            InkWell(
                              onTap: (){},
                              child: Text(
                                "Terms & Conditions",
                                style: TextStyle(fontSize: 15,color: Colors.orange),
                              ),
                            ),
                            Text(
                              " and ",
                              style: TextStyle(fontSize: 15),
                            ),
                            InkWell(
                              child: Text(
                                "Privacy Policy",
                                style: TextStyle(fontSize: 15,color: Colors.orange),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            Column(
              children: [
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.blue.shade800,
                    minimumSize: Size(double.infinity, 50),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  onPressed: _sendOTP,
                  child: Text("Send OTP",style: TextStyle(color: Colors.white),),
                ),
                Center(
                  child: TextButton(
                    onPressed: () {},
                    child: Column(
                      mainAxisSize: MainAxisSize.min, // Ensure Column takes only necessary space
                      children: [
                        Text(
                          "LOST YOUR NUMBER?",
                          style: TextStyle(color: Colors.orange),
                        ),
                        Container(
                          width: 140, // Adjust the width as needed
                          height: 2, // Thickness of the underline
                          color: Colors.orange, // Color of the underline
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}


// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:flutter/material.dart';
// import 'package:country_code_picker_plus/country_code_picker_plus.dart';
//
// class WelcomeScreen extends StatefulWidget {
//   @override
//   _WelcomeScreenState createState() => _WelcomeScreenState();
// }
//
// class _WelcomeScreenState extends State<WelcomeScreen> {
//   final _formKey = GlobalKey<FormState>();
//   final TextEditingController _mobileController = TextEditingController();
//   final TextEditingController _otpController = TextEditingController();
//   String _countryCode = '+91';
//   String? _verificationId;
//   bool _isOTPSent = false;
//
//   Future<void> _sendOTP() async {
//     if (_formKey.currentState!.validate()) {
//       String fullMobileNumber = '$_countryCode${_mobileController.text}';
//
//       try {
//         await FirebaseAuth.instance.verifyPhoneNumber(
//           phoneNumber: fullMobileNumber,
//           timeout: const Duration(seconds: 60),
//           verificationCompleted: (PhoneAuthCredential credential) async {
//             await FirebaseAuth.instance.signInWithCredential(credential);
//             ScaffoldMessenger.of(context).showSnackBar(
//               SnackBar(content: Text('Phone number automatically verified!')),
//             );
//           },
//           verificationFailed: (FirebaseAuthException e) {
//             ScaffoldMessenger.of(context).showSnackBar(
//               SnackBar(content: Text('Error: ${e.message}')),
//             );
//           },
//           codeSent: (String verificationId, int? resendToken) {
//             setState(() {
//               _verificationId = verificationId;
//               _isOTPSent = true;
//             });
//             ScaffoldMessenger.of(context).showSnackBar(
//               SnackBar(content: Text('OTP Sent Successfully!')),
//             );
//           },
//           codeAutoRetrievalTimeout: (String verificationId) {
//             _verificationId = verificationId;
//           },
//         );
//       } catch (e) {
//         ScaffoldMessenger.of(context).showSnackBar(
//           SnackBar(content: Text('Failed to send OTP. Please try again.')),
//         );
//       }
//     }
//   }
//
//   Future<void> _verifyOTP() async {
//     if (_otpController.text.length == 6 && _verificationId != null) {
//       try {
//         PhoneAuthCredential credential = PhoneAuthProvider.credential(
//           verificationId: _verificationId!,
//           smsCode: _otpController.text,
//         );
//
//         await FirebaseAuth.instance.signInWithCredential(credential);
//
//         ScaffoldMessenger.of(context).showSnackBar(
//           SnackBar(content: Text('OTP Verified Successfully!')),
//         );
//
//         // Navigate to the next screen after successful verification
//         // Example: Navigator.push(context, MaterialPageRoute(builder: (context) => HomeScreen()));
//
//       } catch (e) {
//         ScaffoldMessenger.of(context).showSnackBar(
//           SnackBar(content: Text('Invalid OTP. Please try again.')),
//         );
//       }
//     } else {
//       ScaffoldMessenger.of(context).showSnackBar(
//         SnackBar(content: Text('Enter a valid 6-digit OTP')),
//       );
//     }
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: Padding(
//         padding: const EdgeInsets.all(16.0),
//         child: Column(
//           children: [
//             Expanded(
//               child: Column(
//                 mainAxisAlignment: MainAxisAlignment.center,
//                 children: [
//                   Form(
//                     key: _formKey,
//                     child: Column(
//                       crossAxisAlignment: CrossAxisAlignment.start,
//                       children: [
//                         SizedBox(height: 50),
//                         Text(
//                           "Welcome, Sign In",
//                           style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
//                         ),
//                         SizedBox(height: 20),
//                         Row(
//                           children: [
//                             CountryCodePicker(
//                               mode: CountryCodePickerMode.dialog,
//                               initialSelection: 'IN',
//                               showFlag: true,
//                               showDropDownButton: true,
//                               onChanged: (country) {
//                                 setState(() {
//                                   _countryCode = country.dialCode!;
//                                 });
//                               },
//                             ),
//                             Expanded(
//                               child: TextFormField(
//                                 controller: _mobileController,
//                                 keyboardType: TextInputType.phone,
//                                 maxLength: 10,
//                                 decoration: InputDecoration(
//                                   hintText: "Mobile number",
//                                   border: OutlineInputBorder(
//                                     borderRadius: BorderRadius.circular(8.0),
//                                   ),
//                                 ),
//                                 validator: (value) {
//                                   if (value == null ||
//                                       value.isEmpty ||
//                                       value.length != 10 ||
//                                       !RegExp(r'^[0-9]+$').hasMatch(value)) {
//                                     return 'Invalid mobile number. Please try again.';
//                                   }
//                                   return null;
//                                 },
//                               ),
//                             ),
//                           ],
//                         ),
//                         if (_isOTPSent) ...[
//                           SizedBox(height: 10),
//                           TextField(
//                             controller: _otpController,
//                             keyboardType: TextInputType.number,
//                             decoration: InputDecoration(
//                               hintText: "Enter 6-digit OTP",
//                               border: OutlineInputBorder(
//                                 borderRadius: BorderRadius.circular(8.0),
//                               ),
//                             ),
//                           ),
//                         ],
//                         SizedBox(height: 10),
//                         Wrap(
//                           children: [
//                             Text(
//                               "By signing in you accept our ",
//                               style: TextStyle(fontSize: 15),
//                             ),
//                             InkWell(
//                               onTap: () {},
//                               child: Text(
//                                 "Terms & Conditions",
//                                 style: TextStyle(fontSize: 15, color: Colors.orange),
//                               ),
//                             ),
//                             Text(
//                               " and ",
//                               style: TextStyle(fontSize: 15),
//                             ),
//                             InkWell(
//                               child: Text(
//                                 "Privacy Policy",
//                                 style: TextStyle(fontSize: 15, color: Colors.orange),
//                               ),
//                             ),
//                           ],
//                         ),
//                       ],
//                     ),
//                   ),
//                 ],
//               ),
//             ),
//             Column(
//               children: [
//                 ElevatedButton(
//                   style: ElevatedButton.styleFrom(
//                     backgroundColor: Colors.blue.shade800,
//                     minimumSize: Size(double.infinity, 50),
//                     shape: RoundedRectangleBorder(
//                       borderRadius: BorderRadius.circular(10),
//                     ),
//                   ),
//                   onPressed: _isOTPSent ? _verifyOTP : _sendOTP,
//                   child: Text(
//                     _isOTPSent ? "Verify OTP" : "Send OTP",
//                     style: TextStyle(color: Colors.white),
//                   ),
//                 ),
//                 Center(
//                   child: TextButton(
//                     onPressed: () {},
//                     child: Column(
//                       mainAxisSize: MainAxisSize.min, // Ensure Column takes only necessary space
//                       children: [
//                         Text(
//                           "LOST YOUR NUMBER?",
//                           style: TextStyle(color: Colors.orange),
//                         ),
//                         Container(
//                           width: 140, // Adjust the width as needed
//                           height: 2, // Thickness of the underline
//                           color: Colors.orange, // Color of the underline
//                         ),
//                       ],
//                     ),
//                   ),
//                 ),
//               ],
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
