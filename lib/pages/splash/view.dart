import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';
import 'package:weather/utils/onWillPop.dart';

import 'provider.dart';

class SplashPage extends StatefulWidget {
  const SplashPage({Key? key}) : super(key: key);

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {

  @override
  void initState() {
    Provider.of<SplashProvider>(context, listen: false).onInit(context);
    super.initState();
  }

  @override
  Widget build(BuildContext context) => _buildPage(context);

  Widget _buildPage(BuildContext context) {
    return Scaffold(
      body: WillPopScope(
        onWillPop: () => onWillPopFunction(),
        child: FutureBuilder(
          future: Future.delayed(
            const Duration(seconds: 5),
          ),
          builder: (context, snapshot) {
            return Column(
              mainAxisAlignment: MainAxisAlignment.end,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Expanded(
                  child: Center(
                    child: Lottie.asset('assets/lottie/server.json'),
                  ),
                ),
                Lottie.asset('assets/lottie/circle-loader.json', height: 100),
                const SizedBox(height: 10.0),
              ],
            );
          },
        ),
      ),
    );
  }
}