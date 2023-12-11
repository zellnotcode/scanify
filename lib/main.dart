import 'dart:ui';

import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:scanify/constant.dart';
import 'package:scanify/controller/navigation_controller.dart';
import 'package:scanify/screen/home_screen.dart';
import 'package:scanify/screen/info_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await initializeDateFormatting('id_ID', null);
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final NavigationController navigationController =
      Get.put(NavigationController());

  Future<void> _init() async {
    await Future.delayed(const Duration(seconds: 3));

    setState(() {
      navigationController.selectedIndex.value = 3;
    });
  }

  @override
  void initState() {
    super.initState();
    _init();
    navigationController.initialize();
  }

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      home: Scaffold(
        backgroundColor: darkColor,
        body: Obx(() => navigationController.screen.value),
        bottomNavigationBar: Obx(() {
          if (navigationController.screen.value is HomeScreen ||
              navigationController.screen.value is InfoScreen) {
            return SizedBox(
              width: double.maxFinite,
              height: 60,
              child: ClipRect(
                child: BackdropFilter(
                  filter: ImageFilter.blur(sigmaY: 2, sigmaX: 2),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 120),
                    child: GNav(
                      backgroundColor: Colors.transparent,
                      activeColor: Colors.white,
                      tabBackgroundColor: redColor,
                      padding: const EdgeInsets.all(8.0),
                      gap: 8,
                      textStyle: GoogleFonts.overpass(
                          color: Colors.white, fontSize: 16),
                      iconSize: 32,
                      tabs: const [
                        GButton(
                          icon: Icons.home_outlined,
                          iconColor: Colors.white,
                          text: "Home",
                        ),
                        GButton(
                          icon: Icons.info,
                          iconColor: Colors.white,
                          text: "Info",
                        )
                      ],
                      selectedIndex: navigationController.selectedIndex.value,
                      onTabChange: (value) {
                        setState(() {
                          navigationController.selectedIndex.value = value;
                        });
                      },
                    ),
                  ),
                ),
              ),
            );
          } else {
            return const SizedBox();
          }
        }),
        extendBody: true,
      ),
    );
  }
}
