// ignore_for_file: annotate_overrides

part of 'user_profile_entity.dart';

extension UserProfileEntityRepositories on Database {
  UserProfileEntityRepository get userProfileEntities => UserProfileEntityRepository._(this);
}

abstract class UserProfileEntityRepository
    implements
        ModelRepository,
        ModelRepositoryInsert<UserProfileEntityInsertRequest>,
        ModelRepositoryUpdate<UserProfileEntityUpdateRequest>,
        ModelRepositoryDelete<String> {
  factory UserProfileEntityRepository._(Database db) = _UserProfileEntityRepository;

  Future<UserProfileEntityView?> queryUserProfileEntity(String id);
  Future<List<UserProfileEntityView>> queryUserProfileEntitys([QueryParams? params]);
}

class _UserProfileEntityRepository extends BaseRepository
    with
        RepositoryInsertMixin<UserProfileEntityInsertRequest>,
        RepositoryUpdateMixin<UserProfileEntityUpdateRequest>,
        RepositoryDeleteMixin<String>
    implements UserProfileEntityRepository {
  _UserProfileEntityRepository(super.db) : super(tableName: 'UserProfile', keyName: 'id');

  @override
  Future<UserProfileEntityView?> queryUserProfileEntity(String id) {
    return queryOne(id, UserProfileEntityViewQueryable());
  }

  @override
  Future<List<UserProfileEntityView>> queryUserProfileEntitys([QueryParams? params]) {
    return queryMany(UserProfileEntityViewQueryable(), params);
  }

  @override
  Future<void> insert(List<UserProfileEntityInsertRequest> requests) async {
    if (requests.isEmpty) return;
    var values = QueryValues();
    await db.query(
      'INSERT INTO "UserProfile" ( "id", "role", "email", "phone", "avatar_url", "name", "birth_date", "last_time_update" )\n'
      'VALUES ${requests.map((r) => '( ${values.add(r.id)}:text, ${values.add(r.role)}:int8, ${values.add(r.email)}:text, ${values.add(r.phone)}:text, ${values.add(r.avatarUrl)}:text, ${values.add(r.name)}:text, ${values.add(r.birthDate)}:timestamp, ${values.add(r.lastTimeUpdate)}:timestamp )').join(', ')}\n',
      values.values,
    );
  }

  @override
  Future<void> update(List<UserProfileEntityUpdateRequest> requests) async {
    if (requests.isEmpty) return;
    var values = QueryValues();
    await db.query(
      'UPDATE "UserProfile"\n'
      'SET "role" = COALESCE(UPDATED."role", "UserProfile"."role"), "email" = COALESCE(UPDATED."email", "UserProfile"."email"), "phone" = COALESCE(UPDATED."phone", "UserProfile"."phone"), "avatar_url" = COALESCE(UPDATED."avatar_url", "UserProfile"."avatar_url"), "name" = COALESCE(UPDATED."name", "UserProfile"."name"), "birth_date" = COALESCE(UPDATED."birth_date", "UserProfile"."birth_date"), "last_time_update" = COALESCE(UPDATED."last_time_update", "UserProfile"."last_time_update")\n'
      'FROM ( VALUES ${requests.map((r) => '( ${values.add(r.id)}:text::text, ${values.add(r.role)}:int8::int8, ${values.add(r.email)}:text::text, ${values.add(r.phone)}:text::text, ${values.add(r.avatarUrl)}:text::text, ${values.add(r.name)}:text::text, ${values.add(r.birthDate)}:timestamp::timestamp, ${values.add(r.lastTimeUpdate)}:timestamp::timestamp )').join(', ')} )\n'
      'AS UPDATED("id", "role", "email", "phone", "avatar_url", "name", "birth_date", "last_time_update")\n'
      'WHERE "UserProfile"."id" = UPDATED."id"',
      values.values,
    );
  }
}

class UserProfileEntityInsertRequest {
  UserProfileEntityInsertRequest({
    required this.id,
    this.role,
    this.email,
    this.phone,
    this.avatarUrl,
    this.name,
    this.birthDate,
    this.lastTimeUpdate,
  });

  final String id;
  final int? role;
  final String? email;
  final String? phone;
  final String? avatarUrl;
  final String? name;
  final DateTime? birthDate;
  final DateTime? lastTimeUpdate;
}

class UserProfileEntityUpdateRequest {
  UserProfileEntityUpdateRequest({
    required this.id,
    this.role,
    this.email,
    this.phone,
    this.avatarUrl,
    this.name,
    this.birthDate,
    this.lastTimeUpdate,
  });

  final String id;
  final int? role;
  final String? email;
  final String? phone;
  final String? avatarUrl;
  final String? name;
  final DateTime? birthDate;
  final DateTime? lastTimeUpdate;
}

class UserProfileEntityViewQueryable extends KeyedViewQueryable<UserProfileEntityView, String> {
  @override
  String get keyName => 'id';

  @override
  String encodeKey(String key) => TextEncoder.i.encode(key);

  @override
  String get query => 'SELECT "UserProfile".*'
      'FROM "UserProfile"';

  @override
  String get tableAlias => 'UserProfile';

  @override
  UserProfileEntityView decode(TypedMap map) => UserProfileEntityView(
      id: map.get('id'),
      role: map.getOpt('role'),
      email: map.getOpt('email'),
      phone: map.getOpt('phone'),
      avatarUrl: map.getOpt('avatar_url'),
      name: map.getOpt('name'),
      birthDate: map.getOpt('birth_date'),
      lastTimeUpdate: map.getOpt('last_time_update'));
}

class UserProfileEntityView {
  UserProfileEntityView({
    required this.id,
    this.role,
    this.email,
    this.phone,
    this.avatarUrl,
    this.name,
    this.birthDate,
    this.lastTimeUpdate,
  });

  final String id;
  final int? role;
  final String? email;
  final String? phone;
  final String? avatarUrl;
  final String? name;
  final DateTime? birthDate;
  final DateTime? lastTimeUpdate;
}
