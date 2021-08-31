import 'package:flutter/material.dart';
import 'package:clima/utilities/constants.dart';
import 'package:clima/services/weather.dart';
import 'city_screen.dart';
import 'dart:ui' as ui;
import 'about.dart';
import 'package:url_launcher/url_launcher.dart';

class LocationScreen extends StatefulWidget {
  LocationScreen({this.locationWeather});

  final locationWeather;

  @override
  _LocationScreenState createState() => _LocationScreenState();
}

class _LocationScreenState extends State<LocationScreen> {
  WeatherModel weather = WeatherModel();
  int temperature;
  String weatherdes;
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
        weatherdes = 'Error';
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
      weatherdes = weather.getWeatherDes(condition);
      //weatherMessage = weather.getMessage(temperature);
      cityName = weatherData['name'];
    });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
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
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topRight,
                end: Alignment.bottomLeft,
                colors: [Color(0xFF548ba3), Color(0xFFA3BE8C)],
              ),
            ),
            // color: Color(0xFF548ba3),
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
                      image: AssetImage('images/download.png'),
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
                    title: const Text(
                      'Current Location Weather',
                    ),
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
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) {
                      return About();
                    }));
                  },
                ),
                TextButton(
                  onPressed: () async {
                    const url =
                        'https://github.com/akshaykoni174285/climate-application';
                    if (await canLaunch(url)) {
                      await launch(url, forceSafariVC: true);
                    } else {
                      throw 'could not launch the url';
                    }
                  },
                  child: ListTile(
                    leading: Icon(
                      Icons.code,
                      color: Color(0xFF2E3440),
                    ),
                    title: const Text('Github'),
                  ),
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
                    Expanded(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Padding(
                            padding: const EdgeInsets.fromLTRB(0, 20, 0, 0),
                            child: Row(
                              textBaseline: TextBaseline.alphabetic,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisSize: MainAxisSize.min,
                              // mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                SizedBox(
                                  width: 30,
                                ),
                                Text(
                                  '$temperature',
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
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Container(
                            child: Padding(
                              padding: EdgeInsets.fromLTRB(20, 20, 20, 20),
                              child: Text(
                                '$weatherdes',
                                // 'heavy intensity drizzle rain	',
                                style: TextStyle(
                                  fontSize: 30,
                                  fontWeight: FontWeight.bold,
                                  letterSpacing: 2,
                                ),
                                textAlign: TextAlign.center,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Expanded(
                      child: Container(
                        margin: EdgeInsets.fromLTRB(10, 10, 10, 10),
                        padding: EdgeInsets.all(10),
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
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceAround,
                                children: [
                                  Container(
                                    child: Column(
                                      children: [
                                        Text(
                                          'Minimum temp',
                                          style: TextStyle(
                                            letterSpacing: 1,
                                          ),
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
                                          'Feels like',
                                          style: TextStyle(
                                            letterSpacing: 1,
                                          ),
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
                                          style: TextStyle(
                                            letterSpacing: 1,
                                          ),
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
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceAround,
                                children: [
                                  Container(
                                    child: Column(
                                      children: [
                                        Text(
                                          'Maximum temp',
                                          style: TextStyle(
                                            letterSpacing: 1,
                                          ),
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
                                          style: TextStyle(
                                            letterSpacing: 1,
                                          ),
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
                                          style: TextStyle(
                                            letterSpacing: 1,
                                          ),
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
      ),
    );
  }
}
