import 'models.dart';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class Api extends StatefulWidget {
  @override
  State<Api> createState() => _ApiState();
}

class _ApiState extends State<Api> {
  // Fetching Data from api.

  Future<List<Welcome>> fetchUser() async {
    final response = await http.get(
      Uri.parse("https://jsonplaceholder.typicode.com/users"),
    );

    if (response.statusCode == 200) {
      //print(response.body);
      List jsonResponse = json.decode(response.body);
      //print(jsonResponse);
      //print(Welcome.fromJson(json.decode(response.body)[0]));
      jsonResponse.map((data) => print(data));
      return jsonResponse.map((data) => new Welcome.fromJson(data)).toList();
      // return Welcome.fromJson(json.decode(response.body)[0]);
    } else {
      throw Exception("Failed to load Users");
    }
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('e-ID'),
        centerTitle: true,
        backgroundColor: Colors.red,
      ),
      body: SafeArea(
        child: Container(
          child: FutureBuilder<List<Welcome>>(
              future: fetchUser(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.done) {
                  if (snapshot.hasError) {
                    print(snapshot.error);
                    return Center(
                      child: Text(
                        '${snapshot.error}',
                        style: TextStyle(fontSize: 18),
                      ),
                    );
                  } else if (snapshot.hasData) {
                    List<Welcome> data = snapshot.data;
                    return ListView.builder(
                      itemBuilder: (BuildContext context, int index) {
                        return Container(
                          height: 50,
                          child: Center(
                            child: Text(
                              data[index].name,
                              style: TextStyle(
                                fontFamily: 'Agne',
                                fontSize: 18,
                                letterSpacing: 3,
                              ),
                            ),
                          ),
                        );
                      },
                      itemCount: data.length,
                    );
                  }
                }
                return Center(
                  child: CircularProgressIndicator(),
                );
              }),
        ),
      ),
    );
  }
}
