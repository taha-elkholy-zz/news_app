import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:my_news_app/layout/news_layout/cubit/states.dart';
import 'package:my_news_app/shared/bloc_observer.dart';
import 'package:my_news_app/shared/network/remote/dio_helper.dart';

import 'layout/news_layout/cubit/cubit.dart';
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
    return BlocProvider(
      create: (BuildContext context) => NewsCubit()..getBusiness(),
      child: BlocConsumer<NewsCubit, NewsStates>(
        listener:(context, state){},
        builder:(context, state){
          return MaterialApp(
            debugShowCheckedModeBanner: false,
            theme: ThemeData(
              primarySwatch: Colors.deepOrange,
              floatingActionButtonTheme:
              FloatingActionButtonThemeData(backgroundColor: Colors.deepOrange),
              scaffoldBackgroundColor: Colors.white,
              appBarTheme: AppBarTheme(
                // backwardsCompatibility false make me
                // able to control status bar values if true i can't
                backwardsCompatibility: false,
                systemOverlayStyle: SystemUiOverlayStyle(
                    statusBarColor: Colors.white,
                    statusBarIconBrightness: Brightness.dark),
                titleSpacing: 20,
                backgroundColor: Colors.white,
                elevation: 0.0,
                titleTextStyle: TextStyle(
                    color: Colors.black, fontSize: 20, fontWeight: FontWeight.bold),
                iconTheme: IconThemeData(color: Colors.black),
              ),
              bottomNavigationBarTheme: BottomNavigationBarThemeData(
                  backgroundColor: Colors.white,
                  type: BottomNavigationBarType.fixed,
                  selectedItemColor: Colors.deepOrange,
                  unselectedItemColor: Colors.grey,
                  elevation: 20.0),
              textTheme: TextTheme(
                bodyText1: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Colors.black
                ),
              ),
            ),
            darkTheme: ThemeData(
              primarySwatch: Colors.deepOrange,
              floatingActionButtonTheme:
              FloatingActionButtonThemeData(backgroundColor: Colors.deepOrange),
              scaffoldBackgroundColor: HexColor('333739'),
              appBarTheme: AppBarTheme(
                // backwardsCompatibility false make me
                // able to control status bar values if true i can't
                backwardsCompatibility: false,
                systemOverlayStyle: SystemUiOverlayStyle(
                    statusBarColor: HexColor('333739'),
                    statusBarIconBrightness: Brightness.light),
                titleSpacing: 20,
                backgroundColor: HexColor('333739'),
                elevation: 0.0,
                titleTextStyle: TextStyle(
                    color: Colors.white, fontSize: 20, fontWeight: FontWeight.bold),
                iconTheme: IconThemeData(color: Colors.white),
              ),
              bottomNavigationBarTheme: BottomNavigationBarThemeData(
                  backgroundColor: HexColor('333739'),
                  type: BottomNavigationBarType.fixed,
                  selectedItemColor: Colors.deepOrange,
                  unselectedItemColor: Colors.grey,
                  elevation: 20.0),
              textTheme: TextTheme(
                bodyText1: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Colors.white
                ),
              ),
            ),
            themeMode: NewsCubit.get(context).isDark ? ThemeMode.dark : ThemeMode.light,
            home:
            Directionality(textDirection: TextDirection.ltr, child: NewsLayout()),
          );
        },
      ),
    );
  }
}
