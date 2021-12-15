import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../screens/edit_product_screen.dart';

import '../providers/products.dart';

class UserProductItem extends StatelessWidget {
  final String id;
  final String title;
  final String imageUrl;

  UserProductItem(this.id, this.title, this.imageUrl);
  @override
  Widget build(BuildContext context) {
    final scaffold=Scaffold.of(context);
    return ListTile(
      title: Text(title),
      leading: CircleAvatar(
        backgroundImage: NetworkImage(imageUrl),
      ),
      trailing: Container(
        width: 100,
        child: Row(
          children: <Widget>[
            IconButton(
              icon: Icon(Icons.edit),
              onPressed: () {
                Navigator.of(context)
                    .pushNamed(EditProductScreen.routeName, arguments: id);
              },
              color: Theme.of(context).primaryColor,
            ),
            IconButton(
              icon: Icon(Icons.delete),
              onPressed: () {
                showDialog(
                  context: context,
                  builder: (_)=> AlertDialog(
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10)),
                      elevation: 5,
                      title: Text('Are You Sure ?',
                          textAlign: TextAlign.center,
                          style: TextStyle(color: Colors.black, fontSize: 20)),
                      content: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: <Widget>[
                          FlatButton(
                            textColor: Theme.of(context).primaryColor,
                            child: Text('Yes'),
                            onPressed: () async{
                               Navigator.of(context).pop();
                              try{
                             await Provider.of<Products>(context, listen: false)
                                  .deleteProduct(id);
                              } catch(error) {
                                scaffold.showSnackBar(SnackBar(content: Text('Deleting Failed',textAlign: TextAlign.center,),));
                              }
                             
                            },
                          ),
                          FlatButton(
                            textColor: Theme.of(context).primaryColor,
                            child: Text('NO'),
                            onPressed: () {
                              Navigator.of(context).pop();
                            },
                          ),
                        ],
                      )),
                );
              },
              color: Theme.of(context).errorColor,
            )
          ],
        ),
      ),
    );
  }
}
