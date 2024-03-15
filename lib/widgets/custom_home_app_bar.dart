import 'package:document_saver/screen/settings_screen.dart';
import 'package:flutter/material.dart';

import '../helper/sized_box_helper.dart';
import 'custom_text_field.dart';

class CustomHomeAppBar extends StatelessWidget implements PreferredSizeWidget{
  final TextEditingController controller;
  final VoidCallback onSearch;
  const CustomHomeAppBar({Key? key,required this.controller,required this.onSearch}):super(key: key);

  @override
  Widget build(BuildContext context) {
    return PreferredSize(preferredSize: const Size.fromHeight(160),child: Container(
          color: const Color(0xFF1e5376),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15),
            child: Column(
              children: [
                SizedBoxHelper.sizedBox20,
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Image.asset("assets/icon_text.png",width: 150),
                    IconButton(onPressed: (){
                      FocusScope.of(context).unfocus();
                      Navigator.of(context).pushNamed(SettingsScreen.routeName);
                    }, icon: const Icon(Icons.settings,color: Colors.white,)),
                  ],
                ),
                SizedBoxHelper.sizedBox20,
                CustomTextField(controller: controller, hintText: "Enter the title of the document", prefixIconData: Icons.search,suffixIcon: IconButton(onPressed: onSearch, icon: const Text("Go")), validator: (value){
                  return null;
                })
              ],
            ),
          ),
        ),
        );
  }
  
  @override
  // TODO: implement preferredSize
  Size get preferredSize => const Size.fromHeight(150);
}