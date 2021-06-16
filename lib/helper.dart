class Helper {
  String getWeatherIcon(int condition) {
    if (condition < 300) {
      return '🌩';
    } else if (condition < 400) {
      return '🌧';
    } else if (condition < 600) {
      return '☔';
    } else if (condition < 700) {
      return '☃';
    } else if (condition < 800) {
      return '🌫';
    } else if (condition == 800) {
      return '🌞';
    } else if (condition <= 804) {
      return '☁';
    } else {
      return '😕';
    }
  }

  String bgImg(int condition) {
    if (condition < 600) {
      return "images/rainy.jpg";
    } else if (condition < 700) {
      return "images/winter.jpg";
    } else if (condition < 800) {
      return "images/wind.jpg";
    } else if (condition <= 804) {
      return "images/sun.jpg";
    }
  }

  String des(int temp) {
    if (temp > 30) {
      return 'It\'s time for some 🍨';
    } else if (temp > 20) {
      return 'Perfect time for 🌊';
    } else if (temp < 10) {
      return 'Dont go out without 🧣 and 🧤';
    } else {
      return 'Have 🧥 just in case';
    }
  }
}
