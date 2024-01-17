import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:physiatrix_admin/Widgets/sidebar.dart';
import 'package:physiatrix_admin/Widgets/topbar.dart';

class PatientsScreen extends StatelessWidget {
  const PatientsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Row(
        children: [
          const SideBar(),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const TopBar(),
              Padding(
                padding: const EdgeInsets.only(left: 45, top: 45),
                child: Row(
                  children: [
                    const Text(
                      'All Patients',
                      style: TextStyle(
                        color: Color(0xFFD3F36B),
                        fontSize: 28,
                        fontFamily: 'Red Hat Display',
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    SizedBox(
                      width: MediaQuery.of(context).size.width * 0.6,
                    ),
                    Container(
                      width: MediaQuery.of(context).size.width * 0.025,
                      height: MediaQuery.of(context).size.height * 0.06,
                      decoration: BoxDecoration(
                        color: const Color(0xFFD3F36B),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Image.asset(
                        'images/delete.png',
                        fit: BoxFit.contain,
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(
                  height: 520,
                  width: 1150,
                  
                  child: StreamBuilder<QuerySnapshot>(
                    stream: FirebaseFirestore.instance
                        .collection('patientprofiles')
                        .snapshots(),
                    builder: (context, snapshot) {
                      if (snapshot.hasData) {
                        return GridView.builder(
                          gridDelegate:
                              const SliverGridDelegateWithFixedCrossAxisCount(
                               
                            crossAxisCount: 2,
                          ),
                          itemCount: snapshot.data?.docs.length,
                          itemBuilder: (BuildContext context, int index) {
                            final DocumentSnapshot doc = snapshot
                                .data?.docs[index] as DocumentSnapshot<Object?>;
                            final Map<String, dynamic> data =
                                doc.data() as Map<String, dynamic>;

                            final String imageUrl = data['imageUrl'];
                            final String fullName = data['fullName'];
                            final String email = data['email'];
                            final String gender = data['gender'];

                            return PatientCard(
                              imageUrl: imageUrl,
                              fullName: fullName,
                              email: email,
                              gender: gender,
                            );
                          },
                        );
                      } else {
                        return const Center(child: CircularProgressIndicator());
                      }
                    },
                  ))
            ],
          ),
        ],
      ),
    );
  }
}

class PatientCard extends StatefulWidget {
  final String imageUrl;
  final String fullName;
  final String email;
  final String gender;

  const PatientCard({
    super.key,
    required this.imageUrl,
    required this.fullName,
    required this.email,
    required this.gender,
  });

  @override
  State<PatientCard> createState() => _PatientCardState();
}

class _PatientCardState extends State<PatientCard> {
  bool isSelected = false;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        setState(() {
          isSelected = !isSelected;
        });
      },
      child: Padding(
        padding: const EdgeInsets.only(top: 30),
        child: Row(
          children: [
            SizedBox(
              width: MediaQuery.of(context).size.width * 0.055,
            ),
            Container(
              width: MediaQuery.of(context).size.width * 0.018,
              height: MediaQuery.of(context).size.height * 0.035,
              decoration: ShapeDecoration(
                color: const Color(0xFFD3F36B),
                shape: RoundedRectangleBorder(
                  side: const BorderSide(
                    width: 2,
                    color: Color(0xFFD3F36B),
                  ),
                  borderRadius: BorderRadius.circular(2),
                ),
              ),
              child: isSelected
                  ? SvgPicture.asset(
                      'images/check.svg',
                      // ignore: deprecated_member_use
                      color: Colors.white,
                    )
                  : Container(),
            ),
            SizedBox(
              width: MediaQuery.of(context).size.width * 0.03,
            ),
            Card(
              elevation: 5,
              shadowColor: const Color(0xFFD3F36B),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20),
              ),
              child: Container(
                width: MediaQuery.of(context).size.width * 0.27,
                height: MediaQuery.of(context).size.height * 0.2,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Row(
                  children: [
                    SizedBox(width: MediaQuery.of(context).size.width * 0.015),
                    Image.network(
                      widget.imageUrl,
                      fit: BoxFit.contain,
                      height: MediaQuery.of(context).size.height * 0.16,
                    ),
                    SizedBox(width: MediaQuery.of(context).size.width * 0.015),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(
                          height: MediaQuery.of(context).size.height * 0.05,
                        ),
                        Text(
                          widget.fullName,
                          style: const TextStyle(
                            color: Colors.black,
                            fontSize: 22,
                            fontFamily: 'Red Hat Display',
                            fontWeight: FontWeight.w600,
                            height: 0,
                            letterSpacing: 0.35,
                          ),
                        ),
                        Text(
                          widget.email,
                          style: const TextStyle(
                            color: Colors.black,
                            fontSize: 14,
                            fontFamily: 'Red Hat Display',
                            fontWeight: FontWeight.w600,
                            height: 0,
                            letterSpacing: 0.22,
                          ),
                        ),
                        Text(
                          widget.gender,
                          style: const TextStyle(
                            color: Colors.black,
                            fontSize: 16,
                            fontFamily: 'Red Hat Display',
                            fontWeight: FontWeight.w600,
                            height: 0,
                            letterSpacing: 0.26,
                          ),
                        )
                      ],
                    )
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
