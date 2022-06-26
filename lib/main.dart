import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:my_perpus/helper/color_palette.dart';
import 'package:my_perpus/injection.dart';
import 'package:my_perpus/provider/auth.dart';
import 'package:my_perpus/routes.dart';
import 'package:my_perpus/setup_locator.dart';
import 'package:provider/provider.dart';


void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  configureInjection();
  await Firebase.initializeApp();
  await SystemChrome.setPreferredOrientations(
    [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown],
  );

  setupLocator().then((value) {
    runApp(const MyApp());
  });
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        Provider(create: (context) => AuthProvider()),
      ],
      child: GetMaterialApp(
        navigatorKey: Get.key,
        debugShowCheckedModeBanner: false,
        color: ColorPalette.generalBackgroundColor,
        title: 'Herpes',
        initialRoute: Routes.navigator,
        getPages: Routes.newRoutes,
        theme: ThemeData(
          primaryColor: ColorPalette.generalPrimaryColor,
          backgroundColor: ColorPalette.generalBackgroundColor,
          fontFamily: 'ubuntu',
        ),
      ),
    );
  }
}
