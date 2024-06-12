import 'package:flutter/material.dart';
import '../models/contact.dart';
import '../services/contact_service.dart';

class AddContact extends StatefulWidget {
  @override
  _AddContactState createState() => _AddContactState();
}

class _AddContactState extends State<AddContact> {
  ContactService _contactService = ContactService();
  TextEditingController _nameController = TextEditingController();
  TextEditingController _phoneController = TextEditingController();
  TextEditingController _emailController = TextEditingController();

  _addContact() async {
    String name = _nameController.text;
    String phone = _phoneController.text;
    String email = _emailController.text;

    if (name.isNotEmpty && phone.isNotEmpty) {
      Contact newContact = await _contactService.addContact(Contact(nombre: name, celular: phone, email: email));
      Navigator.pop(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Agregar Contacto'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            TextField(
              controller: _nameController,
              decoration: InputDecoration(labelText: 'Nombre'),
            ),
            TextField(
              controller: _phoneController,
              decoration: InputDecoration(labelText: 'celular'),
            ),
            TextField(
              controller: _emailController,
              decoration: InputDecoration(labelText: 'Email'),
            ),
            SizedBox(height: 16),
            ElevatedButton(
              onPressed: _addContact,
              child: Text('Add Contact'),
            ),
          ],
        ),
      ),
    );
  }
}
