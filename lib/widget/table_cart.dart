import 'package:flutter/material.dart';

class TableCard extends StatelessWidget {

  final String name;

  TableCard({this.name});


  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(right: 10.0),
      child: Card(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
          child: Row(
            children: <Widget>[
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Text(name, style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16.0),),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
