import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';
import 'package:weather/pages/current_weather_page/controller/current_weather_page_controller.dart';
import 'package:weather/pages/home_page/controller/home_controller.dart';
import 'package:weather/pages/splash_page/controller/splash_page_controller.dart';
import 'package:weather/services/color_service.dart';


class ForecastPage extends StatelessWidget {
  const ForecastPage({Key? key}) : super(key: key);


  @override
  Widget build(BuildContext context) {
    return GetBuilder<CurrentController>(
      init: CurrentController(),
      builder: (_controller) {
        return Scaffold(
          backgroundColor: ColorService.darkBlue,
          body: _controller.noData ? Container(color: Colors.greenAccent) : Center(child: Lottie.asset('assets/lottie/no_internet_connection.json', height: 300),),
        );
      },
    );
  }
}
