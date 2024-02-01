import 'dart:math';

import 'package:SoulSync/models/experience_dto.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

class ProfileSection extends StatefulWidget {
  final String label;
  final List<ExperienceDto> experienceList;
  final bool isIconEndPosition;
  final VoidCallback? onAdd;
  final Function(String)? onViewAward;
  final Function(String)? onLogSheet;
  final Function(String)? onMoreInfo;

  const ProfileSection({
    super.key,
    required this.label,
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
        padding: const EdgeInsets.symmetric(
          horizontal: 16,
          vertical: 12,
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
                    style: const TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
                IconButton(
                  onPressed: widget.onAdd,
                  splashRadius: 24,
                  icon: const Icon(
                    Icons.add_rounded,
                    color: Color(0xFF9F9D9D),
                  ),
                )
              ],
            ),
            ListView.separated(
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
                            imageUrl: item.organizerIcon,
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
                              item.date,
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
                                        widget.onViewAward?.call(item.id);
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
                                        widget.onLogSheet?.call(item.id);
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
                                    widget.onMoreInfo?.call(item.id);
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