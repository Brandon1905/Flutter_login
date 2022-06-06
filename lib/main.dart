import 'dart:math';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:loginsql/BD/users.dart';
import 'package:loginsql/Homepage.dart';
import 'package:loginsql/models/user.dart';
import 'package:loginsql/singup.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: MyHomePage(title: 'Notifications'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  TextEditingController controllerGmail;
  TextEditingController controllerPassword;
  int aux;
  @override
  void initState() {
    super.initState();
    controllerPassword = new TextEditingController();
    controllerGmail = new TextEditingController();
  }

  @override
  void dispose() {
    controllerPassword.dispose();
    controllerGmail.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.deepPurple,
      body: Container(
        decoration: BoxDecoration(boxShadow: [
          BoxShadow(
              color: Colors.deepPurple[200],
              blurRadius: 25.0,
              spreadRadius: 25.0,
              offset: Offset(15.0, 15.0))
        ], color: Colors.deepPurple, borderRadius: BorderRadius.circular(20)),
        margin: EdgeInsets.only(top: 50, left: 20, right: 20, bottom: 50),
        padding: EdgeInsets.only(left: 20, right: 20),
        child: ListView(children: [
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                Padding(
                  padding: const EdgeInsets.all(50),
                  child: CircleAvatar(
                    radius: 70,
                    child: IconButton(
                        iconSize: 110,
                        icon: const Icon(
                          Icons.person,
                          color: Colors.black,
                        ),
                        onPressed: () {
                          controllerGmail.clear();
                          controllerPassword.clear();
                        }),
                  ),
                ),
              ]),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  TextButton(
                    onPressed: () {},
                    child: const Text(
                      "SIGN IN",
                      style: TextStyle(
                          fontSize: 25,
                          fontWeight: FontWeight.bold,
                          color: Colors.white),
                    ),
                  ),
                  Text(
                    "  -  ",
                    style: TextStyle(fontSize: 25, color: Colors.black),
                  ),
                  TextButton(
                    onPressed: () async {
                      await Navigator.of(context).push(
                        MaterialPageRoute(builder: (context) => signUp()),
                      );
                    },
                    child: const Text(
                      "SIGN UP",
                      style: TextStyle(fontSize: 25, color: Colors.blueGrey),
                    ),
                  ),
                ],
              ),
              Divider(
                height: 5,
              ),
              Padding(
                padding: EdgeInsetsDirectional.fromSTEB(10, 10, 10, 5),
                child: SizedBox(
                  height: 60,
                  child: TextField(
                      style: TextStyle(fontSize: 15, color: Colors.white),
                      controller: controllerGmail,
                      decoration: InputDecoration(
                        hintStyle: TextStyle(fontSize: 15),
                        border: OutlineInputBorder(),
                        labelText: 'Gmail',
                        hintText: "Type the gmail",
                      )),
                ),
              ),
              Padding(
                padding: EdgeInsetsDirectional.fromSTEB(10, 5, 10, 15),
                child: SizedBox(
                  height: 60,
                  child: TextField(
                      style: TextStyle(fontSize: 15, color: Colors.white),
                      controller: controllerPassword,
                      obscureText: true,
                      decoration: InputDecoration(
                        hintStyle: TextStyle(fontSize: 15),
                        border: OutlineInputBorder(),
                        labelText: 'Password',
                        hintText: "Type the password",
                      )),
                ),
              ),
              Container(
                  margin: EdgeInsets.only(top: 20),
                  width: 200,
                  decoration: BoxDecoration(
                      color: Colors.black,
                      borderRadius: BorderRadius.circular(50)),
                  child: ElevatedButton(
                      child: Text(
                        "Login",
                        style: TextStyle(fontSize: 30, color: Colors.white),
                      ),
                      onPressed: () async {
                    if (controllerPassword.text.isNotEmpty &&
                        controllerGmail.text.isNotEmpty) {

                      final user = User(
                        gmail: controllerGmail.text,
                        pass: controllerPassword.text,
                      );
                      
                      User userr = await UserDatabase.instance.readUser2(user);

                      if (userr != null && userr.pass == controllerPassword.text) {
                        controllerGmail.clear();
                        controllerPassword.clear();
                        Navigator.of(context).push(
                            MaterialPageRoute(builder: (context) => MyHome()));

                      }else{
                        Fluttertoast.showToast(
                          msg: "Datos incorrectos",
                          toastLength: Toast.LENGTH_SHORT,
                          gravity: ToastGravity.CENTER,
                          timeInSecForIosWeb: 1,
                          backgroundColor: Colors.black,
                          textColor: Colors.white,
                          fontSize: 16.0);
                      }
                    } else {
                      Fluttertoast.showToast(
                          msg: "Faltan datos",
                          toastLength: Toast.LENGTH_SHORT,
                          gravity: ToastGravity.CENTER,
                          timeInSecForIosWeb: 1,
                          backgroundColor: Colors.black,
                          textColor: Colors.white,
                          fontSize: 16.0);
                    }
                  },)),
            ],
          ),
        ]),
      ),
    );
  }
}
