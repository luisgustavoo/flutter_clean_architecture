import 'package:equatable/equatable.dart';

class User extends Equatable {
  const User({
    required this.id,
    required this.name,
    required this.email,
    required this.password,
  });
  final int id;
  final String name;
  final String email;
  final String password;

  @override
  List<Object?> get props => [id, name, email, password];
}
