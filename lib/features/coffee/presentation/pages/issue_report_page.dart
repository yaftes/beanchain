import 'package:beanchain/features/auth/data/services/auth_services.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';

class IssueReportPage extends StatefulWidget {
  const IssueReportPage({super.key});

  @override
  State<IssueReportPage> createState() => _IssueReportPageState();
}

class _IssueReportPageState extends State<IssueReportPage> {
  final _authService = AuthServices();
  final _formKey = GlobalKey<FormState>();
  final _batchIdController = TextEditingController();
  final _descriptionController = TextEditingController();
  String? _selectedIssue;
  bool _isSubmitting = false;
  File? _pickedImage;

  final List<String> _issueTypes = [
    'Packaging Issue',
    'Quality Issue',
    'Delivery Issue',
    'Taste Issue',
    'Other',
  ];

  String _currentDate() {
    return DateFormat('yyyy-MM-dd').format(DateTime.now());
  }

  Future<void> _submitReport() async {
    if (!_formKey.currentState!.validate()) return;

    setState(() => _isSubmitting = true);

    try {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Issue reported successfully!'),
          backgroundColor: Colors.green,
        ),
      );
      _batchIdController.clear();
      _descriptionController.clear();
      setState(() => _selectedIssue = null);
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

  Future<void> _pickImage() async {
    final ImagePicker _picker = ImagePicker();
    final XFile? pickedFile = await _picker.pickImage(
      source: ImageSource.gallery,
    );
    if (pickedFile != null) {
      setState(() {
        _pickedImage = File(pickedFile.path);
      });
    }
  }

  void _removeImage() {
    setState(() {
      _pickedImage = null;
    });
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
        return AlertDialog(
          title: Text('Are you sure you want to log out?'),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text('Cancel', style: GoogleFonts.poppins()),
            ),
            TextButton(
              onPressed: () async {
                await _authService.signOut();
                Navigator.of(context).pop();
              },
              child: Text('Logout', style: GoogleFonts.poppins()),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    String username = _getUsernameFromEmail(_userEmail);
    return Scaffold(
      backgroundColor: Colors.brown[50],
      appBar: AppBar(
        backgroundColor: Colors.brown[700],
        foregroundColor: Colors.white,
        title: Text(
          username,
          style: GoogleFonts.poppins(color: Colors.white, fontSize: 14),
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: [
                GestureDetector(
                  onTap: _showSignOutDialog,
                  child: Text(
                    'Sign Out',
                    style: GoogleFonts.poppins(
                      color: Colors.white,
                      fontSize: 12,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Icon(
                Icons.bug_report_rounded,
                size: 70,
                color: Colors.brown[800],
              ),
              SizedBox(height: 16),
              Text(
                'Found an issue with your coffee?',
                style: GoogleFonts.poppins(
                  fontSize: 20,
                  fontWeight: FontWeight.w600,
                ),
              ),
              SizedBox(height: 8),
              Text(
                'Please fill out this form to help us investigate.',
                style: GoogleFonts.poppins(
                  fontSize: 14,
                  color: Colors.brown[700],
                ),
              ),
              SizedBox(height: 32),

              TextFormField(
                controller: _batchIdController,
                style: GoogleFonts.poppins(),
                decoration: InputDecoration(
                  labelText: 'Batch ID',
                  prefixIcon: Icon(Icons.numbers),
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
              SizedBox(height: 20),

              DropdownButtonFormField<String>(
                value: _selectedIssue,
                items:
                    _issueTypes.map((type) {
                      return DropdownMenuItem(value: type, child: Text(type));
                    }).toList(),
                onChanged: (value) => setState(() => _selectedIssue = value),
                decoration: InputDecoration(
                  labelText: 'Issue Type',
                  prefixIcon: Icon(Icons.report_problem_rounded),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                validator:
                    (value) =>
                        value == null ? 'Please select issue type' : null,
              ),
              SizedBox(height: 20),

              TextFormField(
                controller: _descriptionController,
                maxLines: 5,
                style: GoogleFonts.poppins(),
                decoration: InputDecoration(
                  labelText: 'Describe the issue in detail',
                  prefixIcon: Icon(Icons.description),
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
              SizedBox(height: 20),

              TextFormField(
                initialValue: _currentDate(),
                readOnly: true,
                decoration: InputDecoration(
                  labelText: 'Report Date',
                  prefixIcon: Icon(Icons.calendar_today),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
              ),
              SizedBox(height: 20),

              SizedBox(
                width: double.infinity,
                child: OutlinedButton.icon(
                  onPressed: _pickImage,
                  icon: Icon(Icons.photo_camera),
                  label: Text(
                    _pickedImage == null
                        ? "Upload Photo (optional)"
                        : "Photo Selected",
                  ),
                  style: OutlinedButton.styleFrom(
                    padding: EdgeInsets.symmetric(vertical: 14),
                    foregroundColor: Colors.brown[800],
                    side: BorderSide(color: Colors.brown.shade300),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                ),
              ),
              SizedBox(height: 12),

              // Show selected photo if any
              if (_pickedImage != null)
                Row(
                  children: [
                    Image.file(
                      _pickedImage!,
                      height: 150,
                      width: 150,
                      fit: BoxFit.cover,
                    ),
                    IconButton(
                      icon: Icon(Icons.close, color: Colors.red),
                      onPressed: _removeImage,
                    ),
                  ],
                ),
              SizedBox(height: 30),

              SizedBox(
                width: double.infinity,
                child: ElevatedButton.icon(
                  icon: Icon(Icons.send_rounded),
                  label:
                      _isSubmitting
                          ? CircularProgressIndicator(color: Colors.white)
                          : Text('Submit Report', style: GoogleFonts.poppins()),
                  onPressed: _isSubmitting ? null : _submitReport,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.brown[700],
                    foregroundColor: Colors.white,
                    padding: EdgeInsets.symmetric(vertical: 16),
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
    );
  }
}
