import 'package:document_saver/helper/sized_box_helper.dart';
import 'package:document_saver/screen/authentication_screen.dart';
import 'package:document_saver/screen/home_screen.dart';
import 'package:document_saver/screen/screen_background.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class SplashScreen extends StatefulWidget {
  static String routeName="/splashscreen";
  const SplashScreen({Key? key}):super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  void _navigate()async{
   await Future.delayed(const Duration(seconds: 1)).then((value){
    bool value=FirebaseAuth.instance.currentUser==null;
   if(value){
    Navigator.of(context).pushReplacementNamed(AuthenticationScreen.routeName);
   }
   else{
    Navigator.of(context).pushReplacementNamed(HomeScreen.routeName);
   }
   }); 
   
  }

  @override
  void initState() {
    _navigate();
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    print(FirebaseAuth.instance.currentUser==null);
    return Scaffold(
      body: ScreenBackgroundWidget(child: Column(
        children: [
          SizedBoxHelper.sizedBox100,
          SizedBoxHelper.sizedBox100,
          SizedBoxHelper.sizedBox40,
          Image.asset('assets/icon_image1.png',height: 200,),
          Image.asset('assets/icon_text.png',height: 60,)
        ],
      )),
    );
  }
}