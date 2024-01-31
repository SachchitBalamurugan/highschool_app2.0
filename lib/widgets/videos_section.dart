// ignore_for_file: use_build_context_synchronously, prefer_typing_uninitialized_variables

import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';


class VideoSection extends StatefulWidget {
  final String? courseName;

  VideoSection({this.courseName});

  @override
  State<VideoSection> createState() => _VideoSectionState();
}

class _VideoSectionState extends State<VideoSection> {
  Map<String, List<String>> videoLists = {
    'Concentration': [
      'Introduction to concentration and its importance in academic success',
      'Memory Game',
      'Focus Game',
      'Brain Game',
      'Color Game',
    ],
    'Depression': [
      'Are you Depressed: Quiz',
      'Find the difference between positive thoughts vs Negative thoughts',
      'Definition of Depression: Differentiating sadness from clinical depression',
      'Prevalence and Impact: Understanding the global burden of depression',
      'Myths and Stigma: Addressing misconceptions about depression and reducing stigma',
      "Quiz: Myths and Stigma",
      'Self-Reflection: Encouraging individuals to explore their unique triggers and stressors',
      "Grounding Techniques: Using sensory-based exercises to stay present and centered",
      // "Distraction Techniques: Exploring healthy distractions during difficult moments",
      // "The Importance of Support: Recognizing the value of social connections during depression",
      // "Communication: Learning effective ways to express feelings and seek help",
      // "Setting Boundaries: Establishing healthy boundaries in relationships for self-care",
      // "Identifying Negative Thought Patterns: Recognizing cognitive distortions and negative self-talk",
      // "Cognitive Restructuring: Challenging and replacing negative thoughts with more balanced ones",
      // "Re:framing: Shifting perspectives to find positive aspects and solutions",
      // "Emotional Awareness: Developing skills to identify and express emotions",
      // "Emotion Regulation: Learning techniques to manage overwhelming emotions",
      // "Understanding Treatment Options: Exploring therapy, counseling, and medication as potential avenues for support",
      // "Overcoming Barriers to Seeking Help: Addressing common concerns about seeking professional assistance",
      // "Mindfulness Practices: Learning to be present and non-judgmental through mindfulness exercises",
      // "Self-Compassion: Nurturing self-kindness and acceptance in times of distress",
      // "Exercise and Depression: Understanding the connection between physical activity and mood",
      // "Nutrition and Mental Health: Exploring the impact of diet on mental well-being",
      // "Sleep Hygiene: Developing healthy sleep habits for better mental and emotional health",
      // "Resilience Skills: Building resilience to bounce back from setbacks and challenges",
      // "Long-Term Coping: Sustaining coping strategies for ongoing mental health management",
      // // Add more videos for Depression
    ],
    'Meditation': [
      'Beginner Meditation Part 1',
      'Beginner Meditation part 2',
      'Beginner Meditation Part 3',
      'Intermediate Meditation Part 1',
      'Intermediate Meditation Part 2',
      'Intermediate Meditation Part 3',
      'Advanced Meditation Part 1',
      'Advanced Meditation Part 2',
      'Advanced Meditation Part 3',
      'Advanced Meditation Part 4',
      'trial',
      // Add more videos for Meditation
    ],
    'OCD': [
      "Get Started",
      "OCD Screening",
      "Exposure",
      "Process of ERP",
      'Touching Trash ERP',
      'Tapping ERP',
      'Cleaning ERP',
      'Keeping Useless Items ERP',
      'Pressure ERP',
      'Washing Hands and Germ ERP',

  // Add more videos for OCD
    ],
  };
  CollectionReference coursesEntry =
      FirebaseFirestore.instance.collection('courses');
  var userId = FirebaseAuth.instance.currentUser!.uid;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    List<String> videoList = videoLists[widget.courseName!] ?? [];

    return ListView.builder(
      itemCount: videoList.length,
      physics: const NeverScrollableScrollPhysics(),
      shrinkWrap: true,
      itemBuilder: (context, index) {
        return ListTile(

          leading: Container(
            padding: const EdgeInsets.all(5),
            decoration: BoxDecoration(
              color: index == 0
                  ? const Color(0xFF674AEF)
                  : const Color(0xFF674AEF).withOpacity(0.6),
              shape: BoxShape.circle,
            ),
            child: const Icon(
              Icons.play_arrow_rounded,
              color: Colors.white,
              size: 30,
            ),
          ),
          title: Text(videoList[index]),
          subtitle: const Text("10 min"),
        );
      },
    );
  }

  dataAdded(String textCalled, String fieldName) async {
    coursesEntry.doc(userId).collection(fieldName).doc(userId).set({
        'Course Name': textCalled,
        'Points': true,
      }); 
  }
}
