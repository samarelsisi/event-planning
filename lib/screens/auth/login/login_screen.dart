import 'package:easy_localization/easy_localization.dart';
import 'package:event_palnning_project/firebase/firebase_manager.dart';
import 'package:event_palnning_project/screens/homescreen.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import '../../../style/app_colors.dart';
import '../../../style/app_styles.dart';
import '../../../style/assets_manager.dart';
import '../../../widget/custom_elevated_button.dart';
import '../../../widget/custome_test_filed.dart';
import '../register/register.dart';

class LoginScreen extends StatefulWidget {
  static const String routeName = 'login_screen';

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  var emailController = TextEditingController(text: '');
  var passwordController = TextEditingController(text: '');
  var formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    return Scaffold(
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
                SizedBox(
                  height: height * 0.04,
                ),
                Image.asset(
                  AssetsManager.logo,
                  height: height * 0.25,
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
                TextButton(
                    onPressed: () {
                      //todo: navigate to forget password screen
                    },
                    child: Align(
                      alignment: Alignment.centerRight,
                      child: Text(
                        "forget_password".tr(),
                        style: AppStyles.bold16Primary.copyWith(
                            decoration: TextDecoration.underline,
                            decorationColor: AppColors.primaryLight),
                      ),
                    )),
                SizedBox(
                  height: height * 0.02,
                ),
                CustomElevatedButton(
                  onButtonClicked: () {
                    if (formKey.currentState!.validate()) {
                      FirebaseManager.login(
                          emailController.text, passwordController.text, () {
                        showDialog(
                          context: context,
                          builder: (context) => const AlertDialog(
                            backgroundColor: Colors.transparent,
                            title: Center(child: CircularProgressIndicator()),
                          ),
                        );
                      }, () {
                        Navigator.pop(context);
                        Navigator.pushNamedAndRemoveUntil(
                          context,
                          Homescreen.routeName,
                          (route) => false,
                        );
                      }, (message) {
                        Navigator.pop(context);
                        showDialog(
                          context: context,
                          builder: (context) => AlertDialog(
                            title: const Text("Something went wrong"),
                            content: Text(message),
                            actions: [
                              ElevatedButton(
                                  onPressed: () {
                                    Navigator.pop(context);
                                  },
                                  child: Text("OK"))
                            ],
                          ),
                        );
                      });
                    }
                  },
                  text: "login".tr(),
                ),
                SizedBox(
                  height: height * 0.02,
                ),
                Text.rich(
                    textAlign: TextAlign.center,
                    TextSpan(children: [
                      TextSpan(
                          text: "do_not_have_an_account".tr(),
                          style: AppStyles.medium16Black),
                      TextSpan(
                          recognizer: TapGestureRecognizer()
                            ..onTap = () {
                              Navigator.of(context)
                                  .pushNamed(RegisterScreen.routeName);
                            },
                          text: "create_account".tr(),
                          style: AppStyles.bold16Primary.copyWith(
                            decoration: TextDecoration.underline,
                            decorationColor: AppColors.primaryLight,
                          )),
                    ])),
                SizedBox(
                  height: height * 0.02,
                ),
                Row(
                  children: [
                    const Expanded(
                      child: Divider(
                        thickness: 2,
                        color: AppColors.primaryLight,
                        endIndent: 20,
                        indent: 20,
                      ),
                    ),
                    Text(
                      "or".tr(),
                      style: AppStyles.medium16Primary,
                    ),
                    const Expanded(
                      child: Divider(
                        endIndent: 20,
                        indent: 20,
                        thickness: 2,
                        color: AppColors.primaryLight,
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: height * 0.02,
                ),
                CustomElevatedButton(
                    onButtonClicked: () {
                      FirebaseManager.signInWithGoogle();
                    },
                    backgroundColor: AppColors.transparentColor,
                    textStyle: AppStyles.medium16Primary,
                    icon: Image.asset(AssetsManager.iconGoogle),
                    text: "login_with_google".tr())
              ],
            ),
          ),
        ),
      ),
    );
  }
}
