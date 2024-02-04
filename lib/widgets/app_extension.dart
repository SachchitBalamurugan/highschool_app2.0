import 'package:SoulSync/models/experience_dto.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:intl/intl.dart';

extension MapExt on Map<String, dynamic> {
  String getStringOrEmpty(String key) {
    if (containsKey(key)) {
      final value = this[key];

      if (value is String) {
        return value;
      }
    }

    return '';
  }

  List<String> getListStringOrEmpty(String key) {
    final newValues = <String>[];

    if (containsKey(key)) {
      final value = this[key];

      // print('Value: $value | ${value as List<dynamic>}');
      if (value is List<dynamic>) {
        newValues.clear();
        newValues.addAll(value.map((e) => e.toString()));
      }
    }

    return newValues;
  }

  Timestamp getTimeStampOrNow(String key) {
    if (containsKey(key)) {
      final value = this[key];

      if (value is Timestamp) {
        return value;
      }
    }

    return Timestamp.now();
  }

  ExperienceDto toExperienceDto(String id) {
    return ExperienceDto(
      id: id,
      award: getStringOrEmpty('award'),
      event: getStringOrEmpty('event'),
      date: getTimeStampOrNow('date').toDate().toString(),
      organizer: getStringOrEmpty('organizer'),
      organizerIcon: getStringOrEmpty('organizerIcon'),
      awardDescription: getStringOrEmpty('awardDescription'),
      certificates: getListStringOrEmpty('certificates'),
      logSheets: getListStringOrEmpty('logSheets'),
    );
  }
}

extension StringExt on String {
  String translateDate({
    String toFormat = 'dd MMM yyyy',
  }) {
    if (isEmpty) {
      return '';
    }

    try {
      final dt = DateTime.parse(this);

      return DateFormat(toFormat, 'en_US').format(dt);
    } catch (e) {
      return '';
    }
  }

  Timestamp? toTimestamp() {
    if (isEmpty) {
      return null;
    }

    try {
      final dt = DateTime.parse(this);

      return Timestamp.fromDate(dt);
    } catch (e) {
      return null;
    }
  }
}

extension DateTimeExt on DateTime? {
  String translateDate({
    String toFormat = 'dd MMM yyyy',
  }) {
    if (this == null) {
      return '';
    }

    try {
      return DateFormat(toFormat, 'en_US').format(this!);
    } catch (e) {
      return '';
    }
  }
}
