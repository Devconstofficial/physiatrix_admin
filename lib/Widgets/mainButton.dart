import 'package:flutter/material.dart';

class MainButton extends StatelessWidget {
  const MainButton({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width * 0.18,
      height: MediaQuery.of(context).size.height * 0.06,
      decoration: ShapeDecoration(
        color: const Color(0xFFD3F36B),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
      ),
      child: const Center(
        child: Text(
          'Login to your account',
          style: TextStyle(
            color: Colors.white,
            fontSize: 18,
            fontFamily: 'Red Hat Display',
            fontWeight: FontWeight.w500,
          ),
        ),
      ),
    );
  }
}
