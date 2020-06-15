import 'package:bhccoffee/widget/table_cart.dart';
import 'package:firebase_database/firebase_database.dart';

import '../model/Table.dart';
import 'package:flutter/material.dart';

class TablePage extends StatefulWidget {
  @override
  _TablePageState createState() => _TablePageState();
}

class _TablePageState extends State<TablePage> {

  final List<TableShop> _table = [];

  @override
  initState() {
    super.initState();
      FirebaseDatabase.instance.reference().child("table").onValue.listen((event) {
        DataSnapshot snapshot = event.snapshot;

        var KEYS = snapshot.value.keys;
        var DATA = snapshot.value;

        _table.clear();

        for (var individualKey in KEYS) {
          TableShop table = new TableShop(
              name: DATA[individualKey]['name'],
              isActive: DATA[individualKey]['isActive']
          );
          _table.add(table);
        }

        _table.sort((a,b)=>a.name.compareTo(b.name));

        setState(() {
          print('Length: $_table.length');
        });
      });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        padding: EdgeInsets.only(left: 20.0, right: 20.0, top: 10.0),
        children: <Widget>[
          Column(
            children: _table.map(_buildTableItem).toList(),
          )
        ],
      ),
    );
  }

  Widget _buildTableItem(TableShop table) {
    return Container(
      margin: EdgeInsets.only(bottom: 20.0),
      child: TableCard(
          name: table.name,
      ),
    );
  }
}
