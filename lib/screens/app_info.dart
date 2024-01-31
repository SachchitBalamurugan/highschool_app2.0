import 'package:flutter/material.dart';

class AppInfoPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [
              Color(0xFF044051),
              Color(0xFF135263),
              Color(0xFF35788A),
              Color(0xFF35778A),
              Color(0xFF43879A),
              Color(0xFF5AA1B5),
            ],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: SafeArea(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Back Button
              Padding(
                padding: const EdgeInsets.only(left: 20, top: 20),
                child: GestureDetector(
                  onTap: () {
                    Navigator.pop(context);
                  },
                  child: Icon(
                    Icons.arrow_back,
                    color: Colors.white,
                    size: 30,
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(20),
                child: Text(
                  "Soul Sync - App Overview",
                  style: TextStyle(
                    fontSize: 30,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
              ),
              Expanded(
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(20),
                      topRight: Radius.circular(20),
                    ),
                  ),
                  child: SingleChildScrollView(
                    padding: const EdgeInsets.all(20),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // Overview Text
                        Text(
                          "Soul Sync is a comprehensive mental health app designed to assist individuals dealing with OCD and Depression. The app offers a holistic approach to mental well-being, focusing on self-improvement, guidance, and support.",
                          style: TextStyle(
                            fontSize: 18,
                            color: Colors.black,
                          ),
                        ),
                        SizedBox(height: 20),
                        // Key Features
                        Text(
                          "Key Features:",
                          style: TextStyle(
                            fontSize: 22,
                            fontWeight: FontWeight.bold,
                            color: Colors.black,
                          ),
                        ),
                        FeatureItem("Courses for Better Mental Health"),
                        FeatureItem("Text-to-Speech Functionality"),
                        FeatureItem("Progress Tracking"),
                        FeatureItem("Therapist Locator"),
                        FeatureItem("Mood Tracker"),
                        FeatureItem("AI Chatbot"),
                        FeatureItem("Community Interaction"),
                        FeatureItem("Events Management"),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget FeatureItem(String feature) {
    return Padding(
      padding: const EdgeInsets.only(top: 10),
      child: Row(
        children: [
          Icon(
            Icons.check_circle,
            color: Color(0xFF038C73),
            size: 20,
          ),
          SizedBox(width: 10),
          Text(
            feature,
            style: TextStyle(
              fontSize: 16,
              color: Colors.black,
            ),
          ),
        ],
      ),
    );
  }
}
