import 'package:bloc/bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_news_app/layout/news_layout/cubit/states.dart';
import 'package:my_news_app/modules/business/business_screen.dart';
import 'package:my_news_app/modules/science/science_screen.dart';
import 'package:my_news_app/modules/sports/sports_screen.dart';
import 'package:my_news_app/shared/network/remote/dio_helper.dart';

class NewsCubit extends Cubit<NewsStates> {
  // constructor match super with initial state of app
  NewsCubit() : super(NewsInitialState());

  // a static object from the NewsCubit
  static NewsCubit get(context) => BlocProvider.of(context);

  // bottom nav bar index
  int currentIndex = 0;

  void changeBottomNaveBarIndex(int index) {
    currentIndex = index;
    // get data of the 1 & 2 index here
    if (index == 1) {
      getSports();
    } else if (index == 2) {
      getScience();
    }
    emit(NewsBottomNavState());
  }

  // list of titles of the app
  List<String> titles = [
    'Business',
    'Sports',
    'Science',
  ];

  // list of screens will shown on news layout
  List<Widget> screens = [
    BusinessScreen(),
    SportsScreen(),
    ScienceScreen(),
  ];

// list of BottomNavigationBarItem
  List<BottomNavigationBarItem> bottomNavItems = [
    BottomNavigationBarItem(
      icon: Icon(Icons.business),
      label: 'Business',
    ),
    BottomNavigationBarItem(
      icon: Icon(Icons.sports),
      label: 'Sports',
    ),
    BottomNavigationBarItem(
      icon: Icon(Icons.science),
      label: 'Science',
    ),
  ];

  // light & dark mode
  bool isDark = false;

  void changeAppMode() {
    isDark = !isDark;
    emit(NewsChangeModeState());
  }

  // List of business articles
  List<dynamic> business = [];

  void getBusiness() {
    //loading
    emit(NewsGetBusinessLoadingState());
    if (business.length == 0) {
      DioHelper.getData(url: 'v2/top-headlines', query: {
        'country': 'eg',
        'category': 'business',
        'apikey': '875465faa7d94a638da55e846be8701b',
      }).then((value) {
        business = value.data['articles'];
        emit(NewsGetBusinessSuccessState());
        print('success');
      }).catchError((error) {
        emit(NewsGetBusinessErrorState(error.toString()));
        print('Error is : ${error.toString()}');
      });
    } else {
      emit(NewsGetBusinessSuccessState());
    }
  }

  // List of business articles
  List<dynamic> science = [];

  void getScience() {
    //loading
    emit(NewsGetScienceLoadingState());
    if (science.length == 0) {
      DioHelper.getData(url: 'v2/top-headlines', query: {
        'country': 'eg',
        'category': 'science',
        'apikey': '875465faa7d94a638da55e846be8701b',
      }).then((value) {
        science = value.data['articles'];

        emit(NewsGetScienceSuccessState());
        print('success');
      }).catchError((error) {
        emit(NewsGetScienceErrorState(error.toString()));
        print('Error is : ${error.toString()}');
      });
    } else {
      emit(NewsGetScienceSuccessState());
    }
  }

  // List of business articles
  List<dynamic> sports = [];

  void getSports() {
    //loading
    emit(NewsGetSportsLoadingState());
    if (sports.length == 0) {
      DioHelper.getData(url: 'v2/top-headlines', query: {
        'country': 'eg',
        'category': 'sports',
        'apikey': '875465faa7d94a638da55e846be8701b',
      }).then((value) {
        sports = value.data['articles'];

        emit(NewsGetSportsSuccessState());
        print('success ${sports.length}');
      }).catchError((error) {
        emit(NewsGetSportsErrorState(error.toString()));
        print('Error is : ${error.toString()}');
      });
    } else {
      emit(NewsGetSportsSuccessState());
    }
  }
}
