import 'package:bloc/bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_news_app/layout/news_layout/cubit/states.dart';
import 'package:my_news_app/modules/business/business_screen.dart';
import 'package:my_news_app/modules/science/science_screen.dart';
import 'package:my_news_app/modules/sports/sports_screen.dart';
import 'package:my_news_app/shared/network/local/cach_helper.dart';
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
  // true because the first time run
  // the fromShared optional value = null
  // and the changeAppMode enter to the else statement
  // and reverse the value of isDark
  bool isDark = true;

  void changeAppMode({bool? fromShared}) {
    if (fromShared != null) {
      // her we get saved data from shared preferences
      isDark = fromShared;
      emit(NewsChangeModeState());
    } else {
      // her we just toggle between the 2 possibles
      isDark = !isDark;
      // save isDark value in shared preferences after edit the new value
      CashHelper.putBoolean(key: 'isDark', value: isDark).then((value) {
        emit(NewsChangeModeState());
      });
    }
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

  // List of business articles
  List<dynamic> search = [];

  void getSearch({required String value}) {
    if (value != '') {
      //loading
      emit(NewsGetSearchLoadingState());
    }

    // make the search list empty
    search = [];

    DioHelper.getData(url: 'v2/everything', query: {
      'q': '$value',
      'sortBy': 'publishedAt',
      'apikey': '875465faa7d94a638da55e846be8701b',
    }).then((value) {
      search = value.data['articles'];

      emit(NewsGetSearchSuccessState());
      print('success ${search.length}');
    }).catchError((error) {
      emit(NewsGetSearchErrorState(error.toString()));
      print('Error is : ${error.toString()}');
    });
  }
}
