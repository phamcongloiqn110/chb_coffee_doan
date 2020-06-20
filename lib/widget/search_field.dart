import 'package:bhccoffee/model/Drink.dart';
import 'package:bhccoffee/pages/drink_detail_search.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';

import 'drink_item_card.dart';
import 'notfound.dart';

class SearchField extends StatefulWidget {
  @override
  _SearchFieldState createState() => _SearchFieldState();
}

class _SearchFieldState extends State<SearchField> {

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
    return Container(
      margin: EdgeInsets.only(top: 20.0),
      child: Material(
        borderRadius: BorderRadius.circular(30.0),
        child: TextField(
          readOnly: true,
          onTap: (){
            showSearch(context: context, delegate: DataSearch(this._drink));
          },
          decoration: InputDecoration(
            filled: true,
            fillColor: Color.fromRGBO(0, 0, 0, 250),
            focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(color: Colors.white),
              borderRadius: BorderRadius.circular(30.0),
            ),
            enabledBorder: UnderlineInputBorder(
              borderSide: BorderSide(color: Colors.white),
              borderRadius: BorderRadius.circular(30.0),
            ),
            contentPadding: EdgeInsets.symmetric(horizontal: 32.0, vertical: 14.0),
            hintText: "Search any drink", hintStyle: TextStyle(color: Colors.grey),
            suffixIcon: Material(
              color: Color.fromRGBO(0,0,0,0),
              borderRadius: BorderRadius.circular(30.0),
              child: IconButton(
                icon: Icon(Icons.search),
                color: Colors.grey,
                onPressed: (){
                  showSearch(context: context, delegate: DataSearch(this._drink));
                },
              ),
            ),
            border: InputBorder.none,
          ),
        ),
      ),
    );
  }
}

class DataSearch extends SearchDelegate<Drink> {
  List<Drink> drinks = [];
  List<Drink> suggestion = [];
  Drink drink;
  var x;

  DataSearch(this.drinks);

  @override
  List<Widget> buildActions(BuildContext context) {
    return [
      IconButton(
        icon: Icon(Icons.clear),
        onPressed: () {
          query = "";
        },
      )
    ];
  }

  @override
  Widget buildLeading(BuildContext context) {
    return IconButton(
        icon: AnimatedIcon(
          icon: AnimatedIcons.menu_arrow,
          progress: transitionAnimation,
        ),
        onPressed: () {
          close(context, null);
        });
  }

  @override
  Widget buildResults(BuildContext context) {
    return DrinkDetailsSearch(drink: drinks[x]);
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    final suggestion = query.isEmpty
        ? []
        : drinks.where((target) => target.name.contains(query)).toList();
    return suggestion.isEmpty ? NotFound() : ListView.builder(
      itemBuilder: (context, index) => Container(
          margin: EdgeInsets.only(bottom: 0.0),
          child: GestureDetector(
            onTap: (){
              x =  index;
              showResults(context);
            },
            child: DrinkItemCard(
                image: drinks[index].image,
                name: drinks[index].name,
                description: drinks[index].description,
                price: drinks[index].price,
                sale: drinks[index].sale
            ),
          ),
      ),
    );
  }
}

