import 'package:SoulSync/consts/collection_constant.dart';
import 'package:SoulSync/widgets/attachment_input.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:image_picker/image_picker.dart';

class SetLogSheetDialog extends StatefulWidget {
  final List<String> urls;

  const SetLogSheetDialog({
    super.key,
    this.urls = const [],
  });

  @override
  State<SetLogSheetDialog> createState() => _SetLogSheetDialogState();
}

class _SetLogSheetDialogState extends State<SetLogSheetDialog> {
  final _picker = ImagePicker();

  final _filePaths = <String>[];

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
                "Log Sheet",
                style: TextStyle(
                  fontSize: 28,
                  fontWeight: FontWeight.w600,
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
                    return Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(16),
                        border: Border.all(
                          color: Colors.grey,
                          width: 2,
                        ),
                      ),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(14),
                        child: CachedNetworkImage(
                          imageUrl: widget.urls[idx],
                          height: 148,
                          width: 148,
                          fit: BoxFit.cover,
                        ),
                      ),
                    );
                  },
                ),
              ),
              const SizedBox(height: 16),
              AttachmentInput(
                filePaths: _filePaths,
                onAddAttachment: _onAddAttachment,
                onRemoveAttachment: _onRemoveAttachment,
              ),
              const SizedBox(height: 24),
              Container(
                width: double.infinity,
                margin: const EdgeInsets.symmetric(horizontal: 12),
                child: FilledButton(
                  onPressed: _onSave,
                  child: const Text('Save'),
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
    if (widget.urls.isEmpty && _filePaths.isEmpty) {
      Fluttertoast.showToast(msg: 'Please insert at least one image');
      return;
    }

    Navigator.of(context).pop(_filePaths);
  }
}
