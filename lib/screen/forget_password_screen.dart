import 'package:document_saver/helper/sized_box_helper.dart';
import 'package:document_saver/provider/auth_provider.dart';
import 'package:document_saver/screen/screen_background.dart';
import 'package:document_saver/widgets/custom_text_field.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../widgets/custom_button.dart';

class ForgetPasswordScreen extends StatefulWidget {
  static String routeName = "/forgetpassword";
  const ForgetPasswordScreen({Key? key}) : super(key: key);

  @override
  State<ForgetPasswordScreen> createState() => _ForgetPasswordScreenState();
}

class _ForgetPasswordScreenState extends State<ForgetPasswordScreen> {
  TextEditingController emailController = TextEditingController();
  final _key = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ScreenBackgroundWidget(
          child: Padding(
        padding: const EdgeInsets.all(20),
        child: ListView(
          children: [
            SizedBoxHelper.sizedBox100,
            Image.asset(
              "assets/icon_image.png",
              height: 150,
            ),
            SizedBoxHelper.sizedBox20,
            const Text(
              "Enter your email to reset the password",
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 25,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBoxHelper.sizedBox20,
            Form(
              key: _key,
              child: CustomTextField(
                controller: emailController,
                hintText: "Enter the email",
                labelText: "Email",
                prefixIconData: Icons.email,
                validator: (String? value) {
                  if (value!.isEmpty) {
                    return "Please enter the value";
                  }
                  return null;
                },
              ),
            ),
            SizedBoxHelper.sizedBox20,
            Consumer<AuthProvider>(builder: (context, provider, child) {
              return provider.isLoadingForgetPassowrd
                  ? Center(
                      child: CircularProgressIndicator(),
                    )
                  : CustomButton(
                      onPressed: () {
                        if (_key.currentState!.validate()) {
                          provider.forgetPassword(
                              emailController.text, context);
                        }
                      },
                      title: "Forget Password");
            }),
          ],
        ),
      )),
    );
  }
}
