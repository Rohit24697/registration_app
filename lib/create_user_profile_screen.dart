// import 'dart:convert';
// import 'package:http/http.dart' as http;
//
// import 'package:flutter/material.dart';
//
// class CreateUserProfileScreen extends StatefulWidget {
//   final String mobile;
//
//   CreateUserProfileScreen({required this.mobile});
//
//   @override
//   _CreateUserProfileScreenState createState() => _CreateUserProfileScreenState();
// }
//
// class _CreateUserProfileScreenState extends State<CreateUserProfileScreen> {
//   final _formKey = GlobalKey<FormState>();
//   final _firstNameController = TextEditingController();
//   final _lastNameController = TextEditingController();
//   final _usernameController = TextEditingController();
//   final _passwordController = TextEditingController();
//   final _confirmPasswordController = TextEditingController();
//
//   bool _obscurePassword = true;
//
//   Future<void> _createUser() async {
//     if (_formKey.currentState!.validate()) {
//       final url = Uri.parse('http://localhost:8080/amicaneservice/api/user/mobile');
//       final response = await http.post(
//         url,
//         headers: {'Content-Type': 'application/json'},
//         body: jsonEncode({
//           "userName": _usernameController.text,
//           "password": _passwordController.text,
//           "mobileNo": widget.mobile.replaceAll('+', ''),
//           "countryCode": widget.mobile.substring(0, widget.mobile.length - 10),
//           "firstName": _firstNameController.text,
//           "lastName": _lastNameController.text,
//         }),
//       );
//
//       final responseData = json.decode(response.body);
//       if (responseData['isErrored'] == false && responseData['status']['value'] == 200) {
//         ScaffoldMessenger.of(context).showSnackBar(
//           SnackBar(content: Text('User created successfully')),
//         );
//       } else if (responseData['data']['error'] == 'Duplicate Entry') {
//         ScaffoldMessenger.of(context).showSnackBar(
//           SnackBar(content: Text('Username already exists. Please choose another one.')),
//         );
//       } else {
//         ScaffoldMessenger.of(context).showSnackBar(
//           SnackBar(content: Text('Failed to create user. Please try again.')),
//         );
//       }
//     }
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: SafeArea(
//         child: Padding(
//           padding: const EdgeInsets.all(16.0),
//           child: Form(
//             key: _formKey,
//             child: SingleChildScrollView(
//               child: Column(
//                 children: [
//                   Text('Successfully Confirmed Phone Number!', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 26.0),),
//                   Text('Create login information for using AmiCane',style: TextStyle(fontWeight: FontWeight.normal, fontSize: 20.0), textAlign: TextAlign.start,),
//                   SizedBox(height: 30),
//                   TextFormField(
//                     controller: _firstNameController,
//                     decoration: InputDecoration(labelText: 'First name',
//                       border: OutlineInputBorder(
//                       borderRadius: BorderRadius.circular(8.0),
//                     ),),
//                     validator: (value) {
//                       if (value == null || value.isEmpty) {
//                         return 'Please enter first name';
//                       }
//                       return null;
//                     },
//                   ),
//                   SizedBox(height: 20.0),
//                   TextFormField(
//                     controller: _lastNameController,
//                     decoration: InputDecoration(labelText: 'Last name',
//                       border: OutlineInputBorder(
//                         borderRadius: BorderRadius.circular(8.0),
//                       ),),
//                     validator: (value) {
//                       if (value == null || value.isEmpty) {
//                         return 'Please enter last name';
//                       }
//                       return null;
//                     },
//                   ),
//                   SizedBox(height: 20.0),
//                   TextFormField(
//                     controller: _usernameController,
//                     decoration: InputDecoration(labelText: 'Username',
//                       border: OutlineInputBorder(
//                         borderRadius: BorderRadius.circular(8.0),
//                       ),),
//                     validator: (value) {
//                       if (value == null || value.isEmpty) {
//                         return 'Please enter username';
//                       }
//                       return null;
//                     },
//                   ),
//                   SizedBox(height: 20.0),
//                   TextFormField(
//                     controller: _passwordController,
//                     decoration: InputDecoration(
//                       labelText: 'Password',
//                       border: OutlineInputBorder(
//                         borderRadius: BorderRadius.circular(8.0),
//                       ),
//                       suffixIcon: IconButton(
//                         icon: Icon(
//                           _obscurePassword ? Icons.visibility : Icons.visibility_off,
//                         ),
//                         onPressed: () {
//                           setState(() {
//                             _obscurePassword = !_obscurePassword;
//                           });
//                         },
//                       ),
//                     ),
//                     obscureText: _obscurePassword,
//                     validator: (value) {
//                       if (value == null || value.isEmpty) {
//                         return 'Please enter password';
//                       }
//                       return null;
//                     },
//                   ),
//                   SizedBox(height: 20.0),
//                   TextFormField(
//                     controller: _confirmPasswordController,
//                     decoration: InputDecoration(
//                       labelText: 'Confirm Password',
//                       border: OutlineInputBorder(
//                         borderRadius: BorderRadius.circular(8.0),
//                       ),
//                       suffixIcon: IconButton(
//                         icon: Icon(
//                           _obscurePassword ? Icons.visibility : Icons.visibility_off,
//                         ),
//                         onPressed: () {
//                           setState(() {
//                             _obscurePassword = !_obscurePassword;
//                           });
//                         },
//                       ),
//                     ),
//                     obscureText: _obscurePassword,
//                     validator: (value) {
//                       if (value == null || value.isEmpty) {
//                         return 'Please confirm password';
//                       }
//                       if (value != _passwordController.text) {
//                         return 'Passwords do not match';
//                       }
//                       return null;
//                     },
//                   ),
//                   SizedBox(height: 30.0),
//                   ElevatedButton(
//                     style: ElevatedButton.styleFrom(
//                       backgroundColor: Colors.blue.shade800,
//                       minimumSize: Size(double.infinity, 50),
//                       shape: RoundedRectangleBorder(
//                         borderRadius: BorderRadius.circular(10),
//                       ),
//                     ),
//                     onPressed: (){}, // Call _verifyOTP here
//                     child: Text(
//                       "Verify",
//                       style: TextStyle(color: Colors.white),
//                     ),
//                   ),
//                 ],
//               ),
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }


import 'dart:convert';
import 'package:http/http.dart' as http;

import 'package:flutter/material.dart';

class CreateUserProfileScreen extends StatefulWidget {
  final String mobile;

  CreateUserProfileScreen({required this.mobile});

  @override
  _CreateUserProfileScreenState createState() => _CreateUserProfileScreenState();
}

class _CreateUserProfileScreenState extends State<CreateUserProfileScreen> {
  final _formKey = GlobalKey<FormState>();
  final _firstNameController = TextEditingController();
  final _lastNameController = TextEditingController();
  final _usernameController = TextEditingController();
  final _passwordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();

  bool _obscurePassword = true;
  bool _obscureConfirmPassword = true;

  // Future<void> _createUser() async {
  //   if (_formKey.currentState!.validate()) {
  //     // final url = Uri.parse('http://localhost:8080/amicaneservice/api/user/mobile');
  //     final url = Uri.parse('http://192.168.1.100:8080/amicaneservice/api/user/mobile');
  //     final response = await http.post(
  //       url,
  //       headers: {'Content-Type': 'application/json'},
  //       body: jsonEncode({
  //         "userName": _usernameController.text,
  //         "password": _passwordController.text,
  //         "mobileNo": widget.mobile.replaceAll('+', ''),
  //         "countryCode": widget.mobile.substring(0, widget.mobile.length - 10),
  //         "firstName": _firstNameController.text,
  //         "lastName": _lastNameController.text,
  //       }),
  //     );
  //
  //     final responseData = json.decode(response.body);
  //     if (responseData['isErrored'] == false && responseData['status']['value'] == 200) {
  //       ScaffoldMessenger.of(context).showSnackBar(
  //         SnackBar(content: Text('User created successfully')),
  //       );
  //     } else if (responseData['data']['error'] == 'Duplicate Entry') {
  //       ScaffoldMessenger.of(context).showSnackBar(
  //         SnackBar(content: Text('Username already exists. Please choose another one.')),
  //       );
  //     } else {
  //       ScaffoldMessenger.of(context).showSnackBar(
  //         SnackBar(content: Text('Failed to create user. Please try again.')),
  //       );
  //     }
  //   }
  // }

  Future<void> _createUser() async {
    if (_formKey.currentState!.validate()) {
      try {
        // final url = Uri.parse('http://10.0.2.2:8080/amicaneservice/api/user/mobile'); // For Emulator
        final url = Uri.parse('http://192.168.1.100:8080/amicaneservice/api/user/mobile'); // For Real Device

        String mobileNo = widget.mobile.replaceAll('+', '');
        String countryCode = widget.mobile.replaceAll(RegExp(r'\d{10}$'), ''); // Safe extraction

        final response = await http.post(
          url,
          headers: {'Content-Type': 'application/json'},
          body: jsonEncode({
            "userName": _usernameController.text,
            "password": _passwordController.text,
            "mobileNo": mobileNo,
            "countryCode": countryCode,
            "firstName": _firstNameController.text,
            "lastName": _lastNameController.text,
          }),
        );

        if (response.statusCode == 200) {
          final responseData = jsonDecode(response.body);
          if (responseData['isErrored'] == false && responseData['status']['value'] == 200) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text('User created successfully')),
            );
          } else if (responseData['data']?['error'] == 'Duplicate Entry') {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text('Username already exists. Please choose another one.')),
            );
          } else {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text('Failed to create user. Please try again.')),
            );
          }
        } else {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('Server error: ${response.statusCode}')),
          );
        }
      } catch (e) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Network error: ${e.toString()}')),
        );
      }
    }
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              Expanded(
                child: Form(
                  key: _formKey,
                  child: SingleChildScrollView(
                    child: Column(
                      children: [
                        Text('Successfully Confirmed Phone Number!', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 26.0),),
                        Text('Create login information for using AmiCane',style: TextStyle(fontWeight: FontWeight.normal, fontSize: 20.0), textAlign: TextAlign.start,),
                        SizedBox(height: 30),
                        TextFormField(
                          controller: _firstNameController,
                          decoration: InputDecoration(labelText: 'First name',
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(8.0),
                            ),),
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please enter first name';
                            }
                            return null;
                          },
                        ),
                        SizedBox(height: 20.0),
                        TextFormField(
                          controller: _lastNameController,
                          decoration: InputDecoration(labelText: 'Last name',
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(8.0),
                            ),),
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please enter last name';
                            }
                            return null;
                          },
                        ),
                        SizedBox(height: 20.0),
                        TextFormField(
                          controller: _usernameController,
                          decoration: InputDecoration(labelText: 'Username',
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(8.0),
                            ),),
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please enter username';
                            }
                            return null;
                          },
                        ),
                        SizedBox(height: 20.0),
                        TextFormField(
                          controller: _passwordController,
                          decoration: InputDecoration(
                            labelText: 'Password',
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(8.0),
                            ),
                            suffixIcon: IconButton(
                              icon: Icon(
                                _obscurePassword ? Icons.visibility : Icons.visibility_off,
                              ),
                              onPressed: () {
                                setState(() {
                                  _obscurePassword = !_obscurePassword;
                                });
                              },
                            ),
                          ),
                          obscureText: _obscurePassword,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please enter password';
                            }
                            return null;
                          },
                        ),
                        SizedBox(height: 20.0),
                        TextFormField(
                          controller: _confirmPasswordController,
                          decoration: InputDecoration(
                            labelText: 'Confirm Password',
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(8.0),
                            ),
                            suffixIcon: IconButton(
                              icon: Icon(
                                _obscureConfirmPassword ? Icons.visibility : Icons.visibility_off,
                              ),
                              onPressed: () {
                                setState(() {
                                  _obscureConfirmPassword = !_obscureConfirmPassword;
                                });
                              },
                            ),
                          ),
                          obscureText: _obscureConfirmPassword,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please confirm password';
                            }
                            if (value != _passwordController.text) {
                              return 'Passwords do not match';
                            }
                            return null;
                          },
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.blue.shade800,
                  minimumSize: Size(180, 50),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                onPressed: _createUser,
                child: Text(
                  "Verify",
                  style: TextStyle(color: Colors.white),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}