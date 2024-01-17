import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:physiatrix_admin/Widgets/sidebar.dart';
import 'package:physiatrix_admin/Widgets/topbar.dart';

class DoctorsScreen extends StatelessWidget {
  const DoctorsScreen({Key? key}) : super(key: key);

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
                      'Registered Doctors',
                      style: TextStyle(
                        color: Color(0xFFD3F36B),
                        fontSize: 28,
                        fontFamily: 'Red Hat Display',
                        fontWeight: FontWeight.w700,
                        height: 0,
                        letterSpacing: 0.45,
                      ),
                    ),
                    SizedBox(
                      width: MediaQuery.of(context).size.width * 0.55,
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
                height: 528,
                width: 1220,
                child: StreamBuilder<QuerySnapshot>(
                  stream: FirebaseFirestore.instance
                      .collection('doctors')
                      .snapshots(),
                  builder: (context, snapshot) {
                    if (!snapshot.hasData) {
                      return const CircularProgressIndicator();
                    }

                    return ListView.builder(
                      itemCount: snapshot.data?.docs.length,
                      itemBuilder: (BuildContext context, int index) {
                        final DocumentSnapshot doc = snapshot.data?.docs[index]
                            as DocumentSnapshot<Object?>;
                        final Map<String, dynamic> data =
                            doc.data() as Map<String, dynamic>;

                        final String imageUrl = data['image_url'];
                        final String name = data['name'];
                        final String designation = data['designation'];
                        final String hospital = data['hospital'];
                        final String price = data['price'];

                        return DoctorCard(
                          imageUrl: imageUrl,
                          name: name,
                          designation: designation,
                          hospital: hospital,
                          price: price,
                        );
                      },
                    );
                  },
                ),
              )
            ],
          ),
        ],
      ),
    );
  }
}

class DoctorCard extends StatefulWidget {
  final String imageUrl;
  final String name;
  final String designation;
  final String hospital;
  final String price;

  const DoctorCard({
    super.key,
    required this.imageUrl,
    required this.name,
    required this.designation,
    required this.hospital,
    required this.price,
  });

  @override
  // ignore: library_private_types_in_public_api
  _DoctorCardState createState() => _DoctorCardState();
}

class _DoctorCardState extends State<DoctorCard> {
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
        padding: const EdgeInsets.only(top: 25),
        child: Row(
          children: [
            SizedBox(
              width: MediaQuery.of(context).size.width * 0.05,
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
              width: MediaQuery.of(context).size.width * 0.02,
            ),
            Card(
              elevation: 5,
              shadowColor: const Color(0xFFD3F36B),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20),
              ),
              child: Container(
                width: MediaQuery.of(context).size.width * 0.7,
                height: MediaQuery.of(context).size.height * 0.2,
                decoration: ShapeDecoration(
                  color: Colors.white,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                ),
                child: Row(
                  children: [
                    SizedBox(
                      width: MediaQuery.of(context).size.width * 0.015,
                    ),
                    Image.network(
                      widget.imageUrl,
                      fit: BoxFit.contain,
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 20, top: 30),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            widget.name,
                            style: const TextStyle(
                              color: Colors.black,
                              fontSize: 28,
                              fontFamily: 'Red Hat Display',
                              fontWeight: FontWeight.w600,
                              height: 0,
                              letterSpacing: 0.45,
                            ),
                          ),
                          SizedBox(
                            height: MediaQuery.of(context).size.height * 0.005,
                          ),
                          Text(
                            widget.designation,
                            style: const TextStyle(
                              color: Colors.black,
                              fontSize: 20,
                              fontFamily: 'Red Hat Display',
                              fontWeight: FontWeight.w600,
                              height: 0,
                              letterSpacing: 0.32,
                            ),
                          )
                        ],
                      ),
                    ),
                    SizedBox(
                      width: MediaQuery.of(context).size.width * 0.055,
                    ),
                    Container(
                      width: MediaQuery.of(context).size.width * 0.005,
                      height: MediaQuery.of(context).size.height * 0.15,
                      decoration: ShapeDecoration(
                        color: Colors.black,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 35, left: 20),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              const Text(
                                'Hospital : ',
                                style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 20,
                                  fontFamily: 'Red Hat Display',
                                  fontWeight: FontWeight.w600,
                                  height: 0,
                                  letterSpacing: 0.32,
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(left: 10),
                                child: Text(
                                  widget.hospital,
                                  style: const TextStyle(
                                    color: Colors.black,
                                    fontSize: 20,
                                    fontFamily: 'Red Hat Display',
                                    fontWeight: FontWeight.w600,
                                    height: 0,
                                    letterSpacing: 0.32,
                                  ),
                                ),
                              )
                            ],
                          ),
                          Padding(
                            padding: const EdgeInsets.only(top: 10),
                            child: Row(
                              children: [
                                const Text(
                                  'Price : ',
                                  style: TextStyle(
                                    color: Colors.black,
                                    fontSize: 20,
                                    fontFamily: 'Red Hat Display',
                                    fontWeight: FontWeight.w600,
                                    height: 0,
                                    letterSpacing: 0.32,
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(left: 10),
                                  child: Text(
                                    '\$ ${widget.price}',
                                    style: const TextStyle(
                                      color: Colors.black,
                                      fontSize: 20,
                                      fontFamily: 'Red Hat Display',
                                      fontWeight: FontWeight.w600,
                                      height: 0,
                                      letterSpacing: 0.32,
                                    ),
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
              ),
            )
          ],
        ),
      ),
    );
  }
}
