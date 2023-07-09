import 'package:flutter/material.dart';
import 'package:share_near/src/utils/constants.dart';
import 'package:share_near/src/utils/size_config.dart';
import 'package:share_near/src/views/global-components/default_button.dart';
import 'package:share_near/src/views/user-profile/components/profile_picture.dart';
import 'package:share_near/src/views/user-profile/components/user_profile_menu.dart';

class UserProfileView extends StatefulWidget {
  const UserProfileView({super.key});

  @override
  State<UserProfileView> createState() => _UserProfileViewState();
}

class _UserProfileViewState extends State<UserProfileView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text(
          'Profile',
          style: TextStyle(color: Colors.black),
          textAlign: TextAlign.center,
        ),
      ),
      body: SafeArea(
        child: SizedBox(
          width: double.infinity,
          child: SingleChildScrollView(
            child: Padding(
              padding: EdgeInsets.symmetric(
                horizontal: getScreenWidth(20),
              ),
              child: Column(
                children: <Widget>[
                  smallerGap,
                  const ProfilePicture(),
                  biggerGap,
                  const UserProfileMenu(
                    leadingIcon: 'assets/icons/User Icon.svg',
                    text: 'My Account',
                  ),
                  smallerGap,
                  const UserProfileMenu(
                    leadingIcon: 'assets/icons/product.svg',
                    text: 'Rented Products',
                  ),
                  smallerGap,
                  const UserProfileMenu(
                    leadingIcon: 'assets/icons/product.svg',
                    text: 'Borrowed Products',
                  ),
                  biggerGap,
                  DefaultButton(
                    press: () {},
                    widget: const Text('Log out'),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
