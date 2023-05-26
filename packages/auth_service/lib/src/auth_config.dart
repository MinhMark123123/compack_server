class AuthConfig {

  AuthConfig({
    required this.patternEmail,
    required this.patternPassword,
    required this.tokenExpiredDuration,
    required this.refreshTokenExpiredDuration,
    required this.jwtSecretKey,
  });

  final String patternEmail;
  final String patternPassword;
  final Duration tokenExpiredDuration;
  final Duration refreshTokenExpiredDuration;
  final String jwtSecretKey;

}
