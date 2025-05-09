import 'package:beanchain/features/coffee/data/services/issue_report_service.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class MyReportsPage extends StatefulWidget {
  const MyReportsPage({super.key});

  @override
  State<MyReportsPage> createState() => _MyReportsPageState();
}

class _MyReportsPageState extends State<MyReportsPage> {
  final _issueReporService = IssueReportService();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.brown[50],
      appBar: AppBar(
        backgroundColor: Colors.brown[700],
        foregroundColor: Colors.white,
        title: Text(
          'My Reports',
          style: GoogleFonts.poppins(fontWeight: FontWeight.w600),
        ),
      ),
      body: StreamBuilder<QuerySnapshot>(
        stream: _issueReporService.fetchIssueReports(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          }

          if (snapshot.hasError) {
            return Center(
              child: Text(
                'Something went wrong!',
                style: GoogleFonts.poppins(),
              ),
            );
          }

          if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
            return Center(
              child: Text('No reports found!', style: GoogleFonts.poppins()),
            );
          }

          final reports =
              snapshot.data!.docs.map((doc) {
                return {
                  'batchId': doc['batchId'] ?? 'Unknown',
                  'issueType': doc['issueType'] ?? 'No issue type',
                  'description':
                      doc['description'] ?? 'No description provided',
                  'reportDate': doc['reportDate'] ?? 'No date provided',
                };
              }).toList();

          return ListView.builder(
            padding: const EdgeInsets.all(20),
            itemCount: reports.length,
            itemBuilder: (context, index) {
              final report = reports[index];
              return Container(
                margin: const EdgeInsets.only(bottom: 20),
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  color: Colors.brown[100],
                  borderRadius: BorderRadius.circular(20),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.brown.withOpacity(0.2),
                      blurRadius: 12,
                      offset: const Offset(0, 6),
                    ),
                  ],
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Icon(
                          Icons.report_problem_rounded,
                          size: 36,
                          color: Colors.brown[800],
                        ),
                        const SizedBox(width: 10),
                        Expanded(
                          child: Text(
                            report['issueType'],
                            style: GoogleFonts.poppins(
                              fontSize: 18,
                              fontWeight: FontWeight.w600,
                              color: Colors.brown[900],
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 12),
                    Row(
                      children: [
                        Icon(
                          Icons.qr_code_2_rounded,
                          size: 20,
                          color: Colors.brown[700],
                        ),
                        const SizedBox(width: 6),
                        Text(
                          'Batch ID: ${report['batchId']}',
                          style: GoogleFonts.poppins(fontSize: 14),
                        ),
                      ],
                    ),
                    const SizedBox(height: 10),
                    Text(
                      report['description'],
                      style: GoogleFonts.poppins(
                        fontSize: 15,
                        color: Colors.brown[800],
                      ),
                    ),
                    const SizedBox(height: 12),
                    Row(
                      children: [
                        Icon(
                          Icons.calendar_today_outlined,
                          size: 16,
                          color: Colors.grey[700],
                        ),
                        const SizedBox(width: 6),
                        Text(
                          report['reportDate'],
                          style: GoogleFonts.poppins(
                            fontSize: 13,
                            color: Colors.grey[700],
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              );
            },
          );
        },
      ),
    );
  }
}
