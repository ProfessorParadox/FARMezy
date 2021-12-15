// custom form widget code

import 'package:farmezy_alpha/providers/yield_predict_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/loc_list.dart';
import '../screens/crop_recommend_result.dart';

import '../widgets/app_drawer.dart';

class CropRecForm extends StatefulWidget {
  static const routeName = '/Crop-Recommend-Screen';

  @override
  CropRecFormState createState() => CropRecFormState();
}

class CropRecFormState extends State<CropRecForm> {
  String _nitrogen;
  String _phosphorus;
  String _kalium;
  String _pH;
  String _rainfall;
  String _state = "Chandigarh";
  String _city;

  final GlobalKey<FormState> _formKeyCR = GlobalKey<FormState>();
  final List<String> statelist = states;
  // ['dl', 'hr', 'up'];
  final Map<String, List<String>> citylist = cities;
  // ['new dl', 'ggn', 'knp'];
  //TODO: link actual loclist() here

  String _citystat() {
    return _state;
  }

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

  Widget _buildpH() {
    return TextFormField(
      decoration: InputDecoration(labelText: 'pH Level'),
      keyboardType: TextInputType.number,
      validator: (String value) {
        int pHtemp = int.tryParse(value);

        if (pHtemp == null || pHtemp <= 3.50 || pHtemp >= 9.94) {
          return 'pH level must be in (3.50 - 9.94)';
        }

        return null;
      },
      onSaved: (String value) {
        _pH = value;
      },
    );
  }

  Widget _buildrainfall() {
    return TextFormField(
      decoration: InputDecoration(labelText: 'Rainfall Level in mm'),
      keyboardType: TextInputType.number,
      validator: (String value) {
        int rftemp = int.tryParse(value);

        if (rftemp == null || rftemp <= 20 || rftemp >= 299) {
          return 'Rainfall level must be in (20-299) mm';
        }

        return null;
      },
      onSaved: (String value) {
        _rainfall = value;
      },
    );
  }

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
      onChanged: (val) => setState(() {
        _state = val;
      }),
      onSaved: (val) => setState(
        () => _state = val,
      ),
    );
  }

  //... city name dropdown menu
  Widget _buildcityname() {
    return DropdownButtonFormField(
      decoration: InputDecoration(labelText: 'City Name'),
      value: _city,
      items: citylist[_citystat()].map((city) {
        return DropdownMenuItem(
          value: city,
          child: Text('$city'),
        );
      }).toList(),
      validator: (String value) {
        if (value == null) {
          return 'Pick an option';
        }
        return null;
      },
      onChanged: (value) => setState(
        () => _city = value,
      ),
      onSaved: (value) => setState(
        () => _city = value,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKeyCR,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          _buildN(),
          _buildP(),
          _buildK(),
          _buildpH(),
          _buildrainfall(),
          _buildstatename(),
          _buildcityname(),
          SizedBox(
            height: 100,
          ),
          ElevatedButton(
            onPressed: () async {
              if (!_formKeyCR.currentState.validate()) {
                return;
              }

              _formKeyCR.currentState.save();
              Provider.of<YieldData>(context, listen: false).cropRecommend(
                  _nitrogen,
                  _phosphorus,
                  _kalium,
                  '23',
                  '60',
                  _pH,
                  double.parse(_rainfall));
              await Provider.of<YieldData>(context, listen: false).fetchCrop();
              Navigator.of(context).pushReplacementNamed(CropRecRes.routeName);
              /*print(_nitrogen);
              print(_phosphorus);
              print(_kalium);
              print(_pH);
              print(_rainfall);
              print(_state);
              print(_city); */

              //TODO call result screen class()
              // pass positional args of above vars
              // CropRecRes();
            },
            child: Text(
              'Submit',
              style: TextStyle(
                color: Colors.white,
                fontSize: 16,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
