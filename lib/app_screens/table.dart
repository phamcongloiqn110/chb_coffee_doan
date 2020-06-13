import 'package:flutter/material.dart';
import '../app_screens/home.dart';
import '../app_screens/shopping.dart';
import '../app_screens/BouncyPageRoute.dart';

class Table_Page extends StatelessWidget{
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
      bottomNavigationBar: _getNavBar(context),
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

_getNavBar(context) {
  return Stack(
    children: <Widget>[
      Positioned(
        bottom: 0,
        child: ClipPath(
          clipper: NavBarClipper(),
          child: Container(
            height: 60,
            width: MediaQuery
                .of(context)
                .size
                .width,
            decoration: BoxDecoration(
                gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [
                      Colors.tealAccent,
                      Colors.lightBlue,
                    ])),
          ),
        ),
      ),
      Positioned(
        bottom: 45,
        width: MediaQuery
            .of(context)
            .size
            .width,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            IconButton(
              iconSize: 60,
              onPressed: () {
                Navigator.push(
                  context,
                  BouncyPageRoute(widget: Home()));
              },
              icon: _buildNavItem(Icons.home, false),
            ),
            SizedBox(width: 1),
            IconButton(
              iconSize: 60,
              onPressed: () {
                Navigator.push(
                  context,
                  BouncyPageRoute(widget: Shopping_Page()));
              },
              icon: _buildNavItem(Icons.shopping_cart, false),
            ),
            SizedBox(width: 1),
            IconButton(
              iconSize: 60,
              onPressed: () {
                Table_Page();
              },
              icon: _buildNavItem(Icons.table_chart, true),
            ),
          ],
        ),
      ),
      Positioned(
        bottom: 10,
        width: MediaQuery
            .of(context)
            .size
            .width,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            Text('Home',
                style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontFamily: 'Raleway')
            ),
            SizedBox(
              width: 1,
            ),
            Text('Order',
                style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontFamily: 'Raleway')
            ),
            SizedBox(
              width: 1,
            ),
            Text('Table',
                style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontFamily: 'Raleway')
            ),
          ],
        ),
      )
    ],
  );
}

_buildNavItem(IconData icon, bool active) {
  return CircleAvatar(
    radius: 50.0,
    backgroundColor: Colors.blueGrey,
    child: CircleAvatar(
      radius: 50.0,
      backgroundColor:
      active ? Colors.white.withOpacity(0.9) : Colors.transparent,
      child: Icon(
        icon,
        color: active ? Colors.black : Colors.white.withOpacity(0.9),
      ),
    ),
  );
}

class NavBarClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    // TODO: implement getClip
    Path path = Path();
    var sw = size.width;
    var sh = size.height;
    path.cubicTo(sw / 12, 0, sw / 12, 2 * sh / 5, 2 * sw / 12, 2 * sh / 5);
    path.cubicTo(3 * sw / 12, 2 * sh / 5, 3 * sw / 12, 0, 4 * sw / 12, 0);
    path.cubicTo(
        5 * sw / 12, 0, 5 * sw / 12, 2 * sh / 5, 6 * sw / 12, 2 * sh / 5);
    path.cubicTo(7 * sw / 12, 2 * sh / 5, 7 * sw / 12, 0, 8 * sw / 12, 0);
    path.cubicTo(
        9 * sw / 12, 0, 9 * sw / 12, 2 * sh / 5, 10 * sw / 12, 2 * sh / 5);
    path.cubicTo(11 * sw / 12, 2 * sh / 5, 11 * sw / 12, 0, sw, 0);
    path.lineTo(sw, sh);
    path.lineTo(0, sh);
    path.close();
    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) => false;
}