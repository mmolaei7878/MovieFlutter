import 'package:rxdart/rxdart.dart';

enum NavyItem {
  DISCOVER,
  SEARCH,
  SAVED,
}

class BottomNavigationLogic {
  BehaviorSubject<NavyItem> _navBarController = BehaviorSubject<NavyItem>();

  BehaviorSubject<NavyItem> get navBarController => _navBarController.stream;
  close() {
    _navBarController.close();
  }

  NavyItem defaultNavy = NavyItem.DISCOVER;
  void changeBottomNavy(int index) {
    switch (index) {
      case 0:
        _navBarController.sink.add(NavyItem.DISCOVER);

        break;
      case 1:
        _navBarController.sink.add(NavyItem.SEARCH);
        break;
      case 2:
        _navBarController.sink.add(NavyItem.SAVED);
        break;
      default:
        _navBarController.sink.add(NavyItem.DISCOVER);
    }
  }
}

final bottomNavigationLogic = BottomNavigationLogic();
