import 'package:contacts_app_mini_project/features/contacts/controller/contact_notifier.dart';
import 'package:contacts_app_mini_project/features/contacts/controller/theme_controller.dart';

import 'package:contacts_app_mini_project/features/contacts/view/contact_app_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class ContactHome extends ConsumerWidget {
  const ContactHome({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final contacts = ref.watch(contactsProvider);
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
            onPressed: () {
              ref.read(themeProvider.notifier).switcher();
            },
            icon: ref.watch(themeProvider)
                ? const Icon(Icons.sunny)
                : const Icon(Icons.dark_mode)),
        title: const Text('Contacts'),
        centerTitle: true,
        actions: [
          IconButton(
              onPressed: () {},
              icon: IconButton(
                  onPressed: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => Contact(),
                        ));
                  },
                  icon: const Icon(Icons.add)))
        ],
      ),
      body: contacts.isEmpty
          ? const Center(
              child: Text("Empty Contacts"),
            )
          : ListView.builder(
              itemCount: contacts.length,
              itemBuilder: (context, index) => Card(
                child: ListTile(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => Contact(
                          nameText: contacts[index].name,
                          phoneText: contacts[index].phone,
                          isEdit: true,
                          index: index,
                        ),
                      ),
                    );
                  },
                  leading: CircleAvatar(
                    backgroundImage: contacts[index].imageFile == null
                        ? null
                        : FileImage(contacts[index].imageFile!),
                    child: contacts[index].imageFile == null
                        ? const Icon(Icons.person)
                        : null,
                  ),
                  title: Text(contacts[index].name),
                  subtitle: Text(contacts[index].phone),
                  trailing: IconButton(
                      onPressed: () {
                        ref
                            .read(contactsProvider.notifier)
                            .deleteContact(index);
                      },
                      icon: const Icon(Icons.delete)),
                ),
              ),
            ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          showDialog(
            context: context,
            builder: (context) => AlertDialog(
              title: const TextField(
                maxLines: 1,
                decoration: InputDecoration(
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
                keyboardType: TextInputType.phone,
              ),
              content: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  TextButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      child: const Text("Cancel")),
                  TextButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      child: const Text("Call")),
                ],
              ),
            ),
          );
        },
        child: const Icon(Icons.dialpad_outlined),
        splashColor: Colors.black26,
      ),
    );
  }
}
