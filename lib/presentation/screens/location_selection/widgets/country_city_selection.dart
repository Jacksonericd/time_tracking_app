import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:time_tracking_app/core/constants/color_constants.dart';
import 'package:time_tracking_app/core/constants/route_constants.dart';
import 'package:time_tracking_app/core/constants/string_constants.dart';
import 'package:time_tracking_app/core/enums/selection_type.dart';
import 'package:time_tracking_app/core/presentation/widgets/custom_select.dart';

class CountryCitySelection extends StatefulWidget {
  const CountryCitySelection({super.key});

  @override
  State<StatefulWidget> createState() => CountryCitySelectionState();
}

class CountryCitySelectionState extends State<CountryCitySelection> {
  final tfSelectCountryController = TextEditingController();
  final tfSelectCityController = TextEditingController();

  SizedBox get vSpacingTwenty => const SizedBox(
        height: 20,
      );

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          StringConstants.selectCountryCityDescription,
          style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                color: ColorConstants.colorWhite,
              ),
        ),
        vSpacingTwenty,
        CustomSelect(
          textEditingController: tfSelectCountryController,
          selectText: StringConstants.selectCountry,
          selectionType: SelectionType.country,
          onItemClicked: (value) {
            setState(() {
              tfSelectCountryController.text = value;
              tfSelectCityController.text = '';
            });

            Navigator.of(context).pop();
          },
        ),
        vSpacingTwenty,
        Visibility(
          visible: tfSelectCountryController.text.isNotEmpty,
          child: CustomSelect(
            textEditingController: tfSelectCityController,
            selectText: StringConstants.selectCity,
            selectionType: SelectionType.city,
            parameter: tfSelectCountryController.text,
            onItemClicked: (value) {
              setState(() {});
              tfSelectCityController.text = value;
              Navigator.of(context).pop();

              Navigator.of(context).pushNamed(
                RouteConstants.weatherDetailPath,
                arguments: value.trim(),
              );
            },
          ),
        ),
      ],
    );
  }
}
