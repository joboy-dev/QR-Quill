import 'package:flutter/material.dart';
import 'package:persistent_bottom_nav_bar/persistent_tab_view.dart';
import 'package:qr_quill/screens/create.dart';
import 'package:qr_quill/screens/create_barcode.dart';
import 'package:qr_quill/screens/create_qrcode.dart';
import 'package:qr_quill/screens/scan_barcode.dart';
import 'package:qr_quill/screens/scan_qrcode.dart';
import 'package:qr_quill/screens/settings.dart';
import 'package:qr_quill/screens/scan.dart';
import 'package:qr_quill/shared/constants.dart';
import 'package:qr_quill/shared/custom_appbar.dart';

class BottomNavBar extends StatefulWidget {
  const BottomNavBar({super.key});

  static const String id = 'navbar';

  @override
  State<BottomNavBar> createState() => _BottomNavBarState();
}

class _BottomNavBarState extends State<BottomNavBar> {
  // controller
  PersistentTabController? _controller;

  // index
  int _index = 0;

  // navbar items
  List<PersistentBottomNavBarItem> _navbarItems() => [
    PersistentBottomNavBarItem(
      icon: const Icon(Icons.qr_code_2_rounded, size: 35.0),
      inactiveIcon: const Icon(Icons.qr_code_2_rounded, size: 30.0),
      title: 'Create',
      activeColorPrimary: kPrimaryColor,
      activeColorSecondary: kPrimaryColor,
      inactiveColorPrimary: kPrimaryColor.withOpacity(0.5),
      inactiveColorSecondary: kPrimaryColor.withOpacity(0.5),
      textStyle: kNavbarTextStyle,
      routeAndNavigatorSettings: RouteAndNavigatorSettings(
        initialRoute: Create.id,
        routes: {
          CreateQRCode.id:(context) => const CreateQRCode(),
          CreateBarcode.id:(context) => const CreateBarcode(),
        }
      )
    ),

    PersistentBottomNavBarItem(
      icon: const Icon(Icons.qr_code_scanner_rounded, size: 35.0),
      inactiveIcon: const Icon(Icons.qr_code_scanner_rounded, size: 30.0),
      title: 'Scan',
      activeColorPrimary: kPrimaryColor,
      activeColorSecondary: kPrimaryColor,
      inactiveColorPrimary: kPrimaryColor.withOpacity(0.5),
      inactiveColorSecondary: kPrimaryColor.withOpacity(0.5),
      textStyle: kNavbarTextStyle,
      routeAndNavigatorSettings: RouteAndNavigatorSettings(
        initialRoute: Scan.id,
        routes: {
          ScanQRCode.id:(context) => const ScanQRCode(),
          ScanBarcode.id:(context) => const ScanBarcode(),
        }
      )
    ),

    PersistentBottomNavBarItem(
      icon: const Icon(Icons.settings, size: 35.0),
      inactiveIcon: const Icon(Icons.settings, size: 30.0),
      title: 'Settings',
      activeColorPrimary: kPrimaryColor,
      activeColorSecondary: kPrimaryColor,
      inactiveColorPrimary: kPrimaryColor.withOpacity(0.5),
      inactiveColorSecondary: kPrimaryColor.withOpacity(0.5),
      textStyle: kNavbarTextStyle,
    ),
  ];

  // app bars
  List<CustomAppbar> _appbars() => [
    const CustomAppbar(title: 'Create', icon: Icons.qr_code_2_rounded),
    const CustomAppbar(title: 'Scan', icon: Icons.qr_code_scanner_rounded),
    const CustomAppbar(title: 'Settings', icon: Icons.settings),
  ];

  // screens
  List<Widget> _screens() => [
    const Create(),
    const Scan(),
    const Settings(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _appbars()[_index],
      body: PersistentTabView(
        context,
        screens: _screens(),
        items: _navbarItems(),
        controller: _controller,
        backgroundColor: kSecondaryColor,
        screenTransitionAnimation: const ScreenTransitionAnimation(
          animateTabTransition: true,
          duration: kAnimationDuration1,
          curve: Curves.fastOutSlowIn
        ),
        navBarHeight: MediaQuery.of(context).size.height * 0.085,
        navBarStyle: NavBarStyle.style11,
        onItemSelected: (value) {
          setState(() {
            _index = value;
          });
        },
      ),
    );
  }
}