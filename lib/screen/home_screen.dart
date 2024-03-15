import 'dart:async';

import 'package:document_saver/helper/sized_box_helper.dart';
import 'package:document_saver/models/file_card_model.dart';
import 'package:document_saver/provider/auth_provider.dart';
import 'package:document_saver/screen/add_document_page.dart';
import 'package:document_saver/screen/screen_background.dart';
import 'package:document_saver/widgets/custom_floating_action_button.dart';
import 'package:document_saver/widgets/custom_home_app_bar.dart';
import 'package:document_saver/widgets/custom_text_field.dart';
import 'package:document_saver/widgets/file_card.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatefulWidget {
  static String routeName = "/HomeScreen";
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  TextEditingController searchController = TextEditingController();
  StreamController<DatabaseEvent> streamController=StreamController();
  String userId=FirebaseAuth.instance.currentUser!.uid;
  void setStream() {
    FirebaseDatabase.instance
        .ref()
        .child("files_info/$userId")
        .orderByChild("title")
        .startAt(searchController.text)
        .endAt("${searchController.text}" "\uf8ff")
        .onValue.listen((event) {
          streamController.add(event);
    });
  }

  @override
  void initState() {
    setStream();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        floatingActionButton: CustomFloatingActionButton(
            title: "Add Files",
            iconData: Icons.add,
            onTap: () {
              Navigator.pushNamed(context, AddDocumentScreen.routeName);
            }),
        appBar: CustomHomeAppBar(
          controller: searchController,
          onSearch: () {
            setStream();
          },
        ),

        //AppBar(actions: [
        //Consumer<AuthProvider>(

        //builder: (context,provider,child) {
        //return provider.isLoadingLogout?const CircularProgressIndicator(): IconButton(onPressed: (){
        //provider.LogOut(context);
        //}, icon: const Icon(Icons.logout));
        //}
        // )
        // ],
        //),

        body: ScreenBackgroundWidget(
          child: StreamBuilder<DatabaseEvent>(
              stream: streamController.stream,
              builder: (context, snapshot) {
                if (snapshot.hasData && snapshot.data!.snapshot.value != null) {
                  List<FileCardModel> list = [];
                  (snapshot.data!.snapshot.value as Map<dynamic, dynamic>)
                      .forEach((key, value) {
                    print(key);
                    print(value);
                    list.add(FileCardModel.fromJson(value,key));
                  });
                  return ListView(
                    children: list
                        .map(
                          (e) => FileCard(
                            model: FileCardModel(
                              id: e.id,
                              title: e.title,
                              subtitle: e.subtitle,
                              fileUrl: e.fileUrl,
                              dateAdded: e.dateAdded,
                              fileType: e.fileType,
                              fileName: e.fileName,
                            ),
                          ),
                        )
                        .toList(),
                  );
                } else if (snapshot.connectionState ==
                    ConnectionState.waiting) {
                  return const Center(child: CircularProgressIndicator());
                } else {
                  return Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Image.asset(
                        "assets/icon_no_file.png",
                        height: 100,
                      ),
                      SizedBoxHelper.sizedBox20,
                      const Text(
                        "No data",
                        style: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  );
                }
              }),
        ),
      ),
    );
  }
}
