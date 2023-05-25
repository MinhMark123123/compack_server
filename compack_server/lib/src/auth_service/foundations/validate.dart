import 'package:dbcrypt/dbcrypt.dart';

extension StringExtension on String {
  bool matchPattern(String pattern) {
    final reg = RegExp(pattern);
    return reg.hasMatch(this);
  }

  String genPass() {
    return DBCrypt().hashpw(this, DBCrypt().gensalt());
  }

  bool verifyPass(String? dbPassword) {
    if(dbPassword == null){
      return false;
    }
    return DBCrypt().checkpw(this, dbPassword);
  }

}
