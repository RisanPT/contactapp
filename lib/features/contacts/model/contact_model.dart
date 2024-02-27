import 'dart:io';

import 'package:flutter/material.dart';

@immutable
class ContactModel {
  final File? imageFile;
  final String name;
  final String phone;
  const ContactModel({
    this.imageFile,
    required this.name,
    required this.phone,
  });

  ContactModel copyWith({
    File? imageFile,
    String? name,
    String? phone,
  }) {
    return ContactModel(
      imageFile: imageFile ?? this.imageFile,
      name: name ?? this.name,
      phone: phone ?? this.phone,
    );
  }
}
