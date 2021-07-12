// crop vandalism photo output display screen code

import 'package:flutter/material.dart';

class CropVandalismScreen extends StatelessWidget {
  //...
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.lime.shade100,
      appBar: AppBar(
        title: Text('Crop Vandalism Detected!'),
      ),
      body: Container(
        margin: EdgeInsets.all(24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.dangerous,
              size: 200,
            ),
            SizedBox(height: 100),
            Text(
              'Crop Vandalism Detected!',
              textAlign: TextAlign.center,
            ),
          ],
        ), //... builderfunc(),
      ),
    );
  }
}
