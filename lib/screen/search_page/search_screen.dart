import 'package:flutter/material.dart';
import 'package:github_flutter/core/bloc/theme_bloc/theme_bloc.dart';
import 'package:github_flutter/routes/routes.dart';
import 'package:github_flutter/utils/app_images.dart';
import 'package:github_flutter/utils/responsive_size.dart';
import 'package:github_flutter/utils/theme.dart';
import 'package:github_flutter/widgets/app_button.dart';
import 'package:github_flutter/widgets/custom_text_field.dart';
import 'package:provider/provider.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({Key? key}) : super(key: key);

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  final TextEditingController _usernameController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey();
  void submit() {
    if (!_formKey.currentState!.validate()) {
      return;
    }
    Routes.toPage(
      context,
      "/profile/${_usernameController.text.trim()}",
      replace: false,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: Stack(
        children: [
          Container(
            margin: const EdgeInsets.all(25),
            child: Form(
                key: _formKey,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    Image.asset(
                      AppImages.github_logo,
                      color: Theme.of(context).cardColor,
                    ),
                    const SizedBox(
                      height: 50,
                    ),
                    CustomTextFiled(
                      key: const ValueKey('input.username'),
                      width: ResponsiveSize.isMobile(context)
                          ? ResponsiveSize.sizeWidth(context)
                          : 400,
                      controller: _usernameController,
                      // borderColor: AppTheme.secondaryColor,
                      hintText: "Enter Your github Username",
                      fillColor: Colors.grey[200]!,
                      onFieldSubmit: (v) {
                        submit();
                      },
                      validation: (value) {
                        if (value!.isEmpty) {
                          return 'Please write Something';
                        }
                      },
                    ),
                    const SizedBox(height: 30),
                    AppButton(
                      key: const ValueKey('button.check'),
                      width: ResponsiveSize.isMobile(context)
                          ? ResponsiveSize.sizeWidth(context)
                          : 400,
                      bgcolor: AppTheme.fillColor,
                      textColor: Theme.of(context).scaffoldBackgroundColor,
                      callback: () {
                        submit();
                      },
                      buttonText: 'Check',
                    ),
                  ],
                )),
          ),
          Positioned(
            top: 10,
            right: 20,
            child: Visibility(
              visible: true,
              child: FloatingActionButton(
                onPressed: () {
                  context.read<ThemeBloc>().darkTheme =
                      !context.read<ThemeBloc>().darkTheme;
                },
                child: Icon(
                  context.watch<ThemeBloc>().darkTheme
                      ? Icons.wb_sunny_outlined
                      : Icons.nightlight_round,
                  color: Theme.of(context).iconTheme.color,
                ),
              ),
            ),
          ),
        ],
      )),
    );
  }
}
