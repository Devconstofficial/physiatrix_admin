import 'package:flutter/material.dart';
import 'package:physiatrix_admin/Screens/appointment_screen.dart';
import 'package:physiatrix_admin/Screens/dashboard.dart';
import 'package:physiatrix_admin/Screens/doctors_screen.dart';
import 'package:physiatrix_admin/Screens/login_screen.dart';
import 'package:physiatrix_admin/Screens/patient_screen.dart';
import 'package:flutter_svg/svg.dart';

class SideBar extends StatefulWidget {
  const SideBar({Key? key}) : super(key: key);


  @override
  State<SideBar> createState() => _SideBarState();
}

class _SideBarState extends State<SideBar> {
  List<bool> isHovered = List.generate(4, (index) => false);
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Column(
          mainAxisAlignment: MainAxisAlignment.start,

          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              height: MediaQuery.of(context).size.height,
              width: MediaQuery.of(context).size.width * 0.176,
              decoration: const BoxDecoration(
                color: Color(0xFFD3F36B),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey,
                    offset: Offset(4, 0),
                    blurRadius: 5,
                    spreadRadius: 0,
                  ),
                ],
              ),
            ),
          ],
        ),
        Padding(
          padding: const EdgeInsets.only(top: 44, left: 60),
          child: Container(
            width: MediaQuery.of(context).size.width * 0.09,
            height: MediaQuery.of(context).size.height * 0.17,
            decoration: const BoxDecoration(
              color: Colors.white,
              image: DecorationImage(
                image: AssetImage('images/logo.png'),
                fit: BoxFit.fill,
              ),
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(left: 18.5, top: 233),
          child: Column(
            children: [
              for (int i = 0; i < 4; i++)
                InkWell(
                  onTap: () {
                    navigateToScreen(menuNames[i]);
                  },
                  child: Column(
                    children: [
                      MouseRegion(
                        onEnter: (_) {
                          setState(() {
                            isHovered[i] = true;
                          });
                        },
                        onExit: (_) {
                          setState(() {
                            isHovered[i] = false;
                          });
                        },
                        child: Container(
                          width: MediaQuery.of(context).size.width * 0.15,
                          height: MediaQuery.of(context).size.height * 0.06,
                          decoration: ShapeDecoration(
                            color: isHovered[i]
                                ? Colors.white
                                : const Color(0xFFD3F36B),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                          ),
                          child: Row(
                            children: [
                              Padding(
                                padding:
                                    const EdgeInsets.only(left: 20, right: 15),
                                child: SvgPicture.asset(
                                  'images/${iconNames[i]}.svg',
                                  // ignore: deprecated_member_use
                                  color: isHovered[i]
                                      ? const Color(0xFFD3F36B)
                                      : Colors.white,
                                ),
                              ),
                              SizedBox(
                                width:
                                    MediaQuery.of(context).size.width * 0.1064,
                                child: Text(
                                  menuNames[i],
                                  style: TextStyle(
                                    color: isHovered[i]
                                        ? const Color(0xFFD3F36B)
                                        : Colors.white,
                                    fontSize: i == 3 ? 24 : 24,
                                    fontFamily: 'Red Hat Display',
                                    fontWeight: FontWeight.w600,
                                    letterSpacing: 0.38,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      SizedBox(
                        height: MediaQuery.of(context).size.height * 0.03,
                      ),
                    ],
                  ),
                ),
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.24,
              ),
              InkWell(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const LoginScreen()),
                  );
                },
                child: Center(
                  child: Row(
                    children: [
                      SvgPicture.asset('images/Logout.svg'),
                      SizedBox(
                        width: MediaQuery.of(context).size.width * 0.01,
                      ),
                      const Text(
                        'Sign Out',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 20,
                          fontFamily: 'Red Hat Display',
                          fontWeight: FontWeight.w600,
                          height: 0,
                          letterSpacing: 0.38,
                        ),
                      )
                    ],
                  ),
                ),
              )
            ],
          ),
        ),
      ],
    );
  }

  final List<String> iconNames = [
    'doc',
    'patient',
    'dash1',
    'appointment',
    // 'setting',
  ];

  final List<String> menuNames = [
    'Dashboard',
    'Patients',
    'Doctors',
    'Appointments',
    // 'Settings',
  ];

  void navigateToScreen(String screenName) {
    final Map<String, WidgetBuilder> routes = {
      'Dashboard': (context) => const Dashboard(),
      'Patients': (context) => const PatientsScreen(),
      'Doctors': (context) => const DoctorsScreen(),
      'Appointments': (context) => const AppointmentsScreen(),
      // 'Settings': (context) => const SettingsScreen(),
    };

    if (routes.containsKey(screenName)) {
      Navigator.push(context, MaterialPageRoute(builder: routes[screenName]!));
    }
  }
}
