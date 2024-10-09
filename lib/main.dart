import 'package:contact/provider/contact_provider.dart';
import 'package:contact/provider/counter_provider.dart';
import 'package:contact/provider/theme_provider.dart';
import 'package:contact/util.dart';
import 'package:contact/view/add_contact.dart';
import 'package:contact/view/contact_page.dart';
import 'package:contact/view/detail_page.dart';
import 'package:contact/view/home_page.dart';
import 'package:contact/theme.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'view/welcome_page.dart';

late SharedPreferences preferences;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  preferences = await SharedPreferences.getInstance();
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

bool isDark = false;

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => CounterProvider()),
        ChangeNotifierProvider(create: (context) => ThemeProvider()),
        ChangeNotifierProvider(create: (context) => ContactProvider()),
      ],
      builder: (context, child) {
        return MaterialApp(
          initialRoute: (preferences.getBool("continue") ?? false)
              ? PageName.homePage
              : PageName.welcomePage,
          theme: light,
          darkTheme: dark,
          themeMode: Provider.of<ThemeProvider>(context).getThemeMode(),
          routes: {
            PageName.homePage: (context) => HomePage(),
            "detail_page": (context) => DetailPage(),
            PageName.welcomePage: (context) => WelcomePage(),
            PageName.contactPage: (context) => ContactPage(),
            PageName.addContact: (context) => AddContact(),
          },
        );
      },
    );
  }
}
