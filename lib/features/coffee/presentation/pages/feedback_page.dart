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
  final _formKey = GlobalKey<FormState>();
  final _batchIdController = TextEditingController();
  final _descriptionController = TextEditingController();
  String? _selectedIssue;
  bool _isSubmitting = false;
  File? _pickedImage; // Variable to store the picked image file

  final List<String> _issueTypes = [
    'Smell Problem',
    'Bad Taste',
    'Packaging Damage',
    'Incorrect Info',
    'Mold or Foreign Object',
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

  // Function to pick an image from gallery or camera
  Future<void> _pickImage() async {
    final ImagePicker _picker = ImagePicker();
    final XFile? pickedFile = await _picker.pickImage(
      source: ImageSource.gallery, // Change to ImageSource.camera for camera
    );
    if (pickedFile != null) {
      setState(() {
        _pickedImage = File(pickedFile.path);
      });
    }
  }

  @override
  void dispose() {
    _batchIdController.dispose();
    _descriptionController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.brown[50],
      appBar: AppBar(
        backgroundColor: Colors.brown[700],
        title: Text(
          'Report Coffee Issue',
          style: GoogleFonts.poppins(fontWeight: FontWeight.w600),
        ),
        centerTitle: true,
        foregroundColor: Colors.white,
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

              // Batch ID
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

              // Issue Type Dropdown
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

              // Description Field
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

              // Report Date (readonly)
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

              // Placeholder for Photo Upload
              OutlinedButton.icon(
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
              SizedBox(height: 12),

              // Show selected photo if any
              if (_pickedImage != null)
                Padding(
                  padding: const EdgeInsets.only(top: 12.0),
                  child: Image.file(_pickedImage!, height: 150),
                ),
              SizedBox(height: 30),

              // Submit Button
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
