import 'package:flutter/material.dart';

class Header extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(50),
        child: Container(
          alignment: Alignment.bottomCenter,
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.centerLeft,
              end: Alignment.centerRight,
              colors: [
                Colors.white70,
                Colors.lightBlueAccent,
              ],
            ),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              MyImageAssets(),
              Text(
                'Welcome to CHB Coffee',
                style: TextStyle(
                    fontSize: 18,
                    fontFamily: 'Raleway',
                    fontWeight: FontWeight.w700
                ),
              ),
              IconButton(
                icon: Icon(Icons.search),
                onPressed: () => showSearch(context: context, delegate: DataSearch()),
              )
            ],
          ),
        ),
      ),
    );
  }
}

class MyImageAssets extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    AssetImage assetImage = AssetImage("images/logocoffee.png");
    Image image = Image(image: assetImage, height: 50.0);
    return Container(child: image);
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
    // TODO: implement buildActions
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