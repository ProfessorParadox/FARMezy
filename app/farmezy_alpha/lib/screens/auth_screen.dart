//import 'dart:ffi';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/auth.dart';
import '../models/http_exception.dart';

import 'dart:math';

enum AuthMode { Signup, Login }

class AuthScreen extends StatelessWidget {
  static const routeName = '/auth';
  @override
  Widget build(BuildContext context) {
    final deviceSize = MediaQuery.of(context).size;

    return Scaffold(
      body: Stack(
        children: <Widget>[
          Container(
            decoration: BoxDecoration(
              color: Colors.white,
            ),
          ),
          SingleChildScrollView(
            child: Container(
              height: deviceSize.height,
              width: deviceSize.width,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Flexible(
                    child: Container(
                      margin: EdgeInsets.only(top: 20),
                      padding: EdgeInsets.only(
                          top: (deviceSize.height) * 0.15,
                          bottom: (deviceSize.height) * .05),
                      child: Text(
                        "FARMezy",
                        style: TextStyle(
                            color: Colors.teal[700],
                            fontSize: 60,
                            fontWeight: FontWeight.bold),
                      ),
                    ),
                    flex: 3,
                  ),
                  Flexible(
                    child: Container(
                      child: AuthCard(),
                    ),
                    flex: 5,
                  ),
                  Flexible(
                    child: Container(
                      margin: EdgeInsets.only(top: 20),
                      padding:
                          EdgeInsets.only(bottom: (deviceSize.height) * .05),
                      child: Text(
                        "made by CPG-106",
                        style:
                            TextStyle(color: Colors.teal[700], fontSize: 20),
                      ),
                    ),
                    flex: 1,
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

class AuthCard extends StatefulWidget {
  const AuthCard({
    Key key,
  }) : super(key: key);

  @override
  _AuthCardState createState() => _AuthCardState();
}

class _AuthCardState extends State<AuthCard>
    with SingleTickerProviderStateMixin {
  final GlobalKey<FormState> _formKey = GlobalKey();
  AuthMode _authMode = AuthMode.Login;
  Map<String, String> _authData = {"email": '', "password": ''};

  AnimationController _controller;
  Animation<Size> _heightAnimation;
  var screenHeight=window.physicalSize.height;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _controller =
        AnimationController(vsync: this, 
        duration: Duration(
          milliseconds: 300)
          );
      _heightAnimation =Tween<Size>(begin: Size(double.infinity,300),end:Size(double.infinity,400)).animate(CurvedAnimation(
        parent: _controller,
        curve: Curves.easeInOutBack
      ) );

      _heightAnimation.addListener(()=>setState((){}));

  }

  void _showErrorDialog(String message) {
    showDialog(
        context: context,
        builder: (ctx) => AlertDialog(
              title: Text("Some error has occured"),
              content: Text(message),
              actions: [
                FlatButton(
                  child: Text("Okay"),
                  onPressed: () {
                    Navigator.of(ctx).pop();
                  },
                )
              ],
            ));
  }

  var _loading = false;
  final _passwordController = TextEditingController();

  Future<void> _submit() async {
    if (!_formKey.currentState.validate()) {
      return;
    }
    _formKey.currentState.save();
    setState(() {
      _loading = true;
      print("setting loading true");
    });
    try {
      if (_authMode == AuthMode.Login) {
        await Provider.of<Auth>(context, listen: false).login(
          _authData["email"],
          _authData["password"],
        );
      } else {
        await Provider.of<Auth>(context, listen: false).signup(
          _authData["email"],
          _authData["password"],
        );
      }
    } 
    on HttpException catch (error) {
      print("auth screen");
      print(error);
      var errorMessage = "Authentication failed";
      if (error.toString().contains("EMAIL_EXISTS")) {
        errorMessage = "This email address already exists";
      } else if (error.toString().contains("INVALID_EMAIL")) {
        errorMessage = "This email address is not valid";
      } else if (error.toString().contains("WEAK_PASSWORD")) {
        errorMessage = "Password is too short";
      } else if (error.toString().contains("EMAIL_NOT_FOUND")) {
        errorMessage = "No user found with this email address";
      } else if (error.toString().contains("INVALID_PASSWORD")) {
        errorMessage = "Wrong password";
      }
      print("error is caught");
      _showErrorDialog(errorMessage);
    } 
    catch (error) {
      const errorMessage = "Cannot process your request now. Try again later";
      _showErrorDialog(errorMessage);
    }
    setState(() {
      _loading = false;
      print("setting loading false");
    });
  }

  void _switchAuthMode() {
    if (AuthMode.Login == _authMode) {
      setState(() {
        _authMode = AuthMode.Signup;
      });
      _controller.forward();
    } else {
      setState(() {
        _authMode = AuthMode.Login;
      });
      _controller.reverse();
    }
  }

  @override
  Widget build(BuildContext context) {
    // final deviceSize = MediaQuery.of(context).size;

    return Container(
      height: 
       _heightAnimation.value.height,
      // _authMode == AuthMode.Signup
      //     ? (deviceSize.height) * 0.5
      //     : (deviceSize.height) * 0.4,
      padding: EdgeInsets.symmetric(vertical: 10),
      child: Form(
        key: _formKey,
        child: SingleChildScrollView(
          child: Column(
            children: <Widget>[
              Container(
                padding: EdgeInsets.symmetric(horizontal: 30),
                child: TextFormField(
                  decoration: InputDecoration(
                      labelText: 'E-mail',
                      labelStyle: TextStyle(
                          color: Colors.teal[700],
                          fontWeight: FontWeight.bold),
                      focusedBorder: UnderlineInputBorder(
                          borderSide: BorderSide(
                              color: Colors.teal[700],
                              style: BorderStyle.solid))),
                  keyboardType: TextInputType.emailAddress,
                  validator: (value) {
                    if (value.isEmpty || !value.contains('@')) {
                      return "Invalid Email";
                    }
                  },
                  onSaved: (value) {
                    _authData['email'] = value;
                  },
                ),
              ),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 30),
                child: TextFormField(
                  decoration: InputDecoration(labelText: 'Password',
                  labelStyle: TextStyle(
                          color: Colors.teal[700],
                          fontWeight: FontWeight.bold),
                      focusedBorder: UnderlineInputBorder(
                          borderSide: BorderSide(
                              color: Colors.teal[700],
                              style: BorderStyle.solid)),),
                  obscureText: true,
                  controller: _passwordController,
                  validator: (value) {
                    if (value.isEmpty || value.length < 8) {
                      return "Password should be greater than 8 characters";
                    }
                  },
                  onSaved: (value) {
                    _authData['password'] = value;
                  },
                ),
              ),
              if (_authMode == AuthMode.Signup)
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 30),
                  child: TextFormField(
                    enabled: _authMode == AuthMode.Signup,
                    decoration: InputDecoration(labelText: "Confirm Password"),
                    obscureText: true,
                    validator: _authMode == AuthMode.Signup
                        ? (value) {
                            if (value != _passwordController.text) {
                              return "Passwords do not match";
                            }
                          }
                        : null,
                  ),
                ),
              SizedBox(
                height: 20,
              ),
              if (_loading)
                CircularProgressIndicator()
              else
                RaisedButton(
                  child: Text(
                    _authMode == AuthMode.Signup ? "Sign up" : "Login",
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 25,
                        fontWeight: FontWeight.bold),
                  ),
                  onPressed: _submit,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                  color: Colors.teal[700],
                  padding: EdgeInsets.symmetric(horizontal: 50, vertical: 8),
                ),
              FlatButton(
                child: Text(
                    "${_authMode == AuthMode.Signup ? "Login" : "Sign up"}"),
                onPressed: _switchAuthMode,
                padding: EdgeInsets.symmetric(horizontal: 30, vertical: 4),
                textColor: Colors.teal[700],
                materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
