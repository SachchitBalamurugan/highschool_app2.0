class ExperienceDto {
  final String id;
  final String award;
  final String event;
  final String organizer;
  final String organizerIcon;
  final String date;
  final List<String> certificates;

  const ExperienceDto({
    this.id = '',
    this.award = '',
    this.event = '',
    this.organizer = '',
    this.organizerIcon = '',
    this.date = '',
    this.certificates = const [],
  });
}
