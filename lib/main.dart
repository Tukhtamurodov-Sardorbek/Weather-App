import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:weather/pages/splash_page/ui/splash_page_ui.dart';
import 'package:flutter/services.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:weather/services/di_service.dart';
import 'package:weather/services/hive_service.dart';
import 'package:weather/services/color_service.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  // #StatusBar & NavigationBar Color
  SystemChrome.setSystemUIOverlayStyle(
    const SystemUiOverlayStyle(
      statusBarColor: ColorService.darkBlue,
      systemNavigationBarColor: ColorService.darkBlue,
    ),
  );
  // #Orientations
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]);

  await DependencyInjectionService.init();
  await Hive.initFlutter();
  await Hive.openBox(HiveService.DB_NAME);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Weather',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const SplashPage(),
    );
  }
}
