// custom form widget code

import 'package:flutter/material.dart';
import '../providers/fertiliser_list.dart';
import '../providers/yield_list.dart';
import '../screens/fertiliser_suggest_result.dart';

class FertiSuggestForm extends StatefulWidget {
  @override
  FertiSuggestFormState createState() => FertiSuggestFormState();
}

class FertiSuggestFormState extends State<FertiSuggestForm> {
  String _nitrogen; //t
  String _phosphorus; //t
  String _kalium; //t
  String _cropname; //dd

  final GlobalKey<FormState> _formKeyFS = GlobalKey<FormState>();
  final List<String> croplist = crops;
  //['wheat', 'rice', 'cotton', 'jute'];

  Widget _buildN() {
    return TextFormField(
      decoration: InputDecoration(labelText: 'Nitrogen Level'),
      keyboardType: TextInputType.number,
      validator: (String value) {
        int ntemp = int.tryParse(value);

        if (ntemp == null || ntemp <= 0 || ntemp >= 140) {
          return 'Nitrogen level must be in (0-140)';
        }

        return null;
      },
      onSaved: (String value) {
        _nitrogen = value;
      },
    );
  }

  Widget _buildP() {
    return TextFormField(
      decoration: InputDecoration(labelText: 'Phosphorus Level'),
      keyboardType: TextInputType.number,
      validator: (String value) {
        int ptemp = int.tryParse(value);

        if (ptemp == null || ptemp <= 5 || ptemp >= 145) {
          return 'Phosphorus level must be in (5-145)';
        }

        return null;
      },
      onSaved: (String value) {
        _phosphorus = value;
      },
    );
  }

  Widget _buildK() {
    return TextFormField(
      decoration: InputDecoration(labelText: 'Potassium Level'),
      keyboardType: TextInputType.number,
      validator: (String value) {
        int ktemp = int.tryParse(value);

        if (ktemp == null || ktemp <= 5 || ktemp >= 205) {
          return 'Potassium level must be in (5-205)';
        }

        return null;
      },
      onSaved: (String value) {
        _kalium = value;
      },
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

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKeyFS,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          _buildN(),
          _buildP(),
          _buildK(),
          _buildcropname(),
          SizedBox(
            height: 100,
          ),
          ElevatedButton(
            onPressed: () {
              if (!_formKeyFS.currentState.validate()) {
                return;
              }

              _formKeyFS.currentState.save();

              print(_nitrogen);
              print(_phosphorus);
              print(_kalium);
              print(_cropname);

              //TODO call result screen class()
              // pass positional args of above vars
              // FertiSuggestRes();
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
      ),
    );
  }
}
