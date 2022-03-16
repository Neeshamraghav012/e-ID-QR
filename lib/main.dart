import 'dart:convert';

import 'package:flutter/material.dart';
import 'generate.dart';
import 'package:http/http.dart' as http;

void main() {
  runApp(MaterialApp(
    home: MyApp(),
    debugShowCheckedModeBanner: false,
  ));
}

// Login Screen
class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  TextEditingController _user = TextEditingController();
  TextEditingController _password = TextEditingController();

  String username;
  String loginpass;
  bool error = false;
  String name;
  String rollNo;
  String avatar;
  String qrdata;

  void getData() async {
    var credential = {
      "user": username,
      "password": loginpass,
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

  final GlobalKey<ScaffoldState> _scaffoldkey = new GlobalKey<ScaffoldState>();
  @override
  Widget build(BuildContext context) {
    getData();
    return Scaffold(
      key: _scaffoldkey,
      backgroundColor: Colors.redAccent,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Hero(
                tag: 'logo',
                child: Container(
                  child: Icon(
                    Icons.qr_code_2_rounded,
                    size: 100,
                    color: Colors.white,
                  ),
                ),
              ),
              Text("e-ID",
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 50.0,
                      fontWeight: FontWeight.w700)),
              SizedBox(
                height: 50.0,
              ),
              Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Padding(
                      padding: EdgeInsets.all(8.0),
                      child: TextField(
                        textAlign: TextAlign.center,
                        controller: _user,
                        keyboardType: TextInputType.name,
                        decoration: InputDecoration(
                            border: OutlineInputBorder(),
                            labelText: 'Enter Username'),
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Padding(
                      padding: EdgeInsets.all(8.0),
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
                          username = _user.text;
                          loginpass = _password.text;
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
            ],
          ),
        ),
      ),
    );
  }
}
