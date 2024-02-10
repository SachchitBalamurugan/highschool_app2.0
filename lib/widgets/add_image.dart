import 'package:flutter/material.dart';

class AddImage extends StatelessWidget {
  final double previewHeight;
  final double previewWidth;
  final VoidCallback? onAdd;

  const AddImage({
    super.key,
    this.previewHeight = 148,
    this.previewWidth = double.infinity,
    this.onAdd,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onAdd,
      child: Container(
        height: previewHeight,
        width: previewWidth,
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
    );
  }
}
