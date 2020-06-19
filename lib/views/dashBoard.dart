import 'package:flutter/material.dart';
import 'package:recipeapp/customWidget/drawer.dart';

class DashBoard extends StatefulWidget {
  @override
  _DashBoardState createState() => _DashBoardState();
}

class _DashBoardState extends State<DashBoard> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: AppDrawer(
        currentRoute: '/dashboard',
      ),
      appBar: AppBar(
        title: Text('Recipe App'),
      ),
      body: Column(
        children: <Widget>[
          Stack(
            children: <Widget>[
              Container(
                height: 250,
              )
            ],
          ),
        ],
      ),
    );
  }
}
