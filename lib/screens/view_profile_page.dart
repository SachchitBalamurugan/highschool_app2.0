import 'dart:io';

import 'package:SoulSync/consts/collection_constant.dart';
import 'package:SoulSync/dialogs/course_score_dialog.dart';
import 'package:SoulSync/dialogs/set_award_dialog.dart';
import 'package:SoulSync/dialogs/set_logsheet_dialog.dart';
import 'package:SoulSync/models/experience_dto.dart';
import 'package:SoulSync/screens/more_info_page2.dart';
import 'package:SoulSync/widgets/app_extension.dart';
import 'package:SoulSync/widgets/profile_section.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:ndialog/ndialog.dart';

class ViewProfilePage extends StatefulWidget {
  final String email;

  const ViewProfilePage({
    super.key,
    required this.email,
  });

  @override
  State<ViewProfilePage> createState() => _ViewProfilePageState();
}

class _ViewProfilePageState extends State<ViewProfilePage> {
  final _academicList = <ExperienceDto>[];
  final _athleticList = <ExperienceDto>[];
  final _artList = <ExperienceDto>[];
  final _organizationList = <ExperienceDto>[];
  final _communityList = <ExperienceDto>[];
  final _honorList = <ExperienceDto>[];

  var _userName = "";
  var _email = "";
  var _phone = "";
  var _isLoading = true;

  CustomProgressDialog? _progressDialog;

  @override
  void initState() {
    super.initState();

    _getUserInfo().then((_) => _getAllData());
  }

  @override
  void dispose() {
    _progressDialog?.dismiss();
    _progressDialog = null;

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            backgroundColor: const Color(0xFF044051),
            floating: true,
            flexibleSpace: FlexibleSpaceBar(
              collapseMode: CollapseMode.pin,
              background: Container(
                padding: const EdgeInsets.only(
                  top: 15,
                  left: 15,
                  right: 15,
                  bottom: 10,
                ),
                decoration: const BoxDecoration(
                  gradient: LinearGradient(
                    colors: [
                      Color(0xFF044051),
                      Color(0xFF135263),
                      Color(0xFF35788A),
                      Color(0xFF35778A),
                      Color(0xFF43879A),
                      Color(0xFF5AA1B5),
                    ],
                  ),
                ),
                child: SafeArea(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          InkWell(
                            onTap: Navigator.of(context).pop,
                            child: const Icon(
                              Icons.arrow_back,
                              size: 30,
                              color: Colors.white,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 20),
                      Padding(
                        padding: const EdgeInsets.only(left: 3, bottom: 15),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            // Add the circular profile picture here
                            const CircleAvatar(
                              radius: 50,
                            ),
                            const SizedBox(width: 15),
                            // Adjust the spacing between the image and text
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  _userName, // Use the user's name
                                  style: const TextStyle(
                                    fontSize: 25,
                                    fontWeight: FontWeight.w600,
                                    letterSpacing: 1,
                                    wordSpacing: 2,
                                    color: Colors.white,
                                  ),
                                ),
                                const Text(
                                  "Lone Star Highschool",
                                  // Your desired heading
                                  style: TextStyle(
                                    fontSize: 20,
                                    fontWeight: FontWeight.w400,
                                    color: Colors.white,
                                  ),
                                ),
                                const Text(
                                  "Little Elm, TX", // Your desired heading
                                  style: TextStyle(
                                    fontSize: 20,
                                    fontWeight: FontWeight.w400,
                                    color: Colors.white,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            pinned: true,
            expandedHeight: 190,
            automaticallyImplyLeading: false,
          ),
          SliverVisibility(
            visible: !_isLoading,
            replacementSliver: const SliverFillRemaining(
              child: Center(child: CircularProgressIndicator()),
            ),
            sliver: SliverToBoxAdapter(
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    const SizedBox(height: 24),
                    ProfileSection(
                      label: 'Academic Achievements',
                      collectionKey: CollectionConstant.academic,
                      experienceList: _academicList,
                      onViewAward: _onViewAward,
                      onMoreInfo: _onMoreInfo,
                    ),
                    const SizedBox(height: 8),
                    ProfileSection(
                      label: 'Athletic Participation',
                      collectionKey: CollectionConstant.athletic,
                      experienceList: _athleticList,
                      onViewAward: _onViewAward,
                      onMoreInfo: _onMoreInfo,
                    ),
                    const SizedBox(height: 8),
                    ProfileSection(
                      label: 'Performing Arts Experience',
                      collectionKey: CollectionConstant.art,
                      experienceList: _artList,
                      onViewAward: _onViewAward,
                      onMoreInfo: _onMoreInfo,
                    ),
                    const SizedBox(height: 8),
                    ProfileSection(
                      label: 'Clubs and Organization Memberships',
                      collectionKey: CollectionConstant.organization,
                      experienceList: _organizationList,
                      onViewAward: _onViewAward,
                      onMoreInfo: _onMoreInfo,
                    ),
                    const SizedBox(height: 8),
                    ProfileSection(
                      label: 'Community Service Hours',
                      collectionKey: CollectionConstant.community,
                      experienceList: _communityList,
                      onLogSheet: _onViewLogSheet,
                      onMoreInfo: _onMoreInfo,
                    ),
                    const SizedBox(height: 8),
                    ProfileSection(
                      label: 'Honor Classes',
                      collectionKey: CollectionConstant.honor,
                      isIconEndPosition: true,
                      experienceList: _honorList,
                      onMoreInfo: _onMoreInfo,
                    ),
                    const SizedBox(height: 80),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Future<void> _getUserInfo() async {
    try {
      DocumentSnapshot userSnapshot = await FirebaseFirestore.instance
          .collection(CollectionConstant.users)
          .doc(widget.email)
          .get();

      setState(() {
        _userName = userSnapshot[CollectionConstant.userName] ?? "User";
        _email = userSnapshot[CollectionConstant.userEmail];
        _phone = userSnapshot[CollectionConstant.userPhone];
      });
    } catch (e) {
      Fluttertoast.showToast(msg: 'Error fetching user data: $e');
    }
  }

  Future _getAllData() async {
    setState(() {
      _isLoading = true;
    });

    final instance = FirebaseFirestore.instance;
    final academicResult = await instance
        .collection(CollectionConstant.users)
        .doc(widget.email)
        .collection(CollectionConstant.academic)
        .get();

    final athleticResult = await instance
        .collection(CollectionConstant.users)
        .doc(widget.email)
        .collection(CollectionConstant.athletic)
        .get();

    final artResult = await instance
        .collection(CollectionConstant.users)
        .doc(widget.email)
        .collection(CollectionConstant.art)
        .get();

    final organizationResult = await instance
        .collection(CollectionConstant.users)
        .doc(widget.email)
        .collection(CollectionConstant.organization)
        .get();

    final communityResult = await instance
        .collection(CollectionConstant.users)
        .doc(widget.email)
        .collection(CollectionConstant.community)
        .get();

    final honorResult = await instance
        .collection(CollectionConstant.users)
        .doc(widget.email)
        .collection(CollectionConstant.honor)
        .get();

    setState(() {
      /// Academic Achievement List
      _academicList.clear();
      _academicList.addAll(academicResult.docs.map((e) {
        return e.data().toExperienceDto(e.id);
      }));

      /// Athletic Participation List
      _athleticList.clear();
      _athleticList.addAll(athleticResult.docs.map((e) {
        return e.data().toExperienceDto(e.id);
      }));

      /// Performing Arts Experience List
      _artList.clear();
      _artList.addAll(artResult.docs.map((e) {
        return e.data().toExperienceDto(e.id);
      }));

      /// Clubs and Organization Memberships List
      _organizationList.clear();
      _organizationList.addAll(organizationResult.docs.map((e) {
        return e.data().toExperienceDto(e.id);
      }));

      /// Community Service Hours List
      _communityList.clear();
      _communityList.addAll(communityResult.docs.map((e) {
        return e.data().toExperienceDto(e.id);
      }));

      /// Community Service Hours List
      _honorList.clear();
      _honorList.addAll(honorResult.docs.map((e) {
        return e.data().toExperienceDto(e.id);
      }));

      _isLoading = false;
    });
  }

  void _onViewAward(
    String collectionKey,
    String experienceId,
    String description,
    List<String> certificateUrls,
  ) async {
    final result = await showDialog(
      context: context,
      builder: (ctx) {
        return SetAwardDialog(
          description: description,
          isEditable: false,
          urls: certificateUrls,
        );
      },
    );

    if (result != null && result is List) {
      var newDescription = description;
      final filePaths = <String>[];

      final first = result.elementAtOrNull(0);
      final second = result.elementAtOrNull(1);

      if (first != null && first is String) {
        newDescription = first;
      }
      if (second != null && second is List<String>) {
        filePaths.clear();
        filePaths.addAll(second);
      }

      _onSaveAward(
        collectionKey,
        experienceId,
        newDescription,
        certificateUrls,
        filePaths,
      );
    }
  }

  void _onViewLogSheet(
    String collectionKey,
    String experienceId,
    List<String> logSheetUrls,
  ) async {
    final result = await showDialog(
      context: context,
      builder: (ctx) {
        return SetLogSheetDialog(
          isEditable: false,
          urls: logSheetUrls,
        );
      },
    );

    if (result != null && result is List<String>) {
      final filePaths = <String>[];

      filePaths.clear();
      filePaths.addAll(result);

      _onSaveLogSheet(
        collectionKey,
        experienceId,
        logSheetUrls,
        filePaths,
      );
    }
  }

  void _onSaveAward(
    String collectionKey,
    String experienceId,
    String newDescription,
    List<String> certificateUrls,
    List<String> filePaths,
  ) async {
    showLoadingDialog();

    final storageRef = FirebaseStorage.instance.ref();
    final fileUrls = <String>[];

    fileUrls.addAll(certificateUrls);

    for (final filePath in filePaths) {
      final file = File(filePath);
      final fileName = filePath.split('/').lastOrNull;

      final path = '${CollectionConstant.storageExperiences}/$fileName';
      final references = storageRef.child(path);

      final snapshot = await references.putFile(file);
      final fileUrl = await snapshot.ref.getDownloadURL();

      fileUrls.add(fileUrl);
    }

    final newMap = <String, dynamic>{};
    newMap['awardDescription'] = newDescription;
    newMap['certificates'] = fileUrls;

    final instance = FirebaseFirestore.instance;

    /// Save
    await instance
        .collection(CollectionConstant.users)
        .doc(_email)
        .collection(collectionKey)
        .doc(experienceId)
        .update(newMap);

    hideLoadingDialog();

    /// Refresh
    await _getAllData();
  }

  void _onSaveLogSheet(
    String collectionKey,
    String experienceId,
    List<String> logSheetUrls,
    List<String> filePaths,
  ) async {
    showLoadingDialog();

    final storageRef = FirebaseStorage.instance.ref();
    final fileUrls = <String>[];

    fileUrls.addAll(logSheetUrls);

    for (var e in filePaths) {
      final file = File(e);
      final fileName = e.split('/').lastOrNull;

      final path = '${CollectionConstant.storageExperiences}/$fileName';
      final references = storageRef.child(path);

      final snapshot = await references.putFile(file);
      final fileUrl = await snapshot.ref.getDownloadURL();

      fileUrls.add(fileUrl);
    }

    final newMap = <String, dynamic>{};
    newMap['logSheets'] = fileUrls;

    final instance = FirebaseFirestore.instance;

    /// Save
    await instance
        .collection(CollectionConstant.users)
        .doc(_email)
        .collection(collectionKey)
        .doc(experienceId)
        .update(newMap);

    hideLoadingDialog();

    /// Refresh
    await _getAllData();
  }

  void _onMoreInfo(String collectionKey, String experienceId) async {
    if (collectionKey == CollectionConstant.honor) {
      await showDialog(
        context: context,
        builder: (ctx) {
          return CourseScoreDialog(
            email: _email,
            experienceId: experienceId,
            isEditable: false,
          );
        },
      );
    } else {
      await Navigator.of(context).push(
        MaterialPageRoute(
          builder: (context) => MoreInfoPage2(
            collectionKey: collectionKey,
            experienceId: experienceId,
            isEditable: false,
            email: _email,
          ),
        ),
      );
    }

    await _getAllData();
  }

  void showLoadingDialog({
    bool isDismissible = true,
  }) {
    _progressDialog = CustomProgressDialog(
      context,
      dismissable: isDismissible,
    );
    _progressDialog?.setLoadingWidget(const CircularProgressIndicator());

    _progressDialog?.show();
  }

  void hideLoadingDialog() {
    _progressDialog?.dismiss();
  }
}
