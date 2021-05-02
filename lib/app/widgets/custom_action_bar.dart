import 'package:flutter/material.dart';

class CustomActionBar extends StatelessWidget {
  final String title;
  final bool hasTitle;
  final bool hasBackground;

  CustomActionBar({this.title, this.hasTitle, this.hasBackground});
  @override
  Widget build(BuildContext context) {
    bool _hasBackground = hasBackground ?? true;
    bool _hasTitle = hasTitle ?? true;
    return Container(
      decoration: BoxDecoration(
          gradient: _hasBackground
              ? LinearGradient(colors: [
                  Colors.white,
                  Colors.white.withOpacity(0),
                ], begin: Alignment(0, 0), end: Alignment(0, 1))
              : null),
      padding: EdgeInsets.only(
        top: 30.0,
        left: 24.0,
        right: 24.0,
        bottom: 24.0,
      ),
      child: Row(
        children: [
          if (_hasTitle)
            Text(
              title ?? 'ActionBar',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
        ],
      ),
    );
  }
}
