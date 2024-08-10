import 'package:flutter/material.dart';
import 'package:time_tracking_app/core/constants/color_constants.dart';
import 'package:time_tracking_app/core/constants/image_constants.dart';
import 'package:time_tracking_app/core/constants/route_constants.dart';
import 'package:time_tracking_app/core/constants/string_constants.dart';
import 'package:time_tracking_app/core/presentation/widgets/app_scaffold.dart';
import 'package:time_tracking_app/core/presentation/widgets/asset_image.dart';
import 'package:time_tracking_app/core/presentation/widgets/search_textfield.dart';

import '../widgets/country_city_selection.dart';

class LocationSelectionView extends StatelessWidget {
  LocationSelectionView({super.key});

  final tfCityNameEditingController = TextEditingController();

  SizedBox get vSpacingTwenty => const SizedBox(
        height: 20,
      );

  SizedBox get vSpacingFifty => const SizedBox(
        height: 50,
      );

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false, // App should not close on the device back button click
      child: AppScaffold(
          hideAppBar: true,
          scaffoldBody: Stack(
            fit: StackFit.loose,
            clipBehavior: Clip.none,
            children: [
              const AssetImageWidget(
                assetPath: ImageConstants.lightBackgroundPng,
                boxFit: BoxFit.cover,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(
                    horizontal: 20.0, vertical: 20.0),
                child: SafeArea(
                  child: SizedBox(
                    width: MediaQuery.of(context).size.width,
                    child: Align(
                        alignment: Alignment.topCenter,
                        child: selectionForm(context)),
                  ),
                ),
              ),
            ],
          )),
    );
  }

  Widget selectionForm(BuildContext context) {
    final isPortrait =
        MediaQuery.of(context).orientation == Orientation.portrait;

    final controlsWidth =
        isPortrait ? MediaQuery.of(context).size.width * 0.8 : 400.0;

    return SizedBox(
      width: controlsWidth,
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            vSpacingFifty,
            const CountryCitySelection(),
            vSpacingFifty,
            Text(
              StringConstants.enterCityDescription,
              style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                    color: ColorConstants.colorWhite,
                  ),
            ),
            vSpacingTwenty,
            SearchTextField(
              textEditingController: tfCityNameEditingController,
              onSearchClicked: () => Navigator.of(context).pushNamed(
                RouteConstants.weatherDetailPath,
                arguments: tfCityNameEditingController.text.trim(),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
