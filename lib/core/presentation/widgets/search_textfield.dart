import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:time_tracking_app/core/constants/string_constants.dart';

class SearchTextField extends StatefulWidget {
  const SearchTextField({
    Key? key,
    required this.textEditingController,
    required this.onSearchClicked,
  }) : super(key: key);

  final TextEditingController textEditingController;
  final VoidCallback onSearchClicked;

  @override
  State<StatefulWidget> createState() => SearchTextFieldState();
}

class SearchTextFieldState extends State<SearchTextField> {
  bool hasTypingErrorOrNull = true;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: widget.textEditingController,
      autovalidateMode: AutovalidateMode.onUserInteraction,
      keyboardType: TextInputType.text,
      maxLength: 30,
      onChanged: (value) {
        hasTypingErrorOrNull =
            widget.textEditingController.text.trim().isEmpty;
        setState(() {});
      },
      style: Theme.of(context).textTheme.titleSmall,
      inputFormatters: [
        FilteringTextInputFormatter.allow(RegExp("[A-Za-z ]*"))
      ],
      validator: (val) {
        if (val.toString().isNotEmpty && val?[0] == ' ') {
          hasTypingErrorOrNull = true;
          return StringConstants.firstCharacterSpaceError;
        }

        return null;
      },
      onEditingComplete: !hasTypingErrorOrNull &&
              widget.textEditingController.text.trim().isNotEmpty
          ? widget.onSearchClicked
          : null,
      decoration: InputDecoration(
        contentPadding: const EdgeInsets.all(10.0),
        disabledBorder: _renderBorder(context),
        border: _renderBorder(context),
        focusedBorder: _renderBorder(context),
        enabledBorder: _renderBorder(context),
        hintText: StringConstants.searchCity,
        hintStyle: Theme.of(context).textTheme.titleMedium,
        filled: true,
        fillColor: Theme.of(context).cardColor,
        errorStyle: Theme.of(context).textTheme.labelLarge?.copyWith(
              color: Theme.of(context).colorScheme.error,
            ),
        suffixIcon: !hasTypingErrorOrNull
            ? InkWell(
                onTap: widget.onSearchClicked,
                child: const Icon(Icons.search),
              )
            : const SizedBox.shrink(),
        counter: const SizedBox.shrink(),
      ),
    );
  }

  OutlineInputBorder _renderBorder(BuildContext context) => OutlineInputBorder(
        borderRadius: BorderRadius.circular(10),
        borderSide: BorderSide(color: Theme.of(context).focusColor),
      );
}
