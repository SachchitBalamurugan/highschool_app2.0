class ScoreDto {
  final String id;
  final String type;
  final double semester1;
  final double semester2;
  final String scoreFile;

  const ScoreDto({
    this.id = '',
    this.type = '',
    this.semester1 = 0.0,
    this.semester2 = 0.0,
    this.scoreFile = '',
  });
}
