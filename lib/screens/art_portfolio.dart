import 'package:SoulSync/screens/profile_page.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import '../screens/course_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'app_info.dart';
import '../screens/community.dart';
import '../screens/account.dart';
import 'iphone-14-12.dart';
import 'BookingManager.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';


class ArtProfile extends StatefulWidget {
  @override
  _ArtProfileState createState() => _ArtProfileState();
}

class _ArtProfileState extends State<ArtProfile> {
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



  File? _aboutArtistImage;
  File? _aboutArtistImageBottom;
  File? _performancesImage;
  File? _awardsImage;
  File? _awardsImageLeft;
  File? _awardsImageRight;
  File? _performanceImageLeft;
  File? _performanceImageRight;

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
          default:
            break;
        }
      }
    });
  }


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
                ),
              ),
              child: SafeArea(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    InkWell(
                      onTap: () {
                        Navigator.pop(context);
                      },
                      child: Icon(
                        Icons.arrow_back,
                        size: 30,
                        color: Colors.white,
                      ),
                    ),
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
                            Navigator.of(context).push(
                              MaterialPageRoute(builder: (context) {
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
                          CircleAvatar(
                            radius: 50,
                          ),
                          const SizedBox(width: 15),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "$_userName",
                                style: const TextStyle(
                                  fontSize: 25,
                                  fontWeight: FontWeight.w600,
                                  letterSpacing: 1,
                                  wordSpacing: 2,
                                  color: Colors.white,
                                ),
                              ),
                              Text(
                                "Lone Star Highschool",
                                style: const TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.w400,
                                  color: Colors.white,
                                ),
                              ),
                              Text(
                                "Little Elm, TX",
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
                ],
              ),
            ),
            //About the Artist Container
            Container(
              padding: EdgeInsets.symmetric(horizontal: 15, vertical: 20),
              child: Row(
                children: [
                  // Container with two boxes in a column
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Stack(
                        children: [
                          Stack(
                            children: [
                              Container(
                                width: 180,
                                height: 180,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(15),
                                  color: Color(0xFF8EB1BB),
                                ),
                                child: _aboutArtistImage != null
                                    ? Image.file(
                                  _aboutArtistImage!,
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
                                    _getImage('aboutArtist');
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
                          SizedBox(height: 15),
                          Stack(
                            children: [
                              Container(
                                width: 180,
                                height: 180,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(15),
                                  color: Color(0xFF8EB1BB),
                                ),
                                child: _aboutArtistImage != null
                                    ? Image.file(
                                  _aboutArtistImage!,
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
                                    _getImage('aboutArtist');
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
                        ],

                      ),
                      SizedBox(height: 15),
                      Stack(
                        children: [
                          Container(
                            width: 180,
                            height: 180,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(15),
                              color: Color(0xFF8EB1BB),
                            ),
                            child: _aboutArtistImageBottom != null
                                ? Image.file(
                              _aboutArtistImageBottom!,
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
                                _getImage('aboutArtistImageBottom');
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
                    ],
                  ),
                  SizedBox(width: 20), // Adjust the spacing between the two columns
                  // Container with heading and text
                  Expanded(
                    child: Align(
                      alignment: Alignment.topCenter,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                              "About The Artist",
                              style: TextStyle(
                                fontSize: 25,
                                fontWeight: FontWeight.w600,
                              )
                          ),
                          SizedBox(height: 10),
                          MyEditableText(),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
            //Performance Container
            // Container with Heading and Image Upload Box
            Container(
              padding: EdgeInsets.symmetric(horizontal: 15, vertical: 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                      "Performances",
                      style: TextStyle(
                        fontSize: 25,
                        fontWeight: FontWeight.w600,
                      )
                  ),
                  SizedBox(height: 10),
                  Stack(
                    children: [
                      Stack(
                        children: [
                          Container(
                            width: 400,
                            height: 200,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(15),
                              color: Color(0xFF8EB1BB),
                            ),
                            child: _performancesImage != null
                                ? Image.file(
                              _performancesImage!,
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
                                _getImage('performances');
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
                    ],
                  ),
                  Container(
                    margin: EdgeInsets.symmetric(vertical: 15), // Add vertical margin as needed
                    child: MyEditableText(),
                  ),
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 5, vertical: 20),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        SizedBox(height: 10),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Stack(
                              children: [
                                Stack(
                                  children: [
                                    Container(
                                      width: 180,
                                      height: 180,
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(15),
                                        color: Color(0xFF8EB1BB),
                                      ),
                                      child: _performanceImageLeft != null
                                          ? Image.file(
                                        _performanceImageLeft!,
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
                                          _getImage('performanceArtistLeft');
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
                              ],
                            ),
                            Stack(
                              children: [
                                Stack(
                                  children: [
                                    Stack(
                                      children: [
                                        Container(
                                          width: 180,
                                          height: 180,
                                          decoration: BoxDecoration(
                                            borderRadius: BorderRadius.circular(15),
                                            color: Color(0xFF8EB1BB),
                                          ),
                                          child: _performanceImageRight != null
                                              ? Image.file(
                                            _performanceImageRight!,
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
                                              _getImage('performanceArtistRight');
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
                                  ],
                                ),
                              ],
                            ),
                          ],
                        ),
                        Container(
                          margin: EdgeInsets.symmetric(vertical: 15),
                          child: MyEditableText(),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            //Awards Container
            Container(
              padding: EdgeInsets.symmetric(horizontal: 15, vertical: 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                      "Awards",
                      style: TextStyle(
                        fontSize: 25,
                        fontWeight: FontWeight.w600,
                      )
                  ),
                  SizedBox(height: 10),
                  Stack(
                    children: [
                      Stack(
                        children: [
                          Container(
                            width: 400,
                            height: 200,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(15),
                              color: Color(0xFF8EB1BB),
                            ),
                            child: _awardsImage != null
                                ? Image.file(
                              _awardsImage!,
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
                                _getImage('awards');
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

                    ],
                  ),
                  Container(
                    margin: EdgeInsets.symmetric(vertical: 15), // Add vertical margin as needed
                    child: MyEditableText(),
                  ),
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 5, vertical: 20),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        SizedBox(height: 10),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Stack(
                              children: [
                                Stack(
                                  children: [
                                    Container(
                                      width: 180,
                                      height: 180,
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(15),
                                        color: Color(0xFF8EB1BB),
                                      ),
                                      child: _awardsImageLeft != null
                                          ? Image.file(
                                        _awardsImageLeft!,
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
                                          _getImage('aboutArtistLeft');
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
                              ],
                            ),
                            Stack(
                              children: [
                                Container(
                                  width: 180,
                                  height: 180,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(15),
                                    color: Color(0xFF8EB1BB),
                                  ),
                                  child: _awardsImageRight != null
                                      ? Image.file(
                                    _awardsImageRight!,
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
                                      _getImage('aboutArtistRight');
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
                          ],
                        ),
                        Container(
                          margin: EdgeInsets.symmetric(vertical: 15),
                          child:MyEditableText(),
                        ),
                      ],
                    ),
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
        hintText: "Type Your Info Here...",
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


