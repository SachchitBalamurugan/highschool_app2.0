import 'package:SoulSync/consts/collection_constant.dart';
import 'package:SoulSync/widgets/attachment_input.dart';
import 'package:SoulSync/widgets/network_image_thumbnail.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:image_picker/image_picker.dart';

class SetAwardDialog extends StatefulWidget {
  final String description;
  final bool isEditable;
  final List<String> urls;

  const SetAwardDialog({
    super.key,
    required this.description,
    required this.isEditable,
    this.urls = const [],
  });

  @override
  State<SetAwardDialog> createState() => _SetAwardDialogState();
}

class _SetAwardDialogState extends State<SetAwardDialog> {
  final _picker = ImagePicker();
  final _descriptionController = TextEditingController();

  final _filePaths = <String>[];

  @override
  void initState() {
    super.initState();

    _descriptionController.text = widget.description;
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15.0),
      ),
      child: SingleChildScrollView(
        child: Container(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const Text(
                "Awards",
                style: TextStyle(
                  fontSize: 28,
                  fontWeight: FontWeight.w600,
                ),
              ),
              const SizedBox(height: 16),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 12),
                child: TextFormField(
                  controller: _descriptionController,
                  decoration: const InputDecoration(
                    hintText: 'Insert award description',
                  ),
                  readOnly: !widget.isEditable,
                  textInputAction: TextInputAction.done,
                ),
              ),
              const SizedBox(height: 24),
              Visibility(
                visible: widget.urls.isNotEmpty,
                child: ListView.builder(
                  itemCount: widget.urls.length,
                  primary: false,
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  padding: const EdgeInsets.symmetric(horizontal: 12),
                  itemBuilder: (ctx, idx) {
                    return NetworkImageThumbnail(
                      imageUrl: widget.urls[idx],
                      isEditable: widget.isEditable,
                    );
                  },
                ),
              ),
              Visibility(
                visible: widget.isEditable,
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 12),
                  child: AttachmentInput(
                    filePaths: _filePaths,
                    maxFiles: 3 - widget.urls.length,
                    onAddAttachment: _onAddAttachment,
                    onRemoveAttachment: _onRemoveAttachment,
                  ),
                ),
              ),
              const SizedBox(height: 24),
              Visibility(
                visible: widget.isEditable,
                child: Container(
                  width: double.infinity,
                  margin: const EdgeInsets.symmetric(horizontal: 12),
                  child: FilledButton(
                    onPressed: _onSave,
                    child: const Text('Save'),
                  ),
                ),
              ),
              const SizedBox(height: 8),
            ],
          ),
        ),
      ),
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

  void _onSave() {
    final newDescription = _descriptionController.text;
    if (newDescription.isEmpty) {
      Fluttertoast.showToast(msg: 'Please fill award');
      return;
    }
    if (widget.urls.isEmpty && _filePaths.isEmpty) {
      Fluttertoast.showToast(msg: 'Please insert at least one image');
      return;
    }

    Navigator.of(context).pop([newDescription, _filePaths]);
  }
}
