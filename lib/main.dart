import 'package:brainsherpa/routes/app_pages.dart';
import 'package:brainsherpa/utils/app_constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:loader_overlay/loader_overlay.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();

  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp])
      .then((_) {
    runApp(const MyApp());
  });
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      builder: (BuildContext context, Widget? child) {
        return GlobalLoaderOverlay(
          overlayWidgetBuilder: (_) {
            return Center(
              child: LoadingAnimationWidget.hexagonDots(
                color: Colors.white,
                size: 25,
              ),
            );
          },
          overlayColor: Colors.black.withOpacity(0.5),
          child: GetMaterialApp(
            debugShowCheckedModeBanner: false,
            theme: ThemeData(
              fontFamily: 'Poppins',
              primaryColorDark: Colors.black,
              appBarTheme:
                  const AppBarTheme(systemOverlayStyle: SystemUiOverlayStyle()),
            ),
            initialRoute: Routes.splash,
            getPages: AppPages.routes,
            title: AppConstants.appName,
          ),
        );
      },
    );
  }
}
