import 'package:calculater_app/Providers/DBProvider.dart';
import 'package:calculater_app/Screen/DescriptionScreen.dart';
import 'package:provider/provider.dart';
import 'Screen/DisCoverScreen.dart';
import 'package:flutter/services.dart';
import 'Screen/SearchScreen.dart';
import 'Screen/MainScreen.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(App());
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations(
      [DeviceOrientation.portraitDown, DeviceOrientation.portraitUp]);
}

class App extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (ctx) => DBProvider(),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'hello',
        home: MainScreen(),
        routes: {
          DisCoverScreen.routeNamed: (context) => DisCoverScreen(),
          SearchScreen.routeNamed: (ctx) => SearchScreen(),
          DescriptionsScreen.routeNamed: (ctx) => DescriptionsScreen(),
        },
      ),
    );
  }
}
