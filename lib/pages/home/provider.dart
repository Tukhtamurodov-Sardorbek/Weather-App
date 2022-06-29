import 'package:bottom_bar_with_sheet/bottom_bar_with_sheet.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

class HomeProvider extends ChangeNotifier {
  int _currentPage = 0;
  bool _isOpen = false;
  bool _isVisible = true;
  bool _firstTimeUse = true;
  PageController pageController = PageController();
  ScrollController scrollController = ScrollController();
  BottomBarWithSheetController bottomBarController = BottomBarWithSheetController(initialIndex: 0);

  int get currentPage => _currentPage;
  bool get isOpen => _isOpen;
  bool get isVisible => _isVisible;
  bool get firstTimeUse => _firstTimeUse;

  set currentPage(int index){
    if(_currentPage != index){
      _currentPage = index;
      notifyListeners();
    }
  }
  set isOpen(bool value){
    if(_isOpen != value){
      _isOpen = value;
      notifyListeners();
    }
  }
  set isVisible(bool value){
    if(_isVisible != value){
      _isVisible = value;
      notifyListeners();
    }
  }
  set firstTimeUse(bool value){
    if(_firstTimeUse != value){
      _firstTimeUse = value;
      notifyListeners();
    }
  }


  void onInit() {
    bottomBarController.stream.listen((opened) {
      isOpen = opened;
      debugPrint('Bottom bar ${opened ? 'opened' : 'closed'}');
    });

    scrollController.addListener(() {
      switch (scrollController.position.userScrollDirection) {
      // Scrolling up
        case ScrollDirection.forward:
          isVisible = true;
          break;
      // Scrolling down
        case ScrollDirection.reverse:
          isVisible = false;
          // firstTimeUse ? showCurrentHourData() : null;
          break;
      // Idle - keep FAB visibility unchanged
        case ScrollDirection.idle:
          break;
      }
    });
  }
}
