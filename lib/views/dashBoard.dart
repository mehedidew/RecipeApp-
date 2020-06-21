import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:recipeapp/controller/all_recipes_api.dart';
import 'package:recipeapp/controller/todays_recipe_api.dart';
import 'package:recipeapp/customWidget/drawer.dart';
import 'package:shared_preferences/shared_preferences.dart';

class DashBoard extends StatefulWidget {
  @override
  _DashBoardState createState() => _DashBoardState();
}

class _DashBoardState extends State<DashBoard> {
  var scaffoldKey = GlobalKey<ScaffoldState>();
  String token;

  @override
  void initState() {
    getToken();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: _onBackPressed,
      child: Scaffold(
        key: scaffoldKey,
        drawer: AppDrawer(
          currentRoute: '/dashboard',
        ),
//      appBar: AppBar(
//        title: Text('Recipe App'),
//      ),
        body: SingleChildScrollView(
          physics: NeverScrollableScrollPhysics(),
          child: Column(
            children: <Widget>[
              Stack(
                children: <Widget>[
                  Container(
                    height: 200,
                    color: Colors.blueGrey[50],
                  ),
                  //=================search bar ============================
                  Column(
                    children: <Widget>[
                      Padding(
                        padding: EdgeInsets.only(
                            left: 15, top: 35, right: 15, bottom: 10),
                        child: Material(
                          elevation: 10,
                          borderRadius: BorderRadius.circular(25),
                          child: TextFormField(
                            decoration: InputDecoration(
                              border: InputBorder.none,
                              prefixIcon: Icon(
                                Icons.search,
                                color: Colors.black,
                              ),
                              contentPadding:
                                  EdgeInsets.only(left: 15, top: 15),
                              hintText: 'Search',
                            ),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 15,
                      ),
                      //====================popular recipe text====================================

                      Padding(
                        padding: EdgeInsets.only(left: 15),
                        child: Container(
                          padding: EdgeInsets.only(left: 10),
                          decoration: BoxDecoration(
                            border: Border(
                                left: BorderSide(
                                    color: Colors.orange,
                                    style: BorderStyle.solid,
                                    width: 3)),
                          ),
                          child: Row(
                            children: <Widget>[
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: <Widget>[
                                  Text(
                                    'Popular Recipes',
                                    style: TextStyle(
                                        fontSize: 20,
                                        fontFamily: 'Timesroman',
                                        fontWeight: FontWeight.bold),
                                  ),
                                ],
                              )
                            ],
                          ),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.only(bottom: 15),
                      ),

                      //=====================popular recipe list===================================
                      Container(
                        padding: EdgeInsets.only(
                          top: 10,
                        ),
                        height: 125,
                        child: FutureBuilder(
                          future: AllRecipesApi(token).fetchData(),
                          builder:
                              (BuildContext context, AsyncSnapshot snapshot) {
                            if (snapshot.connectionState ==
                                ConnectionState.done) {
                              if (snapshot.data == null) {
                                return Container(
                                  child: Center(
                                    child: Container(
                                      height: 125,
                                      width: 250,
                                      decoration: BoxDecoration(
                                          color: Colors.white,
                                          borderRadius:
                                              BorderRadius.circular(12)),
                                    ),
                                  ),
                                );
                              } else {
                                return ListView.builder(
                                    shrinkWrap: true,
                                    scrollDirection: Axis.horizontal,
                                    itemCount: snapshot.data.length,
                                    itemBuilder:
                                        (BuildContext context, int index) {
                                      return InkWell(
                                        onTap: () => Navigator.of(context)
                                            .pushNamed('/showRecipe',
                                                arguments: (snapshot.data[index]
                                                    ['id'])),
                                        child: Padding(
                                          padding:
                                              const EdgeInsets.only(left: 20.0),
                                          child: Container(
                                            height: 125,
                                            width: 250,
                                            decoration: BoxDecoration(
                                                color: Colors.white,
                                                borderRadius:
                                                    BorderRadius.circular(12)),
                                            child: Row(
                                              children: <Widget>[
                                                Padding(
                                                  padding:
                                                      const EdgeInsets.only(
                                                          left: 10),
                                                  child: Container(
                                                    decoration: BoxDecoration(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              32),
                                                      image: DecorationImage(
                                                          image: NetworkImage(
                                                              snapshot.data[
                                                                      index][
                                                                  'recipeImage'])),
                                                    ),
                                                    height: 125,
                                                    width: 100,
                                                  ),
                                                ),
                                                SizedBox(
                                                  width: 10,
                                                ),
                                                Column(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.center,
                                                  children: <Widget>[
                                                    Container(
                                                      width: 100,
                                                      child: Text(
                                                        snapshot.data[index]
                                                            ['title'],
                                                        overflow: TextOverflow
                                                            .ellipsis,
//                                    textAlign: TextAlign.justify,
                                                        maxLines: 3,
                                                        style: TextStyle(
                                                            fontFamily:
                                                                'Quicksand'),
                                                      ),
                                                    ),
                                                    SizedBox(
                                                      height: 10,
                                                    ),
                                                    Container(
                                                      height: 1,
                                                      width: 75,
                                                      color: Colors.orange,
                                                    ),
                                                    SizedBox(
                                                      height: 10,
                                                    ),
                                                    Container(
                                                      width: 100,
                                                      child: Center(
                                                        child: Text(
                                                          snapshot.data[index]
                                                              ['sourceName'],

                                                          overflow: TextOverflow
                                                              .ellipsis,
//                                    textAlign: TextAlign.justify,
                                                          maxLines: 2,
                                                          style: TextStyle(
                                                              fontSize: 12,
                                                              fontFamily:
                                                                  'Quicksand'),
                                                        ),
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ],
                                            ),
                                          ),
                                        ),
                                      );
                                    });
                              }
                            } else {
                              return Container(
                                child: Center(
                                  child: Container(
                                    height: 25,
                                    width: 25,
                                    decoration: BoxDecoration(
                                        color: Colors.white,
                                        borderRadius:
                                            BorderRadius.circular(12)),
                                    child: CircularProgressIndicator(),
                                  ),
                                ),
                              );
                            }
                          },
                        ),
                      ),
                    ],
                  ),
                ],
              ),
              SizedBox(
                height: 15,
              ),

              //======================todays recipe text=====================
              Padding(
                padding: EdgeInsets.only(left: 15),
                child: Container(
                  padding: EdgeInsets.only(left: 10),
                  decoration: BoxDecoration(
                    border: Border(
                        left: BorderSide(
                            color: Colors.orange,
                            style: BorderStyle.solid,
                            width: 3)),
                  ),
                  child: Row(
                    children: <Widget>[
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Text(
                            'Today\'s Recipe',
                            style: TextStyle(
                                fontSize: 20,
                                fontFamily: 'Timesroman',
                                fontWeight: FontWeight.bold),
                          ),
                        ],
                      )
                    ],
                  ),
                ),
              ),

              //=======================today's recipe list========================
              Container(
                height: 1000,
                child: FutureBuilder(
                  future: TodaysRecipesApi(token).fetchData(),
                  builder: (BuildContext context, AsyncSnapshot snapshot) {
                    if (snapshot.connectionState == ConnectionState.done) {
                      if (snapshot.data == null) {
                        return Container(
                          child: Center(
                            child: Container(
                              height: 125,
                              width: 250,
                              decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(12)),
                            ),
                          ),
                        );
                      } else {
                        return ListView.builder(
                            itemCount: snapshot.data.length,
                            itemBuilder: (BuildContext context, int index) {
                              return Stack(
                                children: <Widget>[
                                  Padding(
                                    padding: EdgeInsets.only(
                                        left: 12, right: 12, top: 15),
                                    child: Container(
                                      height: 275,
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(15),
                                        image: DecorationImage(
                                            image: NetworkImage(snapshot
                                                .data[index]['recipeImage']),
                                            fit: BoxFit.cover),
                                      ),
                                      child: ClipRect(
                                        child: BackdropFilter(
                                          filter: ImageFilter.blur(
                                              sigmaX: 1.5, sigmaY: 1.5),
                                          child: Container(
                                            decoration: BoxDecoration(
                                              color:
                                                  Colors.white.withOpacity(0.1),
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                  Container(
                                    padding: EdgeInsets.only(
                                        top: 150, left: 60, right: 30),
                                    child: Column(
                                      children: <Widget>[
                                        Text(
                                          snapshot.data[index]['title'],
                                          overflow: TextOverflow.ellipsis,
//                                    textAlign: TextAlign.justify,
                                          maxLines: 3,
                                          style: TextStyle(
                                              fontFamily: 'Timesroman',
                                              fontSize: 30,
                                              fontWeight: FontWeight.bold,
                                              shadows: [
                                                Shadow(
                                                  blurRadius: 4.0,
                                                  color: Colors.black54,
                                                  offset: Offset(2.0, 2.0),
                                                ),
                                              ],
                                              color: Colors.white),
                                        ),
                                        SizedBox(
                                          height: 10,
                                        ),
                                        Container(
                                          height: 3,
                                          width: 75,
                                          color: Colors.orange,
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              );
                            });
                      }
                    } else {
                      return Container(
                        child: Center(
                          child: CircularProgressIndicator(),
                        ),
                      );
                    }
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<bool> _onBackPressed() {
    return showDialog(
        context: context,
        builder: (context) => AlertDialog(
              title: Text('Do you want to Exit?'),
              actions: <Widget>[
                FlatButton(
                    onPressed: () {
                      SystemChannels.platform
                          .invokeMethod('SystemNavigator.pop');
                    },
                    child: Text('Yes')),
                FlatButton(
                    onPressed: () => Navigator.pop(context, false),
                    child: Text('No')),
              ],
            ));
  }

  void getToken() async {
    SharedPreferences pref = await SharedPreferences.getInstance();

    setState(() {
      token = pref.getString('TOKEN');
    });
    print(token);
  }
}
