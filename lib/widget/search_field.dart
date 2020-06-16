import 'package:bhccoffee/model/Drink.dart';
import 'package:bhccoffee/pages/drink_detail_page.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_database/ui/firebase_animated_list.dart';
import 'package:flutter/material.dart';

import 'drink_item_card.dart';


class SearchField extends StatefulWidget {
  @override
  _SearchFieldState createState() => _SearchFieldState();
}

class _SearchFieldState extends State<SearchField> {

  final List<Item> _drink = [];
  Item item;

  DatabaseReference itemRef;
  TextEditingController controller = new TextEditingController();
  String searchString;

  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    item = Item(null, null, null, null, null);

    FirebaseDatabase database = FirebaseDatabase.instance;
    itemRef = database.reference().child("food");
    itemRef.onChildAdded.listen(_onEntryAdded);
    itemRef.onChildChanged.listen(_onEntryChanged);
    controller.addListener(() {
      setState(() {
        searchString = controller.text;
      });
    });
  }

  _onEntryAdded(Event event){
    setState(() {
      _drink.add(Item.fromSnapshot(event.snapshot));
    });
  }

  _onEntryChanged(Event event){
    var old = _drink.singleWhere((element){
      return element.key == event.snapshot.key;
    });
    setState(() {
      _drink[_drink.indexOf(old)] = Item.fromSnapshot(event.snapshot);
    });
  }

  void handleSubmit(){
    final FormState formState = formKey.currentState;

    if(formState.validate()){
      formState.save();
      formState.reset();
      itemRef.push().set(item.toJson());
    }
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
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
            showSearch(context: context, delegate: DataSearch());
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
                  showSearch(context: context, delegate: DataSearch());
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

class Item {
  String key;
  String image;
  String name;
  String description;
  double price;
  int sale;

  Item(this.image, this.name, this.description, this.price, this.sale);

  Item.fromSnapshot(DataSnapshot snapshot)
      : key = snapshot.key,
        image = snapshot.value["image"],
        name = snapshot.value["name"],
        description = snapshot.value["description"],
        price = snapshot.value["price"],
        sale = snapshot.value["sale"];


  toJson() {
    return {
      "image": image,
      "name": name,
      "description": description,
      "price": price,
      "sale": sale,
    };
  }
}

class DataSearch extends SearchDelegate<String> {
  final listDrink = [
    "Milk Coffee",
    "Black Coffee",
    "Milk Tea",
    "Cacao",
    "Yogurt",
    "Juice",
    "Smoothie"
  ];

  final rencentDrink = ["Milk Coffee", "Black Coffee", "Milk Tea"];

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
      },
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    return Center(
      child: Container(
        height: 100.0,
        width: 100.0,
        child: Card(
          color: Colors.red,
          child: Center(
            child: Text(query),
          ),
        ),
      ),
    );
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    final suggestionList = query.isEmpty
        ? rencentDrink
        : listDrink.where((element) => element.startsWith(query)).toList();
    return ListView.builder(
      itemBuilder: (context, index) =>
          ListTile(
            onTap: () {
              showResults(context);
            },
            leading: Icon(Icons.fastfood),
            title: RichText(text: TextSpan(
                text: suggestionList[index].substring(0, query.length),
                style: TextStyle(
                  color: Colors.black, fontWeight: FontWeight.bold,
                ),
                children: [TextSpan(
                    text: suggestionList[index].substring(query.length),
                    style: TextStyle(color: Colors.grey)
                ),
                ] // children
            ),
            ),
            trailing: Icon(Icons.find_replace),
          ),
      itemCount: suggestionList.length,
    );
  }
}


