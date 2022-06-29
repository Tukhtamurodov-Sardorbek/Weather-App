// #Double tap to exit
Future<bool> onWillPopFunction() async{
  DateTime? lastPressed;
  final now = DateTime.now();
  const maxDuration = Duration(seconds: 2);
  final isWarning =  lastPressed == null || now.difference(lastPressed) > maxDuration;

  if(isWarning){
    lastPressed = DateTime.now();
    // doubleTap(context);
    return false;
  }
  return true;
}