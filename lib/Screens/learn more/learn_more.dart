import 'dart:ui';

import 'package:flutter/material.dart';

import '../../Shared/Constants/dimenstions.dart';
import '../../Shared/Core/assets_paths.dart';
import '../../Shared/Widgets/category_item.dart';
import '../../Shared/data/categories_data.dart';


class LearnMore extends StatelessWidget {
  const LearnMore({super.key});

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      body: Stack(
        children: [
          Image.asset(
            AssetsPaths.backgroundImage2,
            height: screen_height,
            fit: BoxFit.cover,
            filterQuality: FilterQuality.none,
          ),
          BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 15, sigmaY: 15),
            child:Padding(
              padding: const EdgeInsets.only(top: 38.0, left: 8.0),
              child: GridView(
                gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
                  maxCrossAxisExtent: 200,
                  childAspectRatio: 9/10,
                  mainAxisExtent: 280,
                  crossAxisSpacing:5
                ),
                children: CategoriesData.map((CategoriesData)=>CategoryItem(Title: CategoriesData.title,data: CategoriesData.info,)).toList(),
              ),
            ),
          )
        ],
      ),
    );
  }
}
