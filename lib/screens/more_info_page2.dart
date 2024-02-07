import 'package:SoulSync/consts/collection_constant.dart';
import 'package:SoulSync/screens/account.dart';
import 'package:SoulSync/screens/app_info.dart';
import 'package:SoulSync/widgets/attachment_input.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:image_picker/image_picker.dart';

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
  final _awardController = TextEditingController();
  final _additionalAwardImages1 = <String>[];
  final _additionalAwardImages2 = <String>[];
  final _additionalAwardController = TextEditingController();

  final _snapshotImages = <String>[];
  final _snapshotController = TextEditingController();
  final _additionalSnapshotImages1 = <String>[];
  final _additionalSnapshotImages2 = <String>[];
  final _additionalSnapshotController = TextEditingController();

  var _userName = "";
  var _email = "";
  var _phone = "";
  var _isLoading = true;

  @override
  void initState() {
    super.initState();

    _getUserInfo();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              padding: const EdgeInsets.only(
                  top: 15, left: 15, right: 15, bottom: 10),
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
                  AttachmentInput(
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
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
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
            const SizedBox(height: 8),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Row(
                children: [
                  Expanded(
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
                  const SizedBox(width: 16),
                  Expanded(
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
                ],
              ),
            ),
            const SizedBox(height: 8),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: TextFormField(
                controller: _additionalAwardController,
                decoration: const InputDecoration(
                  hintText: 'Type your Info Here...',
                ),
                textInputAction: TextInputAction.done,
              ),
            ),
            const SizedBox(height: 24),
            const Text(
              "Pictures",
              style: TextStyle(
                fontSize: 25,
                fontWeight: FontWeight.w600,
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
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
            const SizedBox(height: 8),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Row(
                children: [
                  Expanded(
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
                  const SizedBox(width: 16),
                  Expanded(
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
                ],
              ),
            ),
            const SizedBox(height: 8),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: TextFormField(
                controller: _additionalSnapshotController,
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

  void _onSave() {

  }
}
