import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_form_bloc/flutter_form_bloc.dart';

class CustomTextFieldBlocBuilder extends StatelessWidget {
  const CustomTextFieldBlocBuilder(
      {super.key,
      this.readOnly,
      this.textAlign,
      required this.textFieldBloc,
      required this.maxLength,
      this.labelText,
      this.hintText,
      this.onChanged,
      this.suffixIcon,
      this.textStyling,
      this.labelStyling,
      this.backgroundColor,
      this.backgroundFilled,
      this.inputType,
      this.enabled,
      this.hideCounter,
      this.hideBorder,
      this.autoFocus,
      this.inputFormatters,
      this.prefixText,
      this.prefixStyle,
      this.hintStyle,
      this.isPassword,
      this.borderRadius,
      this.maxLines});

  final TextFieldBloc textFieldBloc;
  final String? labelText;
  final String? hintText;
  final int maxLength;
  final Function(String)? onChanged;
  final Widget? suffixIcon;
  final TextStyle? textStyling;
  final TextStyle? labelStyling;
  final Color? backgroundColor;
  final bool? backgroundFilled;
  final TextInputType? inputType;
  final bool? enabled;
  final bool? hideCounter;
  final bool? hideBorder;
  final bool? autoFocus;
  final bool? readOnly;
  final TextAlign? textAlign;
  final List<TextInputFormatter>? inputFormatters;
  final String? prefixText;
  final TextStyle? prefixStyle;
  final TextStyle? hintStyle;
  final bool? isPassword;
  final double? borderRadius;
  final int? maxLines;

  @override
  Widget build(BuildContext context) {
    final isPasswordField = isPassword ?? false;

    OutlineInputBorder renderBorder() => OutlineInputBorder(
          borderRadius: BorderRadius.circular(borderRadius ?? 10),
          borderSide: BorderSide(
              color: (hideBorder ?? false)
                  ? Theme.of(context).disabledColor
                  : Theme.of(context).focusColor),
        );

    OutlineInputBorder errorBorder() => OutlineInputBorder(
          borderRadius: BorderRadius.circular(borderRadius ?? 10),
          borderSide: BorderSide(color: Theme.of(context).colorScheme.error),
        );

    return TextFieldBlocBuilder(
      textFieldBloc: textFieldBloc,
      suffixButton: isPasswordField ? SuffixButton.obscureText : null,
      textAlign: textAlign ?? TextAlign.left,
      autofocus: autoFocus ?? false,
      isEnabled: enabled ?? true,
      keyboardType: inputType ?? TextInputType.text,
      maxLength: maxLength != 0 ? maxLength : null,
      onChanged: onChanged,
      textStyle: textStyling,
      padding: const EdgeInsets.only(top: 8, bottom: 0),
      inputFormatters: inputFormatters ??
          [
            FilteringTextInputFormatter.allow(
                RegExp("[A-Za-z0-9#+-.!@\$%^&*?;:{}\\()_=`\"'<>,/| ]*")),
          ],
      maxLines: maxLines ?? 1,
      minLines: 1,
      scrollPadding:
          EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
      decoration: InputDecoration(
        isDense: true,
        disabledBorder: renderBorder(),
        border: renderBorder(),
        focusedBorder: renderBorder(),
        enabledBorder: renderBorder(),
        errorBorder: errorBorder(),
        labelText: labelText,
        labelStyle: labelStyling ??
            Theme.of(context)
                .textTheme
                .titleMedium
                ?.copyWith(color: Theme.of(context).hintColor),
        hintText: hintText ?? '',
        filled: backgroundFilled ?? true,
        fillColor: backgroundColor ?? Theme.of(context).primaryColorLight,
        errorStyle: Theme.of(context).textTheme.bodySmall?.copyWith(
            color: Theme.of(context).colorScheme.error,
            fontSize: 12,
            height: 1),
        errorMaxLines: 1,
        helperMaxLines: 1,
        suffixIcon: suffixIcon ?? const SizedBox.shrink(),
        prefixText: prefixText ?? '',
        prefixStyle: prefixStyle,
        counter: const Padding(padding: EdgeInsets.zero),
        counterStyle: (hideCounter ?? true)
            ? const TextStyle(height: 0.5)
            : TextStyle(
                color: (hideCounter ?? true)
                    ? Theme.of(context).disabledColor
                    : Theme.of(context).colorScheme.error),
      ),
      readOnly: readOnly ?? false,
    );
  }
}
