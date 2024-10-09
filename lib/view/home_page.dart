import 'dart:async';

import 'package:contact/provider/counter_provider.dart';
import 'package:contact/provider/theme_provider.dart';
import 'package:contact/util.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../main.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    print("_HomePageState build");
    return Scaffold(
      appBar: AppBar(
        title: Text("Title"),
        actions: [
          Consumer<ThemeProvider>(
            builder: (context, themeProvider, child) {
              return DropdownButton(
                items: [
                  DropdownMenuItem(
                    child: Text(
                      "System",
                      style: TextStyle(color: Colors.black),
                    ),
                    value: "System",
                  ),
                  DropdownMenuItem(
                    child: Text(
                      "Dark",
                      style: TextStyle(color: Colors.black),
                    ),
                    value: "Dark",
                  ),
                  DropdownMenuItem(
                    child: Text(
                      "Light",
                      style: TextStyle(color: Colors.black),
                    ),
                    value: "Light",
                  ),
                ],
                value: themeProvider.themeMode,
                onChanged: (value) {
                  themeProvider.changeTheme(value ?? "System");
                  print("object =>$value ");
                },
              );
            },
          ),
        ],
      ),
      body: Center(
          child: Column(
        children: [
          Text(
            "Title",
            style: Theme.of(context).textTheme.bodyLarge,
          ),
          Text(
            "demo 1",
            style: TextStyle(
                fontSize: 30,
                color: Colors.red,
                fontStyle: FontStyle.italic,
                fontWeight: FontWeight.bold),
          ),
          Text(
            "demo 2",
            style: TextStyle(
                fontSize: 20,
                color: Colors.red,
                fontStyle: FontStyle.italic,
                fontWeight: FontWeight.bold),
          ),
          Text("Hello"),
          Icon(
            (Theme.of(context).colorScheme.brightness == Brightness.light)
                ? Icons.light_mode
                : Icons.dark_mode,
            color: Theme.of(context).textTheme.bodyMedium?.color,
            size: 150,
          ),
          Row(
            // mainAxisAlignment: MainAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            children: [
              IconButton(
                  onPressed: () {
                    Provider.of<CounterProvider>(context, listen: false)
                        .change();
                  },
                  icon: Icon(Icons.remove)),
              Consumer<CounterProvider>(
                builder: (context, value, child) {
                  return Text("${value.count}");
                },
              ),
              IconButton(onPressed: () {}, icon: Icon(Icons.add)),
            ],
          ),
          ElevatedButton(
              onPressed: () {
                Navigator.pushNamed(context, PageName.contactPage);
              },
              child: Text("Contact Page"))
        ],
      )),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.of(context).pushNamed("detail_page");
        },
        child: Icon(Icons.add),
      ),
    );
  }
}
