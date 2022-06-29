import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:weather/pages/current_weather_data/provider.dart';
import 'package:weather/pages/home/provider.dart';
import 'package:weather/pages/splash/provider.dart';
import 'package:weather/pages/splash/view.dart';
import 'package:weather/services/hive_service.dart';
import 'package:weather/services/color_service.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // * StatusBar & NavigationBar Color
  SystemChrome.setSystemUIOverlayStyle(
    const SystemUiOverlayStyle(
      statusBarColor: ColorService.darkBlue,
      systemNavigationBarColor: ColorService.darkBlue,
    ),
  );

  // * Orientations
  SystemChrome.setPreferredOrientations(
    [
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ],
  );

  // * Local Database
  await Hive.initFlutter();
  await Hive.openBox(HiveService.DB_NAME);

  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (BuildContext context) => SplashProvider(),
        ),
        ChangeNotifierProvider(
            create: (BuildContext context) => HomeProvider()),
        ChangeNotifierProvider(
            create: (BuildContext context) => CurrentWeatherProvider()),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Weather',
        themeMode: ThemeMode.dark,
        theme: ThemeData(
          primaryColor: Colors.black,
          scaffoldBackgroundColor: ColorService.darkBlue,
          appBarTheme: const AppBarTheme(
            backgroundColor: ColorService.darkBlue,
            elevation: 0,
          ),
        ),
        home: SplashPage(),
      ),
    ),
  );
}
