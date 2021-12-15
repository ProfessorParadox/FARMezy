import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:intl/intl.dart';
import 'dart:math';

import '../providers/orders.dart' as ot;
import '../providers/products.dart';

class OrderItem extends StatefulWidget {
  final ot.OrderItem order;
  OrderItem(this.order);

  @override
  _OrderItemState createState() => _OrderItemState();
}

class _OrderItemState extends State<OrderItem> {
  var _expanded = false;

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.all(5),
      child: Column(
        children: <Widget>[
          ListTile(
            title: Text('\$${widget.order.price}'),
            subtitle: Text(
              DateFormat('dd/MM/yyyy hh:mm').format(widget.order.dateTime),
            ),
            trailing: IconButton(
                icon: Icon(_expanded ? Icons.expand_less : Icons.expand_more),
                onPressed: () {
                  setState(() {
                    _expanded = !_expanded;
                  });
                }),
          ),
          if (_expanded)
            Container(
                height: min(widget.order.products.length * 20.0 + 100.0, 180),
                child: ListView(
                  children: widget.order.products.map((item) =>ListTile(
            leading: ClipRRect(
              borderRadius: BorderRadius.circular(10),
                child: Image.network(
              Provider.of<Products>(context).productImage(item.title),
              width: 50,
              fit: BoxFit.cover,
            )),
            title: Text(
              item.title,
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.w500),
            ),
            subtitle: Text('Qty : ${item.quantity}',style: TextStyle(fontSize: 15),),
            trailing: Text(
              'Price : \$${item.price * item.quantity}',
              style:
                  TextStyle(fontSize: 18, color: Theme.of(context).primaryColor,fontWeight: FontWeight.bold),
            ),
          ),  ).toList(),
                ))
        ],
      ),
    );
  }
}
