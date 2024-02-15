import 'dart:io';

import 'package:SoulSync/consts/collection_constant.dart';
import 'package:SoulSync/models/score_dto.dart';
import 'package:SoulSync/widgets/app_extension.dart';
import 'package:SoulSync/widgets/attachment_input.dart';
import 'package:SoulSync/widgets/network_image_thumbnail.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:collection/collection.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:image_picker/image_picker.dart';
import 'package:ndialog/ndialog.dart';
import 'package:sprintf/sprintf.dart';

class CourseScoreDialog extends StatefulWidget {
  final String email;
  final String experienceId;
  final bool isEditable;

  const CourseScoreDialog({
    super.key,
    required this.email,
    required this.experienceId,
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
  final _scores = <ScoreDto>[];
  final _semester1Controller = TextEditingController();
  final _semester2Controller = TextEditingController();
  final _filePaths = <String>[];

  var _isLoading = false;
  var _selectedIndex = 0;
  var _apImageUrl = '';

  CustomProgressDialog? _progressDialog;

  @override
  void initState() {
    super.initState();

    setState(() {
      _selectedIndex = 0;
    });

    _getDetail();
  }

  @override
  void dispose() {
    _progressDialog?.dismiss();
    _progressDialog = null;

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15.0),
      ),
      child: Visibility(
        visible: !_isLoading,
        replacement: const SizedBox(
          height: 400,
          child: Center(
            child: CircularProgressIndicator(),
          ),
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
                        value: _types[_selectedIndex],
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
                                  readOnly: !widget.isEditable,
                                  onChanged: _onSemester1Change,
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
                                  readOnly: !widget.isEditable,
                                  onChanged: _onSemester2Change,
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
                visible: _types[_selectedIndex] == _types[0],
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
                visible: _types[_selectedIndex] == _types[0],
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: Align(
                    child: SizedBox(
                      width: 200,
                      child: Visibility(
                        visible: _apImageUrl.isEmpty,
                        replacement: NetworkImageThumbnail(
                          imageUrl: _apImageUrl.isEmpty
                              ? CollectionConstant.emptyImage
                              : _apImageUrl,
                          isEditable: widget.isEditable,
                        ),
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
              ),
              const SizedBox(height: 16),
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
      ),
    );
  }

  Future _getDetail() async {
    setState(() {
      _isLoading = true;
      _filePaths.clear();
    });

    _scores.clear();

    final instance = FirebaseFirestore.instance;
    for (final t in _types) {
      final result = await instance
          .collection(CollectionConstant.users)
          .doc(widget.email)
          .collection(CollectionConstant.honor)
          .doc(widget.experienceId)
          .collection(t)
          .doc(t)
          .get();

      final data = result.data()?.toScoreDto(result.id);
      if (data != null) {
        _scores.add(data);
      } else {
        _scores.add(const ScoreDto());
      }
    }

    setState(() {
      _isLoading = false;
      _apImageUrl = _scores[0].scoreFile ?? '';
    });

    _onChange(_types[0]);
  }

  void _onChange(String? newValue) {
    var idx = _types.indexOf(newValue ?? '');
    if (idx == -1) {
      idx = 0;
    }

    setState(() {
      _selectedIndex = idx;
      final score = _scores[_selectedIndex];

      _semester1Controller.text = score.semester1 != null
          ? sprintf(
              '%.0f',
              [score.semester1],
            )
          : '';
      _semester2Controller.text = score.semester2 != null
          ? sprintf(
              '%.0f',
              [score.semester2],
            )
          : '';
    });
  }

  void _onSemester1Change(String text) {
    final score = _scores[_selectedIndex];

    _scores[_selectedIndex] = score.copyWith(
      semester1: double.tryParse(text),
    );
  }

  void _onSemester2Change(String text) {
    final score = _scores[_selectedIndex];

    _scores[_selectedIndex] = score.copyWith(
      semester2: double.tryParse(text),
    );
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

  Future<String> _uploadFile(String filePath) async {
    final storageRef = FirebaseStorage.instance.ref();

    final file = File(filePath);
    final fileName = filePath.split('/').lastOrNull;

    final path = '${CollectionConstant.storageExperiences}/$fileName';
    final references = storageRef.child(path);

    final snapshot = await references.putFile(file);
    return await snapshot.ref.getDownloadURL();
  }

  void _onSave() async {
    showLoadingDialog();

    final instance = FirebaseFirestore.instance;
    for (final (index, t) in _types.indexed) {
      String? fileUrl;
      if (index == 0 && _filePaths.isNotEmpty) {
        fileUrl = await _uploadFile(_filePaths[0]);

        await instance
            .collection(CollectionConstant.users)
            .doc(widget.email)
            .collection(CollectionConstant.honor)
            .doc(widget.experienceId)
            .update({CollectionConstant.organizerIcon: fileUrl});
      }

      await instance
          .collection(CollectionConstant.users)
          .doc(widget.email)
          .collection(CollectionConstant.honor)
          .doc(widget.experienceId)
          .collection(t)
          .doc(t)
          .set(_scores[index].copyWith(scoreFile: fileUrl).toMap());
    }

    hideLoadingDialog();
    Fluttertoast.showToast(msg: 'Successfully Update Data');
    Navigator.of(context).pop();
  }

  void showLoadingDialog({
    bool isDismissible = true,
  }) {
    _progressDialog = CustomProgressDialog(
      context,
      dismissable: isDismissible,
    );
    _progressDialog?.setLoadingWidget(const CircularProgressIndicator());

    _progressDialog?.show();
  }

  void hideLoadingDialog() {
    _progressDialog?.dismiss();
  }
}
