import 'package:SoulSync/widgets/app_extension.dart';

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

  @override
  String toString() {
    return 'ExperienceDto{id: $id, award: $award, event: $event, organizer: $organizer, organizerIcon: $organizerIcon, date: $date, certificates: $certificates}';
  }

  Map<String, dynamic> toMap() {
    return {
      'award': award,
      'event': event,
      'organizer': organizer,
      'date': date.toTimestamp(),
    };
  }
}
