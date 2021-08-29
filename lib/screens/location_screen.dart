import 'package:flutter/material.dart';
import 'package:clima/utilities/constants.dart';
import 'package:clima/services/weather.dart';
import 'city_screen.dart';
import 'dart:ui';

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
        backgroundColor: Color(0x44000000),
        title: Text('Climate App'),
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
          filter: ImageFilter.blur(
            sigmaX: 5,
            sigmaY: 5,
          ),
          child: Container(
            color: Colors.black.withOpacity(0.1),
            child: SafeArea(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: <Widget>[
                  Padding(
                    padding: EdgeInsets.only(left: 15.0),
                    child: Row(
                      children: <Widget>[
                        Text(
                          '$temperature°',
                          style: kTempTextStyle,
                        ),
                        Text(
                          weatherIcon,
                          style: kConditionTextStyle,
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(right: 15.0),
                    child: Text(
                      '$weatherMessage in $cityName',
                      textAlign: TextAlign.right,
                      style: kMessageTextStyle,
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
