// ignore_for_file: annotate_overrides

part of 'user_entity.dart';

extension UserEntityRepositories on Database {
  UserEntityRepository get userEntities => UserEntityRepository._(this);
}

abstract class UserEntityRepository
    implements
        ModelRepository,
        ModelRepositoryInsert<UserEntityInsertRequest>,
        ModelRepositoryUpdate<UserEntityUpdateRequest>,
        ModelRepositoryDelete<String> {
  factory UserEntityRepository._(Database db) = _UserEntityRepository;

  Future<UserEntityView?> queryUserEntity(String id);
  Future<List<UserEntityView>> queryUserEntitys([QueryParams? params]);
}

class _UserEntityRepository extends BaseRepository
    with
        RepositoryInsertMixin<UserEntityInsertRequest>,
        RepositoryUpdateMixin<UserEntityUpdateRequest>,
        RepositoryDeleteMixin<String>
    implements UserEntityRepository {
  _UserEntityRepository(super.db) : super(tableName: 'Account', keyName: 'id');

  @override
  Future<UserEntityView?> queryUserEntity(String id) {
    return queryOne(id, UserEntityViewQueryable());
  }

  @override
  Future<List<UserEntityView>> queryUserEntitys([QueryParams? params]) {
    return queryMany(UserEntityViewQueryable(), params);
  }

  @override
  Future<void> insert(List<UserEntityInsertRequest> requests) async {
    if (requests.isEmpty) return;
    var values = QueryValues();
    await db.query(
      'INSERT INTO "Account" ( "id", "email", "phone", "password", "role", "token", "refresh_token", "time_created", "last_logon_time", "last_time_update" )\n'
      'VALUES ${requests.map((r) => '( ${values.add(r.id)}:text, ${values.add(r.email)}:text, ${values.add(r.phone)}:text, ${values.add(r.password)}:text, ${values.add(r.role)}:int8, ${values.add(r.token)}:text, ${values.add(r.refreshToken)}:text, ${values.add(r.timeCreated)}:timestamp, ${values.add(r.lastLogonTime)}:timestamp, ${values.add(r.lastTimeUpdate)}:timestamp )').join(', ')}\n',
      values.values,
    );
  }

  @override
  Future<void> update(List<UserEntityUpdateRequest> requests) async {
    if (requests.isEmpty) return;
    var values = QueryValues();
    await db.query(
      'UPDATE "Account"\n'
      'SET "email" = COALESCE(UPDATED."email", "Account"."email"), "phone" = COALESCE(UPDATED."phone", "Account"."phone"), "password" = COALESCE(UPDATED."password", "Account"."password"), "role" = COALESCE(UPDATED."role", "Account"."role"), "token" = COALESCE(UPDATED."token", "Account"."token"), "refresh_token" = COALESCE(UPDATED."refresh_token", "Account"."refresh_token"), "time_created" = COALESCE(UPDATED."time_created", "Account"."time_created"), "last_logon_time" = COALESCE(UPDATED."last_logon_time", "Account"."last_logon_time"), "last_time_update" = COALESCE(UPDATED."last_time_update", "Account"."last_time_update")\n'
      'FROM ( VALUES ${requests.map((r) => '( ${values.add(r.id)}:text::text, ${values.add(r.email)}:text::text, ${values.add(r.phone)}:text::text, ${values.add(r.password)}:text::text, ${values.add(r.role)}:int8::int8, ${values.add(r.token)}:text::text, ${values.add(r.refreshToken)}:text::text, ${values.add(r.timeCreated)}:timestamp::timestamp, ${values.add(r.lastLogonTime)}:timestamp::timestamp, ${values.add(r.lastTimeUpdate)}:timestamp::timestamp )').join(', ')} )\n'
      'AS UPDATED("id", "email", "phone", "password", "role", "token", "refresh_token", "time_created", "last_logon_time", "last_time_update")\n'
      'WHERE "Account"."id" = UPDATED."id"',
      values.values,
    );
  }
}

class UserEntityInsertRequest {
  UserEntityInsertRequest({
    required this.id,
    this.email,
    this.phone,
    this.password,
    this.role,
    this.token,
    this.refreshToken,
    this.timeCreated,
    this.lastLogonTime,
    this.lastTimeUpdate,
  });

  final String id;
  final String? email;
  final String? phone;
  final String? password;
  final int? role;
  final String? token;
  final String? refreshToken;
  final DateTime? timeCreated;
  final DateTime? lastLogonTime;
  final DateTime? lastTimeUpdate;
}

class UserEntityUpdateRequest {
  UserEntityUpdateRequest({
    required this.id,
    this.email,
    this.phone,
    this.password,
    this.role,
    this.token,
    this.refreshToken,
    this.timeCreated,
    this.lastLogonTime,
    this.lastTimeUpdate,
  });

  final String id;
  final String? email;
  final String? phone;
  final String? password;
  final int? role;
  final String? token;
  final String? refreshToken;
  final DateTime? timeCreated;
  final DateTime? lastLogonTime;
  final DateTime? lastTimeUpdate;
}

class UserEntityViewQueryable extends KeyedViewQueryable<UserEntityView, String> {
  @override
  String get keyName => 'id';

  @override
  String encodeKey(String key) => TextEncoder.i.encode(key);

  @override
  String get query => 'SELECT "Account".*'
      'FROM "Account"';

  @override
  String get tableAlias => 'Account';

  @override
  UserEntityView decode(TypedMap map) => UserEntityView(
      id: map.get('id'),
      email: map.getOpt('email'),
      phone: map.getOpt('phone'),
      password: map.getOpt('password'),
      role: map.getOpt('role'),
      token: map.getOpt('token'),
      refreshToken: map.getOpt('refresh_token'),
      timeCreated: map.getOpt('time_created'),
      lastLogonTime: map.getOpt('last_logon_time'),
      lastTimeUpdate: map.getOpt('last_time_update'));
}

class UserEntityView {
  UserEntityView({
    required this.id,
    this.email,
    this.phone,
    this.password,
    this.role,
    this.token,
    this.refreshToken,
    this.timeCreated,
    this.lastLogonTime,
    this.lastTimeUpdate,
  });

  final String id;
  final String? email;
  final String? phone;
  final String? password;
  final int? role;
  final String? token;
  final String? refreshToken;
  final DateTime? timeCreated;
  final DateTime? lastLogonTime;
  final DateTime? lastTimeUpdate;
}
