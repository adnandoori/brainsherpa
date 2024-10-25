import 'package:brainsherpa/controllers/splash_controller.dart';
import 'package:brainsherpa/utils/common_widgets.dart';
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
            color: Colors.black,
            child: const Center(),
          );
        },
      ),
    );
  }
}
