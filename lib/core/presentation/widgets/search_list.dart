import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:time_tracking_app/core/constants/color_constants.dart';
import 'package:time_tracking_app/core/constants/string_constants.dart';
import 'package:time_tracking_app/core/presentation/widgets/styled_text.dart';
import 'package:time_tracking_app/data/model/selection.dart';

class SearchList extends StatefulWidget {
  const SearchList({
    super.key,
    required this.selectionData,
    required this.onItemClicked,
  });

  final List<SelectionData> selectionData;
  final Function(String) onItemClicked;

  @override
  State<StatefulWidget> createState() => SearchListState();
}

class SearchListState extends State<SearchList> {
  late List<SelectionData> selectionData;
  late List<SelectionData> searchedData;

  @override
  void initState() {
    selectionData = widget.selectionData;
    searchedData = widget.selectionData;

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        TextField(
          inputFormatters: [
            FilteringTextInputFormatter.allow(RegExp("[A-Za-z ]*"))
          ],
          onChanged: (value) {
            searchedData = selectionData
                .where(
                    (e) => e.data.toLowerCase().contains(value.toLowerCase()))
                .toList();

            setState(() {});
          },
          style: Theme.of(context).textTheme.titleSmall,
          decoration: InputDecoration(
            contentPadding: const EdgeInsets.all(10.0),
            disabledBorder: _renderBorder(context),
            border: _renderBorder(context),
            focusedBorder: _renderBorder(context),
            enabledBorder: _renderBorder(context),
            hintText: StringConstants.search,
            hintStyle: Theme.of(context).textTheme.titleMedium,
            filled: true,
            fillColor: Theme.of(context).cardColor,
          ),
        ),
        const SizedBox(
          height: 10,
        ),
        if (searchedData.isNotEmpty) ...{displayDataList} else ...{noDataFound},
      ],
    );
  }

  Widget get displayDataList => Expanded(
        child: ListView.separated(
          padding: EdgeInsets.zero,
          scrollDirection: Axis.vertical,
          itemCount: searchedData.length,
          itemBuilder: (context, index) {
            return InkWell(
              child: StyledText.titleSmall(searchedData[index].displayData),
              onTap: () => widget.onItemClicked(searchedData[index].data),
            );
          },
          separatorBuilder: (_, i) => dividerWidget,
        ),
      );

  Widget get noDataFound =>
      StyledText.bodySmall(StringConstants.noResultsFound);

  Widget get dividerWidget => const Divider(
        color: ColorConstants.lighterGrey,
      );

  OutlineInputBorder _renderBorder(BuildContext context) => OutlineInputBorder(
        borderRadius: BorderRadius.circular(10),
        borderSide: BorderSide(color: Theme.of(context).focusColor),
      );
}
