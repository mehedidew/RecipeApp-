import 'package:flutter/material.dart';
import 'package:recipeapp/controller/userDetails_api.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AppDrawer extends StatefulWidget {
  final String currentRoute;

  const AppDrawer({Key key, this.currentRoute}) : super(key: key);

  @override
  _AppDrawerState createState() => _AppDrawerState();
}

String name = '';
String email = '';

class _AppDrawerState extends State<AppDrawer> {
  String current;
  String token;
  _AppDrawerState({this.current});

  @override
  void initState() {
    getUserDetails();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: <Widget>[
          _createHeader(),
        ],
      ),
    ));
  }

  _createHeader() {
    return DrawerHeader(
      margin: EdgeInsets.zero,
      padding: EdgeInsets.zero,
      decoration: BoxDecoration(
          image: DecorationImage(
              fit: BoxFit.fill,
              image: AssetImage('images/drawerBackground.jpg'))),
      child: Stack(
        children: <Widget>[
          Positioned(
            left: 20,
            top: 20,
            child: Container(
              width: 80,
              height: 80,
              decoration: BoxDecoration(
                  border: Border.all(
                    color: Colors.redAccent,
                    width: 3,
                  ),
                  shape: BoxShape.circle,
                  image: DecorationImage(
                      fit: BoxFit.fill,
                      image: NetworkImage(
                          'https://image.flaticon.com/icons/png/512/149/149071.png'))),
            ),
          ),
          Positioned(
              bottom: 30.0,
              left: 20.0,
              child: Text(name,
                  style: TextStyle(
                      shadows: [
                        Shadow(
                          blurRadius: 4.0,
                          color: Colors.black54,
                          offset: Offset(2.0, 2.0),
                        ),
                      ],
                      color: Colors.white,
                      fontSize: 16.0,
                      fontWeight: FontWeight.w500))),
          Positioned(
              bottom: 10.0,
              left: 20.0,
              child: Text(email,
                  style: TextStyle(
                      shadows: [
                        Shadow(
                          blurRadius: 4.0,
                          color: Colors.black54,
                          offset: Offset(2.0, 2.0),
                        ),
                      ],
                      color: Colors.white,
                      fontSize: 16.0,
                      fontWeight: FontWeight.w500))),
        ],
      ),
    );
  }

  void getUserDetails() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    token = pref.get('TOKEN');
    UserDetails(token).fetchData().whenComplete(() => setData());
  }

  void setData() {
    setState(() {
      name = UserDetails.uName;
      email = UserDetails.uEmail;
    });
  }
}
