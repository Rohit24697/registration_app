//
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:flutter/material.dart';
// import 'create_user_profile_screen.dart';
//
// class OTPScreen extends StatefulWidget {
//   final String mobile;
//   final String verificationId;
//
//   OTPScreen({required this.mobile, required this.verificationId});
//
//   @override
//   _OTPScreenState createState() => _OTPScreenState();
// }
//
// class _OTPScreenState extends State<OTPScreen> {
//   final _formKey = GlobalKey<FormState>();
//   final TextEditingController _otpController = TextEditingController();
//
//   Future<void> _verifyOTP() async {
//     if (_formKey.currentState!.validate()) {
//       try {
//         // Firebase authentication
//         PhoneAuthCredential credential = PhoneAuthProvider.credential(
//           verificationId: widget.verificationId,
//           smsCode: _otpController.text,
//         );
//
//         UserCredential userCredential =
//         await FirebaseAuth.instance.signInWithCredential(credential);
//
//         if (userCredential.user != null) {
//           Navigator.push(
//             context,
//             MaterialPageRoute(
//               builder: (context) => CreateUserProfileScreen(mobile: widget.mobile),
//             ),
//           );
//         } else {
//           ScaffoldMessenger.of(context).showSnackBar(
//             SnackBar(content: Text('Invalid OTP. Please try again.')),
//           );
//         }
//       } catch (e) {
//         ScaffoldMessenger.of(context).showSnackBar(
//           SnackBar(content: Text('Error: ${e.toString()}')),
//         );
//       }
//     }
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(title: Text('OTP Verification')),
//       body: Padding(
//         padding: const EdgeInsets.all(16.0),
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: [
//             Form(
//               key: _formKey,
//               child: Column(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   Text('OTP Verification',style: TextStyle(fontWeight: FontWeight.bold,fontSize: 24.0),),
//                   Text('Please check the text message on your mobile phone for OTP',style: TextStyle(fontWeight: FontWeight.normal,fontSize: 16.0),),
//                   SizedBox(height: 16),
//                   TextFormField(
//                     controller: _otpController,
//                     decoration: InputDecoration(labelText: '6 digit OTP number',
//                       border: OutlineInputBorder(
//                         borderRadius: BorderRadius.circular(8.0),
//                       ),),
//                     keyboardType: TextInputType.number,
//                     validator: (value) {
//                       if (value == null || value.isEmpty) {
//                         return 'Please enter OTP';
//                       }
//                       if (!RegExp(r'^\d{6}$').hasMatch(value)) {
//                         return 'OTP should be exactly 6 digits.';
//                       }
//                       return null;
//                     },
//                   ),
//                   SizedBox(height: 8),
//                   Row(
//                     mainAxisAlignment: MainAxisAlignment.end,
//                     children: [
//                       TextButton(
//                         onPressed: () {},
//                         child: Column(
//                           mainAxisSize: MainAxisSize.min, // Ensure Column takes only necessary space
//                           children: [
//                             Text(
//                               "RE-SEND OTP",
//                               style: TextStyle(color: Colors.orange),
//                             ),
//                             Container(
//                               width: 90, // Adjust the width as needed
//                               height: 2, // Thickness of the underline
//                               color: Colors.orange, // Color of the underline
//                             ),
//                           ],
//                         ),
//                       ),
//                     ],
//                   ),
//                   SizedBox(height: 16),
//                   ElevatedButton(
//                     style: ElevatedButton.styleFrom(
//                       backgroundColor: Colors.blue.shade800,
//                       minimumSize: Size(double.infinity, 50),
//                       shape: RoundedRectangleBorder(
//                         borderRadius: BorderRadius.circular(10),
//                       ),
//                     ),
//                     onPressed: (){},
//                     child: Text("Verify",style: TextStyle(color: Colors.white),),
//                   ),
//                   SizedBox(height: 16),
//                   Center(
//                     child: TextButton(
//                       onPressed: () {},
//                       child: Column(
//                         mainAxisSize: MainAxisSize.min, // Ensure Column takes only necessary space
//                         children: [
//                           Text(
//                             "WRONG PHONE NUMBER?",
//                             style: TextStyle(color: Colors.orange),
//                           ),
//                           Container(
//                             width: 170, // Adjust the width as needed
//                             height: 2, // Thickness of the underline
//                             color: Colors.orange, // Color of the underline
//                           ),
//                         ],
//                       ),
//                     ),
//                   )
//                 ],
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }


import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:registration_app/welcome_screen.dart';
import 'create_user_profile_screen.dart';

class OTPScreen extends StatefulWidget {
  final String mobile;
  final String verificationId;

  OTPScreen({required this.mobile, required this.verificationId});

  @override
  _OTPScreenState createState() => _OTPScreenState();
}

class _OTPScreenState extends State<OTPScreen> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _otpController = TextEditingController();

  Future<void> _verifyOTP() async {
    if (_formKey.currentState!.validate()) {
      try {
        // Firebase authentication
        PhoneAuthCredential credential = await PhoneAuthProvider.credential(
          verificationId: widget.verificationId,
          smsCode: _otpController.text.toString(),
        );

        UserCredential userCredential =
        await  FirebaseAuth.instance.signInWithCredential(credential);
        // FirebaseAuth.instance.signInWithCredential(credential).then((value){
        //   Navigator.push(context, MaterialPageRoute(builder: (context)=>WelcomeScreen()));
        // });

        if (userCredential.user != null) {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => CreateUserProfileScreen(mobile: widget.mobile),
            ),
          );
        } else {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('Invalid OTP. Please try again.')),
          );
        }
      } catch (ex) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Error: ${ex.toString()}')),
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
              child: Form(
                key: _formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center, // Center the form content
                  children: [
                    Text(
                      'OTP Verification',
                      style:
                      TextStyle(fontWeight: FontWeight.bold, fontSize: 26.0),
                    ),
                    Text(
                      'Please check the text message on your mobile phone for OTP',
                      style: TextStyle(
                          fontWeight: FontWeight.normal, fontSize: 16.0),
                    ),
                    SizedBox(height: 16),
                    TextFormField(
                      controller: _otpController,
                      decoration: InputDecoration(
                        labelText: '6 digit OTP number',
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8.0),
                        ),
                      ),
                      keyboardType: TextInputType.number,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter OTP';
                        }
                        if (!RegExp(r'^\d{6}$').hasMatch(value)) {
                          return 'OTP should be exactly 6 digits.';
                        }
                        return null;
                      },
                    ),
                    SizedBox(height: 8),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        TextButton(
                          onPressed: () {},
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Text(
                                "RE-SEND OTP",
                                style: TextStyle(color: Colors.orange),
                              ),
                              Container(
                                width: 90,
                                height: 2,
                                color: Colors.orange,
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
            Column( // Added this column to place the verify button and wrong phone number at the bottom
              children: [
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.blue.shade800,
                    minimumSize: Size(double.infinity, 50),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  onPressed: _verifyOTP, // Call _verifyOTP here
                  child: Text(
                    "Verify",
                    style: TextStyle(color: Colors.white),
                  ),
                ),
                SizedBox(height: 16),
                Center(
                  child: TextButton(
                    onPressed: () {},
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(
                          "WRONG PHONE NUMBER?",
                          style: TextStyle(color: Colors.orange),
                        ),
                        Container(
                          width: 170,
                          height: 2,
                          color: Colors.orange,
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