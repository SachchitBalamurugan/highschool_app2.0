import 'package:SoulSync/widgets/removable_attachment.dart';
import 'package:collection/collection.dart';
import 'package:flutter/material.dart';

class AttachmentInput extends StatelessWidget {
  final double previewHeight;
  final double previewWidth;
  final List<String> filePaths;
  final Function(int)? onRemoveAttachment;
  final VoidCallback? onAddAttachment;

  const AttachmentInput({
    super.key,
    this.previewHeight = 148,
    this.previewWidth = double.infinity,
    this.filePaths = const [],
    this.onRemoveAttachment,
    this.onAddAttachment,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        ...filePaths.mapIndexed(
          (idx, e) => RemovableAttachment(
            filePath: e,
            previewHeight: previewHeight,
            previewWidth: previewWidth,
            onRemove: () {
              onRemoveAttachment?.call(idx);
            },
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(top: 8),
          child: GestureDetector(
            onTap: onAddAttachment,
            child: Container(
              height: previewHeight,
              width: previewWidth,
              margin: const EdgeInsets.symmetric(horizontal: 12),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(16),
                border: Border.all(
                  color: Colors.grey,
                  width: 2,
                ),
              ),
              child: const Icon(
                Icons.file_upload_outlined,
                color: Colors.grey,
                size: 80,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
