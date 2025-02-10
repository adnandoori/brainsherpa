import 'package:brainsherpa/controllers/splash_controller.dart';
import 'package:brainsherpa/utils/app_colors.dart';
import 'package:brainsherpa/utils/common_widgets.dart';
import 'package:brainsherpa/utils/image_paths.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    printf('--height-->${Get.height}');
    return Scaffold(
      body: GetBuilder<SplashController>(
        init: SplashController(context),
        builder: (controller) {
          return Container(
            height: Get.height,
            width: Get.width,
            color: AppColors.purplecolor,
            child: Center(
              child: Image.asset(
                ImagePath.icAppIcon,
                height: 120,
                width: 120,
              ),
            ),
          );
        },
      ),
    );
  }
}
