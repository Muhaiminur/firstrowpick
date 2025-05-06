class Ncaaf {
  String? startDate;
  String? endDate;

  Ncaaf({this.startDate, this.endDate});

  factory Ncaaf.fromJson(Map<String, dynamic> json) => Ncaaf(
        startDate: json['start_date'] as String?,
        endDate: json['end_date'] as String?,
      );

  Map<String, dynamic> toJson() => {
        'start_date': startDate,
        'end_date': endDate,
      };
}
