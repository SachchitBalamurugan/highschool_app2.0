import 'dart:io';

import 'package:SoulSync/consts/collection_constant.dart';
import 'package:SoulSync/models/experience_dto.dart';
import 'package:SoulSync/screens/account.dart';
import 'package:SoulSync/screens/app_info.dart';
import 'package:SoulSync/widgets/app_extension.dart';
import 'package:SoulSync/widgets/attachment_input.dart';
import 'package:SoulSync/widgets/network_image_thumbnail.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:image_picker/image_picker.dart';
import 'package:ndialog/ndialog.dart';
import 'package:velocity_x/velocity_x.dart';

class MoreInfoPage2 extends StatefulWidget {
  final String collectionKey;
  final String experienceId;

  const MoreInfoPage2({
    super.key,
    required this.collectionKey,
    required this.experienceId,
  });

  @override
  State<MoreInfoPage2> createState() => _MoreInfoPage2State();
}

class _MoreInfoPage2State extends State<MoreInfoPage2> {
  final _picker = ImagePicker();
  final _eventIcons = <String>[];
  final _eventController = TextEditingController();
  final _eventDescController = TextEditingController();

  final _awardImages = <String>[];
  final _additionalAwardImages1 = <String>[];
  final _additionalAwardImages2 = <String>[];
  final _awardController = TextEditingController();

  final _snapshotImages = <String>[];
  final _additionalSnapshotImages1 = <String>[];
  final _additionalSnapshotImages2 = <String>[];
  final _snapshotController = TextEditingController();

  var _userName = "";
  var _email = "";
  var _phone = "";
  var _isLoading = true;

  ExperienceDto? _experience;
  CustomProgressDialog? _progressDialog;

  @override
  void initState() {
    super.initState();

    _getUserInfo().then((_) => _getDetail());
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
      body: Visibility(
        visible: !_isLoading,
        replacement: const Center(
          child: CircularProgressIndicator(),
        ),
        child: SingleChildScrollView(
          child: Column(
            children: [
              Container(
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
                  borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(20),
                    bottomRight: Radius.circular(20),
                  ),
                ),
                child: SafeArea(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      InkWell(
                        onTap: Navigator.of(context).pop,
                        child: const Icon(
                          Icons.arrow_back,
                          size: 30,
                          color: Colors.white,
                        ),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          InkWell(
                            onTap: _onOpenInfoPage,
                            child: const Icon(
                              Icons.info,
                              size: 30,
                              color: Colors.white,
                            ),
                          ),
                          GestureDetector(
                            onTap: _onOpenProfilePage,
                            child: const Icon(
                              Icons.person,
                              size: 30,
                              color: Colors.white,
                            ),
                          )
                        ],
                      ),
                      const SizedBox(height: 20),
                      Padding(
                        padding: const EdgeInsets.only(left: 3, bottom: 15),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const CircleAvatar(
                              radius: 50,
                            ),
                            const SizedBox(width: 15),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  _userName,
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
                                  style: TextStyle(
                                    fontSize: 20,
                                    fontWeight: FontWeight.w400,
                                    color: Colors.white,
                                  ),
                                ),
                                const Text(
                                  "Little Elm, TX",
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
              const SizedBox(height: 24),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Row(
                  children: [
                    Visibility(
                      visible: _experience?.organizerIcon.isEmptyOrNull == true,
                      replacement: NetworkImageThumbnail(
                        imageUrl: _experience?.organizerIcon,
                        previewHeight: 120,
                        previewWidth: 120,
                        onAddAttachment: () {
                          _onAddImage('_eventIcons');
                        },
                      ),
                      child: AttachmentInput(
                        filePaths: _eventIcons,
                        previewHeight: 120,
                        previewWidth: 120,
                        maxFiles: 1,
                        onAddAttachment: () {
                          _onAddImage('_eventIcons');
                        },
                        onRemoveAttachment: (index) {
                          _onRemoveImage('_eventIcons', index);
                        },
                      ),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: Column(
                        children: [
                          TextFormField(
                            controller: _eventController,
                            decoration: const InputDecoration(
                              hintText: 'Event Name',
                            ),
                            textInputAction: TextInputAction.next,
                          ),
                          const SizedBox(height: 6),
                          TextFormField(
                            controller: _eventDescController,
                            decoration: const InputDecoration(
                              hintText: 'Event Description',
                            ),
                            textInputAction: TextInputAction.newline,
                            maxLines: 2,
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 32),
              const Text(
                "What Did I win",
                style: TextStyle(
                  fontSize: 25,
                  fontWeight: FontWeight.w600,
                ),
              ),
              const SizedBox(height: 12),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Visibility(
                  visible: _experience?.certificates.elementAtOrNull(0) == null,
                  replacement: NetworkImageThumbnail(
                    imageUrl: _experience?.certificates.elementAtOrNull(0),
                    previewHeight: 180,
                  ),
                  child: AttachmentInput(
                    filePaths: _awardImages,
                    previewHeight: 180,
                    maxFiles: 1,
                    onAddAttachment: () {
                      _onAddImage('_awardImages');
                    },
                    onRemoveAttachment: (index) {
                      _onRemoveImage('_awardImages', index);
                    },
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Row(
                  children: [
                    Expanded(
                      child: Visibility(
                        visible: _experience?.certificates.elementAtOrNull(1) == null,
                        replacement: NetworkImageThumbnail(
                          imageUrl: _experience?.certificates.elementAtOrNull(1),
                          previewHeight: 124,
                          onAddAttachment: () {
                            _onAddImage('_additionalAwardImages1');
                          },
                        ),
                        child: AttachmentInput(
                          filePaths: _additionalAwardImages1,
                          previewHeight: 124,
                          maxFiles: 1,
                          onAddAttachment: () {
                            _onAddImage('_additionalAwardImages1');
                          },
                          onRemoveAttachment: (index) {
                            _onRemoveImage('_additionalAwardImages1', index);
                          },
                        ),
                      ),
                    ),
                    const SizedBox(width: 16),
                    Expanded(
                      child: Visibility(
                        visible: _experience?.certificates.elementAtOrNull(2) == null,
                        replacement: NetworkImageThumbnail(
                          imageUrl: _experience?.certificates.elementAtOrNull(2),
                          previewHeight: 124,
                          onAddAttachment: () {
                            _onAddImage('_additionalAwardImages2');
                          },
                        ),
                        child: AttachmentInput(
                          filePaths: _additionalAwardImages2,
                          previewHeight: 124,
                          maxFiles: 1,
                          onAddAttachment: () {
                            _onAddImage('_additionalAwardImages2');
                          },
                          onRemoveAttachment: (index) {
                            _onRemoveImage('_additionalAwardImages2', index);
                          },
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 8),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: TextFormField(
                  controller: _awardController,
                  decoration: const InputDecoration(
                    hintText: 'Type your Info Here...',
                  ),
                  textInputAction: TextInputAction.done,
                ),
              ),
              const SizedBox(height: 32),
              const Text(
                "Pictures",
                style: TextStyle(
                  fontSize: 25,
                  fontWeight: FontWeight.w600,
                ),
              ),
              const SizedBox(height: 12),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Visibility(
                  visible: _experience?.snapshots.elementAtOrNull(0) == null,
                  replacement: NetworkImageThumbnail(
                    imageUrl: _experience?.snapshots.elementAtOrNull(0),
                    previewHeight: 180,
                    onAddAttachment: () {
                      _onAddImage('_snapshotImages');
                    },
                  ),
                  child: AttachmentInput(
                    filePaths: _snapshotImages,
                    previewHeight: 180,
                    maxFiles: 1,
                    onAddAttachment: () {
                      _onAddImage('_snapshotImages');
                    },
                    onRemoveAttachment: (index) {
                      _onRemoveImage('_snapshotImages', index);
                    },
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Row(
                  children: [
                    Expanded(
                      child: Visibility(
                        visible: _experience?.snapshots.elementAtOrNull(1) == null,
                        replacement: NetworkImageThumbnail(
                          imageUrl: _experience?.snapshots.elementAtOrNull(1),
                          previewHeight: 124,
                          onAddAttachment: () {
                            _onAddImage('_additionalSnapshotImages1');
                          },
                        ),
                        child: AttachmentInput(
                          filePaths: _additionalSnapshotImages1,
                          previewHeight: 124,
                          maxFiles: 1,
                          onAddAttachment: () {
                            _onAddImage('_additionalSnapshotImages1');
                          },
                          onRemoveAttachment: (index) {
                            _onRemoveImage('_additionalSnapshotImages1', index);
                          },
                        ),
                      ),
                    ),
                    const SizedBox(width: 16),
                    Expanded(
                      child: Visibility(
                        visible: _experience?.snapshots.elementAtOrNull(2) == null,
                        replacement: NetworkImageThumbnail(
                          imageUrl: _experience?.snapshots.elementAtOrNull(2),
                          previewHeight: 124,
                          onAddAttachment: () {
                            _onAddImage('_additionalSnapshotImages2');
                          },
                        ),
                        child: AttachmentInput(
                          filePaths: _additionalSnapshotImages2,
                          previewHeight: 124,
                          maxFiles: 1,
                          onAddAttachment: () {
                            _onAddImage('_additionalSnapshotImages2');
                          },
                          onRemoveAttachment: (index) {
                            _onRemoveImage('_additionalSnapshotImages2', index);
                          },
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 8),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: TextFormField(
                  controller: _snapshotController,
                  decoration: const InputDecoration(
                    hintText: 'Type your Info Here...',
                  ),
                  textInputAction: TextInputAction.done,
                ),
              ),
              const SizedBox(height: 48),
              Container(
                width: double.infinity,
                margin: const EdgeInsets.symmetric(horizontal: 16),
                child: FilledButton(
                  onPressed: _onSave,
                  child: const Text('Save'),
                ),
              ),
              const SizedBox(height: 24),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> _getUserInfo() async {
    User? user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      try {
        DocumentSnapshot userSnapshot = await FirebaseFirestore.instance
            .collection(CollectionConstant.users)
            .doc(user.email)
            .get();

        setState(() {
          _userName = userSnapshot['User Name'] ?? "User";
          _email = userSnapshot['Email'];
          _phone = userSnapshot['Phone'];
        });
      } catch (e) {
        Fluttertoast.showToast(msg: 'Error fetching user data: $e');
      }
    }
  }

  Future _getDetail() async {
    setState(() {
      _isLoading = true;
      _eventIcons.clear();
      _awardImages.clear();
      _additionalAwardImages1.clear();
      _additionalAwardImages2.clear();
      _snapshotImages.clear();
      _additionalSnapshotImages1.clear();
      _additionalSnapshotImages2.clear();
    });

    final instance = FirebaseFirestore.instance;
    final result = await instance
        .collection(CollectionConstant.users)
        .doc(_email)
        .collection(widget.collectionKey)
        .doc(widget.experienceId)
        .get();

    setState(() {
      _isLoading = false;
      _experience = result.data()?.toExperienceDto(widget.experienceId);
    });

    _eventController.text = _experience?.event ?? '';
    _eventDescController.text = _experience?.eventDescription ?? '';
    _awardController.text = _experience?.awardDescription ?? '';
    _snapshotController.text = _experience?.snapshotsDescription ?? '';
  }

  void _onOpenInfoPage() {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => AppInfoPage(),
      ),
    );
  }

  void _onOpenProfilePage() {
    Navigator.of(context).push(
      MaterialPageRoute(builder: (context) {
        return AccountScreen(
          email: _email,
          phone: _phone,
          username: _userName,
        );
      }),
    );
  }

  void _onAddImage(String id) async {
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
      switch (id) {
        case '_eventIcons':
          _eventIcons.add(pickedImage.path);
          break;
        case '_awardImages':
          _awardImages.add(pickedImage.path);
          break;
        case '_additionalAwardImages1':
          _additionalAwardImages1.add(pickedImage.path);
          break;
        case '_additionalAwardImages2':
          _additionalAwardImages2.add(pickedImage.path);
          break;
        case '_snapshotImages':
          _snapshotImages.add(pickedImage.path);
          break;
        case '_additionalSnapshotImages1':
          _additionalSnapshotImages1.add(pickedImage.path);
          break;
        case '_additionalSnapshotImages2':
          _additionalSnapshotImages2.add(pickedImage.path);
          break;
      }
    });
  }

  void _onRemoveImage(String id, int index) {
    setState(() {
      switch (id) {
        case '_eventIcons':
          _eventIcons.removeAt(index);
          break;
        case '_awardImages':
          _awardImages.removeAt(index);
          break;
        case '_additionalAwardImages1':
          _additionalAwardImages1.removeAt(index);
          break;
        case '_additionalAwardImages2':
          _additionalAwardImages2.removeAt(index);
          break;
        case '_snapshotImages':
          _snapshotImages.removeAt(index);
          break;
        case '_additionalSnapshotImages1':
          _additionalSnapshotImages1.removeAt(index);
          break;
        case '_additionalSnapshotImages2':
          _additionalSnapshotImages2.removeAt(index);
          break;
      }
    });
  }

  void _onSave() async {
    final instance = FirebaseFirestore.instance;
    final newMap = <String, dynamic>{};

    // Show Loading
    showLoadingDialog();

    /// Event Detail
    newMap[CollectionConstant.event] = _eventController.text;
    newMap[CollectionConstant.eventDescription] = _eventDescController.text;
    if (_eventIcons.isNotEmpty) {
      final organizerIcon = await _uploadFile(_eventIcons[0]);
      newMap[CollectionConstant.organizerIcon] = organizerIcon;
    }

    /// Award
    final collectiveAwardImages = <String>[];
    collectiveAwardImages.addAll(_awardImages);
    collectiveAwardImages.addAll(_additionalAwardImages1);
    collectiveAwardImages.addAll(_additionalAwardImages2);
    if (collectiveAwardImages.isNotEmpty) {
      final urls = <String>[];
      final existingUrls = _experience?.certificates ?? [];
      if (existingUrls.isNotEmpty) {
        urls.addAll(existingUrls);
      }

      for (final path in collectiveAwardImages) {
        final fileUrl = await _uploadFile(path);
        urls.add(fileUrl);
      }

      newMap[CollectionConstant.certificates] = urls;
    }
    newMap[CollectionConstant.certificatesDescription] = _awardController.text;

    /// Snapshots
    final collectiveSnapshotImages = <String>[];
    collectiveSnapshotImages.addAll(_snapshotImages);
    collectiveSnapshotImages.addAll(_additionalSnapshotImages1);
    collectiveSnapshotImages.addAll(_additionalSnapshotImages2);
    if (collectiveSnapshotImages.isNotEmpty) {
      final urls = <String>[];
      final existingUrls = _experience?.snapshots ?? [];
      if (existingUrls.isNotEmpty) {
        urls.addAll(existingUrls);
      }

      for (final path in collectiveSnapshotImages) {
        final fileUrl = await _uploadFile(path);
        urls.add(fileUrl);
      }

      newMap[CollectionConstant.snapshots] = urls;
    }
    newMap[CollectionConstant.snapshotsDescription] = _snapshotController.text;

    /// Save
    await instance
        .collection(CollectionConstant.users)
        .doc(_email)
        .collection(widget.collectionKey)
        .doc(widget.experienceId)
        .update(newMap);

    // Hide Loading
    hideLoadingDialog();
    Fluttertoast.showToast(msg: 'Successfully Save Information');

    await _getDetail();
  }

  Future<String> _uploadFile(String filePath) async {
    final storageRef = FirebaseStorage.instance.ref();

    final file = File(filePath);
    final fileName = filePath.split('/').lastOrNull;

    final path = '${CollectionConstant.storageExperiences}/$fileName';
    final references = storageRef.child(path);

    final snapshot = await references.putFile(file);
    return await snapshot.ref.getDownloadURL();
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
