import 'package:SoulSync/widgets/app_extension.dart';

class ExperienceDto {
  final String id;
  final String award;
  final String awardDescription;
  final String event;
  final String eventDescription;
  final String organizer;
  final String organizerIcon;
  final String date;
  final List<String> certificates;
  final String certificatesDescription;
  final List<String> logSheets;
  final List<String> snapshots;
  final String snapshotsDescription;

  const ExperienceDto({
    this.id = '',
    this.award = '',
    this.awardDescription = '',
    this.event = '',
    this.eventDescription = '',
    this.organizer = '',
    this.organizerIcon = '',
    this.date = '',
    this.certificates = const [],
    this.certificatesDescription = '',
    this.logSheets = const [],
    this.snapshots = const [],
    this.snapshotsDescription = '',
  });

  @override
  String toString() {
    return 'ExperienceDto{id: $id, award: $award, awardDescription: $awardDescription, event: $event, eventDescription: $eventDescription, organizer: $organizer, organizerIcon: $organizerIcon, date: $date, certificates: $certificates, logSheets: $logSheets, snapshots: $snapshots}';
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
