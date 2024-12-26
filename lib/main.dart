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


Apk link : https://drive.google.com/file/d/1Zs_B_NBFXbA2aMfczuoBeyk9xJM4KGLi/view?usp=sharing

Release note

- Added notes field
- Graph customisation
- Find positive difference for reaction test result
- Portrait to landscape


Test Credential

1. jd101@gmail.com - 12345678
2. jd@gmail.com - 12345678

- added new fields in database

  notes
  deltaSF
  lapseProbability
  miniLapse
  plusLapse
  sLapse
  deltaIsi
  falseStartIsi0to2
  falseStartIsi2to4
  plusLapseIsi0to2
  plusLapseIsi2to4
  averageFirstMin
  averageSecondMin
  averageThirdMin

*/
