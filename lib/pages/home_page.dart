import '../model/Drink.dart';
import 'package:firebase_database/firebase_database.dart';

import '../widget/bought_drink.dart';
import '../widget/food_category.dart';
import '../widget/search_field.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../widget/home_header.dart';
import 'drink_detail_page.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  final List<Drink> _drink = [];

  @override
  void initState() {
    super.initState();
    DatabaseReference foodRef = FirebaseDatabase.instance.reference().child(
        "food");
    foodRef.once().then((DataSnapshot snapshot) {
      var KEYS = snapshot.value.keys;
      var DATA = snapshot.value;

      _drink.clear();

      for (var individualKey in KEYS) {
        Drink drink = Drink(
            individualKey,
            DATA[individualKey]['name'],
            DATA[individualKey]['description'],
            DATA[individualKey]['image'],
            (DATA[individualKey]['isActive']== 'true') ? true : false,
            (DATA[individualKey]['isSale'] == 'true') ? true : false,
            double.parse(DATA[individualKey]['price']),
            int.parse(DATA[individualKey]['sale']));
        _drink.add(drink);
      }
      setState(() {
        print('Length: $_drink.length');
      });
    });
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
    return GestureDetector(
      onTap: (){
        Navigator.of(context).push(MaterialPageRoute(
          builder: (BuildContext context) => DrinkDetailsPage(drink: drink),
        ));
      },
      child: Container(
        margin: EdgeInsets.only(bottom: 20.0),
        child: BoughtDrinks(
            image: drink.image,
            name: drink.name,
            description: drink.description,
            price: drink.price,
            sale: drink.sale
        ),

      ),
    );
  }
}

