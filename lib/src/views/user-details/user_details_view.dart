import 'dart:io';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:share_near/src/models/user_model.dart';
import 'package:share_near/src/services/data.dart';
import 'package:share_near/src/utils/constants.dart';
import 'package:share_near/src/utils/size_config.dart';
import 'package:share_near/src/views/global-components/app_text_form_field.dart';
import 'package:share_near/src/views/global-components/default_button.dart';
import 'package:share_near/src/views/home-view/home_view.dart';

class UserDetailsView extends StatefulWidget {
  const UserDetailsView({super.key});

  @override
  State<UserDetailsView> createState() => _UserDetailsViewState();
}

class _UserDetailsViewState extends State<UserDetailsView> {
  late final TextEditingController _fullNameController;
  late final TextEditingController _phoneNumberController;
  late final TextEditingController _nidNumberController;
  late final TextEditingController _districtNameController;
  late final GlobalKey<FormState> _formKey;

  @override
  void initState() {
    _fullNameController = TextEditingController();
    _phoneNumberController = TextEditingController();
    _nidNumberController = TextEditingController();
    _districtNameController = TextEditingController();
    _formKey = GlobalKey();
    super.initState();
  }

  @override
  void dispose() {
    _fullNameController.dispose();
    _phoneNumberController.dispose();
    _nidNumberController.dispose();
    _districtNameController.dispose();
    super.dispose();
  }

  // String? _errorMessage;
  bool _isProcessing = false;
  String? _errorMessage;
  String imageURL = '';
  XFile? file;

  Future<void> userInfoUpload() async {
    Reference referenceRoot = FirebaseStorage.instance.ref();
    Reference referenceDirImages = referenceRoot.child('profileImage');
    List<String> parts = appUserEmail!.split('@');
    String imageName = parts[0];
    Reference referenceImageToUpload = referenceDirImages.child(imageName);
    try {
      //Store the file
      final task = await referenceImageToUpload
          .putFile(File(file!.path))
          .whenComplete(() => {});
      imageURL = await task.ref.getDownloadURL();
    } catch (error) {
      // print('error');
      // ignore: use_build_context_synchronously
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: Text(error.toString()),
        ),
      );
    }
    UserModel user = UserModel(
      email: appUserEmail!.trim(),
      fullName: _fullNameController.text.trim(),
      phoneNumber: _phoneNumberController.text.trim(),
      nidNumber: _nidNumberController.text.trim(),
      districtName: _districtNameController.text.trim(),
      profileImage: imageURL,
    );
    await Data().createUserProfile(user).whenComplete(() {
      // print('done');
    }).catchError((error, stackTrace) {
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: Text(error.toString()),
        ),
      );
    });
  }

  setImage() async {
    ImagePicker imagePicker = ImagePicker();
    XFile? image = await imagePicker.pickImage(
        source: ImageSource.gallery, imageQuality: 50);
    if (image == null) return;
    file = image;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Sign up',
          style: TextStyle(color: Colors.black),
        ),
      ),
      body: SizedBox(
        width: double.infinity,
        child: Padding(
          padding: EdgeInsets.symmetric(
            horizontal: getScreenWidth(20),
          ),
          child: SingleChildScrollView(
            child: Column(
              children: <Widget>[
                smallerGap,
                Text(
                  'Complete Profile',
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: getScreenWidth(28),
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const Text(
                  'Complete your profile\'s details',
                  textAlign: TextAlign.center,
                ),
                smallerGap,
                Form(
                  key: _formKey,
                  child: Column(
                    children: <Widget>[
                      AppTextFormField(
                        label: 'Full name',
                        hintText: 'Enter your full name',
                        svgIcon: 'assets/icons/User.svg',
                        controller: _fullNameController,
                        validator: (value) {
                          final bool fullNameValid =
                              RegExp('[a-zA-Z]').hasMatch(value ?? '');
                          if (fullNameValid) {
                            return null;
                          }
                          return 'Enter valid full name';
                        },
                      ),
                      smallerGap,
                      AppTextFormField(
                        label: 'Phone number',
                        hintText: 'Enter your phone number',
                        svgIcon: 'assets/icons/Phone.svg',
                        controller: _phoneNumberController,
                        textInputType: TextInputType.number,
                        validator: (value) {
                          final bool firstNameValid =
                              RegExp(r"^\d{11}$").hasMatch(value ?? '');
                          if (firstNameValid) {
                            return null;
                          }
                          return 'Enter valid phone number';
                        },
                      ),
                      smallerGap,
                      AppTextFormField(
                        label: 'NID number',
                        hintText: 'Enter your NID number',
                        svgIcon: 'assets/icons/nid.svg',
                        controller: _nidNumberController,
                        textInputType: TextInputType.number,
                        validator: (value) {
                          final bool firstNameValid =
                              RegExp(r"^\d{10}$").hasMatch(value ?? '');
                          if (firstNameValid) {
                            return null;
                          }
                          return 'Enter valid NID number';
                        },
                      ),
                      smallerGap,
                      AppTextFormField(
                        label: 'District name',
                        hintText: 'Enter your district name',
                        svgIcon: 'assets/icons/location.svg',
                        controller: _districtNameController,
                        validator: (value) {
                          final bool districtNameValid = bangladeshDistricts
                              .contains(_districtNameController.text.trim());
                          if (districtNameValid) {
                            return null;
                          }
                          return 'Enter valid district name';
                        },
                      ),
                      smallerGap,
                      ElevatedButton(
                        style: ButtonStyle(
                          padding: MaterialStateProperty.all<EdgeInsets>(
                              const EdgeInsets.all(15)),
                          foregroundColor:
                              MaterialStateProperty.all<Color>(Colors.red),
                          backgroundColor:
                              MaterialStateProperty.all<Color>(primaryColor),
                          shape:
                              MaterialStateProperty.all<RoundedRectangleBorder>(
                            RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20),
                            ),
                          ),
                        ),
                        onPressed: () async {
                          await setImage();
                        },
                        child: const Text('Pick profile picture'),
                      ),
                      smallerGap,
                      DefaultButton(
                        widget: _isProcessing
                            ? CircularProgressIndicator(
                                color: Colors.white,
                                strokeWidth: getScreenWidth(3),
                              )
                            : Text(
                                'Submit',
                                style: TextStyle(
                                  fontSize: getScreenWidth(18),
                                  color: Colors.white,
                                ),
                              ),
                        press: () async {
                          if ((_formKey.currentState!.validate())) {
                            setState(() {
                              _isProcessing = true;
                            });
                            await userInfoUpload();
                            // print(_errorMessage);
                            setState(() {
                              _isProcessing = false;
                            });
                            _errorMessage == null
                                ? Get.off(
                                    () => const HomeView(),
                                    transition: Transition.zoom,
                                  )
                                // ignore: use_build_context_synchronously
                                : showDialog(
                                    context: context,
                                    builder: (context) => const AlertDialog(
                                      title: Text("Failed"),
                                    ),
                                  );
                            _errorMessage = null;
                          }
                        },
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
