import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/contact.dart';

class ContactService {
  final String baseUrl = "https://proyectofinal-production-7dfb.up.railway.app/api/contacts";

  Future<List<Contact>> getContacts() async {
    final response = await http.get(Uri.parse(baseUrl));
    if (response.statusCode == 200) {
      Iterable list = json.decode(response.body);
      return list.map((model) => Contact.fromJson(model)).toList();
    } else {
      throw Exception("Failed to load contacts");
    }

  }

  Future<Contact> addContact(Contact contact) async {
    try {
      final response = await http.post(
        Uri.parse(baseUrl),
        headers: {"Content-Type": "application/json"},
        body: jsonEncode(contact.toJson()),
      );

      if (response.statusCode == 201) {
        return Contact.fromJson(json.decode(response.body));
      } else {
        throw Exception("HTTP Error ${response.statusCode}");
      }
    } catch (error) {
      throw Exception("Failed to add contact");
    }

  }

  Future<Contact> updateContact(Contact contact) async {
    final response = await http.put(
      Uri.parse('$baseUrl/${contact.id}'),
      headers: {"Content-Type": "application/json"},
      body: jsonEncode(contact.toJson()),
    );
    if (response.statusCode == 200) {
      return Contact.fromJson(json.decode(response.body));
    } else {
      throw Exception("Failed to update contact");
    }
  }

  Future<void> deleteContact(int id) async {
    final response = await http.delete(Uri.parse('$baseUrl/$id'));
    if (response.statusCode != 204) {
      throw Exception("Failed to delete contact");
    }
  }
}
