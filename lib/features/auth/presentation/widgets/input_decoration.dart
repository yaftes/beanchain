import 'package:flutter/material.dart';


InputDecoration buildinputDecoration(String label, String hint, IconData icon) {
  return InputDecoration(
    labelText: label,
    hintText: hint,
    hintStyle: TextStyle(color: Colors.black45),
    errorStyle: TextStyle(color: Colors.white),
    prefixIcon: Icon(icon, color: Colors.brown),
    filled: true,
    labelStyle: TextStyle(color: Colors.brown[500]),
    fillColor: Colors.white,
    contentPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
    border: OutlineInputBorder(
      borderRadius: BorderRadius.circular(12),
      borderSide: BorderSide.none,
    ),
  );
}
