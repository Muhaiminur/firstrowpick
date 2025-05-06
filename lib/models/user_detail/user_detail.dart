import 'entity.dart';

class UserDetail {
  String? action;
  String? path;
  String? uri;
  List<Entity>? entities;
  int? timestamp;
  int? duration;
  int? count;

  UserDetail({
    this.action,
    this.path,
    this.uri,
    this.entities,
    this.timestamp,
    this.duration,
    this.count,
  });

  factory UserDetail.fromJson(Map<String, dynamic> json) => UserDetail(
        action: json['action'] as String?,
        path: json['path'] as String?,
        uri: json['uri'] as String?,
        entities: (json['entities'] as List<dynamic>?)
            ?.map((e) => Entity.fromJson(e as Map<String, dynamic>))
            .toList(),
        timestamp: json['timestamp'] as int?,
        duration: json['duration'] as int?,
        count: json['count'] as int?,
      );

  Map<String, dynamic> toJson() => {
        'action': action,
        'path': path,
        'uri': uri,
        'entities': entities?.map((e) => e.toJson()).toList(),
        'timestamp': timestamp,
        'duration': duration,
        'count': count,
      };
}
