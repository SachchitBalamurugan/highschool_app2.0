import 'package:SoulSync/widgets/add_image.dart';
import 'package:SoulSync/widgets/removable_attachment.dart';
import 'package:collection/collection.dart';
import 'package:flutter/material.dart';

class AttachmentInput extends StatelessWidget {
  final double previewHeight;
  final double previewWidth;
  final List<String> filePaths;
  final int? maxFiles;
  final Function(int)? onRemoveAttachment;
  final VoidCallback? onAddAttachment;

  const AttachmentInput({
    super.key,
    this.previewHeight = 148,
    this.previewWidth = double.infinity,
    this.filePaths = const [],
    this.maxFiles,
    this.onRemoveAttachment,
    this.onAddAttachment,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        ...filePaths.mapIndexed(
          (idx, e) => Padding(
            padding: const EdgeInsets.only(top: 12),
            child: RemovableAttachment(
              filePath: e,
              previewHeight: previewHeight,
              previewWidth: previewWidth,
              onRemove: onRemoveAttachment != null
                  ? () {
                      onRemoveAttachment?.call(idx);
                    }
                  : null,
            ),
          ),
        ),
        Visibility(
          visible: maxFiles == null || filePaths.length < (maxFiles ?? 0),
          child: Padding(
            padding: const EdgeInsets.only(top: 12),
            child: AddImage(
              previewHeight: previewHeight,
              previewWidth: previewWidth,
              onAdd: onAddAttachment,
            ),
          ),
        ),
      ],
    );
  }
}
