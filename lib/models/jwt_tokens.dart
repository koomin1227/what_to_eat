class JwtTokens {
  final String accessToken;
  final String refreshToken;

  JwtTokens({
    required this.accessToken,
    required this.refreshToken,
  });

  factory JwtTokens.fromJson(Map<String, dynamic> json) {
    return switch (json) {
      {
      'accessToken': String accessToken,
      'refreshToken': String refreshToken,
      } =>
          JwtTokens(
            accessToken: accessToken,
            refreshToken: refreshToken,
          ),
      _ => throw const FormatException('Failed to load JwtTokens.'),
    };
  }
}