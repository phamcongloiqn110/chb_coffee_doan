import '../model/ListDrinks.dart';
import 'package:flutter/material.dart';

class BoughtDrinks extends StatefulWidget {

  final String description;
  final String image;
  final bool isActive;
  final bool isSale;
  final ListFood keyList;
  final String name;
  final String price;
  final String sale;

  BoughtDrinks({this.description, this.image, this.isActive, this.isSale, this.keyList,
    this.name, this.price, this.sale});

  @override
  _BoughtDrinksState createState() => _BoughtDrinksState();
}

class _BoughtDrinksState extends State<BoughtDrinks> {
  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(10.0),
      child: Stack(
        children: <Widget>[
          Container(
            height: 275.0,
            width: 500.0,
            child: Image.network(widget.image, fit: BoxFit.cover),
          ),
          Positioned(
            left: 0.0,
            bottom: 0.0,
            child: Container(
              height: 102.0,
              width: 500.0,
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [
                    Colors.black,
                    Colors.black12
                  ],
                  begin: Alignment.bottomCenter,
                  end: Alignment.topCenter
                )
              ),
            ),
          ),
          Positioned(
            left: 10.0,
            bottom: 25.0,
            right: 10.0,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Text(
                  widget.name,
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 18.0,
                    fontWeight: FontWeight.bold
                  ),
                ),
                Column(
                  children: <Widget>[
                    Text(
                      widget.price,
                      style: TextStyle(
                        color: Colors.orange,
                        fontSize: 15.0,
                        fontWeight: FontWeight.bold
                      ),
                    ),
                    Text(
                      widget.sale,
                      style: TextStyle(
                          color: Colors.grey,
                          fontSize: 15.0
                      ),
                    )
                  ],
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
