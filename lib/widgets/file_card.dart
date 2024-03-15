import 'package:document_saver/models/file_card_model.dart';
import 'package:document_saver/provider/document_provider.dart';
import 'package:document_saver/screen/document_view_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../helper/sized_box_helper.dart';

class FileCard extends StatelessWidget {
  final FileCardModel model;
  const FileCard({Key? key,required this.model}):super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 10),
              width: MediaQuery.sizeOf(context).width,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(5),
                boxShadow:[BoxShadow(
                color: Colors.grey.shade200,
                blurRadius:4,
                spreadRadius: 4,
              )]),
              child: Padding(
                padding: const EdgeInsets.all(15.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                  Row(
                    children: [
                      model.fileType=="pdf"?Image.asset("assets/icon_pdf_type.png",width: 60,):Image.asset("assets/icon_image_type.png",width: 60,),
                      SizedBoxHelper.sizedBox5,
                      SizedBox(
                        width: MediaQuery.sizeOf(context).width*0.45,
                        child: Column(
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: [
                        Text(model.title,style: Theme.of(context).textTheme.titleLarge,),
                        Text("Date Added:${model.dateAdded.substring(0,10)}",style: Theme.of(context).textTheme.labelLarge?.copyWith(color: Colors.grey),),
                                          ],
                                        ),
                      ),
                    ],
                  ),
                  
                  Row(
                    children: [
                      IconButton(onPressed: (){
                        showDialog(context: context, builder: (context) {
                          return AlertDialog(
                            backgroundColor: Colors.red,
                            title: const Text("Delete",style: TextStyle(
                              color:Colors.white,
                              fontSize: 20,
                            ),),
                            content: Text(model.title,style: const TextStyle(
                              color:Colors.white,
                              fontSize: 16
                            ),),
                            actions:[
                              TextButton(onPressed: (){
                                Navigator.of(context).pop();
                              }, child: const Text("Cancel",style: TextStyle(
                              color:Colors.white,
                              fontSize: 20,
                            ),)),
                              TextButton(onPressed: (){
                                Provider.of<DocumentProvider>(context,listen: false).deleteDocument(model.id,model.fileName,context).then((value){
                                  Navigator.of(context).pop();
                                });
                              }, child: const Text("OK",style: TextStyle(
                              color:Colors.white,
                              fontSize: 20,
                            ),)),
                            ]
                          );
                        });
                      }, icon: const Icon(Icons.delete,color: Colors.red,)),
                  InkWell(onTap: (){
                    Navigator.of(context).pushNamed(DocumentViewScreen.routeName,arguments: DocumentViewScreenArgs(fileName: model.fileName, fileUrl: model.fileUrl,fileType: model.fileType));
                  },child: Text("View",style: Theme.of(context).textTheme.titleSmall?.copyWith(color: Colors.blue),))
                    ],
                  ),
                ],
                ),
              ),
            );
  }
}