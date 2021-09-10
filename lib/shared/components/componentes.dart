import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';

Widget buildArticleItem(context, article) => Padding(
  padding: const EdgeInsets.all(20.0),
  child: Row(
    children: [
      Container(
        width: 120,
        height: 120,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            image:article['urlToImage'] != null
                ? DecorationImage(
                image: NetworkImage('${article['urlToImage']}'),
                fit: BoxFit.cover)
                : DecorationImage(
              image: NetworkImage(
                // default image if the source image is null
                  'https://guidesaudi.com/Images/Logo/GuideSaudi/default.png'),
            ),

        ),
      ),
      SizedBox(
        width: 20,
      ),
      Expanded(
        child: Container(
          height: 120,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Expanded(
                child: Text(
                  '${article['title']}',
                  maxLines: 3,
                  overflow: TextOverflow.ellipsis,
                  style:Theme.of(context).textTheme.bodyText1,
                ),
              ),
              Text(
                '${article['publishedAt']}',
                style: TextStyle(color: Colors.grey),
              )
            ],
          ),
        ),
      ),
    ],
  ),
);

Widget articleBuilder(list) => ConditionalBuilder(
  condition: list.length > 0,
  builder: (context) {
    return ListView.separated(
      physics: BouncingScrollPhysics(),
      itemBuilder: (context, index) => buildArticleItem(context, list[index],),
      separatorBuilder: (context, index) => Padding(
        padding: const EdgeInsetsDirectional.only(start: 20),
        child: Container(
          width: double.infinity, height: 1, color: Colors.grey,),
      ),
      itemCount: list.length,
    );
  },
  fallback: (context) => Center(child: CircularProgressIndicator(),),
);
