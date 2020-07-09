import 'package:flutter/material.dart';

class HomeHeader extends StatelessWidget {
  final textStyle = TextStyle(
      fontSize: 32.0, fontWeight: FontWeight.bold, fontFamily: 'Raleway');

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(bottom: 20.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text("Chào mừng đến với ", style: TextStyle(
                fontSize: 25.0
              )),
              Text("CHB Coffee", style: textStyle),
            ],
          ),
          Padding(
            padding: EdgeInsets.only(right: 10.0),
            child: Image.asset(
              "images/logocoffee.png",
              height: 80.0,
              width: 100.0,
            ),
          ),
        ],
      ),
    );
  }
}
