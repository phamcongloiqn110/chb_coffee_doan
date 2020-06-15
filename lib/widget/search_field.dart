import 'package:flutter/material.dart';

class SearchField extends StatelessWidget {
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

class DataSearch extends SearchDelegate{

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
