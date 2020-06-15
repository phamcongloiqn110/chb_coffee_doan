import 'package:bhccoffee/model/Drink.dart';
import 'package:flutter/material.dart';
import '../widget/button.dart';

class DrinkDetailsPage extends StatefulWidget {

  final Drink drink;

  DrinkDetailsPage({this.drink});

  @override
  _DrinkDetailsPageState createState() => _DrinkDetailsPageState();
}

class _DrinkDetailsPageState extends State<DrinkDetailsPage> {

  var _mediumSpace = SizedBox(
    height: 20.0,
  );

  var _smallSpace = SizedBox(
    height: 10.0,
  );

  int countNum = 1;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          elevation: 0.0,
          title: Text(
            "Food Details",
            style: TextStyle(fontSize: 16.0, color: Colors.black),
          ),
          backgroundColor: Colors.white,
          iconTheme: IconThemeData(color: Colors.black),
          centerTitle: true,
        ),
        body: Padding(
          padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Container(
                height: 300.0,
                width: MediaQuery.of(context).size.width,
                decoration: BoxDecoration(
                    image: DecorationImage(
                        image: NetworkImage(widget.drink.image),
                        fit: BoxFit.cover),
                    borderRadius: BorderRadius.circular(10.0)),
              ),
              _mediumSpace,
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Text(
                    widget.drink.name,
                    style: TextStyle(fontSize: 18.0, color: Colors.black,fontWeight: FontWeight.bold),
                  ),
                  Text(
                    "\$" + widget.drink.price.toString(),
                    style: TextStyle(
                      fontSize: 16.0,
                      color: Theme.of(context).primaryColor,
                    ),
                  ),
                ],
              ),
              _mediumSpace,
              Text(
                "Description:",
                style: TextStyle(fontSize: 16.0, color: Colors.black, fontWeight: FontWeight.bold),
              ),
              _smallSpace,
              Text(
                widget.drink.description,
                textAlign: TextAlign.justify,
              ),
              _smallSpace,
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  IconButton(icon: Icon(
                      Icons.remove_circle),
                      onPressed: (){
                        setState(() {
                          if(countNum<2){
                            countNum = 1;
                          }else{
                            countNum--;
                          }
                        });
                      }),
                  SizedBox(width: 15.0,),
                  Text('$countNum', style: TextStyle(fontSize: 16.0,),),
                  SizedBox(width: 15.0,),
                  IconButton(icon: Icon(
                      Icons.add_circle),
                      onPressed: (){
                        setState(() {
                          if(countNum>98){
                            countNum = 99;
                          }else{
                            countNum++;
                          }
                        });
                      }),
                ],
              ),
              _smallSpace,
              Button(
                btnText: "Proceed to Order",
              ),
            ],
          ),
        ),
      ),
    );
  }
}