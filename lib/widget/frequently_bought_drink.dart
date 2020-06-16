import 'package:flutter/material.dart';

class BoughtDrinks extends StatefulWidget {

  final String image;
  final String name;
  final double price;
  final int sale;
  final String description;

  BoughtDrinks({this.image, this.name, this.price, this.sale, this.description});

  @override
  _BoughtDrinksState createState() => _BoughtDrinksState();
}

class _BoughtDrinksState extends State<BoughtDrinks> {
  @override
  Widget build(BuildContext context) {
    return ClipRRect(
        borderRadius: BorderRadius.circular(15.0),
        child: Stack(
          children: <Widget>[
            Container(
              height: 275.0,
              width: MediaQuery.of(context).size.width,
              child: Image.network(widget.image, fit: BoxFit.cover),
            ),
            Positioned(
              left: 0.0,
              bottom: 0.0,
              child: Container(
                height: 102.0,
                width: MediaQuery.of(context).size.width,
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [
                      Color.fromRGBO(0, 0, 0, 100),
                      Color.fromRGBO(0, 0, 0, 0)
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
                  Column(
                    children: <Widget>[
                      Text(
                        widget.name,
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 18.0,
                            fontWeight: FontWeight.bold
                        ),
                      ),
                    ],
                  ),
                  Column(
                    children: <Widget>[
                      Text(
                        "\$"+widget.price.toString(),
                        style: TextStyle(
                          color: Colors.orange,
                          fontSize: 15.0,
                          fontWeight: FontWeight.bold
                        ),
                      ),
                      Text(
                        widget.sale.toString()+"%",
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
