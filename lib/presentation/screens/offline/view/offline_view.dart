import 'package:flutter/material.dart';
import 'package:time_tracking_app/core/constants/image_constants.dart';
import 'package:time_tracking_app/core/constants/string_constants.dart';
import 'package:time_tracking_app/core/presentation/widgets/app_scaffold.dart';
import 'package:time_tracking_app/core/presentation/widgets/asset_image.dart';
import 'package:time_tracking_app/core/presentation/widgets/styled_text.dart';

class OfflineView extends StatelessWidget {
  const OfflineView({super.key});

  @override
  Widget build(BuildContext context) {
    return AppScaffold(
      scaffoldBody: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          offlinePng,
          connectInternetWidget(context),
        ],
      ),
    );
  }
}

Widget get offlinePng => const AssetImageWidget(
  assetPath: ImageConstants.offlinePng,
  boxFit: BoxFit.cover,
  height: 130,
  width: 130,
);

Widget connectInternetWidget(BuildContext context) => Center(
      child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
          child: Text(
            StringConstants.connectInternet,
            textAlign: TextAlign.center,
            style: Theme.of(context).textTheme.headlineSmall,
          )),
    );
