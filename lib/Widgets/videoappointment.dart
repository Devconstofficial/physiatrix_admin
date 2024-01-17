import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class VideoAppointment extends StatelessWidget {
  const VideoAppointment({super.key});

 @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width * 0.6,
      height: MediaQuery.of(context).size.height * 0.17,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.5),
            spreadRadius: 3,
            blurRadius: 5,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: Row(
        children: [
          SizedBox(width: MediaQuery.of(context).size.width * 0.015),
          Image.asset(
            'images/image.png',
            fit: BoxFit.contain,
            height: MediaQuery.of(context).size.height * 0.14,
          ),
          SizedBox(width: MediaQuery.of(context).size.width * 0.015),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.025,
              ),
              const Text(
                'Dr. Khezar Mahmood',
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 22,
                  fontFamily: 'Red Hat Display',
                  fontWeight: FontWeight.w600,
                ),
              ),
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.01,
              ),
              const Text(
                'Video Call - Upcoming',
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 14,
                  fontFamily: 'Red Hat Display',
                  fontWeight: FontWeight.w600,
                  height: 0,
                  letterSpacing: 0.22,
                ),
              ),
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.01,
              ),
              Row(
                children: [
                  const Text(
                    '10.00 AM',
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 14,
                      fontFamily: 'Red Hat Display',
                      fontWeight: FontWeight.w600,
                      height: 0,
                      letterSpacing: 0.26,
                    ),
                  ),
                  SizedBox(width: MediaQuery.of(context).size.width * 0.4),
                  SvgPicture.asset(
                    'images/video.svg', 
                     height: 25,
                     width: 25,
                  ),
                ],
              )
            ],
          )
        ],
      ),
    );
  }
}
