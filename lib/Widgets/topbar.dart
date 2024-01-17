import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:physiatrix_admin/Widgets/searchfield.dart';

class TopBar extends StatelessWidget {
  const TopBar({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height * 0.13,
      width: MediaQuery.of(context).size.width * 0.824,
      decoration: const BoxDecoration(
        color: Color(0xFFD3F36B),
        boxShadow: [
          BoxShadow(
            color: Colors.grey,
            offset: Offset(1, 4),
            blurRadius: 5,
            spreadRadius: 0,
          ),
        ],
      ),
      child: Padding(
        padding: const EdgeInsets.only(top: 22),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              width: MediaQuery.of(context).size.width * 0.02,
            ),
            const Text(
              'Hello Admin',
              style: TextStyle(
                color: Colors.white,
                fontSize: 24,
                fontFamily: 'Red Hat Display',
                fontWeight: FontWeight.w600,
                letterSpacing: 0.48,
              ),
            ),
            SizedBox(
              width: MediaQuery.of(context).size.width * 0.02,
            ),
            Container(
              width: MediaQuery.of(context).size.width * 0.02,
              height: MediaQuery.of(context).size.height * 0.05,
              
              decoration: ShapeDecoration(
                color: Colors.white,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8)),
              ),
              child: SvgPicture.asset(
                'images/far.svg',
                fit: BoxFit.fill,
              ),
            ),
            SizedBox(
              width: MediaQuery.of(context).size.width * 0.12,
            ),
            SizedBox(
              width: MediaQuery.of(context).size.width * 0.27,
              height: MediaQuery.of(context).size.height * 0.06,
              child: const SearchField(
                label: 'Search',
                icon: Icons.search_sharp,
              ),
            ),
            SizedBox(
              width: MediaQuery.of(context).size.width * 0.12,
            ),
            const Text(
              'Mr Admin',
              style: TextStyle(
                color: Colors.white,
                fontSize: 24,
                fontFamily: 'Red Hat Display',
                fontWeight: FontWeight.w600,
                letterSpacing: 0.38,
              ),
            ),
            SizedBox(
              width: MediaQuery.of(context).size.width * 0.015,
            ),
            Container(
              width: MediaQuery.of(context).size.width * 0.05,
              height: MediaQuery.of(context).size.height * 0.06,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: Colors.white,
                border: Border.all(
                  color: Colors.white,
                  width: 2.0,
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
