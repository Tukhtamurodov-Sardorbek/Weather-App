import 'package:bottom_bar_with_sheet/bottom_bar_with_sheet.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:weather/pages/current_weather_page/ui/current_weather_page_ui.dart';
import 'package:weather/pages/forecast_weather_page/ui/forecast_page_ui.dart';
import 'package:weather/pages/home_page/controller/home_controller.dart';
import 'package:weather/services/color_service.dart';
import 'package:weather/utils/onWillPop.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<HomeController>(
      init: HomeController(),
      builder: (_controller) {
        return Scaffold(
          backgroundColor: ColorService.darkBlue,
          body: WillPopScope(
            onWillPop: () => onWillPopFunction(),
            child: PageView(
              controller: _controller.pageController,
              physics: const NeverScrollableScrollPhysics(),
              children: [
                CurrentPage(),
                ForecastPage(),
              ],
              onPageChanged: (int index) {
                _controller.onPageChange(index);
              },
            ),
          ),
          bottomNavigationBar: AnimatedContainer(
            height: _controller.isVisible && _controller.isOpen
                ? MediaQuery.of(context).size.height - 30
                : _controller.isVisible
                    ? 55
                    : 0,
            duration: const Duration(milliseconds: 300),
            child: SingleChildScrollView(
              child: BottomBarWithSheet(
                controller: _controller.bottomBarController,
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
                onSelectItem: (index) =>
                    _controller.pageController.animateToPage(
                  index,
                  duration: const Duration(milliseconds: 500),
                  curve: Curves.easeIn,
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
