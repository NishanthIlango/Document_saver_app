import 'dart:io';

import 'package:document_saver/helper/snackbar_helper.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter/material.dart';

class DocumentProvider extends ChangeNotifier {
  String _selectedFileName = "";
  TextEditingController titleController = TextEditingController();
  TextEditingController noteController = TextEditingController();
  File? _file;
  String get selectedFileName => _selectedFileName;
  final FirebaseDatabase _firebaseDatabase = FirebaseDatabase.instance;
  final FirebaseStorage _firebaseStorage = FirebaseStorage.instance;
  void setSelectedFileName(String value) {
    _selectedFileName = value;
    notifyListeners();
  }

  void pickDocument(BuildContext context) async {
    FilePickerResult? result = await FilePicker.platform
        .pickFiles(
            allowMultiple: false,
            allowedExtensions: ["pdf", "png", "jpg", "jpeg"],
            type: FileType.custom)
        .then((result) {
      if (result!.files.isNotEmpty) {
        PlatformFile selectedFile = result!.files.first;
        setSelectedFileName(selectedFile.name);
        _file = File(selectedFile.path!);
        print(selectedFile.name);
      } else {
        SnackBarHelper.showErrorSnackBar(context, "No files is selected");
      }
    });
  }

  bool _isFileUploading = false;
  bool get isFileUploading => _isFileUploading;
  void setIsFileUploading(bool value) {
    _isFileUploading = value;
    notifyListeners();
  }

  void resetAll() {
    titleController = TextEditingController();
    noteController = TextEditingController();
    _selectedFileName = "";
    _file = null;
  }

  String userId = FirebaseAuth.instance.currentUser!.uid;

  void sendDocumentData({
    required BuildContext context,
  }) async {
    try {
      setIsFileUploading(true);
      UploadTask uploadTask = _firebaseStorage
          .ref()
          .child("files/$userId")
          .child(_selectedFileName)
          .putFile(_file!);
      TaskSnapshot taskSnapshot = await uploadTask;
      String uploadedFileUrl = await taskSnapshot.ref.getDownloadURL();
      await _firebaseDatabase.ref().child("files_info/$userId").push().set({
        "title": titleController.text,
        "note": noteController.text,
        "fileUrl": uploadedFileUrl,
        "dateAdded": DateTime.now().toString(),
        "fileName": _selectedFileName,
        "fileType": _selectedFileName.split(".").last,
      });
      resetAll(); 
      setIsFileUploading(false);
    } on FirebaseException catch (firebaseError) {
      setIsFileUploading(false);
      SnackBarHelper.showErrorSnackBar(context, firebaseError.message!);
    } catch (error) {
      setIsFileUploading(false);
      SnackBarHelper.showErrorSnackBar(context, error.toString());
    }
  }
  Future<void> deleteDocument(String id,String fileName,BuildContext context) async{
    try{
      await _firebaseStorage.ref().child("files/$userId/$fileName").delete();
      await _firebaseDatabase.ref().child("files_info/$userId/$id").remove().then((value){
        
      });
      SnackBarHelper.showSuccessSnackBar(context, "$fileName deleted successfully");
    }on FirebaseException catch(firebaseError){
      SnackBarHelper.showErrorSnackBar(context, firebaseError.message!);
    }
    catch(error){
      SnackBarHelper.showErrorSnackBar(context, error.toString());
    }
  }
}
