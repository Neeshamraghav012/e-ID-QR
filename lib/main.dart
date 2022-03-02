import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';
import 'generate.dart';
import 'package:http/http.dart' as http;

void main() {
  runApp(MaterialApp(
    home: MyApp(),
    debugShowCheckedModeBanner: false,
  ));
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  TextEditingController _user = TextEditingController();
  TextEditingController _password = TextEditingController();

  var username;
  var loginpass;

  var name;
  var rollNo;
  var avatar;
  var qrdata;

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

    if (response.statusCode == 500) {
      print("Error");
    } else {
      String data = response.body;
      name = jsonDecode(data)['data']['name'];
      avatar = jsonDecode(data)['data']['avatar'];
      qrdata = jsonDecode(data)['data']['qrCode'];
      rollNo = jsonDecode(data)['data']['rollNumber'];
      print(name);
      print(avatar);
      print(qrdata);
      print(rollNo);
    }
  }

  @override
  Widget build(BuildContext context) {
    getData();
    return Scaffold(
      appBar: AppBar(
        title: Text("e-ID"),
        backgroundColor: Colors.red,
        centerTitle: true,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Padding(
              padding: EdgeInsets.all(8.0),
              child: TextField(
                controller: _user,
                decoration: InputDecoration(
                    border: OutlineInputBorder(), labelText: 'Enter Username'),
              ),
            ),
            SizedBox(
              height: 10,
            ),
            Padding(
              padding: EdgeInsets.all(8.0),
              child: TextField(
                controller: _password,
                obscureText: true,
                decoration: InputDecoration(
                    border: OutlineInputBorder(), labelText: 'Enter Password'),
              ),
            ),
            ElevatedButton(
              onPressed: () {
                setState(() {
                  username = _user.text;
                  loginpass = _password.text;
                });
                Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) => GeneratePage(
                          rollNo: rollNo,
                          avatar: avatar,
                          name: name,
                          qrdata: qrdata,
                        )));
              },
              style: ElevatedButton.styleFrom(
                primary: Colors.red,
              ),
              child: Text('Log in'),
            )
          ],
        ),
      ),
    );
  }
}
