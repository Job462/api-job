import 'package:flutter/material.dart';
import '../models/contact.dart';
import '../services/contact_service.dart';
import 'add_contact.dart';
import 'edit_contact.dart';

class ContactList extends StatefulWidget {
  @override
  _ContactListState createState() => _ContactListState();
}

class _ContactListState extends State<ContactList> {
  ContactService _contactService = ContactService();
  late Future<List<Contact>> _contacts;

  @override
  void initState() {
    super.initState();
    _contacts = _contactService.getContacts();
  }
  Future<void> _showDeleteConfirmationDialog(Contact contact) async {
    return showDialog<void>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Confirmar eliminación'),
          content: SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                Text('¿Estás seguro de que quieres eliminar este contacto?'),
              ],
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: Text('Cancelar'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              child: Text('Eliminar'),
              onPressed: () async {
                await _contactService.deleteContact(contact.id ?? 0);
                Navigator.of(context).pop();
                setState(() {
                  _contacts = _contactService.getContacts();
                });
              },
            ),
          ],
        );
      },
    );
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Contact List'),
      ),
      body: FutureBuilder(
        future: _contacts,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return CircularProgressIndicator();
          } else if (snapshot.hasError) {
            return Text('Error: ${snapshot.error}');
          } else {
            List<Contact> contacts = snapshot.data as List<Contact>;
            print(contacts);
            return ListView.builder(
              itemCount: contacts.length,
              itemBuilder: (context, index) {
                Contact contact = contacts[index];
                return ListTile(
                  title: Text(contact.nombre),
                  subtitle: Text('Tel: ${contact.celular}\nEmail: ${contact.email}'),
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => EditContact(contact: contact),
                      ),
                    ).then((value) {
                      setState(() {
                        _contacts = _contactService.getContacts();
                      });
                    });
                  },
                  trailing: IconButton(
                    icon: Icon(Icons.delete),
                    onPressed: () {
                      _showDeleteConfirmationDialog(contact);
                    },
                  ),
                );
              },
            );
          }
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => AddContact(),
            ),
          ).then((value) {
            setState(() {
              _contacts = _contactService.getContacts();
            });
          });
        },
        child: Icon(Icons.add),
      ),
    );
  }
}
