import 'package:document_saver/helper/sized_box_helper.dart';
import 'package:document_saver/provider/auth_provider.dart';
import 'package:document_saver/screen/forget_password_screen.dart';
import 'package:document_saver/screen/screen_background.dart';
import 'package:document_saver/widgets/custom_button.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../widgets/custom_text_field.dart';

class AuthenticationScreen extends StatefulWidget {
  static String routeName = "/authenticationScreen";
  const AuthenticationScreen({Key? key}) : super(key: key);

  @override
  State<AuthenticationScreen> createState() => _AuthenticationScreenState();
}

class _AuthenticationScreenState extends State<AuthenticationScreen> {
  TextEditingController usernameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController confirmPasswordController = TextEditingController();
  GlobalKey<FormState> _key = GlobalKey();

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => AuthProvider(),
      child: Consumer<AuthProvider>(builder: (context, provider, _) {
        return Scaffold(
          body: ScreenBackgroundWidget(
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Form(
                key: _key,
                child: ListView(
                  children: [
                    SizedBoxHelper.sizedBox20,
                    Image.asset(
                      "assets/icon_image.png",
                      height: 150,
                    ),
                    SizedBoxHelper.sizedBox20,
                    if (!provider.isLogin)
                      CustomTextField(
                        validator: (String? value) {
                          if (value!.isEmpty) {
                            return 'Please enter a username';
                          } else {
                            return null;
                          }
                        },
                        controller: usernameController,
                        labelText: "UserName",
                        hintText: "Enter your username",
                        prefixIconData: Icons.person,
                      ),
                    SizedBoxHelper.sizedBox20,
                    CustomTextField(
                      validator: (String? value) {
                        if (value!.isEmpty) {
                          return 'Please enter a email';
                        } else {
                          return null;
                        }
                      },
                      controller: emailController,
                      labelText: "Email",
                      hintText: "Enter your email id",
                      prefixIconData: Icons.email,
                    ),
                    SizedBoxHelper.sizedBox20,
                    CustomTextField(
                      validator: (String? value) {
                        if (value!.isEmpty || value.length < 8) {
                          return 'Please enter a password';
                        } else {
                          return null;
                        }
                      },
                      obscureText: provider.obscureText,
                      controller: passwordController,
                      labelText: "Password",
                      hintText: "Enter the password",
                      prefixIconData: Icons.lock_outline_sharp,
                      suffixIcon: IconButton(
                        onPressed: () {
                          provider.setObscureText();
                        },
                        icon: Icon(provider.obscureText
                            ? Icons.remove_red_eye
                            : Icons.visibility_off),
                      ),
                    ),
                    SizedBoxHelper.sizedBox20,
                    if (!provider.isLogin)
                      CustomTextField(
                        validator: (String? value) {
                          if (value!.isEmpty) {
                            return "Please reenter the password";
                          } else if (value != passwordController.text) {
                            return "The passwords does not match!";
                          } else {
                            return null;
                          }
                        },
                        obscureText: provider.obscureText,
                        controller: confirmPasswordController,
                        labelText: "Confirm Password",
                        hintText: "Confirm the password",
                        prefixIconData: Icons.lock,
                        suffixIcon: IconButton(
                          onPressed: () {
                            provider.setObscureText();
                          },
                          icon: Icon(provider.obscureText
                              ? Icons.remove_red_eye
                              : Icons.visibility_off),
                        ),
                      ),
                    SizedBoxHelper.sizedBox20,
                    provider.isLoading
                        ? const Center(child: CircularProgressIndicator())
                        : CustomButton(
                            onPressed: () {
                              if (_key.currentState!.validate()) {
                                if (provider.isLogin) {
                                  provider.signIn(context,
                                      email: emailController.text,
                                      password: passwordController.text);
                                } else {
                                  provider.signUp(context,
                                      email: emailController.text,
                                      username: usernameController.text,
                                      password: passwordController.text);
                                }
                              }
                            },
                            title: provider.isLogin ? "Login" : "Register"),
                    MaterialButton(
                      onPressed: () {
                        provider.setIsLogin();
                      },
                      child: Text(provider.isLogin
                          ? "Don't have an account?Register"
                          : "Already have an account? Login"),
                    ),
                    MaterialButton(
                      onPressed: () {
                        Navigator.of(context)
                            .pushNamed(ForgetPasswordScreen.routeName);
                      },
                      child: const Text("Forgot Password"),
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      }),
    );
  }
}
