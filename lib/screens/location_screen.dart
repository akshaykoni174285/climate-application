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
      wind_speed = weatherData['wind']['speed'];

      print(wind_speed);
      humdity = weatherData['main']['humidity'];
      print(humdity);
      double feels = weatherData['main']['feels_like'];
      feels_like = feels.toInt();
      print(feels_like);
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
        title: Text('$cityName'),
        centerTitle: true,
      ),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            const DrawerHeader(
              padding: EdgeInsets.all(0),
              margin: EdgeInsets.only(top: 50),
              decoration: BoxDecoration(
                image: DecorationImage(
                  fit: BoxFit.cover,
                  image: AssetImage('images/location_background.jpg'),
                ),
                color: Color(0xFF4C566A),
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
                ),
              ),
            ),
            TextButton(
              child: ListTile(
                title: const Text('About'),
                leading: Icon(Icons.info),
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
                      Text('cloudy'),
                      SizedBox(
                        height: 30,
                      ),
                      Text('air purify percenteage'),
                    ],
                  ),
                  Expanded(
                    child: Container(
                      margin: EdgeInsets.fromLTRB(20, 50, 20, 20),
                      padding: EdgeInsets.all(25),
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
                                      Text('Real feel'),
                                      SizedBox(
                                        height: 8,
                                      ),
                                      Text('$feels_like°c'),
                                    ],
                                  ),
                                ),
                                Container(
                                  child: Column(
                                    children: [
                                      Text('Wind speed'),
                                      SizedBox(
                                        height: 8,
                                      ),
                                      Text('hello'),
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
                                      Text('Humidity'),
                                      SizedBox(
                                        height: 8,
                                      ),
                                      Text('$humdity%'),
                                    ],
                                  ),
                                ),
                                Container(
                                  child: Column(
                                    children: [
                                      Text('Pressure'),
                                      SizedBox(
                                        height: 8,
                                      ),
                                      Text('hello'),
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

// Padding(
// padding: EdgeInsets.only(left: 15.0),
// child: Row(
// children: <Widget>[
// Text(
// '$temperature°',
// style: kTempTextStyle,
// ),
// Text(
// weatherIcon,
// style: kConditionTextStyle,
// ),
// ],
// ),
// ),
// Padding(
// padding: EdgeInsets.only(right: 15.0),
// child: Text(
// '$weatherMessage in $cityName',
// textAlign: TextAlign.right,
// style: kMessageTextStyle,
// ),
// ),
