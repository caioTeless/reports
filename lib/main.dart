import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:path/path.dart';
import 'package:reports/pages/home_page.dart';
import 'package:reports/pages/read_data.dart';
import 'package:reports/pages/tab_screens.dart';
import 'package:reports/routes/app_routes.dart';

main() => runApp(const Home());

class Home extends StatelessWidget {
  const Home({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusManager.instance.primaryFocus?.unfocus();
      },
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        localizationsDelegates: const [
          GlobalMaterialLocalizations.delegate,
          GlobalWidgetsLocalizations.delegate
        ],
        supportedLocales: const [Locale('pt', 'BR')],
        routes: {
          AppRoutes.appHomeMenuScreens: (ctx) => const TabScreens(),
          AppRoutes.appHomePage: (ctx) => const HomePage(),
          AppRoutes.appResults: (ctx) => const ReadDataPage(),
        },
      ),
    );
  }
}
