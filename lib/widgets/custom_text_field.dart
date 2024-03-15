import 'package:flutter/material.dart';

class CustomTextField extends StatelessWidget {
  final TextEditingController controller;
  final String hintText;
  final String? labelText;
  final IconData prefixIconData;
  final Widget? suffixIcon;
  final String? Function(String?) validator;
  final bool obscureText;
  const CustomTextField({Key? key,required this.controller,required this.hintText,this.labelText,required this.prefixIconData,this.suffixIcon,required this.validator,this.obscureText=false}):super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(borderRadius: BorderRadius.circular(10),
      color: Colors.white),
      child: TextFormField(
        validator: validator,
        obscureText: obscureText,
        controller: controller,
        decoration: InputDecoration(hintText: hintText,labelText: labelText,prefixIcon: Icon(prefixIconData,),suffixIcon: suffixIcon),
      ),
    );
  }
}