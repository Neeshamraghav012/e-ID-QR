import 'package:flutter/material.dart';
import 'package:qr_flutter/qr_flutter.dart';

// QR code Screen.
class GeneratePage extends StatelessWidget {
  var rollNo;
  var name;
  var avatar;
  var qrdata;
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
                '$name',
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
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
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
          // Hero(
          //   tag: 'logo',
          //   child: Container(
          //     child: CircleAvatar(
          //       backgroundImage: NetworkImage(avatar == null
          //           ? 'https://lh3.googleusercontent.com/a-/AAuE7mChgTiAe-N8ibcM3fB_qvGdl2vQ9jvjYv0iOOjB=s96-c'
          //           : avatar),
          //       radius: 100,
          //     ),
          //   ),
          // ),
          // Center(
          //   child: CircleAvatar(
          //     backgroundImage: NetworkImage(avatar == null
          //         ? 'https://lh3.googleusercontent.com/a-/AAuE7mChgTiAe-N8ibcM3fB_qvGdl2vQ9jvjYv0iOOjB=s96-c'
          //         : avatar),
          //     radius: 100,
          //   ),
          // ), //CircleAvatar

          Padding(
            padding: const EdgeInsets.all(16.0),
            child: SizedBox(
              height: 50,
              child: Text(
                "Welcome $name",
                style: TextStyle(
                    fontSize: 24,
                    color: Colors.redAccent,
                    fontStyle: FontStyle.italic,
                    letterSpacing: 3),
              ),
            ),
          ),
          SizedBox(
            child: (rollNo == null)
                ? Center(child: Text("enter sometext to display qr code..."))
                : QrImage(
                    embeddedImage: NetworkImage(
                      "https://avatas1.githubusercontent.com/u/41328571?s=280&v=4",
                    ),
                    data: qrdata,
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
    );
  }
}

// User Profile Screen.
class Settings extends StatelessWidget {
  var rollNo;
  var name;
  var avatar;
  var qrdata;

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

          Padding(
            padding: const EdgeInsets.all(16.0),
            child: SizedBox(
              height: 50,
              child: ReText("Name: ", name),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: SizedBox(
              height: 50,
              child: ReText("Roll No.: ", rollNo),
            ),
          ),
        ],
      ),
    );
  }
}

// ReUsable widget for text.
class ReText extends StatelessWidget {
  // const Text({ Key? key }) : super(key: key);
  String fieldName;
  String data;
  ReText(this.fieldName, this.data);

  @override
  Widget build(BuildContext context) {
    return Text(
      "$fieldName: $data",
      style: TextStyle(
          fontSize: 20,
          color: Colors.black87,
          fontStyle: FontStyle.italic,
          letterSpacing: 3),
    );
  }
}
