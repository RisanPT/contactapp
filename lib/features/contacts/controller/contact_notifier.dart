import 'package:contacts_app_mini_project/features/contacts/model/contact_model.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:image_picker/image_picker.dart';

class ContactNotifier extends Notifier<List<ContactModel>> {
  @override
  List<ContactModel> build() {
    return [];
  }
  void addContact(int? index, ContactModel contact) {
    if (index != null) {
      final updatedContacts = [...state];
      updatedContacts[index] = contact;
      state = updatedContacts;
      
    } else {
      state = [contact, ...state];
    }
  }
  void deleteContact(int index) {
    final delete = state;
    delete.removeAt(index);
    state = List.from(delete);
  }
}
final contactsProvider = NotifierProvider<ContactNotifier, List<ContactModel>>(
  () => ContactNotifier(),
);

final imageProvider = StateProvider<XFile?>((ref) => null);
