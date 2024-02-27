import 'dart:io';

import 'package:contacts_app_mini_project/features/contacts/controller/contact_notifier.dart';
import 'package:contacts_app_mini_project/features/contacts/model/contact_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:image_picker/image_picker.dart';
import 'package:shimmer/shimmer.dart';

class Contact extends ConsumerWidget {
  final int? index;
  final File? pic;
  final String? nameText;
  final String? phoneText;
  final bool isEdit;

  Contact({
    super.key,
    this.nameText,
    this.pic,
    this.phoneText,
    this.index,
    this.isEdit = false,
  });

  final name = TextEditingController();
  final phone = TextEditingController();
  final formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    if (isEdit) {
      name.text = nameText ?? "";
      phone.text = phoneText ?? "";
    }
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: const Icon(Icons.close)),
        title: Text("Contact ${isEdit ? "Edit" : "Add"}"),
        centerTitle: true,
        clipBehavior: Clip.antiAlias,
        // actions: [
        //   IconButton(
        //       onPressed: () {
        //         ref.read(themeProvider.notifier).switcher();
        //       },
        //       icon: ref.watch(themeProvider)
        //           ? const Icon(Icons.sunny)
        //           : const Icon(Icons.dark_mode))
        // ],
      ),
      body: SingleChildScrollView(
        child: Form(
          key: formKey,
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Center(
                  child: GestureDetector(
                    child: Stack(children: [
                      CircleAvatar(
                        backgroundImage: ref.watch(imageProvider) == null
                            ? null
                            : FileImage(File(ref.watch(imageProvider)!.path)),
                        radius: 80,
                        backgroundColor: Colors.amber,
                        child: ref.watch(imageProvider) == null
                            ? const Icon(
                                Icons.person,
                                size: 10 * 6,
                              )
                            : null,
                      ),
                      Positioned(
                          top: 100,
                          right: 10,
                          child: IconButton(
                            onPressed: () {
                              showDialog(
                                context: context,
                                builder: (context) => AlertDialog(
                                  title: const Text("Pick Image From"),
                                  content: Row(
                                    children: [
                                      TextButton.icon(
                                        onPressed: () async {
                                          final imagePicker = ImagePicker();
                                          XFile? image =
                                              await imagePicker.pickImage(
                                                  source: ImageSource.camera);
                                          if (image != null) {
                                            if (context.mounted) {
                                              Navigator.pop(context);
                                            }
                                          }
                                          ref
                                              .read(imageProvider.notifier)
                                              .state = image;
                                        },
                                        icon: const Icon(
                                            Icons.camera_alt_rounded),
                                        label: const Text("Camera"),
                                      ),
                                      TextButton.icon(
                                        onPressed: () async {
                                          final imagePicker = ImagePicker();
                                          XFile? image =
                                              await imagePicker.pickImage(
                                                  source: ImageSource.gallery);
                                          if (image != null) {
                                            Navigator.pop(context);
                                          }
                                          ref
                                              .read(imageProvider.notifier)
                                              .state = image;
                                        },
                                        icon: const Icon(Icons.photo),
                                        label: const Text("Gallery"),
                                      )
                                    ],
                                  ),
                                ),
                              );
                            },
                            icon: const Icon(Icons.camera),
                            iconSize: 40,
                          ))
                    ]),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(15.0),
                child: TextFormField(
                  controller: name,
                  maxLines: 1,
                  decoration: const InputDecoration(
                      hintText: "Enter Name",
                      border: OutlineInputBorder(
                        gapPadding:
                            TextSelectionToolbar.kToolbarContentDistanceBelow,
                        borderSide: BorderSide(
                            strokeAlign: BorderSide.strokeAlignCenter,
                            width: 4,
                            style: BorderStyle.solid,
                            color: Colors.black),
                        borderRadius: BorderRadius.all(Radius.circular(10)),
                      )),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return "Name Cannot be empty";
                    }
                    return null;
                  },
                  keyboardType: TextInputType.name,
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(15.0),
                child: TextFormField(
                  controller: phone,
                  maxLines: 1,
                  decoration: const InputDecoration(
                      hintText: "Enter Number",
                      border: OutlineInputBorder(
                        gapPadding:
                            TextSelectionToolbar.kToolbarContentDistanceBelow,
                        borderSide: BorderSide(
                            strokeAlign: BorderSide.strokeAlignCenter,
                            width: 4,
                            style: BorderStyle.solid,
                            color: Colors.black),
                        borderRadius: BorderRadius.all(Radius.circular(10)),
                      )),
                  maxLength: 10,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return "Phone number Cannot be empty";
                    }
                    if (value.length < 10) {
                      return "Enter a valid phone number";
                    }
                    return null;
                  },
                  keyboardType: TextInputType.phone,
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 30),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    SizedBox(
                        child: Shimmer.fromColors(
                            baseColor: Colors.blue,
                            direction: ShimmerDirection.ltr,
                            enabled: true,
                            highlightColor: Colors.amber,
                            child: TextButton(
                                onPressed: () {
                                  Navigator.pop(context);
                                },
                                child: const Text(
                                  "Cancel",
                                  style: TextStyle(
                                      color: Colors.amber, fontSize: 20),
                                )))),
                    SizedBox(
                        child: Shimmer.fromColors(
                            baseColor: Colors.blue,
                            direction: ShimmerDirection.ltr,
                            enabled: true,
                            highlightColor: Colors.amber,
                            child: TextButton(
                                onPressed: () {
                                  if (formKey.currentState!.validate()) {
                                    ref
                                        .read(contactsProvider.notifier)
                                        .addContact(
                                          index,
                                          ContactModel(
                                            imageFile:
                                                ref.watch(imageProvider) == null
                                                    ? null
                                                    : File(ref
                                                        .watch(imageProvider)!
                                                        .path),
                                            name: name.text,
                                            phone: phone.text,
                                          ),
                                        );
                                    name.clear();
                                    phone.clear();
                                    ref.read(imageProvider.notifier).state =
                                        null;
                                    Navigator.pop(context);
                                  }
                                },
                                child: const Text(
                                  "Save",
                                  style: TextStyle(
                                      color: Colors.amber, fontSize: 20),
                                ))))
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
