import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:recipeapp/controller/login_api.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  TextEditingController _email = TextEditingController();
  TextEditingController _password = TextEditingController();

  String email, password;
  String token;
  bool loading = false;

  _goToDashBoard(val) async {
    if (LoginApi.response == 'success') {
      setState(() {
        loading = false;
      });
      Navigator.pushNamed(context, '/dashboard', arguments: (val));
    } else {
      setState(() {
        loading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: SingleChildScrollView(
          child: Column(
            children: <Widget>[
              Container(
                height: 400,
                decoration: BoxDecoration(
                    image: DecorationImage(
                        fit: BoxFit.fill,
                        image: AssetImage('images/background.png'))),
                child: Stack(
                  children: <Widget>[
                    Positioned(
                      left: 30,
                      height: 200,
                      width: 80,
                      child: Container(
                        decoration: BoxDecoration(
                            image: DecorationImage(
                                image: AssetImage('images/light-1.png'))),
                      ),
                    ),
                    Positioned(
                        left: 140,
                        height: 150,
                        width: 80,
                        child: Container(
                          decoration: BoxDecoration(
                              image: DecorationImage(
                                  image: AssetImage('images/light-2.png'))),
                        )),
                    Positioned(
                      right: 40,
                      top: 40,
                      height: 150,
                      width: 80,
                      child: Container(
                        decoration: BoxDecoration(
                          image: DecorationImage(
                            image: AssetImage('images/clock.png'),
                          ),
                        ),
                      ),
                    ),
                    Positioned(
                      child: Container(
                        margin: EdgeInsets.only(top: 50),
                        child: Center(
                          child: Text(
                            'Login',
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 30,
                                fontWeight: FontWeight.bold),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: EdgeInsets.only(left: 30, right: 30, bottom: 30),
                child: Column(
                  children: <Widget>[
                    Visibility(
                        visible: loading,
                        child: LinearProgressIndicator(
                          valueColor:
                              AlwaysStoppedAnimation<Color>(Colors.blue),
                        )),
                    Container(
                      padding: EdgeInsets.all(5),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(10),
                        boxShadow: [
                          BoxShadow(
                              color: Color.fromRGBO(143, 148, 251, .5),
                              blurRadius: 20,
                              offset: Offset(0, 10))
                        ],
                      ),
                      child: Column(
                        children: <Widget>[
                          Container(
                            padding: EdgeInsets.all(8),
                            decoration: BoxDecoration(
                                border: Border(
                                    bottom:
                                        BorderSide(color: Colors.grey[100]))),
                            child: TextField(
                              controller: _email,
                              decoration: InputDecoration(
                                border: InputBorder.none,
                                hintText: 'Email',
                                hintStyle: TextStyle(color: Colors.grey[400]),
                              ),
                              onChanged: (text) {
                                email = text;
                              },
                            ),
                          ),
                          Container(
                            padding: EdgeInsets.all(8),
                            child: TextField(
                              controller: _password,
                              decoration: InputDecoration(
                                border: InputBorder.none,
                                hintText: 'Password',
                                hintStyle: TextStyle(color: Colors.grey[400]),
                              ),
                              onChanged: (text) {
                                password = text;
                              },
                            ),
                          ),
                          SizedBox(
                            height: 30,
                          ),
                          InkWell(
                            onTap: () async {
                              LoginApi(email, password)
                                  .fetchData()
                                  .then((value) {
                                _goToDashBoard(value);
                              });

                              setState(() {
                                loading = true;
                              });
                            },
                            child: Container(
                              height: 50,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10),
                                  gradient: LinearGradient(colors: [
                                    Color.fromRGBO(143, 148, 251, 1),
                                    Color.fromRGBO(143, 148, 251, .5)
                                  ])),
                              child: Center(
                                child: Text(
                                  'Login',
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
