import 'dart:io';

import 'package:flutter/material.dart';

class RemovableAttachment extends StatelessWidget {
  final String filePath;
  final double previewHeight;
  final double previewWidth;
  final double roundedRadius;
  final VoidCallback? onRemove;

  const RemovableAttachment({
    super.key,
    required this.filePath,
    required this.previewHeight,
    required this.previewWidth,
    this.roundedRadius = 16,
    this.onRemove,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: previewHeight,
      width: previewWidth,
      child: Stack(
        children: [
          Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(roundedRadius),
              border: Border.all(
                color: Colors.grey,
                width: 2,
              ),
            ),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(roundedRadius - 2),
              child: Image.file(
                File(filePath),
                height: previewWidth,
                width: previewWidth,
                fit: BoxFit.cover,
              ),
            ),
          ),
          Visibility(
            visible: onRemove != null,
            child: Align(
              alignment: Alignment.topRight,
              child: GestureDetector(
                onTap: onRemove,
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.black.withOpacity(0.5),
                    borderRadius: const BorderRadius.only(
                      topRight: Radius.circular(16),
                      bottomLeft: Radius.circular(16),
                    )
                  ),
                  padding: const EdgeInsets.all(8),
                  child: const Icon(
                    Icons.close,
                    size: 20,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
