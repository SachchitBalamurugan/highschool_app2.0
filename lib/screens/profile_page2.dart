import 'package:SoulSync/models/experience_dto.dart';
import 'package:SoulSync/screens/account.dart';
import 'package:SoulSync/screens/app_info.dart';
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

  @override
  void initState() {
    super.initState();
    _loadUserName();
  }

  Future<void> _loadUserName() async {
    User? user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      try {
        DocumentSnapshot userSnapshot = await FirebaseFirestore.instance
            .collection('users')
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
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
            const SizedBox(height: 24),
            ProfileSection(
              label: 'Academic Achievements',
              experienceList: const [
                ExperienceDto(
                  award: 'Deca National 2nd Place',
                  event: 'Deca Business Competition - Business topic',
                  date: 'Jan 12, 2023',
                  organizer: 'Deca',
                  organizerIcon: 'https://nmctso.com/wp-content/uploads/2022/07/DECA-Logo-Stack-Blue.jpeg',
                ),
                ExperienceDto(
                  award: 'Deca National 2nd Place',
                  event: 'Deca Business Competition - Business topic',
                  date: 'Jan 12, 2023',
                  organizer: 'Deca',
                  organizerIcon: 'https://nmctso.com/wp-content/uploads/2022/07/DECA-Logo-Stack-Blue.jpeg',
                ),
                ExperienceDto(
                  award: 'Deca National 2nd Place',
                  event: 'Deca Business Competition - Business topic',
                  date: 'Jan 12, 2023',
                  organizer: 'Deca',
                  organizerIcon: 'https://nmctso.com/wp-content/uploads/2022/07/DECA-Logo-Stack-Blue.jpeg',
                ),
              ],
              onViewAward: _onViewAward,
              onMoreInfo: _onMoreInfo,
            ),
            const SizedBox(height: 8),
            ProfileSection(
              label: 'Athletic Participation',
              experienceList: const [
                ExperienceDto(
                  award: 'NFL Football Quarter Back',
                  event: 'Dallas Cowboys - 4 National Trophies',
                  date: 'Jan 12, 2023',
                  organizer: 'NFL',
                  organizerIcon: 'https://upload.wikimedia.org/wikipedia/en/thumb/a/a2/National_Football_League_logo.svg/1200px-National_Football_League_logo.svg.png',
                ),
                ExperienceDto(
                  award: 'NFL Football Quarter Back',
                  event: 'Dallas Cowboys - 4 National Trophies',
                  date: 'Jan 12, 2023',
                  organizer: 'NFL',
                  organizerIcon: 'https://upload.wikimedia.org/wikipedia/en/thumb/a/a2/National_Football_League_logo.svg/1200px-National_Football_League_logo.svg.png',
                ),
              ],
              onViewAward: _onViewAward,
              onMoreInfo: _onMoreInfo,
            ),
            const SizedBox(height: 8),
            ProfileSection(
              label: 'Performing Arts Experience',
              experienceList: const [
                ExperienceDto(
                  award: 'Fine Arts National Team',
                  event: 'National Fine Arts',
                  date: 'Jan 12, 2023',
                  organizer: '-',
                  organizerIcon: 'https://images-platform.99static.com//YC7wFTo5yPJl8KJ6gsvBgbuBNCk=/147x0:867x720/fit-in/500x500/99designs-contests-attachments/16/16829/attachment_16829470',
                ),
              ],
              onViewAward: _onViewAward,
              onMoreInfo: _onMoreInfo,
            ),
            const SizedBox(height: 8),
            ProfileSection(
              label: 'Clubs and Organization Memberships',
              experienceList: const [
                ExperienceDto(
                  award: 'Vice President',
                  event: 'DECA',
                  date: 'Jan 12, 2023',
                  organizer: 'Deca',
                  organizerIcon: 'https://nmctso.com/wp-content/uploads/2022/07/DECA-Logo-Stack-Blue.jpeg',
                ),
                ExperienceDto(
                  award: 'President of Board',
                  event: 'BPA (Business Professionals of America)',
                  date: 'Jan 12, 2023',
                  organizer: 'BPA',
                  organizerIcon: 'https://yt3.googleusercontent.com/kJDmKEMe0RHiZQwOsiuzubzSOk1E7vSY4nMPkaQmFBY24V_ZXfF4Z-UhxI8U29CcSDCP-ouKI-M=s900-c-k-c0x00ffffff-no-rj',
                ),
              ],
              onViewAward: _onViewAward,
              onMoreInfo: _onMoreInfo,
            ),
            const SizedBox(height: 8),
            ProfileSection(
              label: 'Community Service Hours',
              experienceList: const [
                ExperienceDto(
                  award: 'Flash Cards Volunteer',
                  event: 'Classroom Central - 50 Total Hours',
                  date: 'Jan 12, 2023',
                  organizer: 'Classroom Central',
                  organizerIcon: 'https://play-lh.googleusercontent.com/z7bP0KPGHRfkaGx5jWaybjEt5LM0TyyWt5SUZk_ghf8PHe9yTRlccAtxzLoTSrfTACs=w240-h480-rw',
                ),
              ],
              onLogSheet: _onViewLogSheet,
              onMoreInfo: _onMoreInfo,
            ),
            const SizedBox(height: 8),
            ProfileSection(
              label: 'Honor Classes',
              isIconEndPosition: true,
              experienceList: const [
                ExperienceDto(
                  award: 'AP Computer Science',
                  event: 'Associated with Lone Star Highschool',
                  date: 'Jan 12, 2023',
                  organizer: '-',
                  organizerIcon: 'https://static.thenounproject.com/png/969639-200.png',
                ),
              ],
              onMoreInfo: _onMoreInfo,
            ),
            const SizedBox(height: 80),
          ],
        ),
      ),
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

  void _onViewAward(String experienceId) {

  }

  void _onViewLogSheet(String experienceId) {

  }

  void _onMoreInfo(String experienceId) {

  }
}
