import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../controllers/auth/user_controller.dart';
import '../../core/app_route.dart';
import '../../utils/app_color.dart';
import '../widgets/custom_circle_avatar.dart';
import '../widgets/profile_details_view_widget.dart';

class ProfileInfo extends StatefulWidget {
  const ProfileInfo({super.key});

  @override
  State<ProfileInfo> createState() => _ProfileInfoState();
}

class _ProfileInfoState extends State<ProfileInfo> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.white,
      appBar: AppBar(
        title: const Text('Profile Info'),
        actions: [
          IconButton(
            onPressed: () {
              Navigator.pushNamed(context, AppRoute.updateProfileScreen);
            },
            icon: const Padding(
              padding: EdgeInsets.only(
                right: 15,
              ),
              child: Icon(Icons.edit),
            ),
          ),
        ],
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 25),
          physics: const BouncingScrollPhysics(),
          child: GetBuilder<UserController>(
            builder: (userController) {
              final user = userController.user.value;
              return Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  CustomCircleAvatar(
                    imageString: user.photo ?? '',
                    imageWidth: 100,
                    imageHeight: 100,
                    imageRadius: 50,
                    borderColor: AppColor.textColorPrimary,
                  ),
                  const SizedBox(height: 10),
                  Text(
                    user.fullName,
                    style: Theme.of(context).textTheme.titleLarge,
                  ),
                  Container(
                    margin: const EdgeInsets.symmetric(vertical: 20),
                    width: double.maxFinite,
                    height: 1,
                    decoration: BoxDecoration(
                      color: AppColor.grey.withOpacity(0.7),
                    ),
                  ),
                  ProfileDetailsViewWidget(
                    header: 'Email:',
                    info: user.email ?? '',
                  ),
                  const SizedBox(height: 7),
                  ProfileDetailsViewWidget(
                    header: 'Number:',
                    info: user.mobile ?? '',
                  ),
                  const SizedBox(height: 7),
                  const ProfileDetailsViewWidget(
                    header: 'Password:',
                    info: '**********',
                  ),
                ],
              );
            },
          ),
        ),
      ),
    );
  }
}
