import '../model/Drink.dart';
import '../pages/drink_detail_search.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../model/OrderDetail.dart';
import 'notfound.dart';

class SearchField extends StatefulWidget {
  @override
  _SearchFieldState createState() => _SearchFieldState();
}

class _SearchFieldState extends State<SearchField> {

  final List<dynamic> _drink = [];
  final List<String> nameDrinks = [];

  @override
  void initState() {
    super.initState();
    FirebaseDatabase.instance.reference().child("food").onValue.listen((event) {
      DataSnapshot snapshot = event.snapshot;

      var KEYS = snapshot.value.keys;
      var DATA = snapshot.value;

      _drink.clear();
      nameDrinks.clear();

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
        nameDrinks.add(drink.name);
        _drink.add(drink);
      }
      setState(() {
        print('Length: $_drink.length');
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<OrderDetail>(
      builder: (context, OrderDetail, child){
        return Container(
          margin: EdgeInsets.only(top: 20.0),
          child: Material(
            borderRadius: BorderRadius.circular(30.0),
            child: TextField(
              readOnly: true,
              onTap: (){
                showSearch(context: context, delegate: DataSearch(list: _drink, nameDrinks: nameDrinks));
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
                      showSearch(context: context, delegate: DataSearch(list: _drink, nameDrinks: nameDrinks));
                    },
                  ),
                ),
                border: InputBorder.none,
              ),
            ),
          ),
        );
      }
    );
  }
}

class DataSearch extends SearchDelegate<String>{
  List<dynamic> list;
  List<String> nameDrinks;
  DataSearch({this.list, this.nameDrinks});
  @override
  List<Widget> buildActions(BuildContext context) {
    return [
      IconButton(
        icon: Icon(Icons.clear),
        onPressed: () {
          query = "";
          showSuggestions(context);
        },
      ),
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

  var result;
  for(var i = 0; i<list.length; i++){
    if(list[i].name == query){
      result = DrinkDetailsSearch(list[i]);
    }
  }
  return result;
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    var searchList = query.isEmpty ? nameDrinks : nameDrinks.where((p) => p.contains(query)).toList();
    return searchList.isEmpty ? NotFound() : ListView.builder(
      itemCount: searchList.length,
      itemBuilder: (context, index) {
         return ListTile(
           leading: Icon(Icons.fastfood),
           title: Text(searchList[index].toString()),
           trailing: Icon(Icons.youtube_searched_for),
           onTap: (){
             query = searchList[index];
             showResults(context);
           },
         );
      });
  }

}

