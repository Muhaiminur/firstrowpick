class Entity {
  String? uuid;
  String? type;
  int? created;
  int? modified;
  String? username;
  bool? activated;
  String? nickname;

  Entity({
    this.uuid,
    this.type,
    this.created,
    this.modified,
    this.username,
    this.activated,
    this.nickname,
  });

  factory Entity.fromJson(Map<String, dynamic> json) => Entity(
        uuid: json['uuid'] as String?,
        type: json['type'] as String?,
        created: json['created'] as int?,
        modified: json['modified'] as int?,
        username: json['username'] as String?,
        activated: json['activated'] as bool?,
        nickname: json['nickname'] as String?,
      );

  Map<String, dynamic> toJson() => {
        'uuid': uuid,
        'type': type,
        'created': created,
        'modified': modified,
        'username': username,
        'activated': activated,
        'nickname': nickname,
      };
}
