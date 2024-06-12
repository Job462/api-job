class Contact {
  final int? id;
  final String nombre;
  final String celular;
  final String email;

  Contact({
    this.id,
    required this.nombre,
    required this.celular,
    required this.email,
  });




  factory Contact.fromJson(Map<String, dynamic> json) {
    return Contact(
      id: json['id'],
      nombre: json['nombre'],
      celular: json['celular'],
      email: json['email'],
    );
  }
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'nombre': nombre,
      'celular': celular,
      'email': email,
    };
  }
}
