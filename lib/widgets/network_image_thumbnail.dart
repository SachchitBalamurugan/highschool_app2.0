import 'package:SoulSync/consts/collection_constant.dart';
import 'package:SoulSync/widgets/add_image.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

class NetworkImageThumbnail extends StatelessWidget {
  final double previewHeight;
  final double previewWidth;
  final String? imageUrl;
  final bool isEditable;
  final VoidCallback? onAddAttachment;

  const NetworkImageThumbnail({
    super.key,
    this.previewHeight = 148,
    this.previewWidth = double.infinity,
    this.isEditable = true,
    this.imageUrl,
    this.onAddAttachment,
  });

  @override
  Widget build(BuildContext context) {
    if (imageUrl == null) {
      return Padding(
        padding: const EdgeInsets.only(top: 12),
        child: AddImage(
          previewHeight: previewHeight,
          previewWidth: previewWidth,
          onAdd: onAddAttachment,
        ),
      );
    }

    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: Colors.grey,
          width: 2,
        ),
      ),
      margin: const EdgeInsets.only(top: 12),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(14),
        child: CachedNetworkImage(
          imageUrl: imageUrl ?? CollectionConstant.emptyImage,
          height: previewHeight,
          width: previewWidth,
          fit: BoxFit.cover,
        ),
      ),
    );
  }
}
