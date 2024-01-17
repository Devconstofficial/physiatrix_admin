import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:physiatrix_admin/Widgets/mycard.dart';
import 'package:physiatrix_admin/Widgets/sidebar.dart';
import 'package:physiatrix_admin/Widgets/topbar.dart';

class Dashboard extends StatefulWidget {
  const Dashboard({Key? key}) : super(key: key);

  @override
  // ignore: library_private_types_in_public_api
  _DashboardState createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  int totalDoctors = 0;
  int totalPatients = 0;
  int totalAppointments = 0;
  int upcomingAppointments = 0;
  int pastAppointments = 0;

  @override
  void initState() {
    super.initState();
    _fetchData();
  }

  Future<void> _fetchData() async {
    int finalPrice = 0;
    try {
      QuerySnapshot<Map<String, dynamic>> doctorsSnapshot =
          await FirebaseFirestore.instance.collection('doctors').get();
      setState(() {
        totalDoctors = doctorsSnapshot.size;
      });

      QuerySnapshot<Map<String, dynamic>> patientsSnapshot =
          await FirebaseFirestore.instance.collection('patientprofiles').get();
      setState(() {
        totalPatients = patientsSnapshot.size;
      });

      QuerySnapshot<Map<String, dynamic>> appointmentsSnapshot =
          await FirebaseFirestore.instance.collection('appointments').get();
      final now = DateTime.now();

      QuerySnapshot<Map<String, dynamic>> upcomingAppointmentsSnapshot =
          await FirebaseFirestore.instance
              .collection('appointments')
              .where('timestamp', isGreaterThan: now)
              .get();

      QuerySnapshot<Map<String, dynamic>> pastAppointmentsSnapshot =
          await FirebaseFirestore.instance
              .collection('appointments')
              .where('timestamp', isLessThan: now)
              .get();

      appointmentsSnapshot.docs
          .map((doc) => finalPrice += int.parse(doc['doctorProfile']['price']));

      setState(() {
        totalAppointments = appointmentsSnapshot.size;
        print("Total Appointments " + totalAppointments.toString());

        upcomingAppointments = upcomingAppointmentsSnapshot.docs.length;
        pastAppointments = pastAppointmentsSnapshot.docs.length;

        print("Upcoming Appointments" +
            upcomingAppointmentsSnapshot.docs.length.toString());
        print("Past Appointments" +
            pastAppointmentsSnapshot.docs.length.toString());

        // upcomingAppointments = appointmentsSnapshot.docs
        //     .where((doc) => (doc['timestamp']).toDate().isAfter(now))
        //     .length;

        // pastAppointments = appointmentsSnapshot.docs
        //     .where((doc) => (doc['timestamp']).toDate().isBefore(now))
        //     .length;
      });

      // Print statements for debugging
      print('Total Doctors: $totalDoctors');
      print('Total Patients: $totalPatients');
      print('Total Appointments: $totalAppointments');
      print('Upcoming Appointments: $upcomingAppointments');
      print('Past Appointments: $pastAppointments');
      print('Final Price: ${finalPrice.toString()}');
    } catch (error) {
      print('Error fetching data: $error');
    }
  }

  // Future<void> _fetchData() async {
  //   QuerySnapshot<Map<String, dynamic>> doctorsSnapshot =
  //       await FirebaseFirestore.instance.collection('doctors').get();
  //   setState(() {
  //     totalDoctors = doctorsSnapshot.size;
  //   });

  //   QuerySnapshot<Map<String, dynamic>> patientsSnapshot =
  //       await FirebaseFirestore.instance.collection('patientprofiles').get();
  //   setState(() {
  //     totalPatients = patientsSnapshot.size;
  //   });

  //   QuerySnapshot<Map<String, dynamic>> appointmentsSnapshot =
  //       await FirebaseFirestore.instance.collection('appointments').get();
  //   setState(() {
  //     totalAppointments = appointmentsSnapshot.size;
  //     print('Total Appointments: $totalAppointments');

  //     final now = DateTime.now();
  //     upcomingAppointments = appointmentsSnapshot.docs
  //         .where((doc) => (doc['date'] as Timestamp).toDate().isAfter(now))
  //         .length;
  //     pastAppointments = appointmentsSnapshot.docs
  //         .where((doc) => (doc['date'] as Timestamp).toDate().isBefore(now))
  //         .length;
  //   });
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white70,
      body: Row(
        children: [
          const SideBar(),
          SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const TopBar(),
                Padding(
                  padding: const EdgeInsets.only(left: 40),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(top: 40),
                        child: Row(
                          children: [
                            MyCard(
                                text1: totalDoctors.toString(),
                                text2: 'Total Doctors',
                                text3: '12% (30 days)',
                                imageAsset1: 'images/doctorcard.png',
                                imageAsset2: 'images/down.svg',
                                up: false),
                            SizedBox(
                              width: MediaQuery.of(context).size.width * 0.022,
                            ),
                            MyCard(
                                text1: totalPatients.toString(),
                                text2: 'Total Patients',
                                text3: '4% (30 days)',
                                imageAsset1: 'images/patcard.png',
                                imageAsset2: 'images/up.svg',
                                up: true),
                            SizedBox(
                              width: MediaQuery.of(context).size.width * 0.022,
                            ),
                            const MyCard(
                                text1: '\$750',
                                text2: 'Total Revenue',
                                text3: '4% (30 days)',
                                imageAsset1: 'images/revenue.png',
                                imageAsset2: 'images/down.svg',
                                up: false),
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 20),
                        child: Row(
                          children: [
                            MyCard(
                                text1: totalAppointments.toString(),
                                text2: 'Total Appointments',
                                text3: '12% (30 days)',
                                imageAsset1: 'images/1.png',
                                imageAsset2: 'images/down.svg',
                                up: false),
                            SizedBox(
                              width: MediaQuery.of(context).size.width * 0.022,
                            ),
                            MyCard(
                                text1: upcomingAppointments.toString(),
                                text2: 'Upcoming Appointments',
                                text3: '4% (30 days)',
                                imageAsset1: 'images/up1.png',
                                imageAsset2: 'images/up.svg',
                                up: true),
                            SizedBox(
                              width: MediaQuery.of(context).size.width * 0.022,
                            ),
                            MyCard(
                                text1: pastAppointments.toString(),
                                text2: 'Past Appointments',
                                text3: '4% (30 days)',
                                imageAsset1: 'images/pa.png',
                                imageAsset2: 'images/down.svg',
                                up: false),
                          ],
                        ),
                      ),
                      const Padding(
                        padding: EdgeInsets.only(top: 30),
                        child: Text(
                          'Patient Reviews',
                          style: TextStyle(
                            color: Color(0xFFD3F36B),
                            fontSize: 24,
                            fontFamily: 'Red Hat Display',
                            fontWeight: FontWeight.w600,
                            height: 0,
                            letterSpacing: 0.45,
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 210,
                        width: 1170,
                        child: StreamBuilder<QuerySnapshot>(
                          stream: FirebaseFirestore.instance
                              .collection('reviews')
                              .snapshots(),
                          builder: (context, snapshot) {
                            if (!snapshot.hasData) {
                              return const CircularProgressIndicator();
                            }

                            final reviews = snapshot.data!.docs;
                            return ListView.builder(
                              scrollDirection: Axis.horizontal,
                              itemCount: reviews.length,
                              itemBuilder: (BuildContext context, int index) {
                                final review = reviews[index];
                                final reviewData =
                                    review.data() as Map<String, dynamic>;

                                return Padding(
                                  padding: const EdgeInsets.all(20),
                                  child: ReviewCard(
                                    imageUrl: reviewData['patientImage'],
                                    name: reviewData['patientName'],
                                    rating: reviewData['rating'],
                                    text: reviewData['text'],
                                  ),
                                );
                              },
                            );
                          },
                        ),
                      ),
                    ],
                  ),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class ReviewCard extends StatelessWidget {
  final String? imageUrl;
  final String? name;
  final double? rating;
  final String? text;

  const ReviewCard({
    super.key,
    this.imageUrl,
    this.name,
    this.rating,
    this.text,
  });

  @override
  Widget build(BuildContext context) {
    Widget content;

    if (imageUrl != null && name != null && rating != null && text != null) {
      content = Padding(
        padding: const EdgeInsets.only(right: 30),
        child: Container(
          width: MediaQuery.of(context).size.width * 0.24,
          height: MediaQuery.of(context).size.height * 0.25,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(15),
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.5),
                spreadRadius: 3,
                blurRadius: 5,
                offset: const Offset(0, 3),
              ),
            ],
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.only(top: 10),
                child: Row(
                  children: [
                    Column(
                      children: [
                        Container(
                          width: MediaQuery.of(context).size.width * 0.08,
                          height: MediaQuery.of(context).size.height * 0.08,
                          decoration: ShapeDecoration(
                            image: DecorationImage(
                              image: NetworkImage(imageUrl!),
                              fit: BoxFit.contain,
                            ),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(100),
                            ),
                          ),
                        )
                      ],
                    ),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Text(
                          name!,
                          style: const TextStyle(
                            color: Colors.black,
                            fontSize: 14,
                            fontFamily: 'Red Hat Display',
                            fontWeight: FontWeight.w600,
                            height: 0,
                          ),
                        ),
                        RatingBar.builder(
                          itemSize: 12,
                          initialRating: rating!,
                          minRating: 0,
                          direction: Axis.horizontal,
                          allowHalfRating: true,
                          itemCount: 5,
                          itemBuilder: (context, _) => const Icon(
                            Icons.star,
                            color: Colors.amber,
                          ),
                          onRatingUpdate: (rating) {},
                        ),
                      ],
                    )
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(
                  left: 25,
                  top: 20,
                ),
                child: Row(
                  children: [
                    SizedBox(
                      width: MediaQuery.of(context).size.width * 0.2,
                      child: Text(
                        text!,
                        style: const TextStyle(
                          color: Colors.black,
                          fontSize: 12,
                          fontFamily: 'Red Hat Display',
                          fontWeight: FontWeight.w600,
                        ),
                        textAlign: TextAlign.justify,
                        softWrap: true,
                      ),
                    )
                  ],
                ),
              )
            ],
          ),
        ),
      );
    } else {
      content = Container();
    }

    return content;
  }
}
