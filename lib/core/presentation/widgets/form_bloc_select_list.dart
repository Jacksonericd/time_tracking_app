import 'package:flutter/material.dart';
import 'package:flutter_form_bloc/flutter_form_bloc.dart';
import 'package:time_tracking_app/core/constants/string_constants.dart';
import 'package:time_tracking_app/data/model/multi_data.dart';

class FormBlocSelectList extends StatelessWidget {
  const FormBlocSelectList({
    super.key,
    required this.selectFieldBloc,
    required this.defaultText,
  });

  final SelectFieldBloc<MultiData, dynamic> selectFieldBloc;
  final String defaultText;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SelectFieldBloc, SelectFieldBlocState>(
        bloc: selectFieldBloc,
        builder: (context, state) {
          final text = (state.value?.description ?? defaultText).toString();

          return InkWell(
            child: Column(
              children: [
                Container(
                  height: 50,
                  padding: const EdgeInsets.all(10),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: Theme.of(context).primaryColorLight,
                      border:
                          Border.all(color: Theme.of(context).disabledColor)),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        child: Text(
                          text,
                          style: Theme.of(context)
                              .textTheme
                              .titleMedium
                              ?.copyWith(
                                  color: text == defaultText
                                      ? Theme.of(context).hintColor
                                      : Theme.of(context).primaryColorDark,
                                  fontWeight: FontWeight.w400),
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(right: 8),
                        child: Icon(
                          text == defaultText
                              ? Icons.arrow_right
                              : Icons.arrow_drop_down,
                          color: Theme.of(context).primaryColorDark,
                        ),
                      ),
                      // icon ?? const SizedBox.shrink()
                    ],
                  ),
                ),
                if (state.canShowError) ...{
                  Align(
                      alignment: Alignment.centerLeft,
                      child: Text("  ${state.error}",
                          style:
                              Theme.of(context).textTheme.bodySmall?.copyWith(
                                    color: Theme.of(context).colorScheme.error,
                                  )))
                }
              ],
            ),
            onTap: () => openPopupList(selectFieldBloc, context),
          );
        });
  }

  void openPopupList(
    SelectFieldBloc<MultiData, dynamic> selectItemName,
    BuildContext context,
  ) {
    final data = selectItemName.state.items;

    List<Widget> popupContent = [const Text(StringConstants.noDataAvailable)];

    if (data.isNotEmpty) {
      popupContent = data
          .map((item) => InkWell(
                onTap: () {
                  selectFieldBloc.updateValue(item);
                  Navigator.of(context).pop();
                },
                child: Padding(
                  padding:
                      const EdgeInsets.symmetric(vertical: 10, horizontal: 5),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(item.description),
                      const Icon(Icons.arrow_right)
                    ],
                  ),
                ),
              ))
          .toList();
    }

    showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Text(defaultText),
            content: SingleChildScrollView(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: popupContent,
              ),
            ),
          );
        });
  }
}
