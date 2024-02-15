import 'package:SoulSync/consts/collection_constant.dart';
import 'package:SoulSync/models/score_dto.dart';
import 'package:SoulSync/widgets/attachment_input.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:image_picker/image_picker.dart';

class CourseScoreDialog extends StatefulWidget {
  final List<ScoreDto> scoreList;
  final bool isEditable;

  const CourseScoreDialog({
    super.key,
    required this.scoreList,
    required this.isEditable,
  });

  @override
  State<CourseScoreDialog> createState() => _CourseScoreDialogState();
}

class _CourseScoreDialogState extends State<CourseScoreDialog> {
  final _picker = ImagePicker();
  final _types = [
    'AP Course',
    'Dual Credit',
    'AB',
    'Regular Classes',
  ];
  final _semester1Controller = TextEditingController();
  final _semester2Controller = TextEditingController();
  final _filePaths = <String>[];

  var _selectedType = '';

  @override
  void initState() {
    super.initState();

    setState(() {
      _selectedType = _types[0];
    });
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15.0),
      ),
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Expanded(
                  child: DropdownButtonHideUnderline(
                    child: DropdownButton2<String>(
                      items: _types.map((e) {
                        return DropdownMenuItem<String>(
                          value: e,
                          child: Text(e),
                        );
                      }).toList(),
                      isDense: true,
                      value: _selectedType,
                      onChanged: _onChange,
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 8, right: 8),
                  child: IconButton(
                    onPressed: Navigator.of(context).pop,
                    icon: const Icon(Icons.close_rounded),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 8),
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 16),
              child: Text(
                "Grade",
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
            const SizedBox(height: 8),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Row(
                children: [
                  Expanded(
                    child: Column(
                      children: [
                        const Text(
                          "Semester 1",
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        Container(
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            border: Border.all(color: Colors.grey),
                          ),
                          height: 180,
                          child: Center(
                            child: SizedBox(
                              width: 80,
                              child: TextFormField(
                                controller: _semester1Controller,
                                inputFormatters: [
                                  FilteringTextInputFormatter.digitsOnly,
                                ],
                                keyboardType: TextInputType.phone,
                                maxLength: 3,
                                decoration: const InputDecoration(
                                  border: UnderlineInputBorder(),
                                  suffixText: '%',
                                  counterText: '',
                                ),
                                textAlign: TextAlign.center,
                                style: const TextStyle(
                                  fontSize: 32,
                                  color: Colors.black,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(width: 24),
                  Expanded(
                    child: Column(
                      children: [
                        const Text(
                          "Semester 2",
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        Container(
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            border: Border.all(color: Colors.grey),
                          ),
                          height: 180,
                          child: Center(
                            child: SizedBox(
                              width: 80,
                              child: TextFormField(
                                controller: _semester2Controller,
                                inputFormatters: [
                                  FilteringTextInputFormatter.digitsOnly,
                                ],
                                keyboardType: TextInputType.phone,
                                maxLength: 3,
                                decoration: const InputDecoration(
                                  border: UnderlineInputBorder(),
                                  suffixText: '%',
                                  counterText: '',
                                ),
                                textAlign: TextAlign.center,
                                style: const TextStyle(
                                  fontSize: 32,
                                  color: Colors.black,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 16),
            Visibility(
              visible: _selectedType == _types[0],
              child: const Padding(
                padding: EdgeInsets.symmetric(horizontal: 16),
                child: Text(
                  "AP Score",
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ),
            Visibility(
              visible: _selectedType == _types[0],
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Align(
                  child: SizedBox(
                    width: 200,
                    child: AttachmentInput(
                      filePaths: _filePaths,
                      maxFiles: 1,
                      onAddAttachment: _onAddAttachment,
                      onRemoveAttachment: _onRemoveAttachment,
                    ),
                  ),
                ),
              ),
            ),
            Visibility(
              visible: widget.isEditable,
              child: Container(
                width: double.infinity,
                padding: const EdgeInsets.symmetric(
                  horizontal: 16,
                  vertical: 24,
                ),
                child: FilledButton(
                  onPressed: _onSave,
                  child: const Text('Save'),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _onChange(String? newValue) {
    setState(() {
      _selectedType = newValue ?? _types[0];
    });
  }

  void _onAddAttachment() async {
    final pickedImage = await _picker.pickImage(
      source: ImageSource.gallery,
    );
    if (pickedImage == null) return;

    final ext = pickedImage.name.split('.').last;
    if (!CollectionConstant.supportedFileType.contains(ext)) {
      Fluttertoast.showToast(msg: 'Please select image only');
      return;
    }

    setState(() {
      _filePaths.add(pickedImage.path);
    });
  }

  void _onRemoveAttachment(int index) {
    setState(() {
      _filePaths.removeAt(index);
    });
  }

  void _onSave() {}
}
