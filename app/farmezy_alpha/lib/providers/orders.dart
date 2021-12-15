import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:convert/convert.dart';

import './cart.dart';

class OrderItem {
  final String id;
  final double price;
  final List<CartItem> products;
  final DateTime dateTime;

  OrderItem(
      {@required this.id,
      @required this.price,
      @required this.products,
      @required this.dateTime});
}

class Orders with ChangeNotifier {
  List<OrderItem> _orders = [];

  List<OrderItem> get orders {
    return [..._orders];
  }

  String authToken;
  String userId;

  void updateData(String token,String id)
  { authToken=token;
   userId=id;

  }
 


  Future<void> fetchAndSetOrders() async {
    final url = 'https://flutter-demo-app-78d1e.firebaseio.com/orders/$userId.json?auth=$authToken';
    try {
      final response = await http.get(url);
      final List<OrderItem> loadedOrders = [];
      final extractedData = json.decode(response.body) as Map<String, dynamic>;
      if(extractedData==null){
        return;
      }
      extractedData.forEach((orderId, orderData) {
        loadedOrders.add(OrderItem(
            id: orderId,
            price: orderData['price'],
            dateTime: DateTime.parse(orderData['dateTime']),
            products: (orderData['products'] as List<dynamic>)
                .map((item) => CartItem(
                  id:item['id'],
                  price: item['price'],
                  quantity: item['quantity'],
                  title: item['title']
                ))
                .toList()));
      });
      _orders = loadedOrders.reversed.toList();
      notifyListeners();
    } catch (error) {
      throw error;
    }
  }

  void addOrder(List<CartItem> cartProduct, double totalAmount) async {
    final timeStamp = DateTime.now();
    final url = 'https://flutter-demo-app-78d1e.firebaseio.com/orders/$userId.json?auth=$authToken';
    final response = await http.post(url,
        body: json.encode({
          'price': totalAmount,
          'dateTime': timeStamp.toIso8601String(),
          'products': cartProduct
              .map((cp) => {
                    'id': cp.id,
                    'title': cp.title,
                    'quantity': cp.quantity,
                    'price': cp.price,
                  })
              .toList()
        }));
    _orders.insert(
        0,
        OrderItem(
            id: json.decode(response.body)['name'],
            products: cartProduct,
            price: totalAmount,
            dateTime: timeStamp));
    notifyListeners();
  }
}
