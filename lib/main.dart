import 'package:document_saver/firebase_options.dart';
import 'package:document_saver/provider/auth_provider.dart';
import 'package:document_saver/provider/document_provider.dart';
import 'package:document_saver/provider/user_info_provider.dart';
import 'package:document_saver/screen/add_document_page.dart';
import 'package:document_saver/screen/authentication_screen.dart';
import 'package:document_saver/screen/document_view_screen.dart';
import 'package:document_saver/screen/forget_password_screen.dart';
import 'package:document_saver/screen/home_screen.dart';
import 'package:document_saver/screen/settings_screen.dart';
import 'package:document_saver/screen/splash_screen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => AuthProvider()),
        ChangeNotifierProvider(
            create: (_) =>
                DocumentProvider()),
        ChangeNotifierProvider(create: (_)=>UserInfoProvider()), //ChangeNotifierProvider<UserModel>(create: (_)=> UserModel())
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
            inputDecorationTheme: const InputDecorationTheme(
              border: OutlineInputBorder(),
              focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.blue, width: 2)),
            ),
            textTheme: const TextTheme(
                headlineLarge: TextStyle(fontWeight: FontWeight.bold))),
        initialRoute: SplashScreen.routeName,
        routes: {
          SplashScreen.routeName: (context) => const SplashScreen(),
          AuthenticationScreen.routeName: (context) =>
              const AuthenticationScreen(),
          ForgetPasswordScreen.routeName: (context) =>
              const ForgetPasswordScreen(),
          HomeScreen.routeName: (context) => const HomeScreen(),
          AddDocumentScreen.routeName: (context) => const AddDocumentScreen(),
          DocumentViewScreen.routeName:(context) => const DocumentViewScreen(),
          SettingsScreen.routeName:(context) => const SettingsScreen(),
        },
      ),
    );
  }
}
