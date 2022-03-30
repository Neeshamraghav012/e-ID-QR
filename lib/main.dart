// ignore_for_file: dead_code

import 'dart:convert';
import 'package:flutter/material.dart';
import 'QRScreen.dart';
import 'dart:async';
import 'package:http/http.dart' as http;
import 'apis.dart';
import 'models.dart';

void main() {
  runApp(MaterialApp(
    theme: ThemeData(),
    home: Splash(),
    debugShowCheckedModeBanner: false,
  ));
}

// Splash Screen.
class Splash extends StatefulWidget {
  @override
  State<Splash> createState() => _SplashState();
}

class _SplashState extends State<Splash> {
  @override
  void initState() {
    super.initState();
    Timer(
        Duration(seconds: 3),
        () => Navigator.pushReplacement(
            context,
            MaterialPageRoute(
              builder: (context) => MyApp(),
            )));
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      child: Icon(Icons.qr_code_2_rounded, size: 100, color: Colors.red),
    );
  }
}

// Login Screen
class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> with SingleTickerProviderStateMixin {
  TextEditingController _user = TextEditingController();
  TextEditingController _password = TextEditingController();

  // Animation utilities
  AnimationController controller;
  Animation animation;

  @override
  void initState() {
    super.initState();

    controller = AnimationController(
      vsync: this,
      duration: Duration(seconds: 3),
      lowerBound: 0.0,
      upperBound: 80.0,
    );

    animation = CurvedAnimation(parent: controller, curve: Curves.decelerate);

    controller.forward();

    controller.addListener(() {
      setState(() {});
      print(controller.value);
    });
  }

  // Dispose the controller after the animation completetion.
  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  String password;
  String name;
  String rollNo;
  String avatar;
  String qrdata;

  // Variable to keep track of errors.
  bool error = false;

  // Function to fetch data from ERP Api.
  void getData() async {
    var credential = {
      "rollNo.": rollNo,
      "password": password,
    };
    http.Response response = await http.post(
      Uri.parse('https://id-card-jcbose.herokuapp.com/login'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8'
      },
      body: jsonEncode(credential),
    );

    if (response.statusCode == 200) {
      String data = response.body;
      name = jsonDecode(data)['data']['name'];
      avatar = jsonDecode(data)['data']['avatar'];
      qrdata = jsonDecode(data)['data']['qrCode'];
      rollNo = jsonDecode(data)['data']['rollNumber'];
    } else {
      setState(() {
        error = true;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.redAccent,
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: Hero(
                tag: 'logo',
                child: Container(
                  child: Icon(
                    Icons.qr_code_2_rounded,
                    size: controller.value,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(12.0),
              child: Text("e-ID",
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 50.0,
                      fontWeight: FontWeight.w700)),
            ),
            SizedBox(
              height: 50.0,
            ),
            Expanded(
              child: Container(
                decoration: const BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(15),
                    topRight: Radius.circular(15),
                  ),
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: TextField(
                        textAlign: TextAlign.center,
                        controller: _user,
                        keyboardType: TextInputType.number,
                        decoration: InputDecoration(
                            border: OutlineInputBorder(),
                            labelText: 'Enter roll no.'),
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: TextField(
                        textAlign: TextAlign.center,
                        controller: _password,
                        obscureText: true,
                        decoration: InputDecoration(
                          border: OutlineInputBorder(),
                          labelText: 'Enter Password',
                          iconColor: Colors.white,
                        ),
                      ),
                    ),
                    ElevatedButton(
                      onPressed: () {
                        setState(() {
                          rollNo = _user.text;
                          password = _password.text;
                        });
                        // Removing login for testing.
                        if (true) {
                          Navigator.of(context).push(MaterialPageRoute(
                              builder: (context) => GeneratePage(
                                    rollNo: rollNo,
                                    avatar: avatar,
                                    name: name,
                                    qrdata: qrdata,
                                  )));
                        } else {
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: Text(
                                "Invalid Credential.",
                                style: TextStyle(
                                  color: Colors.red,
                                ),
                              ),
                              behavior: SnackBarBehavior.floating,
                            ),
                          );
                        }
                      },
                      style: ElevatedButton.styleFrom(
                        primary: Colors.red,
                      ),
                      child: Text('Log in'),
                    )
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
