import 'package:flutter/material.dart';
import 'package:qr_flutter/qr_flutter.dart';

// QR code Screen.
class GeneratePage extends StatelessWidget {
  String rollNo;
  String name;
  String avatar;
  String qrdata;
  GeneratePage(
      {@required this.rollNo,
      @required this.avatar,
      @required this.name,
      @required this.qrdata});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('e-ID'),
        centerTitle: true,
        backgroundColor: Colors.red,
      ),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: <Widget>[
            DrawerHeader(
              decoration: BoxDecoration(
                color: Colors.red,
              ),
              child: Text(
                'Neesham',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 24,
                ),
              ),
            ),
            ListTile(
              leading: Icon(Icons.account_circle),
              title: Text('Profile'),
              onTap: () {
                Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) => Settings(
                        rollNo: rollNo,
                        name: name,
                        avatar: avatar,
                        qrdata: qrdata)));
              },
            ),
            ListTile(
              leading: Icon(Icons.settings),
              title: Text('Settings'),
              onTap: () {
                Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) => Settings(
                        rollNo: rollNo,
                        name: name,
                        avatar: avatar,
                        qrdata: qrdata)));
              },
            ),
          ],
        ),
      ),
      body: Center(
        child: Card(
          elevation: 40.0,
          child: Container(
            width: 300.0,
            height: 600.0,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Hero(
                  tag: 'logo',
                  child: Container(
                    child: Icon(
                      Icons.qr_code_2_rounded,
                      size: 100,
                      color: Colors.red,
                    ),
                  ),
                ),
                SizedBox(
                  height: 50,
                  child: Text(
                    ((name != null) ? "Welcome $name" : "Welcome Neesham"),
                    style: TextStyle(
                        fontSize: 24,
                        color: Colors.black,
                        // fontStyle: FontStyle.,
                        fontWeight: FontWeight.bold,
                        letterSpacing: 3),
                  ),
                ),
                SizedBox(
                  child: QrImage(
                    embeddedImage: NetworkImage(
                      "https://avatas1.githubusercontent.com/u/41328571?s=280&v=4",
                    ),
                    data: "Neesham",
                    gapless: true,
                  ),
                  width: 200,
                ),
                SizedBox(
                  height: 50,
                ),
                ElevatedButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  style: ElevatedButton.styleFrom(
                    primary: Colors.red,
                  ),
                  child: Text('Go Back'),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}

// User Profile Screen.
class Settings extends StatelessWidget {
  String rollNo;
  String name;
  String avatar;
  String qrdata;

  Settings(
      {@required this.rollNo,
      @required this.avatar,
      @required this.name,
      @required this.qrdata});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('e-ID'),
        centerTitle: true,
        backgroundColor: Colors.red,
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Center(
            child: CircleAvatar(
              foregroundImage: NetworkImage(
                  "https://res.cloudinary.com/dzqbzqgjw/image/upload/v1569098981/avatar_default_yqxzqe.png"),
              radius: 100,
            ),
          ), //CircleAvatar
          SizedBox(
            height: 40.0,
          ),
          Card(
              elevation: 20.0,
              child: Container(
                  width: 350.0,
                  height: 200.0,
                  child: Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: SizedBox(
                          height: 50,
                          child: ReText("Name", "Neesham"),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: SizedBox(
                          height: 50,
                          child: ReText("Roll No.", "20001015043"),
                        ),
                      ),
                    ],
                  ))),
        ],
      ),
    );
  }
}

// ReUsable widget for text.
class ReText extends StatelessWidget {
  
  String fieldName;
  String data;
  ReText(this.fieldName, this.data);

  @override
  Widget build(BuildContext context) {
    return Text(
      "$fieldName: $data",
      style: TextStyle(
          fontSize: 20,
          color: Colors.black,
          // fontStyle: FontStyle.italic,
          letterSpacing: 3),
    );
  }
}
