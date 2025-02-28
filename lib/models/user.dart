class User {
  final int? id;
  final String nombre;
  final String email;
  final String password;

  User({this.id, required this.nombre, required this.email, required this.password});

  // Convierte un User a un Map (para guardar en la base de datos)
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'nombre': nombre,
      'email': email,
      'password': password,
    };
  }

  // Convierte un Map a un User (para leer de la base de datos)
  factory User.fromMap(Map<String, dynamic> map) {
    return User(
      id: map['id'],
      nombre: map['nombre'],
      email: map['email'],
      password: map['password'],
    );
  }
}