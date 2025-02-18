import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:brainsherpa/controllers/dashboard/reaction_time_list_controller.dart';
import 'package:brainsherpa/routes/app_pages.dart';
import 'package:brainsherpa/utils/app_colors.dart';
import 'package:brainsherpa/utils/app_string.dart';
import 'package:brainsherpa/utils/common_widgets.dart';

class CognitiveSpeedScreen extends StatelessWidget {
  const CognitiveSpeedScreen({super.key});
  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
            backgroundColor: AppColors.bgColor,
            body: GetBuilder<ReactionTimeListController>(
                init: ReactionTimeListController(context),
                id: ReactionTimeListController.stateId,
                builder: (controller) {
                  return SizedBox(
                    height: Get.height,
                    width: Get.width,
                    child: Column(
                      children: [
                        widgetAppBar(title: 'Cognitive Speed'),
                        Text('Cognitive Speed Screen'),
                      ],
                    ),
                  );
                })));
  }
}
