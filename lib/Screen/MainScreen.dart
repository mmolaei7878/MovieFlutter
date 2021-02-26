import 'package:flutter/material.dart';
import 'package:bottom_navy_bar/bottom_navy_bar.dart';
import 'ManageScreen.dart';
import 'SavedScreen.dart';
import 'SearchScreen.dart';
import '../Bloc/BottomNavBloc.dart';

class MainScreen extends StatelessWidget {
  final BottomNavigationLogic bottomNavigationLogic = BottomNavigationLogic();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: StreamBuilder(
        stream: bottomNavigationLogic.navBarController.stream,
        initialData: bottomNavigationLogic.defaultNavy,
        builder: (ctx, AsyncSnapshot<NavyItem> snapShot) => BottomNavyBar(
          curve: Curves.decelerate,
          backgroundColor: Color(0xFF010101),
          onItemSelected: bottomNavigationLogic.changeBottomNavy,
          selectedIndex: snapShot.data.index,
          items: [
            BottomNavyBarItem(
              title: Text(
                ' Discover',
                style: TextStyle(color: Colors.white, fontSize: 13.0),
              ),
              icon: Padding(
                padding: const EdgeInsets.only(left: 5.0),
                child: Icon(
                  Icons.layers,
                  size: 18.0,
                  color: snapShot.data.index == 0 ? Colors.white : Colors.white,
                ),
              ),
            ),
            BottomNavyBarItem(
              title: Text(
                ' Search',
                style: TextStyle(color: Colors.white, fontSize: 13.0),
              ),
              icon: Padding(
                padding: const EdgeInsets.only(left: 5.0),
                child: Icon(
                  Icons.search,
                  size: 18.0,
                  color: snapShot.data.index == 1 ? Colors.white : Colors.white,
                ),
              ),
            ),
            BottomNavyBarItem(
              title: Text(
                ' Saved',
                style: TextStyle(color: Colors.white, fontSize: 13.0),
              ),
              icon: Padding(
                padding: const EdgeInsets.only(left: 5.0),
                child: Icon(
                  Icons.save,
                  size: 18.0,
                  color: snapShot.data.index == 2 ? Colors.white : Colors.white,
                ),
              ),
            ),
          ],
        ),
      ),
      body: StreamBuilder(
        stream: bottomNavigationLogic.navBarController.stream,
        initialData: bottomNavigationLogic.defaultNavy,
        builder: (ctx, AsyncSnapshot<NavyItem> snapshot) {
          switch (snapshot.data.index) {
            case 0:
              return ManageScreen();
              break;
            case 1:
              return SearchScreen();
              break;
            case 2:
              return SavedScreen();
              break;
            default:
              return ManageScreen();
          }
        },
      ),
    );
  }
}
