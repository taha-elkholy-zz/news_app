import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:my_news_app/shared/bloc_observer.dart';

import 'layout/news_layout/news_layout.dart';

void main() {
  Bloc.observer = MyBlocObserver();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: NewsLayout(),
    );
  }
}
