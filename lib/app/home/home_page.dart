import 'package:e_commerceapp/app/common_widgets/show_alert_dialog.dart';
import 'package:e_commerceapp/app/home/cart_page.dart';
import 'package:e_commerceapp/app/tabs/home_tab.dart';
import 'package:e_commerceapp/app/tabs/saved_tab.dart';
import 'package:e_commerceapp/app/tabs/search_tab.dart';
import 'package:e_commerceapp/app/widgets/bottom_tabs.dart';
import 'package:e_commerceapp/services/auth.dart';
import 'package:e_commerceapp/services/firestore_service.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  FirestoreService _firebaseService = FirestoreService();
  PageController _tabsPageController;
  int _selectedTabs = 0;

  @override
  void initState() {
    print("UserId: ${_firebaseService.getUserId()}");
    _tabsPageController = PageController();
    super.initState();
  }

  @override
  void dispose() {
    _tabsPageController.dispose();
    super.dispose();
  }

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
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            child: PageView(
              controller: _tabsPageController,
              onPageChanged: (num) {
                setState(() {
                  _selectedTabs = num;
                });
              },
              children: [
                HomeTab(),
                SavedTab(),
                SearchTab(),
              ],
            ),
          ),
          BottomTabs(
            seletecdTab: _selectedTabs,
            tabPressed: (num) {
              _tabsPageController.animateToPage(num,
                  duration: Duration(milliseconds: 300),
                  curve: Curves.easeOutCubic);
            },
          )
        ],
      ),
    );
  }
}
