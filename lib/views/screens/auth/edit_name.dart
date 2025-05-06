import 'dart:io';

import 'package:device_info_plus/device_info_plus.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:halftimepick/utils/colors.dart';
import 'package:halftimepick/utils/dimensions.dart';
import 'package:halftimepick/utils/routes.dart';
import 'package:halftimepick/utils/shared_pref.dart';
import 'package:halftimepick/views/custom_widgets/custom_button.dart';
import 'package:halftimepick/views/custom_widgets/nameTextField.dart';

class EditProfilePage extends StatefulWidget {
  const EditProfilePage({super.key});

  @override
  State<EditProfilePage> createState() => _EditProfilePageState();
}

class _EditProfilePageState extends State<EditProfilePage> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _userController = TextEditingController();
  bool agreedToTerms = false;
  final SharedPref sharedPref = SharedPref();
  String deviceid = "";
  String username = "";

  String getDeviceId() {
    var deviceId = '';
    DeviceInfoPlugin deviceInfo = DeviceInfoPlugin();
    try {
      if (Platform.isAndroid) {
        deviceInfo.androidInfo.then((AndroidDeviceInfo info) {
          deviceId = info.id; // Unique Android ID
        });
      } else if (Platform.isIOS) {
        deviceInfo.iosInfo.then((IosDeviceInfo info) {
          deviceId = info.identifierForVendor!;
          // Unique iOS ID
        });
      }
    } catch (e) {
      print('Failed to get device info: $e');
    }
    return deviceId;
  }

  List<String> userDetail = [];
  Future<List<String>> getUser() async {
    var userDel = await sharedPref.readStringList("userDet") ?? <String>[];
    setState(() {
      userDetail = userDel;
    });
    return userDetail;
  }

  @override
  initState() {
    getUser().then((value) {
      _userController.text = value.first.toString();
    });
    deviceid = getDeviceId();
    getUser();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final double appBarHeight = AppBar().preferredSize.height;
    const double bottomNavigationBarHeight = kBottomNavigationBarHeight;
    final double screenHeight = MediaQuery.of(context).size.height;
    final double screenHeightWithoutAppBarAndBottomNavigationBar =
        screenHeight - appBarHeight - bottomNavigationBarHeight;
    return Scaffold(
      appBar: AppBar(
        elevation: 0.0,
        backgroundColor: ProjectColors.secondaryColor,
        iconTheme: const IconThemeData(color: Colors.white),
        titleTextStyle: const TextStyle(
            fontSize: Dimensions.FONT_SIZE_EXTRA_LARGE, color: Colors.white),
        title: const Text("EDIT NAME"),
        centerTitle: true,
        titleSpacing: 0.0,
      ),
      body: SizedBox(
        height: screenHeightWithoutAppBarAndBottomNavigationBar,
        child: Stack(
          fit: StackFit.expand,
          children: [
            // Background Image
            Image.asset(
              'assets/images/background_image.png', // Provide path to your image
              fit: BoxFit.cover,
            ),
            // Gradient Layer

            Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [
                    Colors.black.withOpacity(0.9),
                    ProjectColors.primaryColor
                        .withOpacity(0.8), // Start with transparent color
                    // Adjust opacity as needed
                  ],
                ),
              ),
            ),
            Column(
              children: [
                Form(
                  key: _formKey,
                  child: Container(
                    margin: const EdgeInsets.all(16),
                    child: Column(
                      children: [
                        Container(
                          margin: EdgeInsets.only(
                              top: MediaQuery.of(context).size.height * 0.08,
                              bottom: 20),
                          child: Image.asset(
                            'assets/images/new_logo.png',
                            width: MediaQuery.of(context).size.width *
                                0.42, // Provide path to your image
                            fit: BoxFit.fitWidth,
                          ),
                        ),
                        Container(
                          margin: const EdgeInsets.symmetric(horizontal: 40),
                          child: const Text(
                            'sports is a premium OTT platform that allows subscribers to watch live sports.',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              color: Color(0xFF677294),
                              fontSize: 14,
                              fontFamily: 'Rubik',
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                        ),
                        Container(
                          margin: const EdgeInsets.only(top: 16),
                          child: FullNameTextField(
                            controller: _userController,
                            hintText: 'Username',
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Please enter username';
                              }
                              if (value.trim().isEmpty) {
                                return 'Username cannot be blank';
                              }
                              if (value.length > 10) {
                                return 'Username length cannot be more than 10 characters';
                              }
                              if (int.tryParse(value) != null) {
                                return 'Username cannot contain only numbers';
                              }
                              if (value.trimLeft().startsWith(' ')) {
                                return 'Username cannot start with a blank space';
                              }
                              return null; // Validation passed
                            },
                          ),
                        ),
                        const SizedBox(
                          height: 12,
                        ),
                      ],
                    ),
                  ),
                ),
                CustomButton(
                    onTap: () {
                      if (_formKey.currentState!.validate()) {
                        sharedPref.saveStringList(
                            "userDet", [_userController.text, deviceid]);
                        Get.offAllNamed(landingpage);
                      }
                    },
                    buttonText: "SAVE"),
              ],
            )
          ],
        ),
      ),
    );
  }
}
