import 'package:flutter/material.dart';
import 'package:worldclock/pages/home.dart';
import 'package:worldclock/pages/Loading.dart';
import 'package:worldclock/pages/Location_Selection.dart';

void main() => runApp(MaterialApp(
      initialRoute: '/',
      routes: {
        '/': (context) => LoadingScreen(),
        '/home': (context) => Home(),
        '/location': (context) => LocationScreen()
      },
    ));
