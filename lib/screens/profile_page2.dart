import 'package:SoulSync/consts/collection_constant.dart';
import 'package:SoulSync/models/experience_dto.dart';
import 'package:SoulSync/screens/account.dart';
import 'package:SoulSync/screens/app_info.dart';
import 'package:SoulSync/widgets/app_extension.dart';
import 'package:SoulSync/widgets/profile_section.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

class ProfilePage2 extends StatefulWidget {
  const ProfilePage2({super.key});

  @override
  State<ProfilePage2> createState() => _ProfilePage2State();
}

class _ProfilePage2State extends State<ProfilePage2> {
  String _userName = "";
  String _email = "";
  String _phone = "";

  final _academicList = <ExperienceDto>[];
  final _athleticList = <ExperienceDto>[];
  final _artList = <ExperienceDto>[];
  final _organizationList = <ExperienceDto>[];
  final _communityList = <ExperienceDto>[];
  final _honorList = <ExperienceDto>[];

  var _isLoading = true;

  @override
  void initState() {
    super.initState();

    _loadUserName().then((_) => _getAllData());
  }

  Future<void> _loadUserName() async {
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

  Future _getAllData() async {
    final instance = FirebaseFirestore.instance;
    final academicResult = await instance
        .collection(CollectionConstant.users)
        .doc(_email)
        .collection(CollectionConstant.academic)
        .get();

    final athleticResult = await instance
        .collection(CollectionConstant.users)
        .doc(_email)
        .collection(CollectionConstant.athletic)
        .get();

    final artResult = await instance
        .collection(CollectionConstant.users)
        .doc(_email)
        .collection(CollectionConstant.art)
        .get();

    final organizationResult = await instance
        .collection(CollectionConstant.users)
        .doc(_email)
        .collection(CollectionConstant.organization)
        .get();

    final communityResult = await instance
        .collection(CollectionConstant.users)
        .doc(_email)
        .collection(CollectionConstant.community)
        .get();

    final honorResult = await instance
        .collection(CollectionConstant.users)
        .doc(_email)
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

  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
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
                                "Lone Star Highschool", // Your desired heading
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
                    experienceList: _academicList,
                    onAdd: () {
                      _onAddExperience(CollectionConstant.academic);
                    },
                    onViewAward: _onViewAward,
                    onMoreInfo: _onMoreInfo,
                  ),
                  const SizedBox(height: 8),
                  ProfileSection(
                    label: 'Athletic Participation',
                    experienceList: _athleticList,
                    onAdd: () {
                      _onAddExperience(CollectionConstant.athletic);
                    },
                    onViewAward: _onViewAward,
                    onMoreInfo: _onMoreInfo,
                  ),
                  const SizedBox(height: 8),
                  ProfileSection(
                    label: 'Performing Arts Experience',
                    experienceList: _artList,
                    onAdd: () {
                      _onAddExperience(CollectionConstant.art);
                    },
                    onViewAward: _onViewAward,
                    onMoreInfo: _onMoreInfo,
                  ),
                  const SizedBox(height: 8),
                  ProfileSection(
                    label: 'Clubs and Organization Memberships',
                    experienceList: _organizationList,
                    onAdd: () {
                      _onAddExperience(CollectionConstant.organization);
                    },
                    onViewAward: _onViewAward,
                    onMoreInfo: _onMoreInfo,
                  ),
                  const SizedBox(height: 8),
                  ProfileSection(
                    label: 'Community Service Hours',
                    experienceList: _communityList,
                    onAdd: () {
                      _onAddExperience(CollectionConstant.community);
                    },
                    onLogSheet: _onViewLogSheet,
                    onMoreInfo: _onMoreInfo,
                  ),
                  const SizedBox(height: 8),
                  ProfileSection(
                    label: 'Honor Classes',
                    isIconEndPosition: true,
                    experienceList: _honorList,
                    onAdd: () {
                      _onAddExperience(CollectionConstant.honor);
                    },
                    onMoreInfo: _onMoreInfo,
                  ),
                  const SizedBox(height: 80),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }

  void _onAddExperience(String collectionKey) {}

  void _onOpenInfoPage() {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => AppInfoPage(),
      ),
    );
  }

  void _onOpenProfilePage() {
    // Replace the following code with your navigation logic
    Navigator.of(context).push(
      MaterialPageRoute(builder: (context) {
        // Replace `YourDestinationScreen` with the screen you want to navigate to.
        return AccountScreen(
          email: _email,
          phone: _phone,
          username: _userName,
        );
      }),
    );
  }

  void _onViewAward(String experienceId) {}

  void _onViewLogSheet(String experienceId) {}

  void _onMoreInfo(String experienceId) {}
}
