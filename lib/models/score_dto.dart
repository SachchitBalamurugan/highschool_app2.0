import 'package:SoulSync/consts/collection_constant.dart';

class ScoreDto {
  final String id;
  final double? semester1;
  final double? semester2;
  final String? scoreFile;

  const ScoreDto({
    this.id = '',
    this.semester1,
    this.semester2,
    this.scoreFile,
  });

  @override
  String toString() {
    return 'ScoreDto{id: $id, semester1: $semester1, semester2: $semester2, scoreFile: $scoreFile}';
  }

  Map<String, dynamic> toMap() {
    return {
      CollectionConstant.semester1: semester1,
      CollectionConstant.semester2: semester2,
      CollectionConstant.scoreFile: scoreFile,
    };
  }
 
  factory ScoreDto.fromMap(Map<String, dynamic> map) {
    return ScoreDto(
      semester1: map[CollectionConstant.semester1] as double,
      semester2: map[CollectionConstant.semester2] as double,
      scoreFile: map[CollectionConstant.scoreFile] as String,
    );
  }

  ScoreDto copyWith({
    String? id,
    double? semester1,
    double? semester2,
    String? scoreFile,
  }) {
    return ScoreDto(
      id: id ?? this.id,
      semester1: semester1 ?? this.semester1,
      semester2: semester2 ?? this.semester2,
      scoreFile: scoreFile ?? this.scoreFile,
    );
  }
}
