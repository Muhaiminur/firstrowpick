import 'ncaaf.dart';
import 'nfl.dart';

class Data {
  Ncaaf? ncaaf;
  Nfl? nfl;

  Data({this.ncaaf, this.nfl});

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        ncaaf: json['NCAAF'] == null
            ? null
            : Ncaaf.fromJson(json['NCAAF'] as Map<String, dynamic>),
        nfl: json['NFL'] == null
            ? null
            : Nfl.fromJson(json['NFL'] as Map<String, dynamic>),
      );

  Map<String, dynamic> toJson() => {
        'NCAAF': ncaaf?.toJson(),
        'NFL': nfl?.toJson(),
      };
}
