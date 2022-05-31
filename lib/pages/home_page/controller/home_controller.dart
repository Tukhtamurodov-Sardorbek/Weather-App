import 'package:bottom_bar_with_sheet/bottom_bar_with_sheet.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:get/get.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';

class HomeController extends GetxController{
  int currentPage = 0;
  bool isOpen = false;
  bool isVisible = true;
  bool firstTimeUse = true;
  bool hasInternet = false;
  PageController pageController = PageController();
  ScrollController scrollController = ScrollController();
  BottomBarWithSheetController bottomBarController = BottomBarWithSheetController(initialIndex: 0);

  // #Update current page on moving to the next or previous page
  void onPageChange(int index){
    currentPage = index;
    update();
  }

  @override
  void onInit() {
    bottomBarController.stream.listen((opened) {
      isOpen = opened;
      update();
      debugPrint('Bottom bar ${opened ? 'opened' : 'closed'}');
    });

    scrollController.addListener(() {
      switch (scrollController.position.userScrollDirection) {
      // Scrolling up
        case ScrollDirection.forward:
          isVisible = true;
          update();
          break;
      // Scrolling down
        case ScrollDirection.reverse:
          isVisible = false;
          update();
          // firstTimeUse ? showCurrentHourData() : null;
          break;
      // Idle - keep FAB visibility unchanged
        case ScrollDirection.idle:
          break;
      }
    });

    InternetConnectionChecker().onStatusChange.listen((event) {
      hasInternet = event == InternetConnectionStatus.connected;
      update();
    });

    super.onInit();
  }
}
