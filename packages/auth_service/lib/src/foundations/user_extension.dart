
import 'package:auth_service/src/auth_config.dart';
import 'package:auth_service/src/data/models/models.dart';
import 'package:auth_service/src/exception/index.dart';
import 'package:dart_jsonwebtoken/dart_jsonwebtoken.dart';

extension UserExtension on User {
  User genAndApplyToken(AuthConfig config) {
    assert(id != null, 'id must not be null');
    final jwTAccessToken = JWT(
      {
        'id': id,
        'email': email,
        'exp': DateTime.now().add(config.tokenExpiredDuration).millisecondsSinceEpoch,
      },
    );
    // Sign it (default with HS256 algorithm)
    final jwtRefreshToken = JWT(
      {
        'id': id,
        'email': email,
        'exp': DateTime.now().add(config.refreshTokenExpiredDuration).millisecondsSinceEpoch,
      },
    );
    token = jwTAccessToken.sign(SecretKey(config.jwtSecretKey));
    refreshToken = jwtRefreshToken.sign(SecretKey(config.jwtSecretKey));
    return this;
  }

  static User decodeToken({required String token, required AuthConfig config}) {
    final jwt = verifyToken(token: token, config: config);
    if (jwt == null) {
      throw AppException.tokenInvalid;
    }
    final accountDecoded = User(
      id: jwt.payload['id'].toString(),
      email: jwt.payload['email'].toString(),
    );
    if (accountDecoded.id == null) {
      throw AppException.tokenInvalid;
    }
    return User(
      id: jwt.payload['id'].toString(),
      email: jwt.payload['email'].toString(),
    );
  }

  static JWT? verifyToken({required String token, required AuthConfig config}) {
    try {
      return JWT.verify(token, SecretKey(config.jwtSecretKey));
    } catch (e) {
      throw AppException.tokenInvalid;
    }
  }
}
