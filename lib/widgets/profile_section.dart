import 'dart:math';

import 'package:SoulSync/consts/collection_constant.dart';
import 'package:SoulSync/models/experience_dto.dart';
import 'package:SoulSync/widgets/app_extension.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

class ProfileSection extends StatefulWidget {
  final String label;
  final String collectionKey;
  final List<ExperienceDto> experienceList;
  final bool isIconEndPosition;
  final Function(String)? onAdd;
  final Function(String, String, String, List<String>)? onViewAward;
  final Function(String, String, List<String>)? onLogSheet;
  final Function(String, String)? onMoreInfo;

  const ProfileSection({
    super.key,
    required this.label,
    required this.collectionKey,
    this.experienceList = const [],
    this.isIconEndPosition = false,
    this.onAdd,
    this.onViewAward,
    this.onLogSheet,
    this.onMoreInfo,
  });

  @override
  State<ProfileSection> createState() => _ProfileSectionState();
}

class _ProfileSectionState extends State<ProfileSection> {
  final int _maxItem = 1;

  var _isExpanded = false;

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 4,
      surfaceTintColor: Colors.white,
      color: Colors.white,
      margin: const EdgeInsets.symmetric(
        horizontal: 20,
        vertical: 8,
      ),
      child: Container(
        padding: const EdgeInsets.only(
          left: 16,
          top: 12,
          bottom: 12,
          right: 4,
        ),
        color: Colors.transparent,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Row(
              children: [
                Expanded(
                  child: Text(
                    widget.label,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    textAlign: TextAlign.start,
                    style: const TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
                Visibility(
                  visible: widget.onAdd != null,
                  child: IconButton(
                    onPressed: () {
                      widget.onAdd?.call(widget.collectionKey);
                    },
                    splashRadius: 24,
                    padding: EdgeInsets.zero,
                    icon: const Icon(
                      Icons.add_rounded,
                      color: Color(0xFF9F9D9D),
                    ),
                  ),
                )
              ],
            ),
            Visibility(
              visible: widget.experienceList.isNotEmpty,
              replacement: SizedBox(
                height: 120,
                child: Center(
                  child: Text(
                    'No data available',
                    style: TextStyle(
                      color: Colors.grey.shade600,
                    ),
                  ),
                ),
              ),
              child: ListView.separated(
                itemCount: _isExpanded
                    ? widget.experienceList.length
                    : min(widget.experienceList.length, _maxItem),
                primary: false,
                shrinkWrap: true,
                padding: EdgeInsets.zero,
                itemBuilder: (ctx, idx) {
                  final item = widget.experienceList[idx];

                  return Container(
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Visibility(
                          visible: !widget.isIconEndPosition,
                          child: Padding(
                            padding: const EdgeInsets.only(right: 8),
                            child: CachedNetworkImage(
                              imageUrl: item.organizerIcon.isEmpty
                                  ? CollectionConstant.emptyImage
                                  : item.organizerIcon,
                              width: 64,
                              height: 64,
                              fit: BoxFit.contain,
                            ),
                          ),
                        ),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                item.award,
                                style: const TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              const SizedBox(height: 2),
                              Text(
                                item.event,
                                maxLines: 2,
                                overflow: TextOverflow.ellipsis,
                                style: const TextStyle(
                                  fontSize: 12,
                                  fontWeight: FontWeight.bold,
                                  color: Color(0xFF818080),
                                ),
                              ),
                              const SizedBox(height: 4),
                              Text(
                                item.date.translateDate(
                                  toFormat: 'MMM dd, yyyy',
                                ),
                                style: const TextStyle(
                                  fontSize: 12,
                                  fontWeight: FontWeight.w400,
                                  color: Color(0xFF9F9D9D),
                                ),
                              ),
                              const SizedBox(height: 8),
                              Row(
                                children: [
                                  Visibility(
                                    visible: widget.onViewAward != null,
                                    child: Padding(
                                      padding: const EdgeInsets.only(right: 16),
                                      child: InkWell(
                                        onTap: () {
                                          widget.onViewAward?.call(
                                            widget.collectionKey,
                                            item.id,
                                            item.awardDescription,
                                            item.certificates,
                                          );
                                        },
                                        borderRadius: BorderRadius.circular(16),
                                        child: Container(
                                          decoration: BoxDecoration(
                                            border: Border.all(
                                              color: const Color(0xFFA5A5A5),
                                              width: 2,
                                            ),
                                            borderRadius:
                                                BorderRadius.circular(16),
                                          ),
                                          padding: const EdgeInsets.symmetric(
                                            horizontal: 12,
                                            vertical: 2,
                                          ),
                                          child: const Text(
                                            'View Award',
                                            style: TextStyle(
                                              fontWeight: FontWeight.w600,
                                              fontSize: 12,
                                              color: Color(0xFF818080),
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                  Visibility(
                                    visible: widget.onLogSheet != null,
                                    child: Padding(
                                      padding: const EdgeInsets.only(right: 16),
                                      child: InkWell(
                                        onTap: () {
                                          widget.onLogSheet?.call(
                                            widget.collectionKey,
                                            item.id,
                                            item.logSheets,
                                          );
                                        },
                                        borderRadius: BorderRadius.circular(16),
                                        child: Container(
                                          decoration: BoxDecoration(
                                            border: Border.all(
                                              color: const Color(0xFFA5A5A5),
                                              width: 2,
                                            ),
                                            borderRadius:
                                                BorderRadius.circular(16),
                                          ),
                                          padding: const EdgeInsets.symmetric(
                                            horizontal: 12,
                                            vertical: 2,
                                          ),
                                          child: const Text(
                                            'Log Sheet',
                                            style: TextStyle(
                                              fontWeight: FontWeight.w600,
                                              fontSize: 12,
                                              color: Color(0xFF818080),
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                  InkWell(
                                    onTap: () {
                                      widget.onMoreInfo?.call(
                                        widget.collectionKey,
                                        item.id,
                                      );
                                    },
                                    borderRadius: BorderRadius.circular(16),
                                    child: Container(
                                      decoration: BoxDecoration(
                                        border: Border.all(
                                          color: const Color(0xFFA5A5A5),
                                          width: 2,
                                        ),
                                        borderRadius: BorderRadius.circular(16),
                                      ),
                                      padding: const EdgeInsets.symmetric(
                                        horizontal: 12,
                                        vertical: 2,
                                      ),
                                      child: const Text(
                                        'More Info',
                                        style: TextStyle(
                                          fontWeight: FontWeight.w600,
                                          fontSize: 12,
                                          color: Color(0xFF818080),
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                        Visibility(
                          visible: widget.isIconEndPosition,
                          child: Padding(
                            padding: const EdgeInsets.only(left: 8),
                            child: CachedNetworkImage(
                              imageUrl: item.organizerIcon,
                              width: 64,
                              height: 64,
                              fit: BoxFit.contain,
                            ),
                          ),
                        ),
                      ],
                    ),
                  );
                },
                separatorBuilder: (ctx, idx) {
                  return const Divider(
                    height: 2,
                    thickness: 2,
                    color: Color(0xFFDFDFDF),
                  );
                },
              ),
            ),
            const Divider(
              height: 2,
              thickness: 2,
              color: Color(0xFFDFDFDF),
            ),
            Visibility(
              visible: widget.experienceList.length > _maxItem,
              child: Padding(
                padding: const EdgeInsets.only(top: 12),
                child: InkWell(
                  onTap: _toggleShowAll,
                  borderRadius: BorderRadius.circular(12),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 12,
                      vertical: 2,
                    ),
                    child: Text(
                      _isExpanded
                          ? 'Hide All ${widget.label}'
                          : 'Show All ${widget.label}',
                      style: const TextStyle(
                        fontWeight: FontWeight.w600,
                        fontSize: 12,
                        color: Color(0xFF818080),
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _toggleShowAll() {
    setState(() {
      _isExpanded = !_isExpanded;
    });
  }
}
