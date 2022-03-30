import 'package:flutter/material.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:animated_text_kit/animated_text_kit.dart';
import 'apis.dart';

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
      backgroundColor: Colors.red,
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          print("Clicked!");
        },
        child: Icon(Icons.qr_code_2_rounded),
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
                rollNo,
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
            ListTile(
              leading: Icon(Icons.list),
              title: Text('Students'),
              onTap: () {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) => Api(),
                  ),
                );
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
                SizedBox(
                  child: QrImage(
                    embeddedImage: NetworkImage(
                      "https://avatas1.githubusercontent.com/u/41328571?s=280&v=4",
                    ),
                    data: rollNo,
                    gapless: true,
                  ),
                  width: 200,
                ),
                SizedBox(
                  height: 20,
                ),
                Text(
                  "Welcome",
                  style: TextStyle(
                      fontSize: 24,
                      color: Colors.black,
                      // fontStyle: FontStyle.,
                      fontWeight: FontWeight.bold,
                      letterSpacing: 3),
                ),
                // Text(
                //   rollNo,
                //   style: TextStyle(
                //     fontSize: 24,
                //     color: Colors.black,
                //     // fontStyle: FontStyle.,
                //     fontWeight: FontWeight.bold,
                //     letterSpacing: 3,
                //   ),
                // ),

                DefaultTextStyle(
                  style: TextStyle(
                    fontSize: 24.0,
                    color: Colors.black,
                    fontFamily: 'Agne',
                    letterSpacing: 3,
                  ),
                  child: AnimatedTextKit(
                    animatedTexts: [
                      TypewriterAnimatedText(
                        rollNo,
                        speed: Duration(milliseconds: 40),
                      ),
                    ],
                    onTap: () {
                      print("Tap Event");
                    },
                  ),
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
      backgroundColor: Colors.red,
      body: Column(
        children: [
          Expanded(
            child: Container(
              // Half of the device height.
              // height: 200.0,
              margin: EdgeInsets.only(top: 20.0),
              decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(160),
                  topRight: Radius.circular(160),
                ),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: <Widget>[
                  Padding(
                    padding: EdgeInsets.only(
                      top: 20,
                    ),
                    child: Center(
                      child: CircleAvatar(
                        foregroundImage: NetworkImage(
                            // Add better image.
                            "https://source.unsplash.com/300x300/?profile"),
                        radius: 100,
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 80.0,
                  ),
                  Card(
                    elevation: 10.0,
                    child: Container(
                      height: 200,
                      width: 400,
                      color: Colors.redAccent,
                      child: Column(
                        children: [
                          SizedBox(
                            height: 20,
                          ),
                          Text(
                            "Neesham",
                            style: TextStyle(
                                fontSize: 24.0,
                                letterSpacing: 2.0,
                                fontWeight: FontWeight.w400),
                          ),
                          SizedBox(
                            height: 20.0,
                          ),
                          Text(
                            "20001015043",
                            style: TextStyle(
                                fontSize: 18.0,
                                letterSpacing: 2.0,
                                fontWeight: FontWeight.w300),
                          ),
                          SizedBox(
                            height: 20.0,
                          ),
                          Text(
                            "Student at YMCA",
                            style: TextStyle(
                              fontSize: 18.0,
                              letterSpacing: 2.0,
                              fontWeight: FontWeight.w400,
                              // color: Colors.green[400],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
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
