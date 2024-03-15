import 'package:flutter/material.dart';

class CustomFloatingActionButton extends StatelessWidget {
  final String title;
  final IconData iconData;
  final VoidCallback onTap;
  const CustomFloatingActionButton({Key? key,required this.title,required this.iconData,required this.onTap}):super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
            width: 100,
            height: 40,
            decoration: BoxDecoration(
              color:Colors.white,
              borderRadius: BorderRadius.circular(10)),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(iconData),
                  Text(title,style: Theme.of(context).textTheme.bodyLarge?.copyWith(fontWeight: FontWeight.bold,color: Colors.black),),
                ],
              ),
          ),
    );
  }
}