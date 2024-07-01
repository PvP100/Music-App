class UpdateProfileRequest {
  final String? email;

  final String? firstName;

  final String? lastName;

  UpdateProfileRequest({this.email, this.firstName, this.lastName});

  Map<String, dynamic> toMap() {
    Map<String, dynamic> data = {};
    if (email != null) {
      data.addAll({'email': email});
    }
    if (firstName != null) {
      data.addAll({'first_name': firstName});
    }
    if (lastName != null) {
      data.addAll({'last_name': lastName});
    }
    return data;
  }
}
