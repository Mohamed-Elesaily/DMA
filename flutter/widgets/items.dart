import 'package:flutter/material.dart';

class Items extends StatefulWidget {
  @override
  _ItemsState createState() => _ItemsState();
}

class _ItemsState extends State<Items> {
  String dropdownValue = 'One';
  @override
  Widget build(BuildContext context) {
    return  DropdownButton<String>(
    value: dropdownValue,
    icon: Icon(Icons.arrow_downward),
    iconSize: 24,
    elevation: 2,
    style: TextStyle(
      color: Colors.white
    ),
    underline: Container(
      height: 5,
      color: Colors.white,
    ),
    onChanged: (String newValue) {
      setState(() {
        dropdownValue = newValue;
        print(dropdownValue);
      });
    },
    items: <String>['One', 'Two', 'Free', 'Four']
      .map<DropdownMenuItem<String>>((String value) {
        return DropdownMenuItem<String>(
          value: value,
          child: Text(value),
        );
      })
      .toList(),
  );
  }
}