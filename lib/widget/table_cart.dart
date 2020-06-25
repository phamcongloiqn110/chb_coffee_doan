import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class TableCard extends StatelessWidget {

  final String name;

  TableCard({this.name});


  @override
  Widget build(BuildContext context) {
//    return Container(
//      margin: EdgeInsets.only(right: 5.0, left: 5.0),
//      child: Card(
//        child: Padding(
//          padding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
//          child: Row(
//            children: <Widget>[
//              Column(
//                mainAxisAlignment: MainAxisAlignment.center,
//                children: <Widget>[
//                  Text(name, style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16.0),),
//                ],
//              ),
//            ],
//          ),
//        ),
//      ),
//    );

    return Stack(
      children: <Widget>[
        Container(
          decoration: BoxDecoration(
            color: Colors.teal,
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(40),
              topRight: Radius.circular(40)
            )
          ),
        ),
        Container(
          margin: EdgeInsets.symmetric(
            horizontal: 5.0,
            vertical: 5.0
          ),
          height: 100.0,
          child: Stack(
            alignment: Alignment.bottomCenter,
            children: <Widget>[
              Container(
                height: 100.0,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(22),
                  color: Colors.blue,
                  boxShadow: [
                    BoxShadow(
                        blurRadius: 5.0, offset: Offset(0, 3), color: Colors.black12),
                  ],
                ),
                child: Container(
                  margin: EdgeInsets.only(right: 10),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(22),
                      color: Colors.white
                  ),
                ),
              ),
              Container(
                child: Column(
                  children: <Widget>[
                    Container(
                        padding: EdgeInsets.only(top: 20.0, left: 30.0),
                        child: Text(name, style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16.0)),
                        alignment: Alignment.topLeft
                    ),
                    Container(
                      child: Text("Empty table"),
                    ),
                    SizedBox(height: 8.0,),
                    Container(
                      height: 20.0,
                      width: 200.0,
                      child: RaisedButton(
                        onPressed: (){},
                        elevation: 1.0,
                        child: Text("...", style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 14.0,),),
                      ),
                    )
                  ],
                ),
              )
            ],
          ),
        )
      ],
    );
  }
}
