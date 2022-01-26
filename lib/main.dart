import 'package:flutter/material.dart';
import 'package:reports/pages/home_page.dart';
import 'package:reports/pages/read_data.dart';
import 'package:reports/pages/tab_screens.dart';
import 'package:reports/routes/app_routes.dart';

main() => runApp(const Home());

class Home extends StatelessWidget {
  const Home({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      routes: {
        AppRoutes.appHomeMenuScreens: (ctx) => const TabScreens(),
        AppRoutes.appHomePage: (ctx) => const HomePage(),
        AppRoutes.appResults: (ctx) => const ReadDataPage(),
      },
    );
  }
}
