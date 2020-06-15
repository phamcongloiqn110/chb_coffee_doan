import 'package:bhccoffee/model/Drink.dart';

import '../widget/drink_item_card.dart';
import 'package:firebase_database/firebase_database.dart';

import 'package:flutter/material.dart';

import 'drink_detail_page.dart';

class MenuPage extends StatefulWidget {
  @override
  _MenuPageState createState() => _MenuPageState();
}

class _MenuPageState extends State<MenuPage> {

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
        Drink drink = new Drink(
            description: DATA[individualKey]['description'],
            image: DATA[individualKey]['image'],
            isActive: DATA[individualKey]['isActive'],
            isSale: DATA[individualKey]['isSale'],
            keyList: DATA[individualKey]['keyList'],
            name: DATA[individualKey]['name'],
            price: DATA[individualKey]['price'],
            sale: DATA[individualKey]['sale']
        );
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
        padding: EdgeInsets.only(left: 20.0, right: 20.0, top: 10.0),
        children: <Widget>[
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Text(
                "Coffee",
                style: TextStyle(
                    fontSize: 18.0,
                    fontWeight: FontWeight.bold
                ),
              ),
            ],
          ),
          SizedBox(height: 10.0),
          Column(
            children: _drink.map(_buildFoodItem).toList(),
          )
        ],
      ),
    );
  }

  Widget _buildFoodItem(Drink drink) {
    return GestureDetector(
      onTap: (){
        Navigator.of(context).push(MaterialPageRoute(
          builder: (BuildContext context) => DrinkDetailsPage(drink: drink),
        ));
      },
      child: Container(
        margin: EdgeInsets.only(bottom: 0.0),
        child: DrinkItemCard(
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
