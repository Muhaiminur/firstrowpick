import 'data.dart';

class DateRangeModel {
  Data? data;

  DateRangeModel({this.data});

  factory DateRangeModel.fromJson(Map<String, dynamic> json) {
    return DateRangeModel(
      data: json['data'] == null
          ? null
          : Data.fromJson(json['data'] as Map<String, dynamic>),
    );
  }

  Map<String, dynamic> toJson() => {
        'data': data?.toJson(),
      };
}
