import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

class Product with ChangeNotifier{
  final String id;
  final String title;
  final String description;
  final double price;
  final String imageUrl;
  bool isFav;


  Product({
    @required this.id,
    @required this.imageUrl,
    @required this.price,
    @required this.description,
    this.isFav=false,
    @required this.title
    });

void toggleFav(String p_id,String token,String u_id) async {
  final url = 'https://flutter-demo-app-78d1e.firebaseio.com/userFavourites/$u_id/$p_id.json?auth=$token';
    isFav=!isFav;
    notifyListeners();
   try {
     final response = await http.put(url,body:json.encode( 
    isFav)); 
  if(response.statusCode>=400)
  {     isFav=!isFav;        }
  }
  catch (_){
    isFav=!isFav;
  }
 
  notifyListeners();
  
}

}