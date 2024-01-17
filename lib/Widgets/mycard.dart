import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class MyCard extends StatelessWidget {
  final String text1;
  final String text2;
  final String text3;
  final String imageAsset1;
  final String imageAsset2;
  final bool up;

  const MyCard({
    Key? key,
    required this.text1,
    required this.text2,
    required this.text3,
    required this.imageAsset1,
    required this.imageAsset2,
    required this.up,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width * 0.24,
      height: MediaQuery.of(context).size.height * 0.2,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(15),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.5),
            spreadRadius: 3,
            blurRadius: 5,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Row(
        children: [
          Column(
            children: [
              Padding(
                padding: const EdgeInsets.only(left: 34, top: 15),
                child: Image.asset(
                  imageAsset1,
                ),
              ),
            ],
          ),
          Padding(
            padding: const EdgeInsets.only(left: 45, top: 15),
            child: Column(
              children: [
                Text(
                  text1,
                  style: const TextStyle(
                    color: Colors.black,
                    fontSize: 36,
                    fontFamily: 'Red Hat Display',
                    fontWeight: FontWeight.w500,
                    height: 0,
                    letterSpacing: 0.97,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 5),
                  child: Text(
                    text2,
                    style: const TextStyle(
                      color: Colors.black,
                      fontSize: 15,
                      fontFamily: 'Red Hat Display',
                      fontWeight: FontWeight.w500,
                      height: 0,
                      letterSpacing: 0.49,
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 5),
                  child: Row(
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(right: 10),
                        child: Container(
                          width: 20,
                          height: 20,
                          decoration: BoxDecoration(
                            color: up ?  const Color(0x262ED5A3) : const Color(0x26FF5B5B),
                            shape: BoxShape.circle,
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(3.0),
                            child: SvgPicture.asset(
                              imageAsset2,
                              width: 15,
                              height: 15,
                            ),
                          ),
                        ),
                      ),
                      Text(
                        text3,
                        style: const TextStyle(
                          color: Colors.black,
                          fontSize: 12,
                          fontFamily: 'Red Hat Display',
                          fontWeight: FontWeight.w400,
                          height: 0.12,
                        ),
                      )
                    ],
                  ),
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}
