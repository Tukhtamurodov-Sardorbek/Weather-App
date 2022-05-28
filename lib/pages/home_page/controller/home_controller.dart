import 'package:bottom_bar_with_sheet/bottom_bar_with_sheet.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:get/get.dart';

class HomeController extends GetxController{
  int currentPage = 0;
  bool isOpen = false;
  bool isVisible = true;
  bool firstTimeUse = true;
  DateTime? lastPressed;
  PageController pageController = PageController();
  ScrollController scrollController = ScrollController();
  BottomBarWithSheetController bottomBarController = BottomBarWithSheetController(initialIndex: 0);


  // #Double tap to exit
  Future<bool> onWillPop() async{
    final now = DateTime.now();
    const maxDuration = Duration(seconds: 2);
    final isWarning = lastPressed == null || now.difference(lastPressed!) > maxDuration;

    if(isWarning){
      lastPressed = DateTime.now();
      // doubleTap(context);
      return false;
    }
    return true;
  }

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
    super.onInit();
  }
}
