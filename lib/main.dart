import 'dart:io';

import 'package:brainsherpa/routes/app_pages.dart';
import 'package:brainsherpa/utils/app_constants.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:loader_overlay/loader_overlay.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  if (Platform.isAndroid) {
    await Firebase.initializeApp(
        options: const FirebaseOptions(
      apiKey: "AIzaSyBcGkpmyetdJIimIkw2mulWoon4ZGB77UM",
      appId: "1:529222992857:android:d08d82db40087617244fc8",
      messagingSenderId: "529222992857",
      projectId: "brainsherpa-backend",
      storageBucket: "",
    ));
  } else {
    await Firebase.initializeApp();
  }

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

/*

- User Authentication
- Signup screen ui design and validation
- Login screen ui design and validation
- Dashboard screen
- Logout api integration


Apk link : https://drive.google.com/file/d/1vHtt0jX3jjR52Ju7QH1ucsMR1FXyT2uh/view?usp=drive_link

Release note
- Fixed minor issues


*/
