import 'package:flutter/material.dart';

class DrinkItemCard extends StatefulWidget {

  final String image;
  final String name;
  final String description;
  final double price;
  final int sale;

  DrinkItemCard({this.image, this.name, this.description, this.price, this.sale});

  @override
  _DrinkItemCardState createState() => _DrinkItemCardState();
}

class _DrinkItemCardState extends State<DrinkItemCard> {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 10.0),
      padding: EdgeInsets.all(5.0),
      width: 500.0,
      height: 125.0,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10.0),
        boxShadow: [
          BoxShadow(
              blurRadius: 5.0, offset: Offset(0, 3), color: Colors.black12),
        ],
      ),
      child: Container(
        width: 450.0,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            Container(
              width: 100.0,
              height: 100.0,
              decoration: BoxDecoration(
                  image: DecorationImage(
                      image: NetworkImage(widget.image),
                      fit: BoxFit.cover),
                  borderRadius: BorderRadius.circular(10.0)),
            ),

            Padding(
              padding: EdgeInsets.only(left: 10.0, top: 5.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Container(
                    width: 190.0,
                    child: Text(
                      widget.name,
                      style: TextStyle(fontSize: 12.0, fontWeight: FontWeight.bold),
                      softWrap: true,
                    ),
                  ),
                  SizedBox(
                    height: 5.0,
                  ),
                  Container(
                    width: 190.0,
                    child: Text(widget.description),
                  ),
                  SizedBox(
                    height: 5.0,
                  ),
                  Container(
                    width: 190.0,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text(
                          "\$"+widget.price.toString(),
                          style: TextStyle(
                              fontSize: 16.0,
                              fontWeight: FontWeight.bold,
                              color: Colors.blue),
                        ),
                        Text(
                          widget.sale.toString()+"%",
                          style: TextStyle(
                              fontSize: 16.0,
                              fontWeight: FontWeight.bold,
                              color: Colors.blue),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            Container(
              child: IconButton(
                icon: Icon(Icons.add),
                color: Colors.black,
                onPressed: (){},
              ),
            )
          ],
        ),
      ),
    );
  }
}


