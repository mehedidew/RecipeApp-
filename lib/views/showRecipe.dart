import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:recipeapp/controller/recipeDetails_api.dart';
import 'package:recipeapp/customWidget/drawer.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ShowRecipe extends StatefulWidget {
  @override
  _ShowRecipeState createState() => _ShowRecipeState();
}

class _ShowRecipeState extends State<ShowRecipe> {
  String token, id;

  @override
  void initState() {
    getToken();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    id = ModalRoute.of(context).settings.arguments;

    return WillPopScope(
      onWillPop: _onBackPressed,
      child: Scaffold(
        drawer: AppDrawer(
          currentRoute: '/showRecipe',
        ),
        body: SingleChildScrollView(
          child: FutureBuilder(
            future: RecipeDetailsApi(token, id).fetchData(),
            builder: (BuildContext context, AsyncSnapshot snapshot) {
              if (snapshot.connectionState == ConnectionState.done) {
                if (snapshot.data == null) {
                  return Container(
                    child: Center(
                      child: Container(),
                    ),
                  );
                } else {
                  return Column(
                    children: <Widget>[
                      //==========recipe image============
                      Padding(
                        padding: const EdgeInsets.only(top: 25.0),
                        child: Stack(
                          children: <Widget>[
                            Container(
                              height: 200,
                              decoration: BoxDecoration(
                                image: DecorationImage(
                                    image: NetworkImage(
                                        snapshot.data['recipeImage']),
                                    fit: BoxFit.cover),
                              ),
                              child: ClipRect(
                                child: BackdropFilter(
                                  filter: ImageFilter.blur(
                                      sigmaX: 1.5, sigmaY: 1.5),
                                  child: Container(
                                    decoration: BoxDecoration(
                                      color: Colors.white.withOpacity(0.1),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            Container(
                              padding: EdgeInsets.only(
                                  top: 100, left: 20, right: 30),
                              child: Column(
                                children: <Widget>[
                                  Text(
                                    snapshot.data['title'],
                                    overflow: TextOverflow.ellipsis,
                                    maxLines: 3,
                                    style: TextStyle(
                                        fontFamily: 'Timesroman',
                                        fontSize: 30,
                                        fontWeight: FontWeight.bold,
                                        shadows: [
                                          Shadow(
                                            blurRadius: 5.0,
                                            color: Colors.black54,
                                            offset: Offset(5.0, 5.0),
                                          ),
                                        ],
                                        color: Colors.white),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                      //==============recipe info==============
                      Padding(
                        padding: EdgeInsets.only(left: 15, top: 15),
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
                                    'Info',
                                    style: TextStyle(
                                        fontSize: 20,
                                        fontFamily: 'Timesroman',
                                        fontWeight: FontWeight.bold),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(left: 10.0),
                                    child: Column(
                                      children: <Widget>[
                                        Padding(
                                          padding:
                                              const EdgeInsets.only(top: 10),
                                          child: Text(
                                            'Servings :  ${snapshot.data['servings']}',
                                            style: TextStyle(
                                                fontSize: 16,
                                                fontStyle: FontStyle.italic),
                                          ),
                                        ),
                                        Padding(
                                          padding:
                                              const EdgeInsets.only(top: 10.0),
                                          child: Text(
                                            'Total Time :  ${snapshot.data['totalTime']}',
                                            style: TextStyle(
                                                fontSize: 16,
                                                fontStyle: FontStyle.italic),
                                          ),
                                        ),
                                        Padding(
                                          padding:
                                              const EdgeInsets.only(top: 10.0),
                                          child: Text(
                                            'Prep Time :  ${snapshot.data['prepTime']}',
                                            style: TextStyle(
                                                fontSize: 16,
                                                fontStyle: FontStyle.italic),
                                          ),
                                        ),
                                        Padding(
                                          padding:
                                              const EdgeInsets.only(top: 10.0),
                                          child: Text(
                                            'Cook Time :  ${snapshot.data['cookTime']}',
                                            style: TextStyle(
                                                fontSize: 16,
                                                fontStyle: FontStyle.italic),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              )
                            ],
                          ),
                        ),
                      ),
                      //=============recipe ingredients===============
                      Padding(
                        padding: EdgeInsets.only(left: 15, top: 15),
                        child: Container(
                          padding: EdgeInsets.only(left: 10),
                          decoration: BoxDecoration(
                            border: Border(
                                left: BorderSide(
                                    color: Colors.deepPurple,
                                    style: BorderStyle.solid,
                                    width: 3)),
                          ),
                          child: Row(
                            children: <Widget>[
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: <Widget>[
                                  Text(
                                    'Ingredients',
                                    style: TextStyle(
                                        fontSize: 20,
                                        fontFamily: 'Timesroman',
                                        fontWeight: FontWeight.bold),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(left: 10.0),
                                    child: SizedBox(
                                      height: 250,
                                      width: 200,
                                      child: Column(
                                        mainAxisSize: MainAxisSize.max,
                                        children: <Widget>[
                                          Expanded(
                                            child: ListView.builder(
                                              itemCount: snapshot
                                                  .data['ingredients'].length,
                                              itemBuilder:
                                                  (BuildContext context,
                                                      int index) {
                                                return Padding(
                                                  padding:
                                                      const EdgeInsets.only(
                                                          top: 10),
                                                  child: Text(
                                                    '${snapshot.data['ingredients'][index]['quantity']} '
                                                    '${snapshot.data['ingredients'][index]['unit']} '
                                                    '${snapshot.data['ingredients'][index]['name']} '
                                                    '(${snapshot.data['ingredients'][index]['preparation']}) ',
                                                    style: TextStyle(
                                                        fontSize: 16,
                                                        fontStyle:
                                                            FontStyle.italic),
                                                  ),
                                                );
                                              },
                                            ),
                                          )
                                        ],
                                      ),
                                    ),
                                  ),
                                ],
                              )
                            ],
                          ),
                        ),
                      ),

                      //============recipe directions====================
                      Padding(
                        padding: EdgeInsets.only(left: 15, top: 15),
                        child: Container(
                          padding: EdgeInsets.only(left: 10),
                          decoration: BoxDecoration(
                            border: Border(
                                left: BorderSide(
                                    color: Colors.blue,
                                    style: BorderStyle.solid,
                                    width: 3)),
                          ),
                          child: Row(
                            children: <Widget>[
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: <Widget>[
                                  Text(
                                    'Directions',
                                    style: TextStyle(
                                        fontSize: 20,
                                        fontFamily: 'Timesroman',
                                        fontWeight: FontWeight.bold),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(left: 10.0),
                                    child: SizedBox(
                                      height: 500,
                                      width: 350,
                                      child: Column(
                                        children: <Widget>[
                                          Expanded(
                                            child: ListView.builder(
                                              itemCount: snapshot
                                                  .data['directions'].length,
                                              itemBuilder:
                                                  (BuildContext context,
                                                      int index) {
                                                return Padding(
                                                  padding:
                                                      const EdgeInsets.only(
                                                          top: 10),
                                                  child: Column(
                                                    children: <Widget>[
                                                      Text(
                                                        'Step ${snapshot.data['directions'][index]['step']} ',
                                                        style: TextStyle(
                                                            color: Colors.blue,
                                                            fontSize: 18,
                                                            fontWeight:
                                                                FontWeight
                                                                    .bold),
                                                      ),
                                                      Padding(
                                                        padding:
                                                            const EdgeInsets
                                                                .only(top: 10),
                                                        child: Text(
                                                          '${snapshot.data['directions'][index]['directiontext']} ',
                                                          style: TextStyle(
                                                              fontSize: 16,
                                                              fontStyle:
                                                                  FontStyle
                                                                      .italic),
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                );
                                              },
                                            ),
                                          )
                                        ],
                                      ),
                                    ),
                                  ),
                                ],
                              )
                            ],
                          ),
                        ),
                      ),
                    ],
                  );
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
      ),
    );
  }

  Future<bool> _onBackPressed() {
    Navigator.popAndPushNamed(context, '/dashboard');
    return null;

    {
//      ListView.builder(
//        itemCount: snapshot.data['ingredients'].length,
//        itemBuilder: (BuildContext context, int index) {
//          return Padding(
//            padding: const EdgeInsets.only(top: 10),
//            child: Text(
////                                                '${snapshot.data['ingredients'][index][]}',
//              'haha',
//              style: TextStyle(fontSize: 16, fontStyle: FontStyle.italic),
//            ),
//          );
//        },
//      );
    }
  }

  void getToken() async {
    SharedPreferences pref = await SharedPreferences.getInstance();

    setState(() {
      token = pref.getString('TOKEN');
    });
  }
}
