import 'package:flutter/material.dart';

class FoodCard extends StatelessWidget {

  final String image;
  final String name;

  FoodCard({this.image, this.name});


  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(right: 10.0),
      child: Card(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
          child: Row(
            children: <Widget>[
              Image(
                image: AssetImage(image),
                height: 65.0,
                width: 65.0,
              ),
              SizedBox(width: 20.0,),
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Text(name, style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16.0),),
                  Text("10 kinds")
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
