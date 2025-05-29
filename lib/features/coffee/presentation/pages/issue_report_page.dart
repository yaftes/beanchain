import 'package:beanchain/features/auth/data/services/auth_services.dart';
import 'package:beanchain/features/coffee/domain/services/issue_report_service.dart';
import 'package:beanchain/features/coffee/presentation/pages/home_page.dart';
import 'package:beanchain/features/coffee/presentation/pages/my_reports_page.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:lottie/lottie.dart';

class IssueReportPage extends StatefulWidget {
  const IssueReportPage({super.key});

  @override
  State<IssueReportPage> createState() => _IssueReportPageState();
}

class _IssueReportPageState extends State<IssueReportPage> {
  final _issueReportService = IssueReportService();
  final _authService = AuthServices();
  final _formKey = GlobalKey<FormState>();
  final _batchIdController = TextEditingController();
  final _descriptionController = TextEditingController();

  String? _selectedIssue;
  bool _isSubmitting = false;
  int rating = 0;

  final List<String> _issueTypes = [
    'Packaging Issue',
    'Quality Issue',
    'Delivery Issue',
    'Taste Issue',
    'Other',
  ];

  List<Color> iconColors = List.generate(5, (_) => Colors.white);

  void _changeRatingIconColor({required int index}) {
    if (index >= 0 && index < iconColors.length) {
      setState(() {
        if (iconColors[index] == const Color.fromARGB(255, 169, 133, 3)) {
          iconColors[index] = Colors.white;
          rating -= 1;
        } else {
          iconColors[index] = const Color.fromARGB(255, 169, 133, 3);
          rating += 1;
        }

        rating = rating.clamp(0, 5);
      });
    }
  }

  String _currentDate() {
    return DateFormat('yyyy-MM-dd').format(DateTime.now());
  }

  Future<void> _submitReport(BuildContext context) async {
    if (!_formKey.currentState!.validate()) return;

    setState(() => _isSubmitting = true);

    try {
      await _issueReportService.createIssueReport(
        batchId: _batchIdController.text,

        issueType: _selectedIssue ?? "N/A",
        description: _descriptionController.text,
        rating: rating,
      );
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Issue reported successfully!'),
          backgroundColor: Colors.green,
        ),
      );

      _batchIdController.clear();
      _descriptionController.clear();

      setState(() {
        iconColors = List.generate(5, (_) => Colors.white);
        rating = 0;
        _selectedIssue = null;
      });
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Error: ${e.toString()}'),
          backgroundColor: Colors.red,
        ),
      );
    } finally {
      setState(() => _isSubmitting = false);
    }
  }

  String _getUsernameFromEmail(String email) {
    return email.split('@')[0];
  }

  final String _userEmail = FirebaseAuth.instance.currentUser?.email ?? "";

  @override
  void dispose() {
    _batchIdController.dispose();
    _descriptionController.dispose();
    super.dispose();
  }

  void _showSignOutDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return Dialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
          child: Padding(
            padding: const EdgeInsets.all(24.0),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(Icons.logout, size: 48, color: Colors.redAccent),
                SizedBox(height: 16),
                Text(
                  'Log Out',
                  style: GoogleFonts.poppins(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Colors.brown[800],
                  ),
                ),
                SizedBox(height: 12),
                Text(
                  'Are you sure you want to sign out?',
                  textAlign: TextAlign.center,
                  style: GoogleFonts.poppins(
                    fontSize: 14,
                    color: Colors.grey[700],
                  ),
                ),
                SizedBox(height: 24),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    OutlinedButton(
                      onPressed: () => Navigator.of(context).pop(),
                      style: OutlinedButton.styleFrom(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                        side: BorderSide(color: Colors.brown),
                        padding: EdgeInsets.symmetric(
                          horizontal: 20,
                          vertical: 12,
                        ),
                      ),
                      child: Text(
                        'Cancel',
                        style: GoogleFonts.poppins(color: Colors.brown),
                      ),
                    ),
                    ElevatedButton(
                      onPressed: () async {
                        await _authService.signOut();

                        Navigator.pushAndRemoveUntil(
                          context,
                          MaterialPageRoute(builder: (context) => HomePage()),
                          (Route<dynamic> route) => false,
                        );
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.redAccent,
                        foregroundColor: Colors.white,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                        padding: EdgeInsets.symmetric(
                          horizontal: 20,
                          vertical: 12,
                        ),
                      ),
                      child: Text('Sign Out', style: GoogleFonts.poppins()),
                    ),
                  ],
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    String username = _getUsernameFromEmail(_userEmail);

    print('BUILD METHOD CALLED: Current _selectedIssue: $_selectedIssue');
    print('BUILD METHOD CALLED: Issue Types: $_issueTypes');

    return Scaffold(
      backgroundColor: Colors.brown[50],
      appBar: AppBar(
        backgroundColor: Colors.brown[700],
        foregroundColor: Colors.white,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CircleAvatar(
              backgroundColor: Colors.white,
              child: Text(
                username.isNotEmpty ? username[0].toUpperCase() : '?',
                style: GoogleFonts.poppins(
                  color: Colors.brown[300],
                  fontSize: 25,
                ),
              ),
            ),
            SizedBox(width: 10),
            Text(
              username,
              style: GoogleFonts.poppins(
                color: Colors.white,
                fontSize: 14,
                fontWeight: FontWeight.w500,
              ),
            ),
          ],
        ),
        actions: [
          PopupMenuButton<String>(
            icon: const Icon(Icons.more_vert, color: Colors.white),
            onSelected: (String value) {
              if (value == 'logout') {
                _showSignOutDialog();
              }
            },
            itemBuilder:
                (BuildContext context) => [
                  PopupMenuItem<String>(
                    value: 'logout',
                    child: Row(
                      children: [
                        const Icon(Icons.logout, color: Colors.redAccent),
                        const SizedBox(width: 10),
                        Text('Sign Out', style: GoogleFonts.poppins()),
                      ],
                    ),
                  ),
                ],
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 25),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(
                child: SizedBox(
                  height: 100,
                  width: 100,
                  child: Lottie.asset(
                    "assets/lottie/coffee_time.json",
                    fit: BoxFit.contain,
                  ),
                ),
              ),
              const SizedBox(height: 16),
              Center(
                child: Text(
                  'Found an issue with your coffee?',
                  style: GoogleFonts.poppins(
                    fontSize: 20,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
              const SizedBox(height: 8),
              Text(
                'Please fill out this form to help us investigate.',
                style: GoogleFonts.poppins(
                  fontSize: 14,
                  color: Colors.brown[700],
                ),
              ),
              const SizedBox(height: 32),
              TextFormField(
                controller: _batchIdController,
                style: GoogleFonts.poppins(),
                decoration: InputDecoration(
                  labelText: 'Batch ID',
                  prefixIcon: const Icon(Icons.numbers),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  hintText: 'Enter the coffee batch ID',
                ),
                validator:
                    (value) =>
                        value == null || value.isEmpty
                            ? 'Please enter batch ID'
                            : null,
              ),
              const SizedBox(height: 20),
              DropdownButtonFormField<String>(
                value: _selectedIssue,
                items:
                    _issueTypes.map((type) {
                      print('Creating DropdownMenuItem for value: $type');

                      return DropdownMenuItem(value: type, child: Text(type));
                    }).toList(),
                onChanged: (value) => setState(() => _selectedIssue = value),
                decoration: InputDecoration(
                  labelText: 'Issue Type',
                  prefixIcon: const Icon(Icons.report_problem_rounded),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                validator:
                    (value) =>
                        value == null ? 'Please select issue type' : null,
              ),
              const SizedBox(height: 20),
              TextFormField(
                controller: _descriptionController,
                maxLines: 5,
                style: GoogleFonts.poppins(),
                decoration: InputDecoration(
                  labelText: 'Describe the issue in detail',
                  prefixIcon: const Icon(Icons.description),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                validator:
                    (value) =>
                        value == null || value.isEmpty
                            ? 'Please describe the issue'
                            : null,
              ),
              const SizedBox(height: 20),
              TextFormField(
                initialValue: _currentDate(),
                readOnly: true,
                decoration: InputDecoration(
                  labelText: 'Report Date',
                  prefixIcon: const Icon(Icons.calendar_today),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
              ),
              const SizedBox(height: 30),
              // five different icon buttons
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                child: Text(
                  "Rate out of 5",
                  style: GoogleFonts.poppins(color: Colors.brown),
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  IconButton(
                    onPressed: () => _changeRatingIconColor(index: 0),
                    icon: Icon(Icons.star, color: iconColors[0]),
                    iconSize: 40,
                  ),
                  IconButton(
                    onPressed: () => _changeRatingIconColor(index: 1),
                    icon: Icon(Icons.star, color: iconColors[1]),
                    iconSize: 40,
                  ),
                  IconButton(
                    onPressed: () => _changeRatingIconColor(index: 2),
                    icon: Icon(Icons.star, color: iconColors[2]),
                    iconSize: 40,
                  ),
                  IconButton(
                    onPressed: () => _changeRatingIconColor(index: 3),
                    icon: Icon(Icons.star, color: iconColors[3]),
                    iconSize: 40,
                  ),
                  IconButton(
                    onPressed: () => _changeRatingIconColor(index: 4),
                    icon: Icon(Icons.star, color: iconColors[4]),
                    iconSize: 40,
                  ),
                ],
              ),
              const SizedBox(height: 30),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton.icon(
                  icon: const Icon(Icons.send_rounded),
                  label:
                      _isSubmitting
                          ? const CircularProgressIndicator(color: Colors.white)
                          : Text('Submit Report', style: GoogleFonts.poppins()),
                  onPressed:
                      _isSubmitting
                          ? null
                          : () {
                            _submitReport(context);
                          },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.brown[700],
                    foregroundColor: Colors.white,
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(14),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
      drawer: Drawer(
        backgroundColor: Colors.brown[100],
        child: Column(
          children: [
            Stack(
              children: [
                SizedBox(
                  width: double.infinity,
                  child: Lottie.asset(
                    "assets/lottie/coffee_cup.json",
                    fit: BoxFit.cover,
                    repeat: true,
                    animate: true,
                  ),
                ),
              ],
            ),
            ListTile(
              leading: const Icon(
                Icons.bug_report_rounded,
                color: Colors.white,
                size: 35,
              ),
              title: Text('Report Issue', style: GoogleFonts.poppins()),
              onTap: () {
                Navigator.of(context).pop();
              },
            ),
            ListTile(
              leading: const Icon(Icons.history, color: Colors.white, size: 35),
              title: Text('My Reports', style: GoogleFonts.poppins()),
              onTap: () {
                Navigator.of(context).pop();
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const MyReportsPage(),
                  ), // Added const
                );
              },
            ),
            const Divider(),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: ListTile(
                leading: const Icon(Icons.logout, color: Colors.brown),
                title: Text('Sign Out', style: GoogleFonts.poppins()),
                onTap: _showSignOutDialog,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
