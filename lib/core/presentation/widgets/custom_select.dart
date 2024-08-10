import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:time_tracking_app/core/constants/color_constants.dart';
import 'package:time_tracking_app/core/enums/selection_type.dart';
import 'package:time_tracking_app/core/presentation/widgets/search_list.dart';
import 'package:time_tracking_app/core/presentation/widgets/styled_text.dart';
import 'package:time_tracking_app/data/model/countries_flag.dart';
import 'package:time_tracking_app/data/model/selection.dart';
import 'package:time_tracking_app/presentation/bloc/location/location_bloc.dart';

import 'bloc_state_widget.dart';
import 'bottom_sheet_header.dart';

class CustomSelect extends StatelessWidget {
  const CustomSelect({
    super.key,
    required this.textEditingController,
    required this.selectText,
    required this.selectionType,
    this.parameter,
    required this.onItemClicked,
  });

  final TextEditingController textEditingController;
  final String selectText;
  final SelectionType selectionType;
  final String? parameter;
  final Function(String) onItemClicked;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      child: Container(
        width: MediaQuery.of(context).size.width,
        padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10.0),
          color: Theme.of(context).cardColor,
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            if (textEditingController.text.toString().isEmpty) ...{
              StyledText.titleMedium(selectText)
            } else ...{
              StyledText.titleSmall(textEditingController.text)
            },
            const Icon(Icons.keyboard_arrow_down),
          ],
        ),
      ),
      onTap: () => openBottomSheetData(context),
    );
  }

  openBottomSheetData(BuildContext context) {
    final dataToDisplay = selectionType == SelectionType.country
        ? getCountryData()
        : getCityData();

    showModalBottomSheet(
        context: context,
        clipBehavior: Clip.antiAliasWithSaveLayer,
        isScrollControlled: true,
        builder: (_) {
          return Container(
            color: Theme.of(context).disabledColor,
            child: BottomSheetHeader(
              headingText: selectText,
              widgetData: dataToDisplay,
            ),
          );
        });
  }

  Widget getCountryData() {
    return BlocProvider(
      create: (context) => LocationBloc()..add(GetCountriesEvent()),
      child: BlocBuilder<LocationBloc, LocationState>(
        builder: (context, state) {
          return BlocStateToWidget(
            message: state.message ?? '',
            blocStates: state.blocStates,
            child: displayCountryData(
              state.countriesFlag?.data ?? [],
              context,
            ),
          );
        },
      ),
    );
  }

  displayCountryData(List<CountryData> list, BuildContext context) {
    final List<SelectionData> selectionData = [];

    selectionData.addAll(
      list
          .map(
            (e) => SelectionData(
                data: '${e.name}',
                displayData: '${e.unicodeFlag}   ${e.name} '),
          )
          .toList(),
    );

    return getListData(selectionData);
  }

  Widget getCityData() {
    return BlocProvider(
      create: (context) =>
          LocationBloc()..add(GetCitiesByCountryEvent(countryName: parameter!)),
      child: BlocBuilder<LocationBloc, LocationState>(
        builder: (context, state) {
          return BlocStateToWidget(
            message: state.message ?? '',
            blocStates: state.blocStates,
            child: displayCityData(
              state.citiesByCountry?.data ?? [],
              context,
            ),
          );
        },
      ),
    );
  }

  displayCityData(List<String> list, BuildContext context) {
    final List<SelectionData> selectionData = [];

    selectionData.addAll(
      list
          .map(
            (e) => SelectionData(data: e, displayData: e),
          )
          .toList(),
    );

    return getListData(selectionData);
  }

  Widget getListData(List<SelectionData> selectionData) {
    return SearchList(
      selectionData: selectionData,
      onItemClicked: (value) => onItemClicked(value),
    );

    return ListView.separated(
      padding: EdgeInsets.zero,
      scrollDirection: Axis.vertical,
      itemCount: selectionData.length,
      itemBuilder: (context, index) {
        return InkWell(
          child: Text(
            selectionData[index].displayData,
            style: Theme.of(context).textTheme.titleSmall,
          ),
          onTap: () => onItemClicked(selectionData[index].data),
        );
      },
      separatorBuilder: (_, i) => const Divider(
        color: ColorConstants.lighterGrey,
      ),
    );
  }
}
