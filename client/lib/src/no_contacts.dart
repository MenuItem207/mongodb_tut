import 'package:flutter/material.dart';

class NoContacts extends StatelessWidget {
  final VoidCallback onAdd;
  const NoContacts({Key? key, required this.onAdd}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          const Icon(
            Icons.person_outline,
            size: 80,
            color: Colors.black45,
          ),
          const Text(
            'No Contacts listed',
            style: TextStyle(fontSize: 20),
          ),
          const SizedBox(
            height: 20,
          ),
          GestureDetector(
            onTap: onAdd,
            child: const Text(
              'Add your first',
              style: TextStyle(color: Colors.purple),
            ),
          ),
        ],
      ),
    );
  }
}
