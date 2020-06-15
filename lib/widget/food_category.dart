import '../widget/food_card.dart';
import '../data/category_data.dart';
import '../model/Drink.dart';
import 'package:flutter/material.dart';

class FoodCategory extends StatelessWidget {

  final List<Drink> _categories = categories;
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 80.0,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: _categories.length,
        itemBuilder: (BuildContext context, int index){
          return FoodCard(
            image: _categories[index].image,
            name: _categories[index].name
          );
        },
      ),
    );
  }
}
