class LoginRequest {
  final String grantType;
  final String clientId;
  final String clientSecret;

  LoginRequest({
    required this.grantType,
    required this.clientId,
    required this.clientSecret,
  });

  Map<String, dynamic> toMap() => {
        "grant_type": grantType,
        "client_id": clientId,
        "client_secret": clientSecret,
      };
}
