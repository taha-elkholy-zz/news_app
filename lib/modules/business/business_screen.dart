import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
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
      listener: (context, state) {
        if(state is NewsGetBusinessErrorState){

        }
      },
      builder: (context, state) {
        return ConditionalBuilder(
          condition: state is! NewsGetBusinessLoadingState,
          builder: (context) {
            List<dynamic> business = NewsCubit.get(context).business;
            return ListView.separated(
              physics: BouncingScrollPhysics(),
                itemBuilder: (context, index) => buildArticleItem(business[index],),
                separatorBuilder: (context, index) => Padding(
                      padding: const EdgeInsetsDirectional.only(start: 20),
                      child: Container(
                        width: double.infinity, height: 1, color: Colors.grey,),
                    ),
                itemCount: business.length,
            );
          },
          fallback: (context) => Center(child: CircularProgressIndicator(),),
        );
      },);
  }
}
