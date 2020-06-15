import '../widget/bought_drink.dart';
import '../widget/food_category.dart';
import '../widget/search_field.dart';
import '../model/Drink.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../widget/home_header.dart';
class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {

  final List<Drink> _drink = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        padding: EdgeInsets.only(top: 40.0, left: 20.0, right: 20.0),
        children: <Widget>[
          HomeHeader(),
          FoodCategory(),
          SearchField(),
          SizedBox(height: 20.0),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Text(
                "Frequently Bought Drinks",
                style: TextStyle(
                  fontSize: 18.0,
                  fontWeight: FontWeight.bold
                ),
              ),
              GestureDetector(
                onTap: (){},
                child: Text(
                  "View all",
                  style: TextStyle(
                    fontSize: 18.0,
                    fontWeight: FontWeight.bold,
                    color: Colors.orangeAccent
                  ),
                ),
              ),
            ],
          ),
          SizedBox(height: 20.0,),
          Column(
            children: _drink.map(_buildDrinkItem).toList(),
          )
        ],
      ),
    );
  }

  Widget _buildDrinkItem(Drink drink){
    return Container(
      margin: EdgeInsets.only(bottom: 20.0),
      child: BoughtDrinks(
        name: drink.name,
        image: drink.image,
        price: drink.price,
        sale: drink.sale,
      ),
    );
  }
}

