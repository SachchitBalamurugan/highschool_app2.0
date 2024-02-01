import 'package:SoulSync/consts/collection_constant.dart';
import 'package:SoulSync/models/experience_dto.dart';
import 'package:SoulSync/screens/account.dart';
import 'package:SoulSync/screens/app_info.dart';
import 'package:SoulSync/widgets/app_extension.dart';
import 'package:SoulSync/widgets/profile_section.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class ProfilePage2 extends StatefulWidget {
  const ProfilePage2({super.key});

  @override
  State<ProfilePage2> createState() => _ProfilePage2State();
}

class _ProfilePage2State extends State<ProfilePage2> {
  String _userName = "";
  String _email = "";
  String _phone = "";

  final _academicAchievementList = <ExperienceDto>[];
  final _athleticParticipationList = <ExperienceDto>[];
  final _artPerformanceList = <ExperienceDto>[];
  final _organizationMembershipList = <ExperienceDto>[];
  final _communityServicesList = <ExperienceDto>[];
  final _honorClassList = <ExperienceDto>[];

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
        print("Error fetching user data: $e");
      }
    }
  }

  Future _getAllData() async {
    final instance = FirebaseFirestore.instance;
    final academicAchievementResult = await instance
        .collection(CollectionConstant.users)
        .doc(_email)
        .collection(CollectionConstant.academicAchievements)
        .get();

    final athleticParticipationResult = await instance
        .collection(CollectionConstant.users)
        .doc(_email)
        .collection(CollectionConstant.athleticParticipation)
        .get();

    final artPerformancesResult = await instance
        .collection(CollectionConstant.users)
        .doc(_email)
        .collection(CollectionConstant.artPerformances)
        .get();

    final organizationMembershipsResult = await instance
        .collection(CollectionConstant.users)
        .doc(_email)
        .collection(CollectionConstant.organizationMemberships)
        .get();

    final communityServicesResult = await instance
        .collection(CollectionConstant.users)
        .doc(_email)
        .collection(CollectionConstant.communityServices)
        .get();

    final honorClassResult = await instance
        .collection(CollectionConstant.users)
        .doc(_email)
        .collection(CollectionConstant.honorClasses)
        .get();

    setState(() {
      /// Academic Achievement List
      _academicAchievementList.clear();
      _academicAchievementList.addAll(academicAchievementResult.docs.map((e) {
        return e.data().toExperienceDto(e.id);
      }));

      /// Athletic Participation List
      _athleticParticipationList.clear();
      _athleticParticipationList.addAll(athleticParticipationResult.docs.map((e) {
        return e.data().toExperienceDto(e.id);
      }));

      /// Performing Arts Experience List
      _artPerformanceList.clear();
      _artPerformanceList.addAll(artPerformancesResult.docs.map((e) {
        return e.data().toExperienceDto(e.id);
      }));

      /// Clubs and Organization Memberships List
      _organizationMembershipList.clear();
      _organizationMembershipList.addAll(organizationMembershipsResult.docs.map((e) {
        return e.data().toExperienceDto(e.id);
      }));

      /// Community Service Hours List
      _communityServicesList.clear();
      _communityServicesList.addAll(communityServicesResult.docs.map((e) {
        return e.data().toExperienceDto(e.id);
      }));

      /// Community Service Hours List
      _honorClassList.clear();
      _honorClassList.addAll(honorClassResult.docs.map((e) {
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
                    experienceList: _academicAchievementList,
                    onViewAward: _onViewAward,
                    onMoreInfo: _onMoreInfo,
                  ),
                  const SizedBox(height: 8),
                  ProfileSection(
                    label: 'Athletic Participation',
                    experienceList: _athleticParticipationList,
                    onViewAward: _onViewAward,
                    onMoreInfo: _onMoreInfo,
                  ),
                  const SizedBox(height: 8),
                  ProfileSection(
                    label: 'Performing Arts Experience',
                    experienceList: _artPerformanceList,
                    onViewAward: _onViewAward,
                    onMoreInfo: _onMoreInfo,
                  ),
                  const SizedBox(height: 8),
                  ProfileSection(
                    label: 'Clubs and Organization Memberships',
                    experienceList: _organizationMembershipList,
                    onViewAward: _onViewAward,
                    onMoreInfo: _onMoreInfo,
                  ),
                  const SizedBox(height: 8),
                  ProfileSection(
                    label: 'Community Service Hours',
                    experienceList: _communityServicesList,
                    onLogSheet: _onViewLogSheet,
                    onMoreInfo: _onMoreInfo,
                  ),
                  const SizedBox(height: 8),
                  ProfileSection(
                    label: 'Honor Classes',
                    isIconEndPosition: true,
                    experienceList: _honorClassList,
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
