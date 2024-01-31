import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import '../screens/course_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'app_info.dart';
import '../screens/community.dart';
import '../screens/account.dart';
import 'art_portfolio.dart';
import 'iphone-14-12.dart';
import 'BookingManager.dart';
import 'more_info_page.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';

class ProfilePage extends StatefulWidget {
  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
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

        print("User data: ${userSnapshot.data()}");

        setState(() {
          _userName = userSnapshot['User Name'] ?? "User";
          _email = userSnapshot['Email'];
          _phone = userSnapshot['Phone'];
          print("Updated _userName: $_userName");
        });
      } catch (e) {
        print("Error fetching user data: $e");
      }
    }
  }


  File? _aboutArtistImage;
  File? _aboutArtistImageBottom;
  File? _performancesImage;
  File? _awardsImage;
  File? _awardsImageLeft;
  File? _awardsImageRight;
  File? _performanceImageLeft;
  File? _performanceImageRight;
  File? _EventInformationUp;
  File? _EventInformationDown;

  Future<void> _getImage(String section) async {
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);

    setState(() {
      if (pickedFile != null) {
        switch (section) {
          case 'aboutArtist':
            _aboutArtistImage = File(pickedFile.path);
            break;
          case 'performances':
            _performancesImage = File(pickedFile.path);
            break;
          case 'awards':
            _awardsImage = File(pickedFile.path);
            break;
          case 'aboutArtistRight':
            _awardsImageRight = File(pickedFile.path);
            break;
          case 'aboutArtistLeft':
            _awardsImageLeft = File(pickedFile.path);
            break;
          case 'performanceArtistLeft':
            _performanceImageLeft = File(pickedFile.path);
            break;
          case 'performanceArtistRight':
            _performanceImageRight = File(pickedFile.path);
            break;
          case 'aboutArtistImageBottom':
            _aboutArtistImageBottom = File(pickedFile.path);
            break;
          case 'EventInformationDown':
            _EventInformationDown = File(pickedFile.path);
            break;
          case 'EventInformationUp':
            _EventInformationUp = File(pickedFile.path);
            break;
          default:
            break;
        }
      }
    });
  }
  //upload and download



  //create static data from lists
  List<String> concentrationVideos = [
    // Video names for the Concentration course
    'Introduction to Concentration',
    'How to Stay More Focused',
    'Simple Games to Stop Distractions',
    'One Task at a Time',
    'Chunking',
    'Task Lists',
    'Project Milestones',
  ];

  List catNames = [

  ];

  List<Color> catColors = [
    const Color(0xFF125061),
    const Color(0xFF166F77),
    const Color(0xFF038C73),
    const Color(0xFFFC7C7F),
    const Color(0xFFCB84FB),
    const Color(0xFF78E667),
  ];

  List<Icon> catIcons = [
    const Icon(Icons.category, color: Colors.white, size: 30),
    const Icon(Icons.video_library, color: Colors.white, size: 30),
    const Icon(Icons.assignment, color: Colors.white, size: 30),
    const Icon(Icons.store, color: Colors.white, size: 30),
    const Icon(Icons.play_circle_fill, color: Colors.white, size: 30),
    const Icon(Icons.emoji_events, color: Colors.white, size: 30),
  ];

  List imgList = [
    'Concentration',
    'Depression',
    'Meditation',
    'OCD',
  ];

  // //Bottom Navigation Bar handling
  // int _currentIndex = 0;

  // final tabs = [
  //   Center(child: Text('Home')),
  //   Center(child: Text('Progress')),
  //   Center(child: Text('Miles Ran')),
  //   Center(child: Text('Account')),
  // ];


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              padding: const EdgeInsets.only(top: 15, left: 15, right: 15, bottom: 10),
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
                  )),
              child: SafeArea(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        InkWell(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(builder: (context) => AppInfoPage()),
                            );
                          },
                          child: Icon(
                            Icons.info,
                            size: 30,
                            color: Colors.white,
                          ),
                        ),
                        GestureDetector(
                          onTap: () {
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
                          },
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
                          CircleAvatar(
                            radius: 50, // Adjust the radius as needed
                            // You can set backgroundImage if you have a user's profile image
                            // For example: backgroundImage: NetworkImage('url_to_image'),
                          ),
                          const SizedBox(width: 15), // Adjust the spacing between the image and text
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "$_userName", // Use the user's name
                                style: const TextStyle(
                                  fontSize: 25,
                                  fontWeight: FontWeight.w600,
                                  letterSpacing: 1,
                                  wordSpacing: 2,
                                  color: Colors.white,
                                ),
                              ),
                              Text(
                                "Lone Star Highschool", // Your desired heading
                                style: const TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.w400,
                                  color: Colors.white,
                                ),
                              ),
                              Text(
                                "Little Elm, TX", // Your desired heading
                                style: const TextStyle(
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
            Padding(
              padding: const EdgeInsets.only(top: 20, left: 15, right: 15),
              child: Column(
                children: [
                  GridView.builder(
                    itemCount: catNames.length,
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 3,
                      childAspectRatio: 1.1,
                    ),
                    itemBuilder: (context, index) {
                      return Column(
                        children: [
                          Container(
                            height: 60,
                            width: 60,
                            decoration: BoxDecoration(
                                color: catColors[index], shape: BoxShape.circle),
                            child: Center(
                              child: catIcons[index],
                            ),
                          ),
                          const SizedBox(height: 10),
                          Text(
                            catNames[index],
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w500,
                              color: Colors.black.withOpacity(0.7),
                            ),
                          )
                        ],
                      );
                    },
                  ),
                  Container(
                    width: 365,
                    height: 253,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(15),
                      color: Colors.white,
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.withOpacity(0.5),
                          spreadRadius: 2,
                          blurRadius: 7,
                          offset: Offset(0, 3),
                        ),
                      ],
                    ),
                    child: SingleChildScrollView( // Wrap with SingleChildScrollView
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                              margin: EdgeInsets.only(left: 10, top: 10),
                              child: Text(
                                "Academic Achievements",
                                style: TextStyle(
                                  fontSize: 24,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ),
                            Spacer(),
                            Container(
                              margin: EdgeInsets.only(top: 10, right: 10),
                              child: Icon(
                                Icons.add,
                                color: Colors.grey,
                                size: 30,
                              ),
                            ),
                            Container(
                              margin: EdgeInsets.only(top: 10, right: 10),
                              child: Icon(
                                Icons.edit,
                                color: Colors.grey,
                                size: 30,
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: 10),
                        Container(
                          margin: EdgeInsets.only(left: 10, top: 10),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              SizedBox(height: 10),
                              Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Container(
                                    constraints: BoxConstraints(
                                      maxWidth: 70,
                                      maxHeight: 70,
                                    ),
                                    child: Image.network(
                                      "https://assets-global.website-files.com/635c470cc81318fc3e9c1e0e/639a07cada7a2d68f4e9ef31_DECA%20Diamond%20Blue.png",
                                      width: 70,
                                      height: 70,
                                    ),
                                  ),
                                  SizedBox(width: 10),
                                  Expanded(
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          "Deca National 2nd Place",
                                          style: TextStyle(
                                            fontSize: 18,
                                            fontWeight: FontWeight.w600,
                                          ),
                                          softWrap: true,
                                        ),
                                        SizedBox(height: 5),
                                        Text(
                                          "Deca Business Competition - Business topic",
                                          style: TextStyle(
                                            fontSize: 18,
                                            fontWeight: FontWeight.w500,
                                          ),
                                          softWrap: true,
                                        ),
                                        SizedBox(height: 5),
                                        Text(
                                          "Jan 12, 2023",
                                          style: TextStyle(
                                            fontSize: 18,
                                            fontWeight: FontWeight.w400,
                                          ),
                                          softWrap: true,
                                        ),
                                        SizedBox(height: 5),
                                        Row(
                                          children: [
                                            GestureDetector(
                                              onTap: () {
                                                showDialog(
                                                  context: context,
                                                  builder: (BuildContext context) {
                                                    //Awards Popup Dialog Box
                                                    return Dialog(
                                                      shape: RoundedRectangleBorder(
                                                        borderRadius: BorderRadius.circular(15.0),
                                                      ),
                                                      child:Container(
                                                        width: 400,
                                                        height: 400,
                                                        child: SingleChildScrollView(
                                                          child: Container(
                                                            padding: EdgeInsets.all(16),
                                                            child: Column(
                                                              crossAxisAlignment: CrossAxisAlignment.center,
                                                              children: [
                                                                Text(
                                                                  "Awards",
                                                                  style: TextStyle(
                                                                    fontSize: 35,
                                                                    fontWeight: FontWeight.w600,
                                                                  ),
                                                                ),
                                                                MyEditableText(),
                                                                SizedBox(height: 16),
                                                                Stack(
                                                                  children: [
                                                                    Container(
                                                                      width: 250,
                                                                      height: 200,
                                                                      decoration: BoxDecoration(
                                                                        borderRadius: BorderRadius.circular(15),
                                                                        color: Color(0xFF8EB1BB),
                                                                      ),
                                                                      child: _EventInformationDown != null
                                                                          ? Image.file(
                                                                        _EventInformationDown!,
                                                                        width: double.infinity,
                                                                        height: double.infinity,
                                                                        fit: BoxFit.cover,
                                                                      )
                                                                          : null,
                                                                    ),
                                                                    Positioned(
                                                                      top: 0,
                                                                      right: 0,
                                                                      child: InkWell(
                                                                        onTap: () {
                                                                          _getImage('EventInformationDown');
                                                                        },
                                                                        child: Container(
                                                                          padding: EdgeInsets.all(8),
                                                                          decoration: BoxDecoration(
                                                                            shape: BoxShape.circle,
                                                                            color: Colors.white,
                                                                          ),
                                                                          child: Icon(
                                                                            Icons.upload_outlined,
                                                                            size: 30,
                                                                            color: Color(0xFF8EB1BB),
                                                                          ),
                                                                        ),
                                                                      ),
                                                                    ),
                                                                  ],
                                                                ),
                                                                SizedBox(height: 16),
                                                                Stack(
                                                                  children: [
                                                                    Container(
                                                                      width: 250,
                                                                      height: 200,
                                                                      decoration: BoxDecoration(
                                                                        borderRadius: BorderRadius.circular(15),
                                                                        color: Color(0xFF8EB1BB),
                                                                      ),
                                                                      child: _EventInformationUp != null
                                                                          ? Image.file(
                                                                        _EventInformationUp!,
                                                                        width: double.infinity,
                                                                        height: double.infinity,
                                                                        fit: BoxFit.cover,
                                                                      )
                                                                          : null,
                                                                    ),
                                                                    Positioned(
                                                                      top: 0,
                                                                      right: 0,
                                                                      child: InkWell(
                                                                        onTap: () {
                                                                          _getImage('EventInformationUp');
                                                                        },
                                                                        child: Container(
                                                                          padding: EdgeInsets.all(8),
                                                                          decoration: BoxDecoration(
                                                                            shape: BoxShape.circle,
                                                                            color: Colors.white,
                                                                          ),
                                                                          child: Icon(
                                                                            Icons.upload_outlined,
                                                                            size: 30,
                                                                            color: Color(0xFF8EB1BB),
                                                                          ),
                                                                        ),
                                                                      ),
                                                                    ),
                                                                  ],
                                                                ), // Add more widgets here if needed
                                                              ],
                                                            ),
                                                          ),
                                                        ),
                                                      ),
                                                    );
                                                  },
                                                );
                                              },
                                              child: Container(
                                                width: 100,
                                                height: 29,
                                                decoration: BoxDecoration(
                                                  borderRadius: BorderRadius.circular(15),
                                                  color: Color(0x00ffffff),
                                                  border: Border.all(
                                                    color: Colors.grey,
                                                    width: 2,
                                                  ),
                                                ),
                                                child: Center(
                                                  child: Text(
                                                    "View Award",
                                                    style: TextStyle(
                                                      fontSize: 13,
                                                      fontWeight: FontWeight.w600,
                                                    ),
                                                  ),
                                                ),
                                              ),
                                            ),
                                            SizedBox(width: 10), // Adjust the width based on your preference
                                            GestureDetector(
                                              onTap: () {
                                                Navigator.push(
                                                  context,
                                                  MaterialPageRoute(builder: (context) => MoreInfo()),
                                                );
                                              },
                                              child: Container(
                                                width: 100,
                                                height: 29,
                                                decoration: BoxDecoration(
                                                  borderRadius: BorderRadius.circular(15),
                                                  color: Color(0x00ffffff),
                                                  border: Border.all(
                                                    color: Colors.grey, // Add your desired border color
                                                    width: 2, // Add your desired border width
                                                  ),
                                                ),
                                                child: Center(
                                                  child: Text(
                                                    "More Info",
                                                    style: TextStyle(
                                                      fontSize: 13,
                                                      fontWeight: FontWeight.w600,
                                                    ),
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                              SizedBox(height: 20),
                              Container(
                                width: 340,
                                height: 3,
                                color: Colors.grey, // Grey line with a height of 3
                              ),
                            ],
                          ),
                        ),
                        Container(
                          margin: EdgeInsets.only(left: 10, top: 10),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              SizedBox(height: 10),
                              Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Container(
                                    constraints: BoxConstraints(
                                      maxWidth: 70,
                                      maxHeight: 70,
                                    ),
                                    child: Image.network(
                                      "https://assets-global.website-files.com/635c470cc81318fc3e9c1e0e/639a07cada7a2d68f4e9ef31_DECA%20Diamond%20Blue.png",
                                      width: 70,
                                      height: 70,
                                    ),
                                  ),
                                  SizedBox(width: 10),
                                  Expanded(
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          "Deca National 2nd Place",
                                          style: TextStyle(
                                            fontSize: 18,
                                            fontWeight: FontWeight.w600,
                                          ),
                                          softWrap: true,
                                        ),
                                        SizedBox(height: 5),
                                        Text(
                                          "Deca Business Competition - Business topic",
                                          style: TextStyle(
                                            fontSize: 18,
                                            fontWeight: FontWeight.w500,
                                          ),
                                          softWrap: true,
                                        ),
                                        SizedBox(height: 5),
                                        Text(
                                          "Jan 12, 2023",
                                          style: TextStyle(
                                            fontSize: 18,
                                            fontWeight: FontWeight.w400,
                                          ),
                                          softWrap: true,
                                        ),
                                        SizedBox(height: 5),
                                        Row(
                                          children: [
                                            GestureDetector(
                                              onTap: () {
                                                showDialog(
                                                  context: context,
                                                  builder: (BuildContext context) {
                                                    //Awards Popup Dialog Box
                                                    return Dialog(
                                                      shape: RoundedRectangleBorder(
                                                        borderRadius: BorderRadius.circular(15.0),
                                                      ),
                                                      child:Container(
                                                        width: 400,
                                                        height: 400,
                                                        child: SingleChildScrollView(
                                                          child: Container(
                                                            padding: EdgeInsets.all(16),
                                                            child: Column(
                                                              crossAxisAlignment: CrossAxisAlignment.center,
                                                              children: [
                                                                Text(
                                                                  "Awards",
                                                                  style: TextStyle(
                                                                    fontSize: 35,
                                                                    fontWeight: FontWeight.w600,
                                                                  ),
                                                                ),
                                                                MyEditableText(),
                                                                SizedBox(height: 16),
                                                                Stack(
                                                                  children: [
                                                                    Container(
                                                                      width: 250,
                                                                      height: 200,
                                                                      decoration: BoxDecoration(
                                                                        borderRadius: BorderRadius.circular(15),
                                                                        color: Color(0xFF8EB1BB),
                                                                      ),
                                                                      child: _EventInformationDown != null
                                                                          ? Image.file(
                                                                        _EventInformationDown!,
                                                                        width: double.infinity,
                                                                        height: double.infinity,
                                                                        fit: BoxFit.cover,
                                                                      )
                                                                          : null,
                                                                    ),
                                                                    Positioned(
                                                                      top: 0,
                                                                      right: 0,
                                                                      child: InkWell(
                                                                        onTap: () {
                                                                          _getImage('EventInformationDown');
                                                                        },
                                                                        child: Container(
                                                                          padding: EdgeInsets.all(8),
                                                                          decoration: BoxDecoration(
                                                                            shape: BoxShape.circle,
                                                                            color: Colors.white,
                                                                          ),
                                                                          child: Icon(
                                                                            Icons.upload_outlined,
                                                                            size: 30,
                                                                            color: Color(0xFF8EB1BB),
                                                                          ),
                                                                        ),
                                                                      ),
                                                                    ),
                                                                  ],
                                                                ),
                                                                SizedBox(height: 16),
                                                                Stack(
                                                                  children: [
                                                                    Container(
                                                                      width: 250,
                                                                      height: 200,
                                                                      decoration: BoxDecoration(
                                                                        borderRadius: BorderRadius.circular(15),
                                                                        color: Color(0xFF8EB1BB),
                                                                      ),
                                                                      child: _EventInformationUp != null
                                                                          ? Image.file(
                                                                        _EventInformationUp!,
                                                                        width: double.infinity,
                                                                        height: double.infinity,
                                                                        fit: BoxFit.cover,
                                                                      )
                                                                          : null,
                                                                    ),
                                                                    Positioned(
                                                                      top: 0,
                                                                      right: 0,
                                                                      child: InkWell(
                                                                        onTap: () {
                                                                          _getImage('EventInformationUp');
                                                                        },
                                                                        child: Container(
                                                                          padding: EdgeInsets.all(8),
                                                                          decoration: BoxDecoration(
                                                                            shape: BoxShape.circle,
                                                                            color: Colors.white,
                                                                          ),
                                                                          child: Icon(
                                                                            Icons.upload_outlined,
                                                                            size: 30,
                                                                            color: Color(0xFF8EB1BB),
                                                                          ),
                                                                        ),
                                                                      ),
                                                                    ),
                                                                  ],
                                                                ), // Add more widgets here if needed
                                                              ],
                                                            ),
                                                          ),
                                                        ),
                                                      ),
                                                    );
                                                  },
                                                );
                                              },
                                              child: Container(
                                                width: 100,
                                                height: 29,
                                                decoration: BoxDecoration(
                                                  borderRadius: BorderRadius.circular(15),
                                                  color: Color(0x00ffffff),
                                                  border: Border.all(
                                                    color: Colors.grey,
                                                    width: 2,
                                                  ),
                                                ),
                                                child: Center(
                                                  child: Text(
                                                    "View Award",
                                                    style: TextStyle(
                                                      fontSize: 13,
                                                      fontWeight: FontWeight.w600,
                                                    ),
                                                  ),
                                                ),
                                              ),
                                            ),
                                            SizedBox(width: 10), // Adjust the width based on your preference
                                            GestureDetector(
                                              onTap: () {
                                                Navigator.push(
                                                  context,
                                                  MaterialPageRoute(builder: (context) => MoreInfo()),
                                                );
                                              },
                                              child: Container(
                                                width: 100,
                                                height: 29,
                                                decoration: BoxDecoration(
                                                  borderRadius: BorderRadius.circular(15),
                                                  color: Color(0x00ffffff),
                                                  border: Border.all(
                                                    color: Colors.grey, // Add your desired border color
                                                    width: 2, // Add your desired border width
                                                  ),
                                                ),
                                                child: Center(
                                                  child: Text(
                                                    "More Info",
                                                    style: TextStyle(
                                                      fontSize: 13,
                                                      fontWeight: FontWeight.w600,
                                                    ),
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                              SizedBox(height: 20),
                              Container(
                                width: 340,
                                height: 3,
                                color: Colors.grey, // Grey line with a height of 3
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  )
                  ),
                  Container(
                      width: 365,
                      margin: EdgeInsets.symmetric(vertical: 40),
                      height: 253,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(15),
                        color: Colors.white,
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey.withOpacity(0.5),
                            spreadRadius: 2,
                            blurRadius: 7,
                            offset: Offset(0, 3),
                          ),
                        ],
                      ),
                      child: SingleChildScrollView( // Wrap with SingleChildScrollView
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Container(
                                  margin: EdgeInsets.only(left: 10, top: 10),
                                  child: Text(
                                    "Athletic Participation",
                                    style: TextStyle(
                                      fontSize: 24,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                ),
                                Spacer(),
                                Container(
                                  margin: EdgeInsets.only(top: 10, right: 10),
                                  child: Icon(
                                    Icons.add,
                                    color: Colors.grey,
                                    size: 30,
                                  ),
                                ),
                                Container(
                                  margin: EdgeInsets.only(top: 10, right: 10),
                                  child: Icon(
                                    Icons.edit,
                                    color: Colors.grey,
                                    size: 30,
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(height: 10),
                            Container(
                              margin: EdgeInsets.only(left: 10, top: 10),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  SizedBox(height: 10),
                                  Row(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Container(
                                        constraints: BoxConstraints(
                                          maxWidth: 70,
                                          maxHeight: 70,
                                        ),
                                        child: Image.network(
                                          "https://assets-global.website-files.com/635c470cc81318fc3e9c1e0e/639a07cada7a2d68f4e9ef31_DECA%20Diamond%20Blue.png",
                                          width: 70,
                                          height: 70,
                                        ),
                                      ),
                                      SizedBox(width: 10),
                                      Expanded(
                                        child: Column(
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              "Deca National 2nd Place",
                                              style: TextStyle(
                                                fontSize: 18,
                                                fontWeight: FontWeight.w600,
                                              ),
                                              softWrap: true,
                                            ),
                                            SizedBox(height: 5),
                                            Text(
                                              "Deca Business Competition - Business topic",
                                              style: TextStyle(
                                                fontSize: 18,
                                                fontWeight: FontWeight.w500,
                                              ),
                                              softWrap: true,
                                            ),
                                            SizedBox(height: 5),
                                            Text(
                                              "Jan 12, 2023",
                                              style: TextStyle(
                                                fontSize: 18,
                                                fontWeight: FontWeight.w400,
                                              ),
                                              softWrap: true,
                                            ),
                                            SizedBox(height: 5),
                                            Row(
                                              children: [
                                                Container(
                                                  width: 100,
                                                  height: 29,
                                                  decoration: BoxDecoration(
                                                    borderRadius: BorderRadius.circular(15),
                                                    color: Color(0x00ffffff),
                                                    border: Border.all(
                                                      color: Colors.grey, // Add your desired border color
                                                      width: 2, // Add your desired border width
                                                    ),
                                                  ),
                                                  child: Center(
                                                    child: Text(
                                                      "View Award",
                                                      style: TextStyle(
                                                        fontSize: 13,
                                                        fontWeight: FontWeight.w600,
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                                SizedBox(width: 10), // Adjust the width based on your preference
                                                Container(
                                                  width: 100,
                                                  height: 29,
                                                  decoration: BoxDecoration(
                                                    borderRadius: BorderRadius.circular(15),
                                                    color: Color(0x00ffffff),
                                                    border: Border.all(
                                                      color: Colors.grey, // Add your desired border color
                                                      width: 2, // Add your desired border width
                                                    ),
                                                  ),
                                                  child: Center(
                                                    child: Text(
                                                      "View Award",
                                                      style: TextStyle(
                                                        fontSize: 13,
                                                        fontWeight: FontWeight.w600,
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                  SizedBox(height: 20),
                                  Container(
                                    width: 340,
                                    height: 3,
                                    color: Colors.grey, // Grey line with a height of 3
                                  ),
                                ],
                              ),
                            ),
                            Container(
                              margin: EdgeInsets.only(left: 10, top: 10),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  SizedBox(height: 10),
                                  Row(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Container(
                                        constraints: BoxConstraints(
                                          maxWidth: 70,
                                          maxHeight: 70,
                                        ),
                                        child: Image.network(
                                          "https://assets-global.website-files.com/635c470cc81318fc3e9c1e0e/639a07cada7a2d68f4e9ef31_DECA%20Diamond%20Blue.png",
                                          width: 70,
                                          height: 70,
                                        ),
                                      ),
                                      SizedBox(width: 10),
                                      Expanded(
                                        child: Column(
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              "Deca National 2nd Place",
                                              style: TextStyle(
                                                fontSize: 18,
                                                fontWeight: FontWeight.w600,
                                              ),
                                              softWrap: true,
                                            ),
                                            SizedBox(height: 5),
                                            Text(
                                              "Deca Business Competition - Business topic",
                                              style: TextStyle(
                                                fontSize: 18,
                                                fontWeight: FontWeight.w500,
                                              ),
                                              softWrap: true,
                                            ),
                                            SizedBox(height: 5),
                                            Text(
                                              "Jan 12, 2023",
                                              style: TextStyle(
                                                fontSize: 18,
                                                fontWeight: FontWeight.w400,
                                              ),
                                              softWrap: true,
                                            ),
                                            SizedBox(height: 5),
                                            Row(
                                              children: [
                                                Container(
                                                  width: 100,
                                                  height: 29,
                                                  decoration: BoxDecoration(
                                                    borderRadius: BorderRadius.circular(15),
                                                    color: Color(0x00ffffff),
                                                    border: Border.all(
                                                      color: Colors.grey, // Add your desired border color
                                                      width: 2, // Add your desired border width
                                                    ),
                                                  ),
                                                  child: Center(
                                                    child: Text(
                                                      "View Award",
                                                      style: TextStyle(
                                                        fontSize: 13,
                                                        fontWeight: FontWeight.w600,
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                                SizedBox(width: 10), // Adjust the width based on your preference
                                                Container(
                                                  width: 100,
                                                  height: 29,
                                                  decoration: BoxDecoration(
                                                    borderRadius: BorderRadius.circular(15),
                                                    color: Color(0x00ffffff),
                                                    border: Border.all(
                                                      color: Colors.grey, // Add your desired border color
                                                      width: 2, // Add your desired border width
                                                    ),
                                                  ),
                                                  child: Center(
                                                    child: Text(
                                                      "View Award",
                                                      style: TextStyle(
                                                        fontSize: 13,
                                                        fontWeight: FontWeight.w600,
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                  SizedBox(height: 20),
                                  Container(
                                    width: 340,
                                    height: 3,
                                    color: Colors.grey, // Grey line with a height of 3
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      )
                  ),
                  Container(
                      width: 365,
                      margin: EdgeInsets.symmetric(vertical: 2),
                      height: 253,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(15),
                        color: Colors.white,
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey.withOpacity(0.5),
                            spreadRadius: 2,
                            blurRadius: 7,
                            offset: Offset(0, 3),
                          ),
                        ],
                      ),
                      child: SingleChildScrollView( // Wrap with SingleChildScrollView
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Container(
                                  margin: EdgeInsets.only(left: 10, top: 10),
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        "Performing Arts",
                                        style: TextStyle(
                                          fontSize: 24,
                                          fontWeight: FontWeight.w600,
                                        ),
                                      ),
                                      Text(
                                        "Experience",
                                        style: TextStyle(
                                          fontSize: 24,
                                          fontWeight: FontWeight.w600,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                Spacer(),
                                Container(
                                  margin: EdgeInsets.only(top: 10, right: 10),
                                  child: Icon(
                                    Icons.add,
                                    color: Colors.grey,
                                    size: 30,
                                  ),
                                ),
                                Container(
                                  margin: EdgeInsets.only(top: 10, right: 10),
                                  child: Icon(
                                    Icons.edit,
                                    color: Colors.grey,
                                    size: 30,
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(height: 10),
                            Container(
                              margin: EdgeInsets.only(left: 10, top: 10),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  SizedBox(height: 10),
                                  Row(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Container(
                                        constraints: BoxConstraints(
                                          maxWidth: 70,
                                          maxHeight: 70,
                                        ),
                                        child: Image.network(
                                          "https://assets-global.website-files.com/635c470cc81318fc3e9c1e0e/639a07cada7a2d68f4e9ef31_DECA%20Diamond%20Blue.png",
                                          width: 70,
                                          height: 70,
                                        ),
                                      ),
                                      SizedBox(width: 10),
                                      Expanded(
                                        child: Column(
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              "Deca National 2nd Place",
                                              style: TextStyle(
                                                fontSize: 18,
                                                fontWeight: FontWeight.w600,
                                              ),
                                              softWrap: true,
                                            ),
                                            SizedBox(height: 5),
                                            Text(
                                              "Deca Business Competition - Business topic",
                                              style: TextStyle(
                                                fontSize: 18,
                                                fontWeight: FontWeight.w500,
                                              ),
                                              softWrap: true,
                                            ),
                                            SizedBox(height: 5),
                                            Text(
                                              "Jan 12, 2023",
                                              style: TextStyle(
                                                fontSize: 18,
                                                fontWeight: FontWeight.w400,
                                              ),
                                              softWrap: true,
                                            ),
                                            SizedBox(height: 5),
                                            Row(
                                              children: [
                                                GestureDetector(
                                                  onTap: () {
                                                    Navigator.push(
                                                      context,
                                                      MaterialPageRoute(builder: (context) => ArtProfile()),
                                                    );
                                                  },
                                                  child: Container(
                                                    width: 100,
                                                    height: 29,
                                                    decoration: BoxDecoration(
                                                      borderRadius: BorderRadius.circular(15),
                                                      color: Color(0x00ffffff),
                                                      border: Border.all(
                                                        color: Colors.grey, // Add your desired border color
                                                        width: 2, // Add your desired border width
                                                      ),
                                                    ),
                                                    child: Center(
                                                      child: Text(
                                                        "View Portfolio",
                                                        style: TextStyle(
                                                          fontSize: 13,
                                                          fontWeight: FontWeight.w600,
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                                SizedBox(width: 10), // Adjust the width based on your preference
                                                GestureDetector(
                                                  onTap: () {
                                                    Navigator.push(
                                                      context,
                                                      MaterialPageRoute(builder: (context) => MoreInfo()),
                                                    );
                                                  },
                                                  child: Container(
                                                    width: 100,
                                                    height: 29,
                                                    decoration: BoxDecoration(
                                                      borderRadius: BorderRadius.circular(15),
                                                      color: Color(0x00ffffff),
                                                      border: Border.all(
                                                        color: Colors.grey, // Add your desired border color
                                                        width: 2, // Add your desired border width
                                                      ),
                                                    ),
                                                    child: Center(
                                                      child: Text(
                                                        "More Info",
                                                        style: TextStyle(
                                                          fontSize: 13,
                                                          fontWeight: FontWeight.w600,
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                  SizedBox(height: 20),
                                  Container(
                                    width: 340,
                                    height: 3,
                                    color: Colors.grey, // Grey line with a height of 3
                                  ),
                                ],
                              ),
                            ),
                            Container(
                              margin: EdgeInsets.only(left: 10, top: 10),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  SizedBox(height: 10),
                                  Row(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Container(
                                        constraints: BoxConstraints(
                                          maxWidth: 70,
                                          maxHeight: 70,
                                        ),
                                        child: Image.network(
                                          "https://assets-global.website-files.com/635c470cc81318fc3e9c1e0e/639a07cada7a2d68f4e9ef31_DECA%20Diamond%20Blue.png",
                                          width: 70,
                                          height: 70,
                                        ),
                                      ),
                                      SizedBox(width: 10),
                                      Expanded(
                                        child: Column(
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              "Deca National 2nd Place",
                                              style: TextStyle(
                                                fontSize: 18,
                                                fontWeight: FontWeight.w600,
                                              ),
                                              softWrap: true,
                                            ),
                                            SizedBox(height: 5),
                                            Text(
                                              "Deca Business Competition - Business topic",
                                              style: TextStyle(
                                                fontSize: 18,
                                                fontWeight: FontWeight.w500,
                                              ),
                                              softWrap: true,
                                            ),
                                            SizedBox(height: 5),
                                            Text(
                                              "Jan 12, 2023",
                                              style: TextStyle(
                                                fontSize: 18,
                                                fontWeight: FontWeight.w400,
                                              ),
                                              softWrap: true,
                                            ),
                                            SizedBox(height: 5),
                                            Row(
                                              children: [
                                                GestureDetector(
                                                  onTap: () {
                                                    Navigator.push(
                                                      context,
                                                      MaterialPageRoute(builder: (context) => ArtProfile()),
                                                    );
                                                  },
                                                  child: Container(
                                                    width: 100,
                                                    height: 29,
                                                    decoration: BoxDecoration(
                                                      borderRadius: BorderRadius.circular(15),
                                                      color: Color(0x00ffffff),
                                                      border: Border.all(
                                                        color: Colors.grey, // Add your desired border color
                                                        width: 2, // Add your desired border width
                                                      ),
                                                    ),
                                                    child: Center(
                                                      child: Text(
                                                        "View Portfolio",
                                                        style: TextStyle(
                                                          fontSize: 13,
                                                          fontWeight: FontWeight.w600,
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                                SizedBox(width: 10), // Adjust the width based on your preference
                                                GestureDetector(
                                                  onTap: () {
                                                    Navigator.push(
                                                      context,
                                                      MaterialPageRoute(builder: (context) => MoreInfo()),
                                                    );
                                                  },
                                                  child: Container(
                                                    width: 100,
                                                    height: 29,
                                                    decoration: BoxDecoration(
                                                      borderRadius: BorderRadius.circular(15),
                                                      color: Color(0x00ffffff),
                                                      border: Border.all(
                                                        color: Colors.grey, // Add your desired border color
                                                        width: 2, // Add your desired border width
                                                      ),
                                                    ),
                                                    child: Center(
                                                      child: Text(
                                                        "More Info",
                                                        style: TextStyle(
                                                          fontSize: 13,
                                                          fontWeight: FontWeight.w600,
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                  SizedBox(height: 20),
                                  Container(
                                    width: 340,
                                    height: 3,
                                    color: Colors.grey, // Grey line with a height of 3
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      )
                  ),
                  Container(
                      width: 365,
                      margin: EdgeInsets.symmetric(vertical: 40),
                      height: 253,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(15),
                        color: Colors.white,
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey.withOpacity(0.5),
                            spreadRadius: 2,
                            blurRadius: 7,
                            offset: Offset(0, 3),
                          ),
                        ],
                      ),
                      child: SingleChildScrollView( // Wrap with SingleChildScrollView
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Container(
                                  margin: EdgeInsets.only(left: 10, top: 10),
                                  child: Text(
                                    "Community Service",
                                    style: TextStyle(
                                      fontSize: 24,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                ),
                                Spacer(),
                                Container(
                                  margin: EdgeInsets.only(top: 10, right: 10),
                                  child: Icon(
                                    Icons.add,
                                    color: Colors.grey,
                                    size: 30,
                                  ),
                                ),
                                Container(
                                  margin: EdgeInsets.only(top: 10, right: 10),
                                  child: Icon(
                                    Icons.edit,
                                    color: Colors.grey,
                                    size: 30,
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(height: 10),
                            Container(
                              margin: EdgeInsets.only(left: 10, top: 10),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  SizedBox(height: 10),
                                  Row(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Container(
                                        constraints: BoxConstraints(
                                          maxWidth: 70,
                                          maxHeight: 70,
                                        ),
                                        child: Image.network(
                                          "https://assets-global.website-files.com/635c470cc81318fc3e9c1e0e/639a07cada7a2d68f4e9ef31_DECA%20Diamond%20Blue.png",
                                          width: 70,
                                          height: 70,
                                        ),
                                      ),
                                      SizedBox(width: 10),
                                      Expanded(
                                        child: Column(
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              "Deca National 2nd Place",
                                              style: TextStyle(
                                                fontSize: 18,
                                                fontWeight: FontWeight.w600,
                                              ),
                                              softWrap: true,
                                            ),
                                            SizedBox(height: 5),
                                            Text(
                                              "Deca Business Competition - Business topic",
                                              style: TextStyle(
                                                fontSize: 18,
                                                fontWeight: FontWeight.w500,
                                              ),
                                              softWrap: true,
                                            ),
                                            SizedBox(height: 5),
                                            Text(
                                              "Jan 12, 2023",
                                              style: TextStyle(
                                                fontSize: 18,
                                                fontWeight: FontWeight.w400,
                                              ),
                                              softWrap: true,
                                            ),
                                            SizedBox(height: 5),
                                            Row(
                                              children: [
                                                GestureDetector(
                                                  onTap: () {
                                                    showDialog(
                                                      context: context,
                                                      builder: (BuildContext context) {
                                                        // Awards Popup Dialog Box
                                                        return Dialog(
                                                          shape: RoundedRectangleBorder(
                                                            borderRadius: BorderRadius.circular(15.0),
                                                          ),
                                                          child: Container(
                                                            width: 400,
                                                            height: 400,
                                                            child: SingleChildScrollView(
                                                              child: Container(
                                                                padding: EdgeInsets.all(16),
                                                                child: Column(
                                                                  crossAxisAlignment: CrossAxisAlignment.center,
                                                                  children: [
                                                                    Text(
                                                                      "Awards",
                                                                      style: TextStyle(
                                                                        fontSize: 35,
                                                                        fontWeight: FontWeight.w600,
                                                                      ),
                                                                    ),
                                                                    MyEditableText(),
                                                                    SizedBox(height: 16),
                                                                    // Container for the first image
                                                                    _buildImageContainer(_EventInformationDown, 'EventInformationDown'),
                                                                    SizedBox(height: 16),
                                                                    // Container for the second image
                                                                    _buildImageContainer(_EventInformationUp, 'EventInformationUp'),
                                                                    // Add more widgets here if needed
                                                                  ],
                                                                ),
                                                              ),
                                                            ),
                                                          ),
                                                        );
                                                      },
                                                    );
                                                  },
                                                  child: Container(
                                                    width: 100,
                                                    height: 29,
                                                    decoration: BoxDecoration(
                                                      borderRadius: BorderRadius.circular(15),
                                                      color: Color(0x00ffffff),
                                                      border: Border.all(
                                                        color: Colors.grey,
                                                        width: 2,
                                                      ),
                                                    ),
                                                    child: Center(
                                                      child: Text(
                                                        "View Award",
                                                        style: TextStyle(
                                                          fontSize: 13,
                                                          fontWeight: FontWeight.w600,
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                                ),

                                                SizedBox(width: 10), // Adjust the width based on your preference
                                                GestureDetector(
                                                  onTap: () {
                                                    Navigator.push(
                                                      context,
                                                      MaterialPageRoute(builder: (context) => MoreInfo()),
                                                    );
                                                  },
                                                  child: Container(
                                                    width: 100,
                                                    height: 29,
                                                    decoration: BoxDecoration(
                                                      borderRadius: BorderRadius.circular(15),
                                                      color: Color(0x00ffffff),
                                                      border: Border.all(
                                                        color: Colors.grey, // Add your desired border color
                                                        width: 2, // Add your desired border width
                                                      ),
                                                    ),
                                                    child: Center(
                                                      child: Text(
                                                        "More Info",
                                                        style: TextStyle(
                                                          fontSize: 13,
                                                          fontWeight: FontWeight.w600,
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                  SizedBox(height: 20),
                                  Container(
                                    width: 340,
                                    height: 3,
                                    color: Colors.grey, // Grey line with a height of 3
                                  ),
                                ],
                              ),
                            ),
                            Container(
                              margin: EdgeInsets.only(left: 10, top: 10),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  SizedBox(height: 10),
                                  Row(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Container(
                                        constraints: BoxConstraints(
                                          maxWidth: 70,
                                          maxHeight: 70,
                                        ),
                                        child: Image.network(
                                          "https://assets-global.website-files.com/635c470cc81318fc3e9c1e0e/639a07cada7a2d68f4e9ef31_DECA%20Diamond%20Blue.png",
                                          width: 70,
                                          height: 70,
                                        ),
                                      ),
                                      SizedBox(width: 10),
                                      Expanded(
                                        child: Column(
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              "Deca National 2nd Place",
                                              style: TextStyle(
                                                fontSize: 18,
                                                fontWeight: FontWeight.w600,
                                              ),
                                              softWrap: true,
                                            ),
                                            SizedBox(height: 5),
                                            Text(
                                              "Deca Business Competition - Business topic",
                                              style: TextStyle(
                                                fontSize: 18,
                                                fontWeight: FontWeight.w500,
                                              ),
                                              softWrap: true,
                                            ),
                                            SizedBox(height: 5),
                                            Text(
                                              "Jan 12, 2023",
                                              style: TextStyle(
                                                fontSize: 18,
                                                fontWeight: FontWeight.w400,
                                              ),
                                              softWrap: true,
                                            ),
                                            SizedBox(height: 5),
                                            Row(
                                              children: [
                                                GestureDetector(
                                                  onTap: () {
                                                    showDialog(
                                                      context: context,
                                                      builder: (BuildContext context) {
                                                        //Awards Popup Dialog Box
                                                        return Dialog(
                                                          shape: RoundedRectangleBorder(
                                                            borderRadius: BorderRadius.circular(15.0),
                                                          ),
                                                          child:Container(
                                                            width: 400,
                                                            height: 400,
                                                            child: SingleChildScrollView(
                                                              child: Container(
                                                                padding: EdgeInsets.all(16),
                                                                child: Column(
                                                                  crossAxisAlignment: CrossAxisAlignment.center,
                                                                  children: [
                                                                    Text(
                                                                      "Awards",
                                                                      style: TextStyle(
                                                                        fontSize: 35,
                                                                        fontWeight: FontWeight.w600,
                                                                      ),
                                                                    ),
                                                                    MyEditableText(),
                                                                    SizedBox(height: 16),
                                                                    Stack(
                                                                      children: [
                                                                        Container(
                                                                          width: 250,
                                                                          height: 200,
                                                                          decoration: BoxDecoration(
                                                                            borderRadius: BorderRadius.circular(15),
                                                                            color: Color(0xFF8EB1BB),
                                                                          ),
                                                                          child: _EventInformationDown != null
                                                                              ? Image.file(
                                                                            _EventInformationDown!,
                                                                            width: double.infinity,
                                                                            height: double.infinity,
                                                                            fit: BoxFit.cover,
                                                                          )
                                                                              : null,
                                                                        ),
                                                                        Positioned(
                                                                          top: 0,
                                                                          right: 0,
                                                                          child: InkWell(
                                                                            onTap: () {
                                                                              _getImage('EventInformationDown');
                                                                            },
                                                                            child: Container(
                                                                              padding: EdgeInsets.all(8),
                                                                              decoration: BoxDecoration(
                                                                                shape: BoxShape.circle,
                                                                                color: Colors.white,
                                                                              ),
                                                                              child: Icon(
                                                                                Icons.upload_outlined,
                                                                                size: 30,
                                                                                color: Color(0xFF8EB1BB),
                                                                              ),
                                                                            ),
                                                                          ),
                                                                        ),
                                                                      ],
                                                                    ),
                                                                    SizedBox(height: 16),
                                                                    Stack(
                                                                      children: [
                                                                        Container(
                                                                          width: 250,
                                                                          height: 200,
                                                                          decoration: BoxDecoration(
                                                                            borderRadius: BorderRadius.circular(15),
                                                                            color: Color(0xFF8EB1BB),
                                                                          ),
                                                                          child: _EventInformationUp != null
                                                                              ? Image.file(
                                                                            _EventInformationUp!,
                                                                            width: double.infinity,
                                                                            height: double.infinity,
                                                                            fit: BoxFit.cover,
                                                                          )
                                                                              : null,
                                                                        ),
                                                                        Positioned(
                                                                          top: 0,
                                                                          right: 0,
                                                                          child: InkWell(
                                                                            onTap: () {
                                                                              _getImage('EventInformationUp');
                                                                            },
                                                                            child: Container(
                                                                              padding: EdgeInsets.all(8),
                                                                              decoration: BoxDecoration(
                                                                                shape: BoxShape.circle,
                                                                                color: Colors.white,
                                                                              ),
                                                                              child: Icon(
                                                                                Icons.upload_outlined,
                                                                                size: 30,
                                                                                color: Color(0xFF8EB1BB),
                                                                              ),
                                                                            ),
                                                                          ),
                                                                        ),
                                                                      ],
                                                                    ), // Add more widgets here if needed
                                                                  ],
                                                                ),
                                                              ),
                                                            ),
                                                          ),
                                                        );
                                                      },
                                                    );
                                                  },
                                                  child: Container(
                                                    width: 100,
                                                    height: 29,
                                                    decoration: BoxDecoration(
                                                      borderRadius: BorderRadius.circular(15),
                                                      color: Color(0x00ffffff),
                                                      border: Border.all(
                                                        color: Colors.grey,
                                                        width: 2,
                                                      ),
                                                    ),
                                                    child: Center(
                                                      child: Text(
                                                        "View Award",
                                                        style: TextStyle(
                                                          fontSize: 13,
                                                          fontWeight: FontWeight.w600,
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                                SizedBox(width: 10), // Adjust the width based on your preference
                                                GestureDetector(
                                                  onTap: () {
                                                    Navigator.push(
                                                      context,
                                                      MaterialPageRoute(builder: (context) => MoreInfo()),
                                                    );
                                                  },
                                                  child: Container(
                                                    width: 100,
                                                    height: 29,
                                                    decoration: BoxDecoration(
                                                      borderRadius: BorderRadius.circular(15),
                                                      color: Color(0x00ffffff),
                                                      border: Border.all(
                                                        color: Colors.grey, // Add your desired border color
                                                        width: 2, // Add your desired border width
                                                      ),
                                                    ),
                                                    child: Center(
                                                      child: Text(
                                                        "More Info",
                                                        style: TextStyle(
                                                          fontSize: 13,
                                                          fontWeight: FontWeight.w600,
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                  SizedBox(height: 20),
                                  Container(
                                    width: 340,
                                    height: 3,
                                    color: Colors.grey, // Grey line with a height of 3
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      )
                  ),
                  Container(
                      width: 365,
                      margin: EdgeInsets.symmetric(vertical: 40),
                      height: 253,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(15),
                        color: Colors.white,
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey.withOpacity(0.5),
                            spreadRadius: 2,
                            blurRadius: 7,
                            offset: Offset(0, 3),
                          ),
                        ],
                      ),
                      child: SingleChildScrollView( // Wrap with SingleChildScrollView
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Container(
                                  margin: EdgeInsets.only(left: 10, top: 10),
                                  child: Text(
                                    "Academic Achievements",
                                    style: TextStyle(
                                      fontSize: 24,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                ),
                                Spacer(),
                                Container(
                                  margin: EdgeInsets.only(top: 10, right: 10),
                                  child: Icon(
                                    Icons.add,
                                    color: Colors.grey,
                                    size: 30,
                                  ),
                                ),
                                Container(
                                  margin: EdgeInsets.only(top: 10, right: 10),
                                  child: Icon(
                                    Icons.edit,
                                    color: Colors.grey,
                                    size: 30,
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(height: 10),
                            Container(
                              margin: EdgeInsets.only(left: 10, top: 10),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  SizedBox(height: 10),
                                  Row(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Container(
                                        constraints: BoxConstraints(
                                          maxWidth: 70,
                                          maxHeight: 70,
                                        ),
                                        child: Image.network(
                                          "https://assets-global.website-files.com/635c470cc81318fc3e9c1e0e/639a07cada7a2d68f4e9ef31_DECA%20Diamond%20Blue.png",
                                          width: 70,
                                          height: 70,
                                        ),
                                      ),
                                      SizedBox(width: 10),
                                      Expanded(
                                        child: Column(
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              "Deca National 2nd Place",
                                              style: TextStyle(
                                                fontSize: 18,
                                                fontWeight: FontWeight.w600,
                                              ),
                                              softWrap: true,
                                            ),
                                            SizedBox(height: 5),
                                            Text(
                                              "Deca Business Competition - Business topic",
                                              style: TextStyle(
                                                fontSize: 18,
                                                fontWeight: FontWeight.w500,
                                              ),
                                              softWrap: true,
                                            ),
                                            SizedBox(height: 5),
                                            Text(
                                              "Jan 12, 2023",
                                              style: TextStyle(
                                                fontSize: 18,
                                                fontWeight: FontWeight.w400,
                                              ),
                                              softWrap: true,
                                            ),
                                            SizedBox(height: 5),
                                            Row(
                                              children: [
                                                Container(
                                                  width: 100,
                                                  height: 29,
                                                  decoration: BoxDecoration(
                                                    borderRadius: BorderRadius.circular(15),
                                                    color: Color(0x00ffffff),
                                                    border: Border.all(
                                                      color: Colors.grey, // Add your desired border color
                                                      width: 2, // Add your desired border width
                                                    ),
                                                  ),
                                                  child: Center(
                                                    child: Text(
                                                      "View Award",
                                                      style: TextStyle(
                                                        fontSize: 13,
                                                        fontWeight: FontWeight.w600,
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                                SizedBox(width: 10), // Adjust the width based on your preference
                                                Container(
                                                  width: 100,
                                                  height: 29,
                                                  decoration: BoxDecoration(
                                                    borderRadius: BorderRadius.circular(15),
                                                    color: Color(0x00ffffff),
                                                    border: Border.all(
                                                      color: Colors.grey, // Add your desired border color
                                                      width: 2, // Add your desired border width
                                                    ),
                                                  ),
                                                  child: Center(
                                                    child: Text(
                                                      "View Award",
                                                      style: TextStyle(
                                                        fontSize: 13,
                                                        fontWeight: FontWeight.w600,
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                  SizedBox(height: 20),
                                  Container(
                                    width: 340,
                                    height: 3,
                                    color: Colors.grey, // Grey line with a height of 3
                                  ),
                                ],
                              ),
                            ),
                            Container(
                              margin: EdgeInsets.only(left: 10, top: 10),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  SizedBox(height: 10),
                                  Row(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Container(
                                        constraints: BoxConstraints(
                                          maxWidth: 70,
                                          maxHeight: 70,
                                        ),
                                        child: Image.network(
                                          "https://assets-global.website-files.com/635c470cc81318fc3e9c1e0e/639a07cada7a2d68f4e9ef31_DECA%20Diamond%20Blue.png",
                                          width: 70,
                                          height: 70,
                                        ),
                                      ),
                                      SizedBox(width: 10),
                                      Expanded(
                                        child: Column(
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              "Deca National 2nd Place",
                                              style: TextStyle(
                                                fontSize: 18,
                                                fontWeight: FontWeight.w600,
                                              ),
                                              softWrap: true,
                                            ),
                                            SizedBox(height: 5),
                                            Text(
                                              "Deca Business Competition - Business topic",
                                              style: TextStyle(
                                                fontSize: 18,
                                                fontWeight: FontWeight.w500,
                                              ),
                                              softWrap: true,
                                            ),
                                            SizedBox(height: 5),
                                            Text(
                                              "Jan 12, 2023",
                                              style: TextStyle(
                                                fontSize: 18,
                                                fontWeight: FontWeight.w400,
                                              ),
                                              softWrap: true,
                                            ),
                                            SizedBox(height: 5),
                                            Row(
                                              children: [
                                                Container(
                                                  width: 100,
                                                  height: 29,
                                                  decoration: BoxDecoration(
                                                    borderRadius: BorderRadius.circular(15),
                                                    color: Color(0x00ffffff),
                                                    border: Border.all(
                                                      color: Colors.grey, // Add your desired border color
                                                      width: 2, // Add your desired border width
                                                    ),
                                                  ),
                                                  child: Center(
                                                    child: Text(
                                                      "View Award",
                                                      style: TextStyle(
                                                        fontSize: 13,
                                                        fontWeight: FontWeight.w600,
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                                SizedBox(width: 10), // Adjust the width based on your preference
                                                Container(
                                                  width: 100,
                                                  height: 29,
                                                  decoration: BoxDecoration(
                                                    borderRadius: BorderRadius.circular(15),
                                                    color: Color(0x00ffffff),
                                                    border: Border.all(
                                                      color: Colors.grey, // Add your desired border color
                                                      width: 2, // Add your desired border width
                                                    ),
                                                  ),
                                                  child: Center(
                                                    child: Text(
                                                      "View Award",
                                                      style: TextStyle(
                                                        fontSize: 13,
                                                        fontWeight: FontWeight.w600,
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                  SizedBox(height: 20),
                                  Container(
                                    width: 340,
                                    height: 3,
                                    color: Colors.grey, // Grey line with a height of 3
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      )
                  ),
                  Container(
                      width: 365,
                      margin: EdgeInsets.symmetric(vertical: 40),
                      height: 253,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(15),
                        color: Colors.white,
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey.withOpacity(0.5),
                            spreadRadius: 2,
                            blurRadius: 7,
                            offset: Offset(0, 3),
                          ),
                        ],
                      ),
                      child: SingleChildScrollView( // Wrap with SingleChildScrollView
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Container(
                                  margin: EdgeInsets.only(left: 10, top: 10),
                                  child: Text(
                                    "Academic Achievements",
                                    style: TextStyle(
                                      fontSize: 24,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                ),
                                Spacer(),
                                Container(
                                  margin: EdgeInsets.only(top: 10, right: 10),
                                  child: Icon(
                                    Icons.add,
                                    color: Colors.grey,
                                    size: 30,
                                  ),
                                ),
                                Container(
                                  margin: EdgeInsets.only(top: 10, right: 10),
                                  child: Icon(
                                    Icons.edit,
                                    color: Colors.grey,
                                    size: 30,
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(height: 10),
                            Container(
                              margin: EdgeInsets.only(left: 10, top: 10),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  SizedBox(height: 10),
                                  Row(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Container(
                                        constraints: BoxConstraints(
                                          maxWidth: 70,
                                          maxHeight: 70,
                                        ),
                                        child: Image.network(
                                          "https://assets-global.website-files.com/635c470cc81318fc3e9c1e0e/639a07cada7a2d68f4e9ef31_DECA%20Diamond%20Blue.png",
                                          width: 70,
                                          height: 70,
                                        ),
                                      ),
                                      SizedBox(width: 10),
                                      Expanded(
                                        child: Column(
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              "Deca National 2nd Place",
                                              style: TextStyle(
                                                fontSize: 18,
                                                fontWeight: FontWeight.w600,
                                              ),
                                              softWrap: true,
                                            ),
                                            SizedBox(height: 5),
                                            Text(
                                              "Deca Business Competition - Business topic",
                                              style: TextStyle(
                                                fontSize: 18,
                                                fontWeight: FontWeight.w500,
                                              ),
                                              softWrap: true,
                                            ),
                                            SizedBox(height: 5),
                                            Text(
                                              "Jan 12, 2023",
                                              style: TextStyle(
                                                fontSize: 18,
                                                fontWeight: FontWeight.w400,
                                              ),
                                              softWrap: true,
                                            ),
                                            SizedBox(height: 5),
                                            Row(
                                              children: [
                                                Container(
                                                  width: 100,
                                                  height: 29,
                                                  decoration: BoxDecoration(
                                                    borderRadius: BorderRadius.circular(15),
                                                    color: Color(0x00ffffff),
                                                    border: Border.all(
                                                      color: Colors.grey, // Add your desired border color
                                                      width: 2, // Add your desired border width
                                                    ),
                                                  ),
                                                  child: Center(
                                                    child: Text(
                                                      "View Award",
                                                      style: TextStyle(
                                                        fontSize: 13,
                                                        fontWeight: FontWeight.w600,
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                                SizedBox(width: 10), // Adjust the width based on your preference
                                                Container(
                                                  width: 100,
                                                  height: 29,
                                                  decoration: BoxDecoration(
                                                    borderRadius: BorderRadius.circular(15),
                                                    color: Color(0x00ffffff),
                                                    border: Border.all(
                                                      color: Colors.grey, // Add your desired border color
                                                      width: 2, // Add your desired border width
                                                    ),
                                                  ),
                                                  child: Center(
                                                    child: Text(
                                                      "View Award",
                                                      style: TextStyle(
                                                        fontSize: 13,
                                                        fontWeight: FontWeight.w600,
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                  SizedBox(height: 20),
                                  Container(
                                    width: 340,
                                    height: 3,
                                    color: Colors.grey, // Grey line with a height of 3
                                  ),
                                ],
                              ),
                            ),
                            Container(
                              margin: EdgeInsets.only(left: 10, top: 10),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  SizedBox(height: 10),
                                  Row(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Container(
                                        constraints: BoxConstraints(
                                          maxWidth: 70,
                                          maxHeight: 70,
                                        ),
                                        child: Image.network(
                                          "https://assets-global.website-files.com/635c470cc81318fc3e9c1e0e/639a07cada7a2d68f4e9ef31_DECA%20Diamond%20Blue.png",
                                          width: 70,
                                          height: 70,
                                        ),
                                      ),
                                      SizedBox(width: 10),
                                      Expanded(
                                        child: Column(
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              "Deca National 2nd Place",
                                              style: TextStyle(
                                                fontSize: 18,
                                                fontWeight: FontWeight.w600,
                                              ),
                                              softWrap: true,
                                            ),
                                            SizedBox(height: 5),
                                            Text(
                                              "Deca Business Competition - Business topic",
                                              style: TextStyle(
                                                fontSize: 18,
                                                fontWeight: FontWeight.w500,
                                              ),
                                              softWrap: true,
                                            ),
                                            SizedBox(height: 5),
                                            Text(
                                              "Jan 12, 2023",
                                              style: TextStyle(
                                                fontSize: 18,
                                                fontWeight: FontWeight.w400,
                                              ),
                                              softWrap: true,
                                            ),
                                            SizedBox(height: 5),
                                            Row(
                                              children: [
                                                Container(
                                                  width: 100,
                                                  height: 29,
                                                  decoration: BoxDecoration(
                                                    borderRadius: BorderRadius.circular(15),
                                                    color: Color(0x00ffffff),
                                                    border: Border.all(
                                                      color: Colors.grey, // Add your desired border color
                                                      width: 2, // Add your desired border width
                                                    ),
                                                  ),
                                                  child: Center(
                                                    child: Text(
                                                      "View Award",
                                                      style: TextStyle(
                                                        fontSize: 13,
                                                        fontWeight: FontWeight.w600,
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                                SizedBox(width: 10), // Adjust the width based on your preference
                                                Container(
                                                  width: 100,
                                                  height: 29,
                                                  decoration: BoxDecoration(
                                                    borderRadius: BorderRadius.circular(15),
                                                    color: Color(0x00ffffff),
                                                    border: Border.all(
                                                      color: Colors.grey, // Add your desired border color
                                                      width: 2, // Add your desired border width
                                                    ),
                                                  ),
                                                  child: Center(
                                                    child: Text(
                                                      "View Award",
                                                      style: TextStyle(
                                                        fontSize: 13,
                                                        fontWeight: FontWeight.w600,
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                  SizedBox(height: 20),
                                  Container(
                                    width: 340,
                                    height: 3,
                                    color: Colors.grey, // Grey line with a height of 3
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      )
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
class CircularProgressBar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 100,
      height: 100,
      child: CircularProgressIndicator(
        strokeWidth: 8,
        value: 0.7, // Replace with the actual progress value
        valueColor: AlwaysStoppedAnimation<Color>(Colors.blue),
      ),
    );
  }
}


class MyEditableText extends StatefulWidget {
  @override
  _MyEditableTextState createState() => _MyEditableTextState();
}

class _MyEditableTextState extends State<MyEditableText> {
  TextEditingController _textEditingController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: _textEditingController,
      style: TextStyle(
        fontSize: 18,
        fontWeight: FontWeight.w500,
      ),
      decoration: InputDecoration(
        hintText: "Type Here...",
      ),
      maxLines: null, // Allows for multiline input
      textAlign: TextAlign.start,
    );
  }

  @override
  void dispose() {
    // Clean up the controller when the widget is disposed
    _textEditingController.dispose();
    super.dispose();
  }
}
Widget _buildImageContainer(File? imageFile, String section) {
  return Stack(
    children: [
      Container(
        width: 250,
        height: 200,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15),
          color: Color(0xFF8EB1BB),
        ),
        child: imageFile != null
            ? Image.file(
          imageFile,
          width: double.infinity,
          height: double.infinity,
          fit: BoxFit.cover,
        )
            : null,
      ),
      Positioned(
        top: 0,
        right: 0,
        child: InkWell(
          onTap: () {
            // Handle image download through a file link here
            // Example: _downloadImage('http://example.com/image.jpg', section);
          },
          child: Container(
            padding: EdgeInsets.all(8),
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: Colors.white,
            ),
            child: Icon(
              Icons.download,
              size: 30,
              color: Color(0xFF8EB1BB),
            ),
          ),
        ),
      ),
    ],
  );
}

// Example function to handle image download through a file link
void _downloadImage(String fileLink, String section) async {
  // Use your preferred method to download the image file
  // Example using dio package:
  // Dio dio = Dio();
  // Response response = await dio.get(fileLink);
  // Uint8List bytes = response.bodyBytes;

  // Save the downloaded bytes to a file and update the state
  // setState(() {
  //   switch (section) {
  //     case 'EventInformationDown':
  //       _EventInformationDown = File.fromRawPath(bytes);
  //       break;
  //     case 'EventInformationUp':
  //       _EventInformationUp = File.fromRawPath(bytes);
  //       break;
  //     // Add cases for other sections if needed
  //   }
  // });
}
