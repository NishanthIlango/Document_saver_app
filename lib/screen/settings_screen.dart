import 'package:document_saver/provider/auth_provider.dart';
import 'package:document_saver/provider/user_info_provider.dart';
import 'package:document_saver/screen/screen_background.dart';
import 'package:document_saver/widgets/custom_button.dart';
import 'package:document_saver/widgets/custom_text_field.dart';
import 'package:document_saver/widgets/setting_card.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../helper/sized_box_helper.dart';

class SettingsScreen extends StatelessWidget {
  static String routeName="/settingsScreen";
  const SettingsScreen({Key? key}):super(key: key);

  @override
  Widget build(BuildContext context) {
    final provider=Provider.of<UserInfoProvider>(context,listen: false);
    provider.getUserName();
    return Scaffold(
      appBar: AppBar(
        title: const Text('Settings'),
        backgroundColor:const Color(0xFF1e5376),
      ),
      body:  ScreenBackgroundWidget(child: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          children: [
            Consumer<UserInfoProvider>(
              builder: (context,model,child) {
                return SettingCard(title: model.userName, trailing: IconButton(onPressed: (){
                  TextEditingController controller=TextEditingController();
                  showModalBottomSheet(context: context, builder:(context)=>
                  Padding(
                    padding:  EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
                    child: SizedBox(
                      height: 250,
                      child: Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: Column(
                          children: [
                            CustomTextField(controller: controller, hintText: "Enter the new username", prefixIconData: Icons.person,labelText: 'username' ,validator: (value){
                              return null;
                            }),
                            SizedBoxHelper.sizedBox20,
                            CustomButton(onPressed: (){
                              model.updateUserName(controller.text,context);
                            }, title: 'Update username')
                          ],
                        ),
                      ),
                    ),
                  ));
                }, icon: const Icon(Icons.edit)), leadingIcon: Icons.person);
              }
            ),
            SizedBoxHelper.sizedBox20,
             SettingCard(title: provider.user!.email!, leadingIcon: Icons.email),
            SizedBoxHelper.sizedBox20,
             SettingCard(title: "Logout", leadingIcon: Icons.logout,trailing: IconButton(onPressed: (){
              Provider.of<AuthProvider>(context,listen: false).LogOut(context);
             }, icon: const Icon(Icons.logout)),),
          ],
        ),
      )),
    );
  }
}