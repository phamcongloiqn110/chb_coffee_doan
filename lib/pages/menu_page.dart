import 'package:provider/provider.dart';

import '../model/Drink.dart';

import '../model/OrderDetail.dart';
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

  @override
  Widget build(BuildContext context) {
    return Consumer<OrderDetail> (
      builder: (context, OrderDetail, child){
        return Scaffold(
          body: ListView(
            padding: EdgeInsets.only(left: 20.0, right: 20.0),
            children: <Widget>[
              Column(
                children: _drink.map(_buildFoodItem).toList(),
              )
            ],
          ),
        );
      }
    );
  }

  Widget _buildFoodItem(Drink drink) {
    return GestureDetector(
      onTap: (){
        Navigator.of(context).push(MaterialPageRoute(
          builder: (BuildContext context) => DrinkDetailsPage(drink),
        ));
      },
      child: Container(
        margin: EdgeInsets.only(bottom: 0.0),
        child: DrinkItemCard(drink),
      ),
    );
  }
}
