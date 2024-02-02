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
            padding: const EdgeInsets.only(top: 8),
            margin: const EdgeInsets.only(left: 12, right: 12, top: 4),
            child: Container(
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
          ),
          Align(
            alignment: Alignment.topRight,
            child: GestureDetector(
              onTap: onRemove,
              child: Container(
                decoration: const BoxDecoration(
                  shape: BoxShape.circle,
                  color: Colors.white,
                ),
                padding: const EdgeInsets.all(6),
                child: const Icon(
                  Icons.close,
                  size: 20,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
