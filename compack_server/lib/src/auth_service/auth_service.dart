import 'package:compack_server/src/auth_service/auth_config.dart';
import 'package:compack_server/src/auth_service/data/auth_data_source.dart';
import 'package:compack_server/src/auth_service/data/entities/user_entity.dart';
import 'package:compack_server/src/auth_service/data/models/models.dart';
import 'package:compack_server/src/auth_service/exception/index.dart';
import 'package:compack_server/src/auth_service/foundations/user_extension.dart';
import 'package:compack_server/src/auth_service/foundations/validate.dart';
import 'package:uuid/uuid.dart';

/// {@template auth_service}
/// Auth Service for other packages
/// {@endtemplate}
class AuthService {
  /// {@macro auth_service}
  const AuthService({
    required AuthDataSource authDataSource,
    required AuthConfig authConfig,
  })  : _authDataSource = authDataSource,
        _authConfig = authConfig;
  final AuthDataSource _authDataSource;
  final AuthConfig _authConfig;

  Future<User> register({
    required String email,
    required String password,
  }) async {
    final errorMessages = _validateUserInfo(email, password);
    if (errorMessages.isNotEmpty) {
      return Future.error(errorMessages);
    }
    final userView = await _authDataSource.findUserByEmail(email: email);
    if(userView != null){
      return login(email: email, password: password);
    }
    final account = User()
      ..id = const Uuid().v4()
      ..email = email;
    final accountResult = account.genAndApplyToken(_authConfig);
    await _authDataSource.saveUser(
      user: accountResult,
      password: password.genPass(),
    );
    return accountResult;
  }

  Future<User> login({
    required String email,
    required String password,
  }) async {
    final errorMessages = _validateUserInfo(email, password);
    if (errorMessages.isNotEmpty) {
      return Future.error(errorMessages);
    }
    final user = await _authDataSource.findUserByEmail(email: email);
    if (user == null) {
      throw AppException.noUserFounded;
    }
    final verifyPassword = password.verifyPass(user.password);
    if (!verifyPassword) {
      throw AppException.passwordNotMatch;
    }
    final currentTime = DateTime.now();
    final userResult = user.toUser().genAndApplyToken(_authConfig)
      ..lastLogonTime = currentTime.toIso8601String()
      ..lastTimeUpdate = currentTime.toIso8601String();
    final userLogonView = await _authDataSource.updateUser(user: userResult);
    return userLogonView.toUser();
  }

  Future<User> findUserById({required String userId}) async {
    final user = await _authDataSource.findUserById(userId: userId);
    if (user == null) {
      throw AppException.noUserFounded;
    }
    return user.toUser();
  }

  List<AppException> _validateUserInfo(String email, String password) {
    final errorMessages = <AppException>[];
    final isEmailValidate = email.matchPattern(_authConfig.patternEmail);
    final isPassValidate = password.matchPattern(_authConfig.patternPassword);
    if (!isEmailValidate) {
      errorMessages.add(AppException.emailInvalid);
    }
    if (!isPassValidate) {
      errorMessages.add(AppException.passwordInvalid);
    }
    return errorMessages;
  }
}
