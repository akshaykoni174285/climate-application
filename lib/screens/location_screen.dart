import 'package:flutter/material.dart';
import 'package:clima/utilities/constants.dart';
import 'package:clima/services/weather.dart';
import 'city_screen.dart';
import 'dart:ui' as ui;
import 'about.dart';

class LocationScreen extends StatefulWidget {
  LocationScreen({this.locationWeather});

  final locationWeather;

  @override
  _LocationScreenState createState() => _LocationScreenState();
}

class _LocationScreenState extends State<LocationScreen> {
  WeatherModel weather = WeatherModel();
  int temperature;
  String weatherIcon;
  String cityName;
  String weatherMessage;
  int feels_like;
  var wind_speed;
  int humdity;
  int pressure;
  String description;
  double min_temp;
  double max_temp;

  @override
  void initState() {
    super.initState();

    updateUI(widget.locationWeather);
  }

  void updateUI(dynamic weatherData) {
    setState(() {
      if (weatherData == null) {
        temperature = 0;
        weatherIcon = 'Error';
        weatherMessage = 'Unable to get weather data';
        cityName = '';
        return;
      }
      min_temp = weatherData['main']['temp_min'];
      max_temp = weatherData['main']['temp_max'];
      wind_speed = weatherData['wind']['speed'];
      pressure = weatherData['main']['pressure'];

      humdity = weatherData['main']['humidity'];

      double feels = weatherData['main']['feels_like'];
      feels_like = feels.toInt();
      double temp = weatherData['main']['temp'];
      temperature = temp.toInt();
      var condition = weatherData['weather'][0]['id'];
      weatherIcon = weather.getWeatherIcon(condition);
      weatherMessage = weather.getMessage(temperature);
      cityName = weatherData['name'];
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        shadowColor: Colors.transparent,
        // backgroundColor: Color(0x44000000),
        backgroundColor: Colors.transparent,
        title: Text(
          '$cityName',
          style: TextStyle(
            letterSpacing: 1,
          ),
        ),
        centerTitle: true,
      ),
      drawer: Drawer(
        child: Container(
          color: Color(0xFF4C566A),
          child: ListView(
            padding: EdgeInsets.zero,
            children: [
              const DrawerHeader(
                padding: EdgeInsets.all(0),
                // margin: EdgeInsets.only(top: 50),
                decoration: BoxDecoration(
                  // color: Color(0xFF434C5E),
                  image: DecorationImage(
                    fit: BoxFit.cover,
                    image: AssetImage('images/location_background.jpg'),
                  ),
                  // color: Color(0xFF81A1C1),
                ),
                child: Text(''),
              ),
              TextButton(
                onPressed: () async {
                  Navigator.pop(context);
                  var weatherData = await weather.getLocationWeather();
                  updateUI(weatherData);
                },
                child: ListTile(
                  title: const Text('Current Location Weather'),
                  leading: Icon(
                    Icons.near_me,
                    color: Color(0xFF2E3440),
                  ),
                ),
              ),
              TextButton(
                onPressed: () async {
                  Navigator.pop(context);
                  var typedName = await Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) {
                        return CityScreen();
                      },
                    ),
                  );
                  if (typedName != null) {
                    var weatherData = await weather.getCityWeather(typedName);
                    updateUI(weatherData);
                  }
                },
                child: ListTile(
                  title: const Text('Search Location'),
                  leading: Icon(
                    Icons.search,
                    color: Color(0xFF2E3440),
                  ),
                ),
              ),
              TextButton(
                child: ListTile(
                  title: const Text('About'),
                  leading: Icon(
                    Icons.info,
                    color: Color(0xFF2E3440),
                  ),
                ),
                onPressed: () {
                  Navigator.pop(context);
                  Navigator.push(context, MaterialPageRoute(builder: (context) {
                    return About();
                  }));
                },
              ),
            ],
          ),
        ),
      ),
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage('images/3bbccc23ecf2aebe5858b762e15cd8f3.jpg'),
            fit: BoxFit.cover,
            // colorFilter: ColorFilter.mode(
            //     Colors.white.withOpacity(0.8), BlendMode.dstATop),
          ),
        ),
        constraints: BoxConstraints.expand(),
        child: BackdropFilter(
          filter: ui.ImageFilter.blur(
            sigmaX: 5,
            sigmaY: 5,
          ),
          child: Container(
            color: Colors.black.withOpacity(0.1),
            child: SafeArea(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      Row(
                        textBaseline: TextBaseline.alphabetic,
                        verticalDirection: VerticalDirection.up,
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.baseline,
                        children: [
                          Text(
                            '14',
                            style: kTempTextStyle,
                          ),
                          Text(
                            '°c',
                            style: TextStyle(
                              fontSize: 30,
                            ),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 7,
                      ),
                      Text(
                        '$weatherIcon',
                        style: TextStyle(
                          fontSize: 30,
                          fontWeight: FontWeight.bold,
                          letterSpacing: 1,
                        ),
                      ),
                    ],
                  ),
                  Expanded(
                    child: Container(
                      margin: EdgeInsets.fromLTRB(20, 50, 20, 20),
                      padding: EdgeInsets.all(20),
                      decoration: BoxDecoration(
                        color: ui.Color(0xB381A1C1),
                        borderRadius: BorderRadius.all(
                          Radius.circular(20),
                        ),
                      ),
                      child: Row(
                        children: [
                          Expanded(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: [
                                Container(
                                  child: Column(
                                    children: [
                                      Text(
                                        'Minimum temp',
                                      ),
                                      SizedBox(
                                        height: 8,
                                      ),
                                      Text(
                                        '$min_temp°c',
                                        style: KDetailStyle,
                                      ),
                                    ],
                                  ),
                                ),
                                Container(
                                  child: Column(
                                    children: [
                                      Text(
                                        'Real feel',
                                      ),
                                      SizedBox(
                                        height: 8,
                                      ),
                                      Text(
                                        '$feels_like°c',
                                        style: KDetailStyle,
                                      ),
                                    ],
                                  ),
                                ),
                                Container(
                                  child: Column(
                                    children: [
                                      Text(
                                        'Wind speed',
                                      ),
                                      SizedBox(
                                        height: 8,
                                      ),
                                      Text(
                                        '$wind_speed Km/h',
                                        style: KDetailStyle,
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Expanded(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: [
                                Container(
                                  child: Column(
                                    children: [
                                      Text(
                                        'Maximum temp',
                                      ),
                                      SizedBox(
                                        height: 8,
                                      ),
                                      Text(
                                        '$max_temp°c',
                                        style: KDetailStyle,
                                      ),
                                    ],
                                  ),
                                ),
                                Container(
                                  child: Column(
                                    children: [
                                      Text(
                                        'Humidity',
                                      ),
                                      SizedBox(
                                        height: 8,
                                      ),
                                      Text(
                                        '$humdity%',
                                        style: KDetailStyle,
                                      ),
                                    ],
                                  ),
                                ),
                                Container(
                                  child: Column(
                                    children: [
                                      Text(
                                        'Pressure',
                                      ),
                                      SizedBox(
                                        height: 8,
                                      ),
                                      Text(
                                        '$pressure mbar',
                                        style: KDetailStyle,
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
