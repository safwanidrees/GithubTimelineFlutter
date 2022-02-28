import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:github_flutter/core/bloc/theme_bloc/theme_bloc.dart';
import 'package:github_flutter/utils/responsive_size.dart';
import 'package:provider/provider.dart';

class LoaderDialog extends StatelessWidget {
  const LoaderDialog({
    Key? key,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      backgroundColor: Colors.transparent,
      insetPadding: EdgeInsets.symmetric(
          vertical: 50, horizontal: ResponsiveSize.sizeWidth(context) * 0.31),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)),
      elevation: 0.0,
      content: Container(
        width: 10,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10.0),
          color: Theme.of(context).backgroundColor,
        ),
        padding: const EdgeInsets.only(top: 20, bottom: 20),
        child: Column(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // const SizedBox(height: 20),
              kIsWeb
                  ? const CircularProgressIndicator()
                  : Platform.isIOS
                      ? Theme(
                          data: ThemeData(
                              cupertinoOverrideTheme: CupertinoThemeData(
                                  brightness: Provider.of<ThemeBloc>(context,
                                              listen: false)
                                          .darkTheme
                                      ? Brightness.dark
                                      : Brightness.light)),
                          child: const CupertinoActivityIndicator())
                      : CircularProgressIndicator(
                          valueColor: AlwaysStoppedAnimation<Color>(
                              Theme.of(context).cardColor),
                        ),
              const Padding(
                padding: EdgeInsets.only(top: 15),
                child: Text(
                  "Loading... ",
                  textAlign: TextAlign.center,
                ),
              ),
            ]),
      ),
    );
  }
}
