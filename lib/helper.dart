class Helper {
  String getWeatherIcon(int condition) {
    if (condition < 300) {
      return '๐ฉ';
    } else if (condition < 400) {
      return '๐ง';
    } else if (condition < 600) {
      return 'โ';
    } else if (condition < 700) {
      return 'โ';
    } else if (condition < 800) {
      return '๐ซ';
    } else if (condition == 800) {
      return '๐';
    } else if (condition <= 804) {
      return 'โ';
    } else {
      return '๐';
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
      return 'It\'s time for some ๐จ';
    } else if (temp > 20) {
      return 'Perfect time for ๐';
    } else if (temp < 10) {
      return 'Dont go out without ๐งฃ and ๐งค';
    } else {
      return 'Have ๐งฅ just in case';
    }
  }
}
