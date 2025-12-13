import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class LeaderboardProvider extends ChangeNotifier {
  Map<int, List<Map<String, dynamic>>> leaderboardPerLevel = {};

  Future<void> fetchLeaderboard(int level) async {
    final snapshot = await FirebaseFirestore.instance
        .collection('leaderboard')
        .where('level', isEqualTo: level)
        .orderBy('score', descending: true)
        .get();

    leaderboardPerLevel[level] =
        snapshot.docs.map((doc) => doc.data()).toList();
    notifyListeners();
  }

  List<Map<String, dynamic>> getLeaderboard(int level) {
    return leaderboardPerLevel[level] ?? [];
  }
}
