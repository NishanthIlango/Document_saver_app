import 'package:document_saver/helper/snackbar_helper.dart';
import 'package:document_saver/screen/authentication_screen.dart';
import 'package:document_saver/screen/home_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';

class AuthProvider extends ChangeNotifier {
  bool _isLogin = true;
  bool get isLogin => _isLogin; // Corrected typo here

  final FirebaseAuth _firebaseAuth=FirebaseAuth.instance;
  final FirebaseDatabase _firebaseDatabase=FirebaseDatabase.instance;

  void setIsLogin() {
    _isLogin = !_isLogin;
    notifyListeners();
  }
  bool _obscureText = true;
  bool get obscureText => _obscureText; // Corrected typo here

  void setObscureText() {
    _obscureText = !_obscureText;
    notifyListeners();
  }
  
  bool _isLoading=false;
  bool get isLoading => _isLoading;

  void setIsLoading(bool value){
    _isLoading=value;
    notifyListeners();
  }
  void setIsLoadingForgetPassword(bool value){
    _isLoadingForgetPassword=value;
    notifyListeners();
  }

  void signUp(BuildContext context,{required String email,required String password,required String username})async{
    try{
      setIsLoading(true);
    UserCredential userCredential= await _firebaseAuth.createUserWithEmailAndPassword(email: email, password: password).then((value) async{
      await _firebaseDatabase.ref().child("user_info/${value.user!.uid}").set({
        "username":username
      });
      setIsLoading(false);
      SnackBarHelper.showSuccessSnackBar(context, "Sign Up is successful");
      Navigator.of(context).pushReplacementNamed(HomeScreen.routeName);
      return value;
    });
    }
    on FirebaseAuthException catch(firebaseError){
      setIsLoading(false);
      SnackBarHelper.showErrorSnackBar(context,firebaseError.message!);
      

    }
    catch(error){
    SnackBarHelper.showErrorSnackBar(context,error.toString());
    
    }
  }
  
  void signIn(BuildContext context,{required String email,required String password})async{
    try{
      setIsLoading(true);
      UserCredential userCredential=await _firebaseAuth.signInWithEmailAndPassword(email: email, password: password).then((value) {
       setIsLoading(false);
        SnackBarHelper.showSuccessSnackBar(context, "Sign In is successful");
        Navigator.of(context).pushReplacementNamed(HomeScreen.routeName);
        return value;
      });
    }
    on FirebaseAuthException catch(firebaseError){
      setIsLoading(false);
      SnackBarHelper.showErrorSnackBar(context,firebaseError.message!);
      

    }
    catch(error){
    SnackBarHelper.showErrorSnackBar(context,error.toString());
    
    }
  }

  bool _isLoadingForgetPassword=false;
  bool get isLoadingForgetPassowrd=>_isLoadingForgetPassword;
  void forgetPassword(String email,BuildContext context)async{
    try{
      setIsLoadingForgetPassword(true);
      await _firebaseAuth.sendPasswordResetEmail(email: email).then((value) {
        setIsLoadingForgetPassword(false);
      SnackBarHelper.showSuccessSnackBar(context, "Reset Password link has been successfully sent");
      });
      
      } on FirebaseAuthException catch(firebaseError){
        setIsLoadingForgetPassword(false);
        SnackBarHelper.showErrorSnackBar(context,firebaseError.message!);
        

      }
      catch(error){
      _isLoadingForgetPassword=false;
      SnackBarHelper.showErrorSnackBar(context,error.toString());
      
      }
    }

  bool _isLoadingLogout=false;
  bool get isLoadingLogout=>_isLoadingLogout;
  void setIsLoadingLogOut(bool value){
    _isLoadingLogout=value;
    notifyListeners();
  }  
  void LogOut(BuildContext context)async{
    try{
      setIsLoadingLogOut(true);
      await _firebaseAuth.signOut().then((value) {
        setIsLoadingLogOut(false);
        SnackBarHelper.showSuccessSnackBar(context, "Logout successfully");
        Navigator.of(context).popUntil((route) => route.isFirst);
        Navigator.pushReplacementNamed(context, AuthenticationScreen.routeName);
      });
    }on FirebaseAuthException catch(firebaseError){
        setIsLoadingLogOut(false);
        SnackBarHelper.showErrorSnackBar(context,firebaseError.message!);
        

      }
      catch(error){
      _isLoadingLogout=false;
      SnackBarHelper.showErrorSnackBar(context,error.toString());
      
      }
  }
  }

