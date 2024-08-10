import 'package:flutter/material.dart';

import '../constants/color_constants.dart';

class CommonFunctions {
  static Color getLightColorByCode(int colorCode) {
    if (colorCode >= 200 && colorCode < 300) {
      return ColorConstants.colorThunderstormLight;
    }
    if (colorCode >= 300 && colorCode < 500) {
      return ColorConstants.colorDrizzleLight;
    }
    if (colorCode >= 500 && colorCode < 600) {
      return ColorConstants.colorRainLight;
    }
    if (colorCode >= 600 && colorCode < 700) {
      return ColorConstants.colorSnowLight;
    }
    if (colorCode >= 700 && colorCode < 800) {
      return ColorConstants.colorAtmosphereLight;
    }
    if (colorCode == 800) {
      return ColorConstants.colorClearLight;
    }
    if (colorCode > 800) {
      return ColorConstants.colorCloudsLight;
    }

    return ColorConstants.colorCloudsLight;
  }

  static Color getDarkColorByCode(int colorCode) {
    if (colorCode >= 200 && colorCode < 300) {
      return ColorConstants.colorThunderstormDark;
    }
    if (colorCode >= 300 && colorCode < 500) {
      return ColorConstants.colorDrizzleDark;
    }
    if (colorCode >= 500 && colorCode < 600) {
      return ColorConstants.colorRainDark;
    }
    if (colorCode >= 600 && colorCode < 700) {
      return ColorConstants.colorSnowDark;
    }
    if (colorCode >= 700 && colorCode < 800) {
      return ColorConstants.colorAtmosphereDark;
    }
    if (colorCode == 800) {
      return ColorConstants.colorClearDark;
    }
    if (colorCode > 800) {
      return ColorConstants.colorCloudsDark;
    }

    return ColorConstants.colorCloudsLight;
  }
}
