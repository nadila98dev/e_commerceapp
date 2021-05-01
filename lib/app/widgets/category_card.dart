import 'package:flutter/material.dart';

class CategoryCard extends StatelessWidget {
  CategoryCard({this.icon, this.name});
  final Icon icon;
  final String name;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: Container(
        width: 119,
        decoration: BoxDecoration(
            color: Colors.white,
            boxShadow: [BoxShadow(blurRadius: 5, color: Colors.blueGrey)]),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: <Widget>[
              icon,
              SizedBox(height: 9.0),
              Text(
                name,
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.w200),
              )
            ],
          ),
        ),
      ),
    );
  }
}
