import 'package:flutter/material.dart';

class BottomTabs extends StatefulWidget {
  final int seletecdTab;
  final Function(int) tabPressed;
  BottomTabs({this.seletecdTab, this.tabPressed});
  @override
  _BottomTabsState createState() => _BottomTabsState();
}

class _BottomTabsState extends State<BottomTabs> {
  int _selectedTabs = 0;

  @override
  Widget build(BuildContext context) {
    _selectedTabs = widget.seletecdTab ?? 0;
    return Container(
      decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(12.0),
            topRight: Radius.circular(12.0),
          ),
          boxShadow: [
            BoxShadow(
                color: Colors.black.withOpacity(0.05),
                spreadRadius: 1.0,
                blurRadius: 30.0)
          ]),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          BottomTabBtn(
            imagetabs: 'images/tab_home.png',
            selected: _selectedTabs == 0 ? true : false,
            onPressed: () {
              setState(() {
                widget.tabPressed(0);
              });
            },
          ),
          BottomTabBtn(
            imagetabs: 'images/tab_saved.png',
            selected: _selectedTabs == 1 ? true : false,
            onPressed: () {
              setState(() {
                widget.tabPressed(1);
              });
            },
          ),
          BottomTabBtn(
            imagetabs: 'images/tab_search.png',
            selected: _selectedTabs == 2 ? true : false,
            onPressed: () {
              setState(() {
                widget.tabPressed(2);
              });
            },
          ),
          BottomTabBtn(
            imagetabs: 'images/tab_search.png',
            selected: _selectedTabs == 3 ? true : false,
            onPressed: () {
              setState(() {});
            },
          ),
        ],
      ),
    );
  }
}

class BottomTabBtn extends StatelessWidget {
  final String imagetabs;
  final bool selected;
  final Function onPressed;
  BottomTabBtn({this.imagetabs, this.selected, this.onPressed});
  @override
  Widget build(BuildContext context) {
    bool _selected = selected ?? false;
    return GestureDetector(
      onTap: onPressed,
      child: Container(
        padding: EdgeInsets.symmetric(
          vertical: 20.0,
          horizontal: 24.0,
        ),
        decoration: BoxDecoration(
            border: Border(
                top: BorderSide(
                    color: _selected
                        ? Theme.of(context).accentColor
                        : Colors.transparent,
                    width: 2.0))),
        child: Image(
          image: AssetImage(imagetabs ?? 'images/tab_home.png'),
          width: 22.0,
          height: 22.0,
          color: _selected ? Theme.of(context).accentColor : Colors.black,
        ),
      ),
    );
  }
}
