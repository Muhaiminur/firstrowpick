// import 'dart:developer';

// import 'package:flutter/gestures.dart';
// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:halftimepick/utils/colors.dart';
// import 'package:halftimepick/utils/routes.dart';
// import 'package:halftimepick/views/custom_widgets/custom_button.dart';
// import 'package:halftimepick/views/custom_widgets/nameTextField.dart';
// import 'package:halftimepick/views/custom_widgets/passwordTextfield.dart';

// class ResigterPage extends StatefulWidget {
//   const ResigterPage({super.key});

//   @override
//   State<ResigterPage> createState() => _ResigterPageState();
// }

// class _ResigterPageState extends State<ResigterPage> {
//   final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
//   final TextEditingController passwordController = TextEditingController();
//   final TextEditingController usernameController = TextEditingController();
//   final TextEditingController nameController = TextEditingController();
//   bool agreedToTerms = false;
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: Stack(
//         fit: StackFit.expand,
//         children: [
//           // Background Image
//           Image.asset(
//             'assets/images/background_image.png', // Provide path to your image
//             fit: BoxFit.cover,
//           ),
//           // Gradient Layer

//           Container(
//             decoration: BoxDecoration(
//               gradient: LinearGradient(
//                 begin: Alignment.topCenter,
//                 end: Alignment.bottomCenter,
//                 colors: [
//                   Colors.black.withOpacity(0.9),
//                   ProjectColors.primaryColor
//                       .withOpacity(0.8), // Adjust opacity as needed
//                 ],
//               ),
//             ),
//           ),
//           Column(
//             children: [
//               Form(
//                 key: _formKey,
//                 child: Container(
//                   margin: const EdgeInsets.all(16),
//                   child: Column(
//                     children: [
//                       Container(
//                         margin: EdgeInsets.only(
//                             top: MediaQuery.of(context).size.height * 0.08,
//                             bottom: 20),
//                         child: Image.asset(
//                           'assets/images/new_logo.png',
//                           width: MediaQuery.of(context).size.width *
//                               0.42, // Provide path to your image
//                           fit: BoxFit.fitWidth,
//                         ),
//                       ),
//                       Container(
//                         margin: const EdgeInsets.symmetric(horizontal: 40),
//                         child: const Text(
//                           'sports is a premium OTT platform that allows subscribers to watch live sports.',
//                           textAlign: TextAlign.center,
//                           style: TextStyle(
//                             color: Color(0xFF677294),
//                             fontSize: 14,
//                             fontFamily: 'Rubik',
//                             fontWeight: FontWeight.w400,
//                           ),
//                         ),
//                       ),
//                       Container(
//                         margin: const EdgeInsets.only(top: 16),
//                         child: FullNameTextField(
//                           controller: usernameController,
//                           hintText: 'Username',
//                           validator: (value) {
//                             if (value == null || value.isEmpty) {
//                               return 'Please enter username';
//                             }
//                             return null; // Validation passed
//                           },
//                         ),
//                       ),
//                       Container(
//                         margin: const EdgeInsets.only(top: 12),
//                         child: FullNameTextField(
//                           controller: nameController,
//                           hintText: 'Name',
//                           validator: (value) {
//                             if (value == null || value.isEmpty) {
//                               return 'Please enter name';
//                             }
//                             return null; // Validation passed
//                           },
//                         ),
//                       ),
//                       /*     Container(
//                         margin: const EdgeInsets.only(top: 12),
//                         child: PhnEmailTextfield(
//                           controller: TextEditingController(),
//                           validationType: ValidationType.phone,
//                           hintText: 'Phone',
//                           validator: (value) {
//                             // Additional validation logic if needed
//                             return null;
//                           },
//                         ),
//                       ), */
//                       /*   Container(
//                         margin: const EdgeInsets.only(top: 12),
//                         child: PhnEmailTextfield(
//                           controller: TextEditingController(),
//                           validationType: ValidationType.email,
//                           hintText: 'Email',
//                           validator: (value) {
//                             // Additional validation logic if needed
//                             return null;
//                           },
//                         ),
//                       ), */
//                       const SizedBox(
//                         height: 12,
//                       ),
//                       PasswordTextField(
//                         controller: passwordController,
//                         hintText: 'Enter your password',
//                         validator: (value) {
//                           if (value == null || value.isEmpty) {
//                             return 'Please enter your password';
//                           }
//                           return null; // Validation passed
//                         },
//                       ),
//                       Container(
//                         margin: const EdgeInsets.only(top: 12),
//                         width: MediaQuery.of(context).size.width * 0.9,
//                         child: Row(
//                           crossAxisAlignment: CrossAxisAlignment.start,
//                           children: [
//                             Container(
//                               decoration: BoxDecoration(
//                                 shape: BoxShape.circle,
//                                 border: Border.all(
//                                   color: ProjectColors
//                                       .textfieldHint, // Border color
//                                   width: 1.0, // Border width
//                                 ),
//                               ),
//                               child: Padding(
//                                 padding: const EdgeInsets.all(2.0),
//                                 child: ClipOval(
//                                   child: Material(
//                                     color: Colors.transparent,
//                                     child: InkWell(
//                                       onTap: () {
//                                         setState(() {
//                                           agreedToTerms = !agreedToTerms;
//                                         });
//                                       },
//                                       child: SizedBox(
//                                         width: 16,
//                                         height: 16,
//                                         child: agreedToTerms
//                                             ? const Icon(
//                                                 Icons.check,
//                                                 size: 15.0,
//                                                 color: ProjectColors
//                                                     .textfieldHint, // Icon color
//                                               )
//                                             : null,
//                                       ),
//                                     ),
//                                   ),
//                                 ),
//                               ),
//                             ),
//                             const SizedBox(width: 10),
//                             SizedBox(
//                               width: MediaQuery.of(context).size.width * 0.8,
//                               child: const Text(
//                                 'I agree with the Terms of Service & Privacy Policy',
//                                 style: TextStyle(
//                                   color: ProjectColors.textfieldHint,
//                                   fontSize: 14,
//                                 ),
//                               ),
//                             ),
//                           ],
//                         ),
//                       ),
//                     ],
//                   ),
//                 ),
//               ),
//               CustomButton(
//                   onTap: () {
//                     if (_formKey.currentState!.validate()) {
//                       log("register");
//                     }
//                   },
//                   buttonText: "Sign up"),
//               Container(
//                 margin: const EdgeInsets.only(top: 12),
//                 child: RichText(
//                   textAlign: TextAlign.center,
//                   text: TextSpan(
//                     style: const TextStyle(
//                       color: Colors.white,
//                       fontSize: 14,
//                       fontFamily: 'Rubik',
//                       fontWeight: FontWeight.w400,
//                     ),
//                     children: [
//                       const TextSpan(
//                         text: 'Have an account? ',
//                       ),
//                       TextSpan(
//                         text: 'Log in',
//                         style: const TextStyle(
//                           decoration: TextDecoration.underline,
//                         ),
//                         recognizer: TapGestureRecognizer()
//                           ..onTap = () {
//                             Get.toNamed(loginpage);
//                           },
//                       ),
//                     ],
//                   ),
//                 ),
//               ),
//             ],
//           )
//           // Your Content Widgets
//           // Add your content widgets on top of the image and gradient layers
//         ],
//       ),
//     );
//   }
// }
