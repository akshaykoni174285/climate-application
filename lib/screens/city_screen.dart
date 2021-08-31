import 'package:flutter/material.dart';
import 'package:clima/utilities/constants.dart';
import 'dart:ui';

class CityScreen extends StatefulWidget {
  @override
  _CityScreenState createState() => _CityScreenState();
}

class _CityScreenState extends State<CityScreen> {
  String cityName;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Container(
          decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage(
                  'images/dap0psm-60254abc-8220-425c-8799-18096ef36690.jpg'),
              fit: BoxFit.cover,
            ),
          ),
          // constraints: BoxConstraints.expand(),

          child: BackdropFilter(
            filter: ImageFilter.blur(
              sigmaX: 5,
              sigmaY: 5,
            ),
            child: Container(
              color: Colors.black.withOpacity(0.1),
              child: SafeArea(
                child: Column(
                  children: <Widget>[
                    Align(
                      alignment: Alignment.topLeft,
                      child: TextButton(
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        child: Icon(
                          Icons.arrow_back_ios,
                          size: 40.0,
                          color: Color(0xFFD8DEE9),
                        ),
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.only(top: 30),
                      padding: EdgeInsets.all(15.0),
                      child: TextField(
                        style: TextStyle(
                          color: Colors.black,
                        ),
                        decoration: kTextFieldInputDecoration,
                        onChanged: (value) {
                          cityName = value;
                        },
                      ),
                    ),
                    TextButton(
                      onPressed: () {
                        Navigator.pop(context, cityName);
                      },
                      child: Text(
                        'Get Weather',
                        style: kButtonTextStyle,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
