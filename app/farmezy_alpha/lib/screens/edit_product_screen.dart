import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/product.dart';
import '../providers/products.dart';

class EditProductScreen extends StatefulWidget {
  static const routeName = '/EditProductScreen';
  @override
  _EditProductScreenState createState() => _EditProductScreenState();
}

class _EditProductScreenState extends State<EditProductScreen> {
  final _priceFocous = FocusNode();
  final _descFocus = FocusNode();
  final _imageUrlController = TextEditingController();
  final _imageFocus = FocusNode();
  final _form = GlobalKey<FormState>();
  var _editedProduct =
      Product(id: null, title: '', price: 0, imageUrl: '', description: '');
  var _isInit = true;
  var _isLoading = false;

  var initValues = {
    'id': '',
    'title': '',
    'price': '',
    'description': '',
    'imageUrl': ''
  };

  @override
  initState() {
    _imageFocus.addListener(_updateImageUrl);
    super.initState();
  }

  @override
  void didChangeDependencies() {
    if (_isInit) {
      final _id = ModalRoute.of(context).settings.arguments as String;

      if (_id != null) {
        _editedProduct =
            Provider.of<Products>(context, listen: false).findById(_id);
        initValues = {
          'title': _editedProduct.title,
          'price': _editedProduct.price.toString(),
          'description': _editedProduct.description,
          'imageUrl': '',
        };
        _imageUrlController.text = _editedProduct.imageUrl;
      }
    }
    _isInit = false;
    // TODO: implement didChangeDependencies

    super.didChangeDependencies();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    _priceFocous.dispose();
    _imageUrlController.dispose();
    _imageFocus.removeListener(_updateImageUrl);
    _descFocus.dispose();
    super.dispose();
  }

  void _updateImageUrl() {
    if (!_imageFocus.hasFocus) {
      if (_imageUrlController.text.isEmpty ||
          (!_imageUrlController.text.startsWith('http') &&
              !_imageUrlController.text.startsWith('https')) /*||

          (!_imageUrlController.text.endsWith('.png') &&
              !_imageUrlController.text.endsWith('.jpg') &&
              !_imageUrlController.text.endsWith('.jpeg'))*/ ) {
        return;
      }
      setState(() {});
    }
  }

  Future<Null> _saveForm() async {
    setState(() {
      _isLoading = true;
    });

    final _isvalid = _form.currentState.validate();
    if (!_isvalid) {
      setState(() {
        _isLoading = false;
      });
      return;
    }

    _form.currentState.save();

    if (_editedProduct.id != null) {
    await  Provider.of<Products>(context, listen: false)
          .updateProduct(_editedProduct.id, _editedProduct);
    
    } else {
      try {
        await Provider.of<Products>(context, listen: false)
            .addProduct(_editedProduct);
      } catch (error) {
        await showDialog<Null>(
          context: context,
          builder: (ctx) => AlertDialog(
            title: Text('An Error has occured'),
            content: Text('Press okay to continue'),
            actions: <Widget>[
              FlatButton(
                child: Text('Okay'),
                onPressed: () {
                  Navigator.of(ctx).pop();
                },
              )
            ],
          ),
        );
      }

      // finally {
      //   print('changing loading to false');
      //   setState(() {
      //     _isLoading = false;
      //   });
      //   Navigator.of(context).pop();
      // }
    }

      setState(() {
        _isLoading = false;
      });
      Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Edit Products'),
        actions: <Widget>[
          IconButton(icon: Icon(Icons.save), onPressed: _saveForm),
        ],
      ),
      body: _isLoading
          ? Center(
              child: CircularProgressIndicator(),
            )
          : Padding(
              padding: const EdgeInsets.all(5),
              child: Form(
                  key: _form,
                  child: ListView(
                    children: <Widget>[
                      TextFormField(
                        initialValue: initValues['title'],
                        decoration: InputDecoration(
                          labelText: 'Title',
                        ),
                        textInputAction: TextInputAction.next,
                        onFieldSubmitted: (_) {
                          FocusScope.of(context).requestFocus(_priceFocous);
                        },
                        onSaved: (val) {
                          _editedProduct = Product(
                              title: val,
                              isFav: _editedProduct.isFav,
                              id: _editedProduct.id,
                              price: _editedProduct.price,
                              description: _editedProduct.description,
                              imageUrl: _editedProduct.imageUrl);
                        },
                        validator: (val) {
                          if (val.isEmpty) {
                            return 'Enter some title';
                          }
                          return null;
                        },
                      ),
                      TextFormField(
                        initialValue: initValues['price'],
                        decoration: InputDecoration(
                          labelText: 'Price',
                        ),
                        textInputAction: TextInputAction.next,
                        keyboardType: TextInputType.number,
                        onFieldSubmitted: (_) {
                          FocusScope.of(context).requestFocus(_descFocus);
                        },
                        onSaved: (val) {
                          _editedProduct = Product(
                              title: _editedProduct.title,
                              isFav: _editedProduct.isFav,
                              id: _editedProduct.id,
                              price: double.parse(val),
                              description: _editedProduct.description,
                              imageUrl: _editedProduct.imageUrl);
                        },
                        validator: (val) {
                          if (val.isEmpty) {
                            return 'Please enter some price';
                          }
                          if (double.tryParse(val) == null) {
                            return 'Enter a valid number';
                          }
                          if (double.tryParse(val) <= 0) {
                            return 'Enter a number greater than 0';
                          }
                          return null;
                        },
                        focusNode: _priceFocous,
                      ),
                      TextFormField(
                        initialValue: initValues['description'],
                        decoration: InputDecoration(
                          labelText: 'Description',
                        ),
                        maxLines: 3,
                        keyboardType: TextInputType.multiline,
                        focusNode: _descFocus,
                        onSaved: (val) {
                          _editedProduct = Product(
                              title: _editedProduct.title,
                              isFav: _editedProduct.isFav,
                              id: _editedProduct.id,
                              price: _editedProduct.price,
                              description: val,
                              imageUrl: _editedProduct.imageUrl);
                        },
                        validator: (val) {
                          if (val.isEmpty) {
                            return 'Enter Description';
                          }
                          if (val.length < 10) {
                            return 'Enter a Description longer then 10 characters';
                          }
                          return null;
                        },
                      ),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: <Widget>[
                          Container(
                            width: 150,
                            height: 150,
                            margin: EdgeInsets.only(top: 5, right: 10),
                            decoration: BoxDecoration(
                              color: Theme.of(context).primaryColor,
                              border: Border.all(
                                width: 2,
                                color: Theme.of(context).primaryColor,
                              ),
                              borderRadius: BorderRadius.circular(5),
                            ),
                            child: _imageUrlController.text.isEmpty
                                ? Text('Enter URL')
                                : FittedBox(
                                    child:
                                        Image.network(_imageUrlController.text),
                                    fit: BoxFit.cover,
                                  ),
                          ),
                          Expanded(
                            child: TextFormField(
                              decoration:
                                  InputDecoration(labelText: 'Image URL'),
                              keyboardType: TextInputType.url,
                              textInputAction: TextInputAction.done,
                              controller: _imageUrlController,
                              focusNode: _imageFocus,
                              onFieldSubmitted: (_) {
                                _saveForm();
                              },
                              onSaved: (val) {
                                _editedProduct = Product(
                                    title: _editedProduct.title,
                                    isFav: _editedProduct.isFav,
                                    id: _editedProduct.id,
                                    price: _editedProduct.price,
                                    description: _editedProduct.description,
                                    imageUrl: val);
                              },
                              validator: (val) {
                                if (val.isEmpty) {
                                  return 'Enter URL';
                                }
                                if (!val.startsWith('http') &&
                                    !val.startsWith('https')) {
                                  return 'Please enter a valid URL';
                                }
                                /*if (!val.endsWith('.png') &&
                                    !val.endsWith('.jpg') &&
                                    !val.endsWith('.JPG')&&
                                    !val.endsWith('.jpeg')) {
                                  return 'Enter a Valid Image URL';
                                } */
                                return null;
                              },
                            ),
                          ),
                        ],
                      ),
                    ],
                  )),
            ),
    );
  }
}
