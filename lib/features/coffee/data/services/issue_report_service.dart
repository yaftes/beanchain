import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:intl/intl.dart';

class IssueReportService {
  final _reports = FirebaseFirestore.instance.collection("issue_reports");
  final _auth = FirebaseAuth.instance;

  Future<void> createIssueReport({
    required String batchId,
    required String issueType,
    required String description,
  }) async {
    final user = _auth.currentUser;

    if (user == null) return;

    await _reports.add({
      "userId": user.uid,
      "batchId": batchId,
      "issueType": issueType,
      "description": description,
      "reportDate": DateFormat('yyyy-MM-dd').format(DateTime.now()),
      "timestamp": FieldValue.serverTimestamp(),
    });
  }

  Stream<QuerySnapshot> fetchIssueReports() {
    final user = _auth.currentUser;
    return _reports.where("userId", isEqualTo: user?.uid).snapshots();
  }
}
