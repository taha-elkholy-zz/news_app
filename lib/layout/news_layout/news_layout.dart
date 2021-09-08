
import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_news_app/layout/news_layout/cubit/cubit.dart';
import 'package:my_news_app/layout/news_layout/cubit/states.dart';

class NewsLayout extends StatelessWidget {
  const NewsLayout({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create:(context) => NewsCubit(),
      child: BlocConsumer<NewsCubit, NewsStates>(
        listener: (context, state){},
        builder: (context, state){
          NewsCubit cubit = NewsCubit.get(context);
          return Scaffold(
            appBar: AppBar(
              title: Text(cubit.titles[cubit.currentIndex]),
              actions: [
                IconButton(icon: Icon(Icons.search), onPressed: (){})
              ],
            ),
            body:ConditionalBuilder(
                condition: true,
                builder: (context) => cubit.screens[cubit.currentIndex],
                fallback: (context) => Center(child: CircularProgressIndicator(),)),
            bottomNavigationBar: BottomNavigationBar(
              currentIndex: cubit.currentIndex,
              onTap: (index){
                cubit.changeBottomNaveBarIndex(index);
              },
              items:cubit.bottomNavItems,
            ),
          );
        },),
    );
  }
}
