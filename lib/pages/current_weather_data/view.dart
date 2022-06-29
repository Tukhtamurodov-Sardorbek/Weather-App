import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'provider.dart';

class CurrentWeatherPage extends StatelessWidget {
  const CurrentWeatherPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (BuildContext context) => CurrentWeatherProvider(),
      builder: (context, child) => _buildPage(context),
    );
  }

  Widget _buildPage(BuildContext context) {
    final provider = context.read<CurrentWeatherProvider>();

    return Container();
  }
}

