class RegisterRequest {
  final String email;

  final String password;

  final String firstName;

  final String lastName;

  // final String birthday;

  RegisterRequest({
    required this.email,
    required this.password,
    required this.firstName,
    required this.lastName,
    // required this.birthday,
  });

  Map<String, dynamic> toMap() => {
        'email': email,
        'password': password,
        'first_name': firstName,
        'last_name': lastName
      };
}
