import 'datum.dart';

class FantasyModel {
  List<Datum>? data;

  FantasyModel({this.data});

  factory FantasyModel.fromJson(Map<String, dynamic> json) => FantasyModel(
        data: (json['data'] as List<dynamic>?)
            ?.map((e) => Datum.fromJson(e as Map<String, dynamic>))
            .toList(),
      );

  Map<String, dynamic> toJson() => {
        'data': data?.map((e) => e.toJson()).toList(),
      };
}
