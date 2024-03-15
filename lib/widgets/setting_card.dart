import 'package:flutter/material.dart';

class SettingCard extends StatelessWidget {
  final String title;
  final Widget? trailing;
  final IconData leadingIcon;
  const SettingCard({Key? key,required this.title,this.trailing,required this.leadingIcon}):super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(5),
                color: Colors.white,
                shape: BoxShape.rectangle,
                boxShadow: const [
                  BoxShadow(
                    color: Colors.grey,blurRadius: 1,spreadRadius: 0,
                  )
                ]
              ),
              child: ListTile(title:  Text(title),
              trailing: trailing,
              leading:Icon(leadingIcon),
              ),
            );
  }
}