import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/material.dart';
import 'package:time_tracking_app/core/constants/api_constants.dart';
import 'package:time_tracking_app/core/constants/image_constants.dart';
import 'package:time_tracking_app/core/constants/string_constants.dart';
import 'package:time_tracking_app/core/extentions/capitalize.dart';
import 'package:time_tracking_app/core/functions/common_functions.dart';
import 'package:time_tracking_app/core/presentation/widgets/app_scaffold.dart';
import 'package:time_tracking_app/core/presentation/widgets/asset_image.dart';
import 'package:time_tracking_app/core/presentation/widgets/bloc_state_widget.dart';
import 'package:time_tracking_app/core/presentation/widgets/styled_text.dart';
import 'package:time_tracking_app/data/model/weather_response.dart';
import 'package:time_tracking_app/presentation/bloc/weather/weather_bloc.dart';

class WeatherDetailView extends StatelessWidget {
  final String cityName;

  const WeatherDetailView({
    super.key,
    required this.cityName,
  });

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => WeatherBloc()
        ..add(WeatherEventByCity(
          cityName: cityName,
        )),
      child: AppScaffold(
        scaffoldBody: BlocBuilder<WeatherBloc, WeatherState>(
          builder: (context, state) {
            return BlocStateToWidget(
              message: state.message ?? '',
              blocStates: state.blocStates,
              child: displayWeatherData(
                state.weatherResponse,
                context,
              ),
            );
          },
        ),
      ),
    );
  }

  Widget displayWeatherData(
    WeatherResponse? weatherResponse,
    BuildContext context,
  ) {
    final deviceHeight = MediaQuery.of(context).size.height;

    if (weatherResponse == null) {
      return const SizedBox.shrink();
    }

    final weather = weatherResponse.weather?.first;

    final currentTemp = weatherResponse.main?.temp;
    final minTemp = weatherResponse.main?.tempMin;
    final maxTemp = weatherResponse.main?.tempMax;
    final humid = weatherResponse.main?.humidity;

    final currentTemperature = currentTemp != null
        ? double.parse(currentTemp).roundToDouble().toInt()
        : null;

    final weatherCondition = weather?.description;
    final weatherConditionIcon = weather?.icon;

    final minTemperature =
        minTemp != null ? double.parse(minTemp).roundToDouble().toInt() : null;
    final maxTemperature =
        maxTemp != null ? double.parse(maxTemp).roundToDouble().toInt() : null;
    final humidity =
        humid != null ? double.parse(humid).roundToDouble().toInt() : null;

    final windSpeed = weatherResponse.wind?.speed;
    final windSpeedConverted = (double.parse(windSpeed!) * 3.6).toInt();

    final weatherCode = weather?.id != null || weather?.id != 'null'
        ? int.parse(weather!.id.toString())
        : 0;

    var brightness = MediaQuery.of(context).platformBrightness;
    bool isDarkMode = brightness == Brightness.dark;

    final backGroundColor = isDarkMode
        ? CommonFunctions.getDarkColorByCode(weatherCode)
        : CommonFunctions.getLightColorByCode(weatherCode);

    return Container(
      height: deviceHeight,
      color: backGroundColor,
      padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
      child: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              backButton(context),
              StyledText.headlineLarge(cityName.capitalize()),
              Image.network(
                '${ApiConstants.weatherIconUrl}/$weatherConditionIcon@4x.png',
                height: 200,
              ),
              Text(
                '$currentTemperature \u2103',
                style: Theme.of(context).textTheme.headlineLarge?.copyWith(
                      fontSize: 72,
                      fontWeight: FontWeight.bold,
                    ),
              ),
              vSpacingTen,
              vSpacingTen,
              StyledText.titleLarge('${weatherCondition?.capitalize()}'),
              vSpacingTen,
              vSpacingTen,
              vSpacingTen,
              vSpacingTen,
              vSpacingTen,
              Container(
                width: MediaQuery.of(context).size.width,
                margin: const EdgeInsets.symmetric(
                    vertical: 10.0, horizontal: 10.0),
                padding: const EdgeInsets.symmetric(
                    vertical: 25.0, horizontal: 25.0),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(18.0),
                  color: Theme.of(context).cardColor,
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    StyledText.titleLarge(StringConstants.weatherInformation),
                    vSpacingTen,
                    vSpacingTen,
                    vSpacingTen,
                    tempWidgets(
                      maxTemperature: maxTemperature,
                      minTemperature: minTemperature,
                      context: context,
                    ),
                    vSpacingTen,
                    vSpacingTen,
                    vSpacingTen,
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        humidityWidget(context: context, humidity: humidity),
                        windSpeedWidget(
                            context: context, windSpeed: windSpeedConverted),
                      ],
                    ),
                    vSpacingTen,
                    vSpacingTen,
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget backButton(BuildContext context) => Align(
        alignment: Alignment.topLeft,
        child: InkWell(
          onTap: Navigator.of(context).pop,
          child: const Icon(Icons.arrow_back_ios),
        ),
      );

  Widget get vSpacingTen => const SizedBox(
        height: 10,
      );

  Widget get vSpacingFive => const SizedBox(
        height: 5,
      );

  Widget get hSpacingFive => const SizedBox(
        width: 5,
      );

  circularImage({required String path}) => CircleAvatar(
        radius: 20,
        backgroundColor: const Color(0xFFE7E7E7),
        child: AssetImageWidget(
          assetPath: path,
          boxFit: BoxFit.cover,
          height: 20,
          width: 20,
        ),
      );

  displayVerticalInfo({
    required String title,
    required String value,
    required TextStyle headingStyle,
  }) =>
      Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: headingStyle,
          ),
          StyledText.titleLarge(value),
        ],
      );

  Widget tempWidgets({
    int? minTemperature,
    int? maxTemperature,
    required BuildContext context,
  }) =>
      Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          displayVerticalInfo(
              title: StringConstants.min,
              value: '$minTemperature \u2103',
              headingStyle: Theme.of(context).textTheme.titleMedium!.copyWith(
                    fontWeight: FontWeight.normal,
                  )),
          displayVerticalInfo(
              title: StringConstants.max,
              value: '$maxTemperature \u2103',
              headingStyle: Theme.of(context).textTheme.titleMedium!.copyWith(
                    fontWeight: FontWeight.normal,
                  )),
        ],
      );

  Widget humidityWidget({
    required BuildContext context,
    int? humidity,
  }) =>
      Row(
        children: [
          circularImage(path: ImageConstants.humidityPng),
          hSpacingFive,
          hSpacingFive,
          displayVerticalInfo(
              title: StringConstants.humidity,
              value: '$humidity%',
              headingStyle: Theme.of(context).textTheme.titleSmall!.copyWith(
                    fontWeight: FontWeight.normal,
                  )),
        ],
      );

  windSpeedWidget({required BuildContext context, required int windSpeed}) =>
      Row(
        children: [
          circularImage(path: ImageConstants.windSpeedPng),
          hSpacingFive,
          hSpacingFive,
          displayVerticalInfo(
              title: StringConstants.windSpeed,
              value: '$windSpeed km/h',
              headingStyle: Theme.of(context).textTheme.titleSmall!.copyWith(
                    fontWeight: FontWeight.normal,
                  )),
        ],
      );
}
