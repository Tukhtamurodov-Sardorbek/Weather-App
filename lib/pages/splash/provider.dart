import 'package:flutter/material.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:weather/pages/home/view.dart';
import 'package:weather/services/hive_service.dart';
import 'package:weather/utils/fetch_data.dart';

class SplashProvider extends ChangeNotifier {
  bool _hasInternet = false;
  bool get hasInternet => _hasInternet;

  Future<void> _checkConnection() async{
    await InternetConnectionChecker().hasConnection.then((bool isConnected) {
      _hasInternet = isConnected;
      notifyListeners();
    });
    debugPrint('~~~~~~~~~~ Internet:  $_hasInternet ~~~~~~~~~~');
  }


  void _nextPage(BuildContext context){
    Future.delayed(const Duration(seconds: 5), () {
      Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => const HomePage()));
    });
  }

  onInit(BuildContext context) async{
    debugPrint('~~~~~~~~~~ Check Network ~~~~~~~~~~');
    await _checkConnection();
    if(_hasInternet){
      await FetchData().fetchData().then((_){
        FetchData().checkDatabase();
        print('* Is DB empty: ${HiveService.loadString(HiveService.key(StorageKeys.IS_EMPTY))}');
        print('* Result in DB: ${HiveService.loadString(HiveService.key(StorageKeys.ALL_DATA_ARE_STORED))}');
        bool allAreStored = HiveService.loadString(HiveService.key(StorageKeys.ALL_DATA_ARE_STORED)) == 'true';
        if(allAreStored){
          debugPrint('~~~~~~~~~~ All Are Stored ~~~~~~~~~~');
          Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => const HomePage()));
        }else{
          debugPrint('~~~~~~~~~~ All Are NOT Stored 1 ~~~~~~~~~~');
          _nextPage(context);
        }
      });
    }
    else{
      debugPrint('~~~~~~~~~~ All Are NOT Stored 2 ~~~~~~~~~~');
      FetchData().checkDatabase();
      print('* Is DB empty: ${HiveService.loadString(HiveService.key(StorageKeys.IS_EMPTY))}');
      print('* Result in DB: ${HiveService.loadString(HiveService.key(StorageKeys.ALL_DATA_ARE_STORED))}');
      _nextPage(context);
    }
  }
}
