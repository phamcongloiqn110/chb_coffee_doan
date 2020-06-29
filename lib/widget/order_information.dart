import 'package:flutter/material.dart';

class OrderInformation extends StatefulWidget {

  final bool active;
  final Function onTap;

  const OrderInformation({Key key, this.active, this.onTap}) : super(key: key);

  @override
  _OrderInformationState createState() => _OrderInformationState();
}

class _OrderInformationState extends State<OrderInformation> {
  @override
  Widget build(BuildContext context) {
    return AnimatedPositioned(
      duration: Duration(milliseconds: 500),
      curve: Curves.decelerate,
      bottom: widget.active ? 5 : -600,
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 30.0),
        height: MediaQuery.of(context).size.height*0.7,
        width: MediaQuery.of(context).size.height*0.95,
        decoration: BoxDecoration(
          color: Color(0xFFF23232b),
          borderRadius: BorderRadius.all(
              Radius.circular(30)
          ),
        ),
      ),
    );
  }
}
