import 'package:flutter/material.dart';
import 'package:loginsql/main.dart';

class MyHome extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("HOME PAGE"),
        centerTitle: true,
      ),
      body: Center(
        child: Container(
            margin: EdgeInsets.only(top: 20),
            width: 200,
            decoration: BoxDecoration(
                color: Colors.black, borderRadius: BorderRadius.circular(50)),
            child: ElevatedButton(
              child: Text(
                "Logout",
                style: TextStyle(fontSize: 30, color: Colors.white),
              ),
              onPressed: () async {
                Navigator.of(context)
                    .push(MaterialPageRoute(builder: (context) => MyApp()));
              },
            )),
      ),
    );
  }
}
