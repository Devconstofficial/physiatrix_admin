import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:intl/intl.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:physiatrix_admin/Widgets/sidebar.dart';
import 'package:physiatrix_admin/Widgets/topbar.dart';

class AppointmentsScreen extends StatefulWidget {
  const AppointmentsScreen({Key? key});

  @override
  State<AppointmentsScreen> createState() => _AppointmentsScreenState();
}

class _AppointmentsScreenState extends State<AppointmentsScreen> {
  bool _isUpcomingSelected = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Row(
        children: [
          const SideBar(),
          Column(
            children: [
              const TopBar(),
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.05,
              ),
              Container(
                width: MediaQuery.of(context).size.width * 0.27,
                height: MediaQuery.of(context).size.height * 0.12,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(10),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.5),
                      spreadRadius: 3,
                      blurRadius: 3,
                      offset: const Offset(0, 3),
                    ),
                  ],
                ),
                child: Row(
                  children: [
                    GestureDetector(
                      onTap: () {
                        setState(() {
                          _isUpcomingSelected = true;
                        });
                      },
                      child: Padding(
                        padding: const EdgeInsets.only(left: 20),
                        child: SizedBox(
                          width: MediaQuery.of(context).size.width * 0.11,
                          height: MediaQuery.of(context).size.height * 0.08,
                          child: Material(
                            elevation: _isUpcomingSelected ? 5 : 5,
                            color: _isUpcomingSelected
                                ? const Color(0xFFD3F36B)
                                : Colors.white,
                            borderRadius: BorderRadius.circular(10),
                            child: Center(
                              child: Text(
                                'Upcoming',
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  color: _isUpcomingSelected
                                      ? Colors.white
                                      : Colors.black,
                                  fontSize: 26,
                                  fontFamily: 'Red Hat Display',
                                  fontWeight: FontWeight.w700,
                                  letterSpacing: -0.30,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      width: MediaQuery.of(context).size.width * 0.02,
                    ),
                    GestureDetector(
                      onTap: () {
                        setState(() {
                          _isUpcomingSelected = false;
                        });
                      },
                      child: SizedBox(
                        width: MediaQuery.of(context).size.width * 0.11,
                        height: MediaQuery.of(context).size.height * 0.08,
                        child: Material(
                          elevation: _isUpcomingSelected ? 5 : 5,
                          color: !_isUpcomingSelected
                              ? const Color(0xFFD3F36B)
                              : Colors.white,
                          borderRadius: BorderRadius.circular(10),
                          child: Center(
                            child: Text(
                              'Past',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                color: !_isUpcomingSelected
                                    ? Colors.white
                                    : Colors.black,
                                fontSize: 26,
                                fontFamily: 'Red Hat Display',
                                fontWeight: FontWeight.w700,
                                letterSpacing: -0.30,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.04,
              ),
              StreamBuilder<QuerySnapshot>(
                stream: FirebaseFirestore.instance
                    .collection('appointments')
                    .orderBy('selectedDate', descending: false)
                    .snapshots(),
                builder: (context, snapshot) {
                  if (!snapshot.hasData) {
                    return const CircularProgressIndicator();
                  }

                  final appointmentWidgets = <Widget>[];

                  if (snapshot.hasError) {
                    return Text('Error: ${snapshot.error}');
                  }

                  final appointmentDocuments = snapshot.data!.docs;

                  for (var document in appointmentDocuments) {
                    final data = document.data() as Map<String, dynamic>;
                    final Timestamp timestamp = data['selectedDate'];
                    final DateTime dateTime = timestamp.toDate();

                    final String formattedDate =
                        DateFormat.yMMMd().format(dateTime);

                    // Filter based on _isUpcomingSelected
                    if ((_isUpcomingSelected &&
                            dateTime.isAfter(DateTime.now())) ||
                        (!_isUpcomingSelected &&
                            dateTime.isBefore(DateTime.now()))) {
                      appointmentWidgets.add(
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Padding(
                              padding:
                                  const EdgeInsets.only(bottom: 20, top: 10),
                              child: Center(
                                child: Text(
                                  formattedDate,
                                  style: const TextStyle(
                                    color: Color(0xFF153144),
                                    fontSize: 14,
                                    fontFamily: 'Red Hat Display',
                                    fontWeight: FontWeight.w400,
                                  ),
                                ),
                              ),
                            ),
                            AppointmentCard1(
                              doctorName: data['doctorProfile']['name'],
                              selectedTime: data['selectedTime'],
                              callType: data['appointmentType'],
                              appointmentDate: dateTime,
                              doctorData: data['doctorProfile'],
                              docData: data,
                              imageUrl: data['doctorProfile']['image_url'],
                            ),
                          ],
                        ),
                      );
                    }
                  }

                  if (appointmentWidgets.isEmpty) {
                    return const Text('No appointments found.');
                  }

                  return SizedBox(
                    height: MediaQuery.of(context).size.height * 0.649,
                    width: MediaQuery.of(context).size.width * 0.61,
                    child: ListView(
                      children: appointmentWidgets,
                    ),
                  );
                },
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class AppointmentCard1 extends StatelessWidget {
  final String doctorName;
  final String callType;
  final DateTime appointmentDate;
  final String selectedTime;
  final String imageUrl;

  // ignore: prefer_typing_uninitialized_variables
  final doctorData;
  // ignore: prefer_typing_uninitialized_variables
  final docData;

  const AppointmentCard1({
    required this.doctorName,
    required this.callType,
    required this.appointmentDate,
    required this.doctorData,
    required this.selectedTime,
    required this.docData,
    required this.imageUrl,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final isPastAppointment = appointmentDate.isBefore(DateTime.now());

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
      child: Stack(
        children: [
          ClipRRect(
            borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(20),
              bottomLeft: Radius.circular(20),
            ),
            child: Container(
              height: MediaQuery.of(context).size.height * 0.17,
              decoration: const BoxDecoration(
                color: Colors.white,
              ),
              child: Image.network(
                imageUrl,
                fit: BoxFit.cover,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 170, top: 20),
            child: Padding(
              padding: const EdgeInsets.only(left: 15),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    doctorName,
                    style: const TextStyle(
                      color: Color(0xFFD3F36B),
                      fontSize: 22,
                      fontFamily: 'Red Hat Display',
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 8, bottom: 8),
                    child: Text.rich(
                      TextSpan(
                        children: [
                          TextSpan(
                            text: '$callType call - ',
                            style: const TextStyle(
                              color: Color(0xFFCDDFEB),
                              fontSize: 16,
                              fontFamily: 'Red Hat Display',
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          TextSpan(
                            text: isPastAppointment ? 'Completed' : 'Upcoming',
                            style: const TextStyle(
                              color: Color(0xFFD3F36B),
                              fontSize: 12,
                              fontFamily: 'Red Hat Display',
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  Text(
                    selectedTime,
                    style: const TextStyle(
                      color: Color(0xFF899CA8),
                      fontSize: 14,
                      fontFamily: 'Red Hat Display',
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                ],
              ),
            ),
          ),
          Positioned(
            right: 10,
            bottom: 10,
            child: SvgPicture.asset(
              callType == 'Voice' ? 'images/video.svg' : 'images/audio.svg',
              key: ValueKey<String>(callType),
            ),
          ),
        ],
      ),
    );
  }
}
