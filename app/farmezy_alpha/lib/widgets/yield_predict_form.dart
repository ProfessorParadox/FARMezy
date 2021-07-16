// custom form widget code

import 'package:flutter/material.dart';
import '../providers/loc_list.dart';
import '../providers/yield_list.dart';
import '../screens/yield_predict_result.dart';

class YieldPredictForm extends StatefulWidget {
  // const YieldPredictForm({ Key? key }) : super(key: key);

  @override
  _YieldPredictFormState createState() => _YieldPredictFormState();
}

class _YieldPredictFormState extends State<YieldPredictForm> {
  String _state; //dd
  String _year = '2021'; //TODO hidden - for now default value / text input
  String _season; //dd
  String _cropname; //dd
  String _rainfall; //t

  final GlobalKey<FormState> _formKeyYP = GlobalKey<FormState>();
  final List<String> statelist = states;
  //['dl', 'hr', 'up'];
  final List<String> seasonlist = seasons;
  //['kharif', 'rabi'];
  final List<String> croplist = crops;
  // ['wheat', 'rice', 'cotton', 'jute'];

  //... state name dropdown menu
  Widget _buildstatename() {
    return DropdownButtonFormField(
      decoration: InputDecoration(labelText: 'State Name'),
      value: _state,
      items: statelist.map((state) {
        return DropdownMenuItem(
          value: state,
          child: Text('$state'),
        );
      }).toList(),
      validator: (String value) {
        if (value == null) {
          return 'Pick an option';
        }
        return null;
      },
      onChanged: (value) => setState(
        () => _state = value,
      ),
      onSaved: (value) => setState(
        () => _state = value,
      ),
    );
  }

  // Widget _buildyear() {
  //   return TextFormField(
  //     decoration: InputDecoration(labelText: 'Year Planted'),
  //     keyboardType: TextInputType.number,
  //     validator: (String value) {
  //       int yrtemp = int.tryParse(value);

  //       if (yrtemp == null || yrtemp <= 1900 || yrtemp >= 2023) {
  //         return 'Year must be greater than 1900';
  //       }

  //       return null;
  //     },
  //     onSaved: (String value) {
  //       _rainfall = value;
  //     },
  //   );
  // }

  //... season name dropdown menu
  Widget _buildseason() {
    return DropdownButtonFormField(
      decoration: InputDecoration(labelText: 'Season Planted'),
      value: _season,
      items: seasonlist.map((season) {
        return DropdownMenuItem(
          value: season,
          child: Text('$season'),
        );
      }).toList(),
      validator: (String value) {
        if (value == null) {
          return 'Pick an option';
        }
        return null;
      },
      onChanged: (value) => setState(
        () => _season = value,
      ),
      onSaved: (value) => setState(
        () => _season = value,
      ),
    );
  }

  //... crop name dropdown menu
  Widget _buildcropname() {
    return DropdownButtonFormField(
      decoration: InputDecoration(labelText: 'Crop Planted'),
      value: _cropname,
      items: croplist.map((crop) {
        return DropdownMenuItem(
          value: crop,
          child: Text('$crop'),
        );
      }).toList(),
      validator: (String value) {
        if (value == null) {
          return 'Pick an option';
        }
        return null;
      },
      onChanged: (value) => setState(
        () => _cropname = value,
      ),
      onSaved: (value) => setState(
        () => _cropname = value,
      ),
    );
  }

  Widget _buildrainfall() {
    return TextFormField(
      decoration: InputDecoration(labelText: 'Rainfall Level in mm'),
      keyboardType: TextInputType.number,
      validator: (String value) {
        int rftemp = int.tryParse(value);

        if (rftemp == null || rftemp <= 0 || rftemp >= 6230) {
          return 'Rainfall level must be in (0-6230) mm';
        }

        return null;
      },
      onSaved: (String value) {
        _rainfall = value;
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKeyYP,
      child: ListView.builder(
        padding: const EdgeInsets.all(8),
        itemCount: 1,
        itemBuilder: (BuildContext context, int index) {
          return Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              _buildstatename(),
              // _buildyear(),
              _buildseason(),
              _buildcropname(),
              _buildrainfall(),
              SizedBox(
                height: 100,
              ),
              ElevatedButton(
                onPressed: () {
                  if (!_formKeyYP.currentState.validate()) {
                    return;
                  }

                  _formKeyYP.currentState.save();

                  print(_state);
                  print(_year);
                  print(_season);
                  print(_cropname);
                  print(_rainfall);

                  //TODO call result screen class()
                  // pass positional args of above vars
                  // rem- pass year value as it is
                  // YieldPredictRes();
                },
                child: Text(
                  'Submit',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                  ),
                ),
              )
            ],
          );
        },
      ),
    );
  }
}
