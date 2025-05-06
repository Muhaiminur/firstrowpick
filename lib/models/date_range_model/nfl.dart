class Nfl {
  String? startDate;
  String? endDate;

  Nfl({this.startDate, this.endDate});

  factory Nfl.fromJson(Map<String, dynamic> json) => Nfl(
        startDate: json['start_date'] as String?,
        endDate: json['end_date'] as String?,
      );

  Map<String, dynamic> toJson() => {
        'start_date': startDate,
        'end_date': endDate,
      };
}
