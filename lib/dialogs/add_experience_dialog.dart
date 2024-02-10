import 'package:SoulSync/consts/collection_constant.dart';
import 'package:SoulSync/models/experience_dto.dart';
import 'package:SoulSync/widgets/app_extension.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

class AddExperienceDialog extends StatefulWidget {
  final String collectionKey;

  const AddExperienceDialog({
    super.key,
    required this.collectionKey,
  });

  @override
  State<AddExperienceDialog> createState() => _AddExperienceDialogState();
}

class _AddExperienceDialogState extends State<AddExperienceDialog> {
  final _awardController = TextEditingController();
  final _eventController = TextEditingController();
  final _dateController = TextEditingController();
  final _organizerController = TextEditingController();

  DateTime? _selectedDate;

  @override
  Widget build(BuildContext context) {
    final bottom = MediaQuery.of(context).viewInsets.bottom;

    return Container(
      decoration: const BoxDecoration(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(10),
          topRight: Radius.circular(10),
        ),
        color: Colors.white,
      ),
      margin: EdgeInsets.only(bottom: bottom),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            const SizedBox(height: 12),
            Align(
              alignment: Alignment.center,
              child: Container(
                width: 48,
                height: 4,
                decoration: BoxDecoration(
                  color: const Color(0xFF979797),
                  borderRadius: BorderRadius.circular(24),
                ),
              ),
            ),
            const SizedBox(height: 24),
            Text(
              'Add ${_getTitle()}',
              style: const TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w600,
              ),
            ),
            const SizedBox(height: 24),
            TextFormField(
              controller: _awardController,
              decoration: const InputDecoration(
                hintText: 'Award',
              ),
              textInputAction: TextInputAction.next,
            ),
            const SizedBox(height: 16),
            TextFormField(
              controller: _eventController,
              decoration: const InputDecoration(
                hintText: 'Event',
              ),
              textInputAction: TextInputAction.next,
            ),
            const SizedBox(height: 16),
            TextFormField(
              controller: _dateController,
              decoration: const InputDecoration(
                hintText: 'Date',
              ),
              readOnly: true,
              textInputAction: TextInputAction.next,
              onTap: _onSelectDate,
            ),
            const SizedBox(height: 16),
            TextFormField(
              controller: _organizerController,
              decoration: const InputDecoration(
                hintText: 'Organizer',
              ),
              textInputAction: TextInputAction.done,
            ),
            const SizedBox(height: 32),
            SizedBox(
              width: double.infinity,
              child: FilledButton(
                onPressed: _onSave,
                child: const Text('Save'),
              ),
            ),
            const SizedBox(height: 48),
          ],
        ),
      ),
    );
  }

  String _getTitle() {
    switch (widget.collectionKey) {
      case CollectionConstant.academic:
        return 'Academic Achievement';
      case CollectionConstant.athletic:
        return 'Athletic Participation';
      case CollectionConstant.art:
        return 'Performing Arts Experience';
      case CollectionConstant.organization:
        return 'Clubs and Organization Membership';
      case CollectionConstant.community:
        return 'Community Service Hours';
      case CollectionConstant.honor:
        return 'Honor Classes';
      default:
        return 'Something';
    }
  }

  void _onSelectDate() async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: _selectedDate,
      firstDate: DateTime(2000),
      lastDate: DateTime(2100),
    );

    if (picked != null && picked != _selectedDate) {
      _dateController.text = picked.translateDate(
        toFormat: 'dd MMM yyyy',
      );
      setState(() {
        _selectedDate = picked;
      });
    }
  }

  void _onSave() {
    final award = _awardController.text;
    final event = _eventController.text;
    final organizer = _organizerController.text;
    final date = _selectedDate?.toString() ?? '';

    if (award.isEmpty || event.isEmpty || organizer.isEmpty || date.isEmpty) {
      Fluttertoast.showToast(msg: 'Please fill all field');
      return;
    }

    final exp = ExperienceDto(
      award: award,
      event: _eventController.text,
      organizer: _organizerController.text,
      date: _selectedDate?.toString() ?? '',
    );

    Navigator.of(context).pop(exp);
  }
}
