import 'package:flutter/material.dart';
import '../models/contact.dart';
import '../services/contact_service.dart';

class EditContact extends StatefulWidget {
  final Contact contact;

  EditContact({required this.contact});

  @override
  _EditContactState createState() => _EditContactState();
}

class _EditContactState extends State<EditContact> {
  ContactService _contactService = ContactService();
  TextEditingController _nameController = TextEditingController();
  TextEditingController _phoneController = TextEditingController();
  TextEditingController _emailController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _nameController.text = widget.contact.nombre;
    _phoneController.text = widget.contact.celular;
    _emailController.text = widget.contact.email;
  }

  _editContact() async {
    String nombre = _nameController.text;
    String celular = _phoneController.text;
    String email = _emailController.text;

    if (nombre.isNotEmpty && celular.isNotEmpty) {
      Contact updatedContact = await _contactService.updateContact(
        Contact(id: widget.contact.id, nombre: nombre, celular: celular, email: email),
      );
      // Puedes realizar acciones adicionales después de editar un contacto.
      Navigator.pop(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Editar Contacto'),
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
              decoration: InputDecoration(labelText: 'Celular'),
            ),
            TextField(
              controller: _emailController,
              decoration: InputDecoration(labelText: 'Email'),
            ),
            SizedBox(height: 16),
            ElevatedButton(
              onPressed: _editContact,
              child: Text('Edit Contact'),
            ),
          ],
        ),
      ),
    );
  }
}
