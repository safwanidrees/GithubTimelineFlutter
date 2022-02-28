import 'package:flutter/material.dart';

import 'package:github_flutter/utils/responsive_size.dart';
import 'package:github_flutter/utils/theme.dart';

class AppButton extends StatelessWidget {
  final String? buttonText;
  final Widget? centerWidget;
  final VoidCallback? callback;
  final Color? bgcolor;
  final Color? borderColor;
  final Color? textColor;
  final double? width;
  final TextStyle? fontStyle;
  final double? height;
  final double borderRadius;
  final bool isCenter;
  const AppButton({
    Key? key,
    this.buttonText,
    this.callback,
    this.bgcolor,
    this.textColor,
    this.width,
    this.fontStyle,
    this.height,
    this.borderRadius = 50,
    this.centerWidget,
    this.borderColor,
    this.isCenter = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        width:
            isCenter ? null : width ?? ResponsiveSize.sizeWidth(context) * 0.9,
        height: height ?? 56,
        decoration: BoxDecoration(
          border: Border.all(
            color: borderColor ?? bgcolor ?? AppTheme.secondaryColor,
          ),
          borderRadius: BorderRadius.circular(borderRadius),
        ),
        child: ElevatedButton(
          style: ElevatedButton.styleFrom(
            primary: bgcolor ?? AppTheme.secondaryColor,
            elevation: 0,
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(borderRadius)),
          ),
          onPressed: callback,
          child: centerWidget ??
              Text(
                buttonText!,
                style: fontStyle ??
                    TextStyle(
                        color: textColor ?? AppTheme.white,
                        fontSize: 18,
                        fontWeight: FontWeight.w500),
              ),
        ),
      ),
    );
  }
}
