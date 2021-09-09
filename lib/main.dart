import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:my_news_app/shared/bloc_observer.dart';
import 'package:my_news_app/shared/network/remote/dio_helper.dart';

import 'layout/news_layout/news_layout.dart';

void main() {
  // use BlocObserver to look at code
  Bloc.observer = MyBlocObserver();

  // initialize the dio here
  DioHelper.init();

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.deepOrange,
        floatingActionButtonTheme: FloatingActionButtonThemeData(
          backgroundColor: Colors.deepOrange
        ),
        scaffoldBackgroundColor: Colors.white,
        appBarTheme: AppBarTheme(
            // backwardsCompatibility false make me
            // able to control status bar values if true i can't
            backwardsCompatibility: false,
            systemOverlayStyle: SystemUiOverlayStyle(
                statusBarColor: Colors.white,
                statusBarIconBrightness: Brightness.dark),
            backgroundColor: Colors.white,
            elevation: 0.0,
            titleTextStyle: TextStyle(
                color: Colors.black,
                fontSize: 20,
                fontWeight: FontWeight.bold),
          iconTheme: IconThemeData(
              color: Colors.black
          ),


        ),
        bottomNavigationBarTheme: BottomNavigationBarThemeData(
            type: BottomNavigationBarType.fixed,
            selectedItemColor: Colors.deepOrange,
            elevation: 20.0),
      ),
      darkTheme: ThemeData(
        scaffoldBackgroundColor: Colors.black26,
        appBarTheme: AppBarTheme(
          // backwardsCompatibility false make me
          // able to control status bar values if true i can't
          backwardsCompatibility: false,
          systemOverlayStyle: SystemUiOverlayStyle(
              statusBarColor: Colors.black26,
              statusBarIconBrightness: Brightness.light),
          backgroundColor: Colors.black26,
          elevation: 0.0,
          titleTextStyle: TextStyle(
              color: Colors.white,
              fontSize: 20,
              fontWeight: FontWeight.bold),
          iconTheme: IconThemeData(
              color: Colors.white
          ),


        ),
        bottomNavigationBarTheme: BottomNavigationBarThemeData(
            type: BottomNavigationBarType.fixed,
            selectedItemColor: Colors.deepOrange,
            backgroundColor: Colors.black26,
            unselectedItemColor: Colors.grey,
            elevation: 20.0),
      ),
      themeMode: ThemeMode.light,
      home: NewsLayout(),
    );
  }
}
