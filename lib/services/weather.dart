import 'package:clima/services/location.dart';
import 'package:clima/services/networking.dart';

const apiKey = '79b1d6c3a2717f1e9c4051c1ed818e11';
const openWeatherMapURL = 'https://api.openweathermap.org/data/2.5/weather';

class WeatherModel {
  Future<dynamic> getCityWeather(String cityName) async {
    NetworkHelper networkHelper = NetworkHelper(
        '$openWeatherMapURL?q=$cityName&appid=$apiKey&units=metric');

    var weatherData = await networkHelper.getData();
    return weatherData;
  }

  Future<dynamic> getLocationWeather() async {
    Location location = Location();
    await location.getCurrentLocation();

    NetworkHelper networkHelper = NetworkHelper(
        '$openWeatherMapURL?lat=${location.latitude}&lon=${location.longitude}&appid=$apiKey&units=metric');

    var weatherData = await networkHelper.getData();
    return weatherData;
  }

  // String getWeatherIcon(int condition) {
  //   if (condition < 300) {
  //     return 'Thunderstorm';
  //   } else if (condition < 400) {
  //     return 'Drizzle';
  //   } else if (condition < 600) {
  //     return 'Rain';
  //   } else if (condition < 700) {
  //     return 'Snow';
  //     // } else if (condition < 800) {
  //     //   return '🌫';
  //   } else if (condition == 800) {
  //     return 'Clear';
  //   } else if (condition <= 804) {
  //     return 'Clouds';
  //   } else {
  //     return '🤷‍';
  //   }
  // }
  String getWeatherDes(int condition) {
    if (condition == 200) return 'thunderstorm with light rain';
    if (condition == 201) return 'thunderstorm with rain';
    if (condition == 202) return 'thunderstorm with heavy rain';
    if (condition == 210) return 'light thunderstorm';
    if (condition == 211) return 'thunderstorm';
    if (condition == 212) return 'heavy thunderstorm';
    if (condition == 221) return 'ragged thunderstorm';
    if (condition == 230) return 'thunderstorm with light drizzle';
    if (condition == 231) return 'thunderstorm with drizzle';
    if (condition == 232) return 'thunderstorm with heavy drizzle';

    if (condition == 300) return 'light intensity drizzle';
    if (condition == 301) return 'drizzle';
    if (condition == 302) return 'heavy intensity drizzle';
    if (condition == 310) return 'light intensity drizzle rain';
    if (condition == 311) return 'drizzle rain';
    if (condition == 312) return 'heavy intensity drizzle rain';
    if (condition == 313) return 'shower rain and drizzle';
    if (condition == 314) return 'heavy shower rain and drizzle';
    if (condition == 321) return 'shower drizzle';

    if (condition == 500) return 'light rain';
    if (condition == 501) return 'moderate rain';
    if (condition == 502) return 'heavy intensity rain';
    if (condition == 503) return 'very heavy rain	';
    if (condition == 504) return 'extreme rain';
    if (condition == 511) return 'freezing rain';
    if (condition == 520) return 'light intensity shower rain';
    if (condition == 521) return 'shower rain';
    if (condition == 522) return 'heavy intensity shower rain';
    if (condition == 531) return 'ragged shower rain';

    if (condition == 600) return 'light snow';
    if (condition == 601) return 'Snow';
    if (condition == 602) return 'Heavy snow';
    if (condition == 611) return 'Sleet';
    if (condition == 612) return 'Light shower sleet';
    if (condition == 613) return 'Shower sleet';
    if (condition == 615) return 'Light rain and snow';
    if (condition == 616) return 'Rain and snow';
    if (condition == 620) return 'Light shower snow';
    if (condition == 621) return 'Shower snow';
    if (condition == 622) return 'Heavy shower snow';

    if (condition == 701) return 'mist';
    if (condition == 711) return 'Smoke';
    if (condition == 721) return 'Haze';
    if (condition == 731) return 'sand/ dust whirls	';
    if (condition == 741) return 'fog';
    if (condition == 751) return 'sand';
    if (condition == 761) return 'dust';
    if (condition == 762) return 'volcanic ash	';
    if (condition == 771) return 'squalls';
    if (condition == 781) return 'tornado';

    if (condition == 800) return 'clear sky';

    if (condition == 801) return 'few clouds: 11-25%';
    if (condition == 802) return 'scattered clouds: 25-50%';
    if (condition == 803) return 'broken clouds: 51-84%';
    if (condition == 804)
      return 'overcast clouds: 85-100%';
    else {
      return 'error 404';
    }
  }

  // String getMessage(int temp) {
  //   if (temp > 25) {
  //     return 'It\'s 🍦 time';
  //   } else if (temp > 20) {
  //     return 'Time for shorts and 👕';
  //   } else if (temp < 10) {
  //     return 'You\'ll need 🧣 and 🧤';
  //   } else {
  //     return 'Bring a 🧥 just in case';
  //   }
  // }
}
