import 'package:e_commerceapp/app/widgets/category_card.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class Category extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 120,
      child: ListView(
        scrollDirection: Axis.horizontal,
        children: <Widget>[
          CategoryCard(
            icon: Icon(
              FontAwesomeIcons.tshirt,
              size: 40,
              color: Colors.blue[700],
            ),
            name: 'Clolthing',
          ),
          CategoryCard(
            icon: Icon(
              FontAwesomeIcons.socks,
              size: 40,
              color: Colors.blue[700],
            ),
            name: 'Socks',
          ),
          CategoryCard(
            icon: Icon(
              FontAwesomeIcons.shoppingBag,
              size: 40,
              color: Colors.blue[700],
            ),
            name: 'Bag',
          ),
        ],
      ),
    );
  }
}
