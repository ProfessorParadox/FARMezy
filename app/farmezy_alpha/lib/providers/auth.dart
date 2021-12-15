import 'package:flutter/cupertino.dart';
import 'package:flutter/widgets.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

import 'dart:convert';
import 'dart:async';

import '../models/http_exception.dart';

class Auth with ChangeNotifier {
  String _token;
  DateTime _expiryDate;
  String _userId;
  Timer _authTimer;
  String errorMsg;

  bool get isAuth {
    return token != null;
  }

  String get uId {
    return _userId;
  }

  String get token {
    if (_expiryDate != null &&
        _token != null &&
        _expiryDate.isAfter(DateTime.now())) {
      return _token;
    }
    return null;
  }

  Future<void> _authenticate(
      String email, String password, String urlSegment) async {
    final url =
        "https://identitytoolkit.googleapis.com/v1/accounts:$urlSegment?key=AIzaSyAdIQvL-Ni_VbPvItJ6a-3e_JGhJimXHao";
    try {
      final response = await http.post(url,
          body: json.encode({
            'email': email,
            'password': password,
            'returnSecureToken': true
          }));

       print(json.decode(response.body));

      final responseData = json.decode(response.body);
      if (responseData["error"] != null) {
        print("throwing http exception");
        errorMsg=responseData["error"]["message"];
        throw HttpException(responseData["error"]["message"]);
      }

      _token = responseData["idToken"];
      _userId = responseData["localId"];
      _expiryDate = DateTime.now()
          .add(Duration(seconds: int.parse(responseData["expiresIn"])));
      _autoLogout();
      notifyListeners();

      final prefs = await SharedPreferences.getInstance();
      final userData = json.encode({
        'token': _token,
        'userId': _userId,
        'expiryDate': _expiryDate.toIso8601String()
      });
      prefs.setString("loginData", userData);
    }on Object catch (error) {
      print("catching it and thrwoing it again");
      print(error);
      throw HttpException(errorMsg);
    }
  }

  Future<void> signup(String email, String password) async {
    _authenticate(email, password, "signUp");
  }

  Future<void> login(String email, String password) async {
    _authenticate(email, password, "signInWithPassword");
  }

  Future<void> logout() async{
    _token = null;
    _userId = null;
    _expiryDate = null;
    if (_authTimer != null) {
      _authTimer.cancel();
      _authTimer = null;
    }
    final storedData= await SharedPreferences.getInstance();
    storedData.remove("loginData");

    notifyListeners();
  }

  void _autoLogout() {
    if (_authTimer != null) {
      _authTimer.cancel();
    }
    final expiryTime = _expiryDate.difference(DateTime.now()).inSeconds;
    _authTimer = Timer(Duration(seconds: expiryTime), logout);
  }

  Future<bool> tryLogin() async {
    final storedData = await SharedPreferences.getInstance();
    if (!storedData.containsKey("loginData")) {
      return false;
    }
    final extratedData = json.decode(storedData.getString("loginData")) as Map<String,Object>;

    final expiryDate = DateTime.parse(extratedData["expiryDate"]);

    if(expiryDate.isBefore(DateTime.now()))
    {
      return false;
    }

    _token=extratedData["token"];
    _userId=extratedData["userId"];
    _expiryDate=expiryDate;
    notifyListeners();
    _autoLogout(); 
    return true;




  }
}
