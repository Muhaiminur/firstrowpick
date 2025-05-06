// import 'package:flutter/material.dart';
// import 'package:halftimepick/utils/colors.dart';
// import 'package:halftimepick/utils/dimensions.dart';
// import 'package:halftimepick/views/custom_widgets/custom_button.dart';

// class ProfilePage extends StatefulWidget {
//   const ProfilePage({super.key});

//   @override
//   State<ProfilePage> createState() => _ProfilePageState();
// }

// class _ProfilePageState extends State<ProfilePage> {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: Colors.black,
//       appBar: AppBar(
//         elevation: 0.0,
//         backgroundColor: ProjectColors.secondaryColor,
//         iconTheme: const IconThemeData(color: Colors.white),
//         titleTextStyle: const TextStyle(
//             fontSize: Dimensions.FONT_SIZE_EXTRA_LARGE, color: Colors.white),
//         title: const Text(
//           'Profile',
//           style: TextStyle(
//             color: Colors.white,
//             fontSize: 18,
//             fontFamily: 'Rubik',
//             fontWeight: FontWeight.w600,
//             height: 0,
//             letterSpacing: -0.30,
//           ),
//         ),
//         centerTitle: true,
//         titleSpacing: 0.0,
//       ),
//       body: SingleChildScrollView(
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             const SizedBox(
//               height: 16,
//             ),
//             Stack(
//               alignment: AlignmentDirectional.center,
//               children: [
//                 ClipRRect(
//                     borderRadius: const BorderRadius.only(
//                         topLeft: Radius.circular(25),
//                         topRight: Radius.circular(25)),
//                     child: Image.asset(
//                       "assets/images/profileback.png",
//                       fit: BoxFit.fill,
//                     )),
//                 SizedBox(
//                   width: 100,
//                   height: 100,
//                   child: Stack(
//                     children: [
//                       CircleAvatar(
//                         minRadius: 50,
//                         child: Image.asset(
//                           "assets/images/avatar.png",
//                           height: 50,
//                           width: 50,
//                           fit: BoxFit.cover,
//                         ),
//                       ),
//                       Positioned(
//                           right: 0,
//                           bottom: 10,
//                           child: InkWell(
//                             onTap: () {},
//                             child: Image.asset(
//                               "assets/images/camera.png",
//                               height: 25,
//                               width: 25,
//                               fit: BoxFit.cover,
//                             ),
//                           ))
//                     ],
//                   ),
//                 )
//               ],
//             ),
//             Container(
//               margin: const EdgeInsets.all(16),
//               child: Column(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   const Text(
//                     'Personal information',
//                     style: TextStyle(
//                       color: Colors.white,
//                       fontSize: 18,
//                       fontFamily: 'Rubik',
//                       fontWeight: FontWeight.bold,
//                       height: 0,
//                     ),
//                   ),
//                   Container(
//                     padding: const EdgeInsets.symmetric(
//                         horizontal: 16, vertical: 16),
//                     width: double.infinity,
//                     margin: const EdgeInsets.only(top: 16),
//                     height: 80,
//                     decoration: BoxDecoration(
//                       borderRadius: BorderRadius.circular(8),
//                       color: ProjectColors.primaryColor,
//                     ),
//                     child: const Column(
//                       crossAxisAlignment: CrossAxisAlignment.start,
//                       mainAxisAlignment: MainAxisAlignment.spaceAround,
//                       children: [
//                         Text(
//                           'Username',
//                           style: TextStyle(
//                             color: Color(0xFF3063C5),
//                             fontSize: 12,
//                             fontFamily: 'Rubik',
//                             fontWeight: FontWeight.w600,
//                           ),
//                         ),
//                         Text(
//                           'nguyenshane@123',
//                           style: TextStyle(
//                             color: Color(0xFFA2A8BB),
//                             fontSize: 16,
//                             fontFamily: 'Rubik',
//                             fontWeight: FontWeight.w400,
//                           ),
//                         )
//                       ],
//                     ),
//                   ),
//                   Container(
//                     padding: const EdgeInsets.symmetric(
//                         horizontal: 16, vertical: 16),
//                     width: double.infinity,
//                     margin: const EdgeInsets.only(top: 16),
//                     height: 80,
//                     decoration: BoxDecoration(
//                       borderRadius: BorderRadius.circular(8),
//                       color: ProjectColors.primaryColor,
//                     ),
//                     child: const Column(
//                       crossAxisAlignment: CrossAxisAlignment.start,
//                       mainAxisAlignment: MainAxisAlignment.spaceAround,
//                       children: [
//                         Text(
//                           'Name',
//                           style: TextStyle(
//                             color: Color(0xFF3063C5),
//                             fontSize: 12,
//                             fontFamily: 'Rubik',
//                             fontWeight: FontWeight.w600,
//                           ),
//                         ),
//                         Text(
//                           'Nguyen Shane',
//                           style: TextStyle(
//                             color: Color(0xFFA2A8BB),
//                             fontSize: 16,
//                             fontFamily: 'Rubik',
//                             fontWeight: FontWeight.w400,
//                           ),
//                         )
//                       ],
//                     ),
//                   ),
//                   Container(
//                     padding: const EdgeInsets.symmetric(
//                         horizontal: 16, vertical: 16),
//                     width: double.infinity,
//                     margin: const EdgeInsets.only(top: 16),
//                     height: 80,
//                     decoration: BoxDecoration(
//                       borderRadius: BorderRadius.circular(8),
//                       color: ProjectColors.primaryColor,
//                     ),
//                     child: Row(
//                       crossAxisAlignment: CrossAxisAlignment.center,
//                       mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                       children: [
//                         const Column(
//                           crossAxisAlignment: CrossAxisAlignment.start,
//                           mainAxisAlignment: MainAxisAlignment.spaceAround,
//                           children: [
//                             Text(
//                               'Contact Number',
//                               style: TextStyle(
//                                 color: Color(0xFF3063C5),
//                                 fontSize: 12,
//                                 fontFamily: 'Rubik',
//                                 fontWeight: FontWeight.w600,
//                               ),
//                             ),
//                             Text(
//                               '+8801800000000',
//                               style: TextStyle(
//                                 color: Color(0xFFA2A8BB),
//                                 fontSize: 16,
//                                 fontFamily: 'Rubik',
//                                 fontWeight: FontWeight.w400,
//                               ),
//                             )
//                           ],
//                         ),
//                         IconButton(
//                             iconSize: 22,
//                             onPressed: () {},
//                             icon: const Icon(
//                               Icons.edit,
//                               color: ProjectColors.textfieldHint,
//                             ))
//                       ],
//                     ),
//                   ),
//                   Container(
//                     padding: const EdgeInsets.symmetric(
//                         horizontal: 16, vertical: 16),
//                     width: double.infinity,
//                     margin: const EdgeInsets.only(top: 16),
//                     height: 80,
//                     decoration: BoxDecoration(
//                       borderRadius: BorderRadius.circular(8),
//                       color: ProjectColors.primaryColor,
//                     ),
//                     child: const Column(
//                       crossAxisAlignment: CrossAxisAlignment.start,
//                       mainAxisAlignment: MainAxisAlignment.spaceAround,
//                       children: [
//                         Text(
//                           'Email',
//                           style: TextStyle(
//                             color: Color(0xFF3063C5),
//                             fontSize: 12,
//                             fontFamily: 'Rubik',
//                             fontWeight: FontWeight.w600,
//                           ),
//                         ),
//                         Text(
//                           'tim.jennings@example.com',
//                           style: TextStyle(
//                             color: Color(0xFFA2A8BB),
//                             fontSize: 16,
//                             fontFamily: 'Rubik',
//                             fontWeight: FontWeight.w400,
//                           ),
//                         )
//                       ],
//                     ),
//                   ),
//                 ],
//               ),
//             ),
//             CustomButton(onTap: () {}, buttonText: "Continue"),
//             const SizedBox(
//               height: 32,
//             )
//           ],
//         ),
//       ),
//     );
//   }
// }
