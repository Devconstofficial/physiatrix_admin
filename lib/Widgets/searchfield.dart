import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class SearchField extends StatefulWidget {
  final String label;
  final IconData icon; // New parameter for the icon
  const SearchField({Key? key, required this.label, required this.icon})
      : super(key: key);

  @override
  State<SearchField> createState() => SearchFieldState();
}

class SearchFieldState extends State<SearchField> {
  @override
  Widget build(BuildContext context) {
    return TextField(
      cursorColor: Colors.white,
      style: const TextStyle(color: Colors.white),
      decoration: InputDecoration(
        focusedBorder: OutlineInputBorder(
          borderSide: const BorderSide(width: 2, color: Colors.white),
          borderRadius: BorderRadius.circular(10),
        ),
        enabledBorder: OutlineInputBorder(
          borderSide: const BorderSide(width: 2, color: Colors.white),
          borderRadius: BorderRadius.circular(10),
        ),
        border: OutlineInputBorder(
          borderSide: const BorderSide(width: 2, color: Colors.white),
          borderRadius: BorderRadius.circular(10),
        ),
        hintText: widget.label,
        hintStyle: TextStyle(
          color: Colors.white,
          fontSize: 15.sp,
          fontFamily: 'Red Hat Display',
          fontWeight: FontWeight.w600,
        ),
        prefixIcon: Icon(
          widget.icon, // Use the provided icon
          color: Colors.white,
        ),
      ),
    );
  }
}
