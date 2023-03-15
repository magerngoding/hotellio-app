// ignore_for_file: prefer_const_constructors

import 'package:d_info/d_info.dart';
import 'package:flutter/material.dart';
import 'package:hotels_app/config/app_color.dart';
import 'package:hotels_app/config/app_route.dart';
import 'package:hotels_app/source/user_source.dart';
import 'package:hotels_app/widget/button_custome.dart';

class SigninPage extends StatelessWidget {
  final controllerEmail = TextEditingController();
  final controllerPassword = TextEditingController();
  final formKey = GlobalKey<FormState>();
  SigninPage({super.key});

  login(BuildContext context) {
    if (formKey.currentState!.validate()) {
      UserSource.signIn(controllerEmail.text, controllerPassword.text).then(
        (response) {
          if (response['success']) {
            DInfo.dialogSuccess(response['message']);
            DInfo.closeDialog(
              actionAfterClose: () {
                Navigator.pushReplacementNamed(context, AppRoute.home);
              },
            );
          } else {
            DInfo.toastError(response['message']);
          }
        },
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: LayoutBuilder(
          builder: (contex, constraints) {
            return SingleChildScrollView(
              child: ConstrainedBox(
                constraints: BoxConstraints(
                  minHeight: constraints.maxHeight,
                ),
                child: Form(
                  key: formKey,
                  child: Padding(
                    padding: const EdgeInsets.all(16),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Image.asset(
                          'assets/logo.png',
                          width: 180,
                          fit: BoxFit.fitWidth,
                        ),
                        SizedBox(
                          height: 80,
                        ),
                        Align(
                          alignment: Alignment.centerLeft,
                          child: Text(
                            'Sign In\nTo Your Account',
                            style: Theme.of(context)
                                .textTheme
                                .titleLarge!
                                .copyWith(
                                  fontWeight: FontWeight.bold,
                                ),
                          ),
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        TextFormField(
                          controller: controllerEmail,
                          validator: (value) =>
                              value == '' ? "'Don't empty" : null,
                          decoration: InputDecoration(
                            isDense: true,
                            filled: true,
                            fillColor: Colors.white,
                            contentPadding: EdgeInsets.symmetric(
                              horizontal: 16,
                              vertical: 16,
                            ),
                            hintText: 'Email Address',
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(30),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(30),
                              borderSide: BorderSide(
                                color: AppColor.secondary,
                              ),
                            ),
                            enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(30),
                              borderSide: BorderSide.none,
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        TextFormField(
                          controller: controllerPassword,
                          validator: (value) =>
                              value == '' ? "'Don't empty" : null,
                          obscureText: true,
                          decoration: InputDecoration(
                            isDense: true,
                            filled: true,
                            fillColor: Colors.white,
                            contentPadding: EdgeInsets.symmetric(
                              horizontal: 16,
                              vertical: 16,
                            ),
                            hintText: 'Password',
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(30),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(30),
                              borderSide: BorderSide(
                                color: AppColor.secondary,
                              ),
                            ),
                            enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(30),
                              borderSide: BorderSide.none,
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 30,
                        ),
                        ButtonCustome(
                          label: 'Sign In',
                          onTap: () => login(context),
                          isExpand: true,
                        ),
                        SizedBox(
                          height: 24,
                        ),
                        Text(
                          'Create new account',
                          style: TextStyle(
                            color: Colors.grey,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
