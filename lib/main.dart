import 'dart:async';

import 'package:dart/home.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  runApp(MaterialApp(
    home: Home(),
  ));
}

class Home extends StatefulWidget {
  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  bool show_hide_password = true;
  var username_controller = TextEditingController();
  var password_controller = TextEditingController();
  var opacity = 0.0;
  var error_opacity = 0.0;
  var error_message = "";
  var successful_message = "";
  var icon = FontAwesomeIcons.eye;

  @override
  void initState() {
    super.initState();
    decide();
  }

// when user is already logged in then navigating user to home screen
  decide() async{
    var pref = await SharedPreferences.getInstance();
    var is_login = pref.getString("login_successful");

    if(is_login == "true"){
      Navigator.push(context,
      MaterialPageRoute(
        builder: (context) => HomePage(),
        
        ));
    }

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text("Home Screen"),
        ),
        body: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Opacity(
              opacity: error_opacity,
              child: Container(
                width: 310,
                color: Colors.red,
                child: Row(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(10),
                      child: Text(
                        error_message,
                        style: TextStyle(fontSize: 18, color: Colors.white),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            AnimatedOpacity(
              duration: Duration(seconds: 1),
              opacity: opacity,
              child: Container(
                width: 310,
                color: Colors.green,
                child: Row(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(10),
                      child: Text(
                        successful_message,
                        style: TextStyle(fontSize: 18, color: Colors.white),
                      ),
                    ),
                    IconButton(
                        onPressed: () {
                          opacity = 0;
                          setState(() {});
                        },
                        icon: FaIcon(
                          FontAwesomeIcons.xmark,
                          color: Colors.white,
                          size: 30,
                        ))
                  ],
                ),
              ),
            ),
            Column(
              children: [
                Center(
                  child: SizedBox(
                    width: 300,
                    child: Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(top: 20),
                          child: TextField(
                            controller: username_controller,
                            style: const TextStyle(fontSize: 23),
                            decoration: const InputDecoration(
                              focusedBorder: OutlineInputBorder(
                                  borderSide: BorderSide(color: Colors.blue)),
                              label: Text("Enter Username"),
                              labelStyle: TextStyle(fontSize: 17),
                              prefixIcon: Icon(Icons.person_2_rounded),
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top: 20),
                          child: TextField(
                            controller: password_controller,
                            style: const TextStyle(fontSize: 23),
                            obscureText: show_hide_password,
                            obscuringCharacter: "*",
                            decoration: InputDecoration(
                              focusedBorder: const OutlineInputBorder(
                                  borderSide: BorderSide(color: Colors.blue)),
                              label: const Text("Enter Password"),
                              labelStyle: const TextStyle(fontSize: 17),
                              prefixIcon: const Icon(Icons.password),
                              suffixIcon: IconButton(
                                onPressed: () {
                                  if (show_hide_password) {
                                    show_hide_password = false;
                                    icon = FontAwesomeIcons.eyeSlash;
                                  } else {
                                    show_hide_password = true;
                                    icon = FontAwesomeIcons.eye;
                                  }

                                  setState(() {});
                                },
                                icon: FaIcon(
                                  icon,
                                  size: 30,
                                ),
                              ),
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 100,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              SizedBox(
                                width: 100,
                                height: 50,
                                child: ElevatedButton(
                                    onPressed: () async {
                                      var username = username_controller.text;
                                      var password = password_controller.text;
                                      if (username == "" && password == "") {
                                        error_opacity = 1;
                                        error_message =
                                            "Username and Password are emtpy";
                                        setState(() {});
                                        return;
                                      } else if (username == "") {
                                        error_opacity = 1;
                                        error_message = "Username is empty";
                                        setState(() {});
                                        return;
                                      } else if (password == "") {
                                        error_opacity = 1;
                                        error_message = "Password is empty";
                                        setState(() {});
                                        return;
                                      }
                                      var pref =
                                          await SharedPreferences.getInstance();
                                      var s_username =
                                          pref.getString("username");
                                      var s_password =
                                          pref.getString("password");

                                      if (username == s_username &&
                                          password == s_password) {
                                            error_opacity = 0;
                                            pref.setString("login_successful", "true");
                                            print(pref.getString("login_successful"));
                                        Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                              builder: (context) => HomePage(),
                                            ));
                                      } else {
                                        error_message = "Wrong Credentials";
                                        error_opacity = 1;
                                        setState(() {});
                                      }
                                    },
                                    child: const Text("Login",
                                        style: TextStyle(fontSize: 20))),
                              ),
                              SizedBox(
                                width: 50,
                              ),
                              SizedBox(
                                width: 100,
                                height: 50,
                                child: ElevatedButton(
                                    onPressed: () async {
                                      var pref =
                                          await SharedPreferences.getInstance();
                                      pref.remove("username");
                                      pref.remove("password");
                                      opacity = 1;
                                      successful_message =
                                          "Successfully Logout";
                                        pref.setString("login_successful", "false");
                                      Timer(Duration(seconds: 3), () {
                                        opacity = 0;
                                        setState(() {});
                                      });
                                      setState(() {});
                                    },
                                    child: const Text("Logout",
                                        style: TextStyle(fontSize: 18))),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(
                          width: 100,
                          height: 50,
                          child: ElevatedButton(
                              onPressed: () async {
                                var username = username_controller.text;
                                var password = password_controller.text;
                                if (username == "" && password == "") {
                                  error_opacity = 1;
                                  error_message =
                                      "Username and Password are emtpy";
                                  setState(() {});
                                } else if (username == "") {
                                  error_opacity = 1;
                                  error_message = "Username is empty";
                                  setState(() {});
                                } else if (password == "") {
                                  error_opacity = 1;
                                  error_message = "Password is empty";
                                  setState(() {});
                                }
                                if (username != "" && password != "") {
                                  error_opacity = 0;
                                  var pref =
                                      await SharedPreferences.getInstance();
                                  pref.setString("username", username);
                                  pref.setString("password", password);
                                  successful_message =
                                      "Account Created Successfully";
                                  opacity = 1;
                                  Timer(Duration(seconds: 3), () {
                                    opacity = 0;
                                    setState(() {});
                                  });
                                  setState(() {});
                                }
                              },
                              child: const Text("SignUp",
                                  style: TextStyle(fontSize: 18))),
                        ),
                      ],
                    ),
                  ),
                )
              ],
            ),
          ],
        ));
  }
}
