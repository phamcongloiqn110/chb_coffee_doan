import 'package:bhccoffee/widget/frequently_bought_drink_sale.dart';

import '../model/Drink.dart';
import 'package:firebase_database/firebase_database.dart';

import '../widget/frequently_bought_drink.dart';
import '../widget/food_category.dart';
import '../widget/search_field.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../widget/home_header.dart';
import 'drink_detail_page.dart';
import 'drink_detail_page_sale.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  final List<Drink> _drink = [];

  @override
  void initState() {
    super.initState();
    FirebaseDatabase.instance.reference().child("food").onValue.listen((event) {
      DataSnapshot snapshot = event.snapshot;
      var KEYS = snapshot.value.keys;
      var DATA = snapshot.value;

      _drink.clear();

      for (var individualKey in KEYS) {
        Drink drink = Drink(
            individualKey,
            DATA[individualKey]['name'],
            DATA[individualKey]['description'],
            DATA[individualKey]['image'],
            DATA[individualKey]['isActive'],
            DATA[individualKey]['isSale'],
            double.parse(DATA[individualKey]['price']),
            int.parse(DATA[individualKey]['sale']));
        _drink.add(drink);
      }
      setState(() {
        print('Length: $_drink.length');
      });
    });
  }

  Widget _CheckDrink(Drink drink){
    if(drink.isSale){
      if(drink.isActive)
        return BoughtDrinksSale(drink);
    }
    else{
      if(drink.isActive)
        return BoughtDrinks(drink);
    }
  }

  Widget _CheckDrinkSale(Drink drink){
    if(drink.isSale){
      if(drink.isActive)
        return DrinkDetailsPageSale(drink);
    }
    else{
      if(drink.isActive)
        return DrinkDetailsPage(drink);
    }
  }

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
                "Danh sách thức uống",
                style: TextStyle(
                    fontSize: 18.0,
                    fontWeight: FontWeight.bold
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
    return GestureDetector(
      onTap: (){
        Navigator.of(context).push(MaterialPageRoute(
          builder: (BuildContext context) => _CheckDrinkSale(drink),
        ));
      },
      child: Container(
        margin: EdgeInsets.only(bottom: 20.0),
        child: _CheckDrink(drink),

      ),
    );
  }
}

