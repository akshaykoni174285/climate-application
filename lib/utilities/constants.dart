import 'package:flutter/material.dart';

const kTempTextStyle = TextStyle(
  fontSize: 100.0,
);

const kMessageTextStyle = TextStyle(
  fontFamily: 'Spartan MB',
  fontSize: 60.0,
);

const kButtonTextStyle = TextStyle(
  fontSize: 30.0,
  fontFamily: 'Spartan MB',
  color: Color(0xFFD8DEE9),
);

const kConditionTextStyle = TextStyle(
  fontSize: 100.0,
);

const KDetailStyle = TextStyle(
  fontSize: 27,
  fontWeight: FontWeight.bold,
  letterSpacing: 1,
);

const kTextFieldInputDecoration = InputDecoration(
  filled: true,
  fillColor: Colors.white,
  icon: Icon(
    Icons.location_city,
    size: 40,
    color: Color(0xFFD8DEE9),
  ),
  hintText: 'Enter City Name',
  hintStyle: TextStyle(
    color: Colors.grey,
  ),
  border: OutlineInputBorder(
    borderRadius: BorderRadius.all(
      Radius.circular(10.0),
    ),
    borderSide: BorderSide.none,
  ),
);
