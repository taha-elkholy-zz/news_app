import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_news_app/layout/news_layout/cubit/cubit.dart';
import 'package:my_news_app/layout/news_layout/cubit/states.dart';
import 'package:my_news_app/modules/search/search_screen.dart';
import 'package:my_news_app/shared/components/componentes.dart';

class NewsLayout extends StatelessWidget {
  const NewsLayout({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<NewsCubit, NewsStates>(
      listener: (context, state) {},
      builder: (context, state) {
        NewsCubit cubit = NewsCubit.get(context);
        return Scaffold(
          appBar: AppBar(
            title: Text(cubit.titles[cubit.currentIndex]),
            actions: [
              IconButton(
                  icon: Icon(Icons.search),
                  onPressed: () {
                    navigateTo(context, SearchScreen());
                  }),
              IconButton(
                  icon: Icon(Icons.brightness_4_outlined),
                  onPressed: () {
                    NewsCubit.get(context).changeAppMode();
                  }),
            ],
          ),
          body: ConditionalBuilder(
              condition: true,
              builder: (context) => cubit.screens[cubit.currentIndex],
              fallback: (context) => Center(
                    child: CircularProgressIndicator(),
                  )),
          bottomNavigationBar: BottomNavigationBar(
            currentIndex: cubit.currentIndex,
            onTap: (index) {
              cubit.changeBottomNaveBarIndex(index);
            },
            items: cubit.bottomNavItems,
          ),
        );
      },
    );
  }
}
