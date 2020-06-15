import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class OrderCard extends StatefulWidget {
  @override
  _OrderCardState createState() => _OrderCardState();
}

class _OrderCardState extends State<OrderCard> {
  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 15.0, vertical: 10.0),
        child: Row(
          mainAxisSize: MainAxisSize.max,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Container(
              decoration: BoxDecoration(
                border: Border.all(color: Color(0xFFD3D3D3), width: 2.0),
                borderRadius: BorderRadius.circular(10.0),
              ),
              width: 45.0,
              height: 73.0,
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 10.0),
                child: Column(
                  children: <Widget>[
                    InkWell(
                      onTap: (){},
                      child: Icon(Icons.keyboard_arrow_up,
                      color: Color(0xFFD3D3D3)),
                    ),
                    Text(
                      "1",
                      style: TextStyle(fontSize: 18.0, color: Colors.grey),
                    ),
                    InkWell(
                      onTap: () {},
                      child: Icon(Icons.keyboard_arrow_down,
                      color: Color(0xFFD3D3D3))
                    )
                  ],
                ),
              ),
            ),
            SizedBox(width: 20.0),
            Container(
              height: 70.0,
              width: 90.0,
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: AssetImage("images/coffee-list1.jpg"),
                  fit: BoxFit.cover
                ),
                borderRadius: BorderRadius.circular(10.0),
                boxShadow: [
                  BoxShadow(
                  color: Colors.black,
                  blurRadius: 5.0,
                  offset: Offset(0.0, 2.0)
                  )
                ]),
            ),
            SizedBox(width: 20.0),
            Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  "Coffee",
                  style: TextStyle(fontSize: 16.0, fontWeight: FontWeight.bold),
                ),
                SizedBox(height: 5.0),
                Text(
                  "Price: \$ 3.0",
                  style: TextStyle(
                      fontSize: 16.0,
                      color: Colors.orangeAccent,
                      fontWeight: FontWeight.bold),
                ),
                SizedBox(height: 5.0),
                Text(
                  "Sale: 50%",
                  style: TextStyle(
                      fontSize: 16.0,
                      color: Colors.grey,
                      fontWeight: FontWeight.w300),
                ),
              ],
            ),
           Spacer(),
           Padding(
             padding: EdgeInsets.only(top: 20.0),
             child: GestureDetector(
               onTap: (){},
               child: Icon(
                 Icons.cancel,
                 color: Colors.red,
               ),
             ),
           ),
          ],
        ),
      ),
    );
  }
}
