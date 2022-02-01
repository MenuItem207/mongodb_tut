import 'package:client/src/api.dart';
import 'package:flutter/material.dart';
import 'package:faker/faker.dart';

import 'contact.dart';
import 'package:client/src/contacts_listing.dart';

class ContactsScreen extends StatefulWidget {
  const ContactsScreen({Key? key, required this.title}) : super(key: key);
  final String title;

  @override
  State<ContactsScreen> createState() => _ContactsScreenState();
}

class _ContactsScreenState extends State<ContactsScreen> {
  List<Contact> contacts = [];
  bool loading = true;
  final ContactsApi api = ContactsApi();

  void _getContacts() {
    api.getContacts().then((value) => setState(() {
          contacts = value;
          loading = false;
        }));
  }

  @override
  void initState() {
    super.initState();
    _getContacts();
  }

  void _addContact() async {
    final faker = Faker();
    final person = faker.person;
    final fullName = '${person.firstName()} ${person.lastName()}';

    final createdContact = await api.createContact(fullName);
    setState(() {
      contacts.add(createdContact);
    });
  }

  void _deleteContact(String id) async {
    await api.deleteContact(id);
    setState(() {
      contacts.removeWhere((contact) => contact.id == id);
    });
  }

  void _refresh() {
    _getContacts();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: loading
          ? const Center(
              child: CircularProgressIndicator(),
            )
          : ContactsListings(
              contacts: contacts, onAdd: _addContact, onDelete: _deleteContact),
      floatingActionButton: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          FloatingActionButton(
            onPressed: _refresh,
            tooltip: 'Refresh List',
            child: const Icon(Icons.refresh),
            backgroundColor: Colors.purple,
          ),
          const SizedBox(width: 10),
          FloatingActionButton(
            onPressed: _addContact,
            tooltip: 'Add new contact',
            child: const Icon(Icons.add),
          ),
        ],
      ),
    );
  }
}
