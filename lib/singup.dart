import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:loginsql/BD/users.dart';
import 'package:loginsql/main.dart';
import 'package:loginsql/models/user.dart';

class signUp extends StatefulWidget {
  @override
  _signUpState createState() => _signUpState();
}

class _signUpState extends State<signUp> {
  TextEditingController controllerUser;
  TextEditingController controllerPassword;
  TextEditingController controllerGmail;

  @override
  void initState() {
    super.initState();
    controllerPassword = new TextEditingController();
    controllerUser = new TextEditingController();
    controllerGmail = new TextEditingController();
  }

  @override
  void dispose() {
    controllerPassword.dispose();
    controllerUser.dispose();
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
                          controllerUser.clear();
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
                    onPressed: () async {
                      await Navigator.of(context).push(
                        MaterialPageRoute(builder: (context) => MyHomePage()),
                      );
                    },
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
                      controller: controllerUser,
                      decoration: InputDecoration(
                        hintStyle: TextStyle(fontSize: 15),
                        border: OutlineInputBorder(),
                        labelText: 'User',
                        hintText: "Type the user",
                      )),
                ),
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
                      onPressed: () => {
                            addNote(),
                            Fluttertoast.showToast(
                                msg: "Usuario ingresado",
                                toastLength: Toast.LENGTH_SHORT,
                                gravity: ToastGravity.CENTER,
                                timeInSecForIosWeb: 1,
                                backgroundColor: Colors.black,
                                textColor: Colors.white,
                                fontSize: 16.0),
                          })),
            ],
          ),
        ]),
      ),
    );
  }

  Future addNote() async {
    final user = User(
        gmail: controllerGmail.text,
        pass: controllerPassword.text,
        name: controllerUser.text);
    await UserDatabase.instance.create(user);
    controllerGmail.clear();
    controllerPassword.clear();
    controllerUser.clear();
  }
}
