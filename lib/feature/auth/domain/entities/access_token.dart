class AccessToken {
  AccessToken({
    required this.accessToken,
    required this.refreshToken,
    required this.type,
  });

  final String accessToken;
  final String refreshToken;
  final String type;
}
