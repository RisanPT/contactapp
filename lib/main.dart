import 'package:contacts_app_mini_project/features/contacts/controller/theme_controller.dart';
import 'package:contacts_app_mini_project/features/contacts/view/contact_home_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

void main() {
  runApp(const ProviderScope(child: MainApp()));
}

class MainApp extends ConsumerWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return MaterialApp(
      title: "Contacts",
        debugShowCheckedModeBanner: false,
        theme: ref.watch(themeProvider) ? ThemeData.dark() : ThemeData(),
        home: const ContactHome());
  }
}
