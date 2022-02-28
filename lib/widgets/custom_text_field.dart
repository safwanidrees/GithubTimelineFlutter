import 'package:flutter/material.dart';

import 'package:github_flutter/utils/responsive_size.dart';
import 'package:github_flutter/utils/theme.dart';

class CustomTextFiled extends StatefulWidget {
  final String? hintText;
  final TextEditingController? controller;
  final bool hideText;
  final TextInputType? keybardType;
  final TextInputAction textInputAction;
  final TextAlign textAlign;
  final Widget? preffixIcon;
  final Widget? suffixIcon;
  final int maxLines;
  final int? maxWords;
  final Color borderColor;
  final double radius;
  final Function? onEditingComplete;
  final Function(String)? onChanged;
  final Function? validation;
  final Function? onTap;
  final Function(String)? onFieldSubmit;
  final bool showCounter;
  final bool enabled;
  final Color fillColor;
  final Color textColor;
  final bool isDense;
  final double? width;
  const CustomTextFiled(
      {Key? key,
      this.hintText = '',
      this.controller,
      this.hideText = false,
      this.keybardType,
      this.onChanged,
      this.validation,
      this.textAlign = TextAlign.left,
      this.onTap,
      this.onEditingComplete,
      this.preffixIcon,
      this.suffixIcon,
      this.maxLines = 1,
      this.onFieldSubmit,
      this.maxWords,
      this.textInputAction = TextInputAction.next,
      this.borderColor = AppTheme.white,
      this.radius = 10.0,
      this.showCounter = true,
      this.enabled = true,
      this.isDense = false,
      this.fillColor = AppTheme.white,
      this.textColor = AppTheme.secondaryColor,
      this.width})
      : super(key: key);

  @override
  _CustomTextFiledState createState() => _CustomTextFiledState();
}

class _CustomTextFiledState extends State<CustomTextFiled> {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: widget.width ?? ResponsiveSize.sizeWidth(context),
      child: TextFormField(
        key: widget.key,
        onChanged: widget.onChanged,
        controller: widget.controller,
        obscureText: widget.hideText,
        textAlign: widget.textAlign,
        onEditingComplete: widget.onEditingComplete as void Function()?,
        style: TextStyle(
            color: widget.textColor, fontSize: 14, fontWeight: FontWeight.w400),
        textInputAction: widget.textInputAction,
        keyboardType: widget.keybardType,
        validator: widget.validation as String? Function(String?)?,
        onTap: widget.onTap as void Function()?,
        onFieldSubmitted: widget.onFieldSubmit!,
        maxLines: widget.maxLines,
        maxLength: widget.maxWords,
        decoration: InputDecoration(
            enabled: widget.enabled,
            counterText: !widget.showCounter ? "" : null,
            prefixIcon: widget.preffixIcon,
            prefixIconConstraints:
                const BoxConstraints(maxHeight: 23, minHeight: 23),
            suffixIcon: widget.suffixIcon,
            suffixIconConstraints:
                const BoxConstraints(maxHeight: 23, minHeight: 23),
            isDense: widget.isDense,
            contentPadding: const EdgeInsets.all(10),
            border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(widget.radius),
                borderSide: BorderSide(color: widget.borderColor, width: 1)),
            focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(widget.radius),
                borderSide: BorderSide(color: widget.borderColor, width: 1)),
            enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(widget.radius),
                borderSide: BorderSide(color: widget.borderColor, width: 1)),
            filled: true,
            hintStyle: const TextStyle(
                fontSize: 14,
                color: AppTheme.secondaryColor,
                fontWeight: FontWeight.w400),
            hintText: widget.hintText,
            fillColor: widget.fillColor),
      ),
    );
  }
}
