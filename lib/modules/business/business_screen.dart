import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_news_app/layout/news_layout/cubit/cubit.dart';
import 'package:my_news_app/layout/news_layout/cubit/states.dart';
import 'package:my_news_app/shared/components/componentes.dart';

class BusinessScreen extends StatelessWidget {
  const BusinessScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<NewsCubit, NewsStates>(
      listener: (context, state) {},
      builder: (context, state) {
        List<dynamic> business = NewsCubit.get(context).business;
        return articleBuilder(business);
      },);
  }
}
