import 'package:flutter/material.dart';

import 'contact.dart';

import 'no_contacts.dart';

class ContactsListings extends StatelessWidget {
  final List<Contact> contacts;
  final VoidCallback onAdd;
  final Function(String id) onDelete;
  const ContactsListings(
      {Key? key,
      required this.contacts,
      required this.onAdd,
      required this.onDelete})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return contacts.isEmpty
        ? NoContacts(
            onAdd: onAdd,
          )
        : ListView.builder(
            scrollDirection: Axis.vertical,
            itemCount: contacts.length,
            itemBuilder: (context, index) => Padding(
              padding: const EdgeInsets.symmetric(vertical: 10.0),
              child: ListTile(
                leading: CircleAvatar(
                  radius: 30,
                  child: Text(contacts[index].initials),
                ),
                title: Text(contacts[index].name),
                trailing: GestureDetector(
                  onTap: () => onDelete(contacts[index].id),
                  child: const Icon(
                    Icons.delete,
                    size: 30,
                  ),
                ),
              ),
            ),
          );
  }
}
