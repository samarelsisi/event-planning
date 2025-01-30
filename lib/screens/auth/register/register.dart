import 'package:easy_localization/easy_localization.dart';
import 'package:event_palnning_project/main.dart';
import 'package:event_palnning_project/screens/homescreen.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

import '../../../style/app_colors.dart';
import '../../../style/app_styles.dart';
import '../../../style/assets_manager.dart';
import '../../../widget/custom_elevated_button.dart';
import '../../../widget/custome_test_filed.dart';
import '../login/login_screen.dart';

class RegisterScreen extends StatefulWidget {
  static const String routeName = 'register_screen';

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  var nameController = TextEditingController(text: 'samar');
  var emailController = TextEditingController(text: 'samarelsisi@route');
  var passwordController = TextEditingController(text: '123456');
  var rePasswordController = TextEditingController(text: '123456');
  var formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          "register".tr(),
          style: AppStyles.medium16Black,
        ),
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(
          horizontal: width * 0.02,
        ),
        child: SingleChildScrollView(
          child: Form(
            key: formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Image.asset(
                  AssetsManager.logo,
                  height: height * 0.25,
                ),
                SizedBox(
                  height: height * 0.02,
                ),
                CustomTextField(
                  controller: nameController,
                  validator: (text) {
                    if (text == null || text.trim().isEmpty) {
                      return 'Please enter name';
                    }
                    return null;
                  },
                  hintText: "name".tr(),
                  prefixIcon: Image.asset(AssetsManager.iconName),
                ),
                SizedBox(
                  height: height * 0.02,
                ),
                CustomTextField(
                  controller: emailController,
                  keyboardType: TextInputType.emailAddress,
                  validator: (text) {
                    if (text == null || text.trim().isEmpty) {
                      return 'Please enter email';
                    }
                    final bool emailValid = RegExp(
                            r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
                        .hasMatch(text);
                    if (!emailValid) {
                      return 'Please enter valid email.';
                    }
                    return null;
                  },
                  hintText: "email".tr(),
                  prefixIcon: Image.asset(AssetsManager.iconEmail),
                ),
                SizedBox(
                  height: height * 0.02,
                ),
                CustomTextField(
                  obscureText: true,
                  controller: passwordController,
                  keyboardType: TextInputType.phone,
                  validator: (text) {
                    if (text == null || text.trim().isEmpty) {
                      return 'Please enter password';
                    }
                    if (text.length < 6) {
                      return 'Password should be at least 6 chars.';
                    }
                    return null;
                  },
                  hintText: "password".tr(),
                  prefixIcon: Image.asset(AssetsManager.iconPassword),
                  suffixIcon: Image.asset(AssetsManager.iconShowPassword),
                ),
                SizedBox(
                  height: height * 0.02,
                ),
                CustomTextField(
                  obscureText: true,
                  controller: rePasswordController,
                  keyboardType: TextInputType.number,
                  validator: (text) {
                    if (text == null || text.trim().isEmpty) {
                      return 'Please enter Re-password';
                    }
                    if (text.length < 6) {
                      return 'Password should be at least 6 chars.';
                    }
                    if (text != passwordController.text) {
                      return "Re-Password doesn't match password";
                    }
                    return null;
                  },
                  hintText: "re_password".tr(),
                  prefixIcon: Image.asset(AssetsManager.iconPassword),
                  suffixIcon: Image.asset(AssetsManager.iconShowPassword),
                ),
                SizedBox(
                  height: height * 0.02,
                ),
                CustomElevatedButton(
                  onButtonClicked: () {
                    Navigator.pushNamed(context, Homescreen.routeName);
                  },
                  text: "create_account".tr(),
                ),
                SizedBox(
                  height: height * 0.02,
                ),
                Text.rich(
                    textAlign: TextAlign.center,
                    TextSpan(children: [
                      TextSpan(
                          text: "already_have_account".tr(),
                          style: AppStyles.medium16Black),
                      TextSpan(
                          recognizer: TapGestureRecognizer()
                            ..onTap = () {
                              Navigator.of(context)
                                  .pushReplacementNamed(LoginScreen.routeName);
                            },
                          text: "login".tr(),
                          style: AppStyles.bold16Primary.copyWith(
                            decoration: TextDecoration.underline,
                            decorationColor: AppColors.primaryLight,
                          )),
                    ])),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
