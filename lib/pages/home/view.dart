import 'package:bottom_bar_with_sheet/bottom_bar_with_sheet.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:weather/pages/current_weather_data/view.dart';
import 'package:weather/services/color_service.dart';
import 'package:weather/utils/onWillPop.dart';

import 'provider.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  void initState(){
    Provider.of<HomeProvider>(context, listen: false).onInit();
    super.initState();
  }

  @override
  Widget build(BuildContext context) => _buildPage(context);

  Widget _buildPage(BuildContext context) {
    final provider = context.watch<HomeProvider>();

    return Scaffold(
      backgroundColor: ColorService.darkBlue,
      body: WillPopScope(
        onWillPop: () => onWillPopFunction(),
        child: PageView(
          controller: provider.pageController,
          physics: const NeverScrollableScrollPhysics(),
          children: [
            const CurrentWeatherPage(),
            Container(color: Colors.deepPurple),
            // Container(color: Colors.limeAccent),
          ],
          onPageChanged: (int index) {
            provider.currentPage = index;
          },
        ),
      ),
      bottomNavigationBar: AnimatedContainer(
        height: provider.isVisible && provider.isOpen
            ? MediaQuery.of(context).size.height - 30
            : provider.isVisible
                ? 55
                : 0,
        duration: const Duration(milliseconds: 300),
        child: SingleChildScrollView(
          child: BottomBarWithSheet(
            controller: provider.bottomBarController,
            mainActionButtonTheme: const MainActionButtonTheme(
              color: ColorService.lightBlue2,
              size: 40,
              icon: Icon(Icons.search, size: 30, color: Colors.white),
            ),
            bottomBarTheme: BottomBarTheme(
              heightOpened: MediaQuery.of(context).size.height - 30,
              mainButtonPosition: MainButtonPosition.right,
              height: 55,
              heightClosed: 55,
              decoration: BoxDecoration(
                color: ColorService.darkBlue,
                borderRadius: const BorderRadius.vertical(
                  top: Radius.circular(25),
                ),
                border: Border.all(color: ColorService.lightBlue1),
              ),
              itemIconColor: ColorService.lightBlue2,
              selectedItemIconColor: Colors.white,
              selectedItemIconSize: 30,
              itemIconSize: 28,
            ),
            sheetChild: SizedBox(
              height: MediaQuery.of(context).size.height - 30,
              width: MediaQuery.of(context).size.width,
              child: Container(
                color: ColorService.lightBlue2,
              ),
            ),
            items: const [
              BottomBarWithSheetItem(icon: Icons.home),
              BottomBarWithSheetItem(icon: Icons.calendar_today)
            ],
            // onSelectItem: (index) => _controller.pageController.jumpToPage(index),
            onSelectItem: (index) => provider.pageController.animateToPage(
              index,
              duration: const Duration(milliseconds: 500),
              curve: Curves.easeIn,
            ),
          ),
        ),
      ),
    );
  }
}
