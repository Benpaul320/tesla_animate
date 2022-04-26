import 'package:flutter/widgets.dart';

class HomeController extends ChangeNotifier {
  //we use HomeController for logical part
  int selectedBottomTab = 0;
  void onBottomNavigationTabChange(index) {
    selectedBottomTab = index;
    notifyListeners();
  }

  bool isRightDoorLock = true;
  bool isLeftDoorLock = true;
  bool isBonnetLock = true;
  bool isTruckLock = true;

  void updateRightDoorLock() {
    isRightDoorLock = !isRightDoorLock;
    notifyListeners();
  }

  void updateLeftDoorLock() {
    isLeftDoorLock = !isLeftDoorLock;
    notifyListeners();
  }

  void updateBonnetDoorLock() {
    isBonnetLock = !isBonnetLock;
    notifyListeners();
  }

  void updateTruckDoorLock() {
    isTruckLock = !isTruckLock;
    notifyListeners();
  }

  bool isCoolSelected = true;

  void updateCoolSelectTab() {
    isCoolSelected = !isCoolSelected;
    notifyListeners();
  }
}
