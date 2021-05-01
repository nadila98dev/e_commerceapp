import 'package:e_commerceapp/app/common_widgets/show_alert_dialog.dart';
import 'package:e_commerceapp/app/home/cart_page.dart';
import 'package:e_commerceapp/app/widgets/category.dart';
import 'package:e_commerceapp/models/productss.dart';
import 'package:e_commerceapp/services/auth.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';

class HomePage extends StatelessWidget {
  Future<void> _signOut(BuildContext context) async {
    try {
      final auth = Provider.of<AuthBase>(context, listen: false);
      await auth.signOut();
    } catch (e) {
      print.toString();
    }
  }

  Future<void> _confirmSignOut(BuildContext context) async {
    final didRequestSignOut = await showAlertDialog(context,
        title: 'Sign out',
        content: 'Are you sure you want to sign out ?',
        cancelActionText: 'Cancel',
        defaultActionText: 'Yes');
    if (didRequestSignOut == true) {
      _signOut(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text('Home'),
        actions: <Widget>[
          IconButton(
              icon: new Icon(
                FontAwesomeIcons.shoppingCart,
                color: Colors.white,
              ),
              onPressed: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => CartPage()));
              }),
          FlatButton(
              onPressed: () => _confirmSignOut(context),
              child: Text(
                'Sign Out',
                style: TextStyle(color: Colors.white, fontSize: 18.0),
              ))
        ],
      ),
      body: ListView(
        children: <Widget>[
          SizedBox(height: 8.0),
          Center(
            child: Text(
              'Categories',
              style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold),
            ),
          ),
          SizedBox(height: 8.0),
          Category(),
          SizedBox(height: 8.0),
          Center(
            child: Text(
              'Products',
              style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold),
            ),
          ),
          SizedBox(height: 8.0),
          Container(
            height: 450,
            child: Productss(),
          )
        ],
      ),
    );
  }
}
