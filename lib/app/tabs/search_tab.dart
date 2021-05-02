import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:e_commerceapp/app/common_widgets/constants.dart';
import 'package:e_commerceapp/app/widgets/custom_input.dart';
import 'package:e_commerceapp/app/widgets/product_card.dart';
import 'package:e_commerceapp/services/firestore_service.dart';
import 'package:flutter/material.dart';

class SearchTab extends StatefulWidget {
  @override
  _SearchTabState createState() => _SearchTabState();
}

class _SearchTabState extends State<SearchTab> {
  FirestoreService _firestoreService = FirestoreService();
  String _searchString = "";
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        if (_searchString.isEmpty)
          Center(
            child: Container(
              child: Text(
                'Search Results',
                style: Constants.regularDartText,
              ),
            ),
          )
        else
          FutureBuilder<QuerySnapshot>(
            future: _firestoreService.productsRef
                .orderBy("search_string")
                .startAfter([_searchString]).endAt(
                    ["$_searchString\uf8ff"]).get(),
            builder: (context, snapshot) {
              if (snapshot.hasError) {
                return Scaffold(
                  body: Center(
                    child: Text('Error: ${snapshot.error}'),
                  ),
                );
              }
              // Collection Data ready to display
              if (snapshot.connectionState == ConnectionState.done) {
                return ListView(
                  padding: EdgeInsets.only(top: 128.0, bottom: 12.0),
                  children: snapshot.data.docs.map((document) {
                    return ProductCard(
                      title: document.data()['name'],
                      ImageUrl: document.data()['images'][0],
                      price: "\$${document.data()['price']}",
                      productId: document.id,
                    );
                  }).toList(),
                );
              }
              return Scaffold(
                body: Center(
                  child: CircularProgressIndicator(),
                ),
              );
            },
          ),
        Padding(
          padding: const EdgeInsets.only(top: 45.0),
          child: CustomInput(
            hintText: "Search here..",
            onSubmitted: (value) {
              setState(() {
                _searchString = value.toLowerCase();
              });
            },
          ),
        ),
      ],
    );
  }
}
