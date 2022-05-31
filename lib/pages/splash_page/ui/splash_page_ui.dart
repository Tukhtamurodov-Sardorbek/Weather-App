import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';
import 'package:weather/pages/splash_page/controller/splash_page_controller.dart';
import 'package:weather/services/color_service.dart';
import 'package:weather/utils/fetch_data.dart';
import 'package:weather/utils/onWillPop.dart';

class SplashPage extends StatelessWidget {
  const SplashPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<SplashController>(
      init: SplashController(),
      builder: (_controller) {
        return Scaffold(
          backgroundColor: ColorService.darkBlue,
          body: WillPopScope(
            onWillPop: () => onWillPopFunction(),
            child: _controller.showMessage ? Center(
              child: Card(
                elevation: 30.0,
                color: Colors.white,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Text('Message', textAlign: TextAlign.center),
                    Divider(),
                    Text('You have permanently denied the permission!', textAlign: TextAlign.center),
                  ],
                ),
              ),
            ) : Column(
              mainAxisAlignment: MainAxisAlignment.end,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Expanded(child: Center(
                  child: Lottie.asset('assets/lottie/server.json'),
                )),
                Lottie.asset('assets/lottie/circle-loader.json', height: 100),
                const SizedBox(height: 10.0),
              ],
            ),
          ),
        );
      },
    );
  }
}
