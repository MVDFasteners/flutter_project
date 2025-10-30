import 'package:flatten/controllers/auth/login_controller.dart';
import 'package:flatten/myPages/TripListScreen.dart';
import 'package:flatten/views/dashboard/attendance.dart';
import 'package:flatten/views/layouts/layout.dart';
import 'package:flutter/material.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_instance/get_instance.dart';

Color lighten(Color color, double factor) {
  assert(factor >= 0 && factor <= 1);
  int r = color.red + ((255 - color.red) * factor).round();
  int g = color.green + ((255 - color.green) * factor).round();
  int b = color.blue + ((255 - color.blue) * factor).round();
  return Color.fromARGB(color.alpha, r, g, b);
}

class CompanyHomePage extends StatefulWidget {
  const CompanyHomePage({super.key});

  @override
  State<CompanyHomePage> createState() => _CompanyHomePageState();
}

class _CompanyHomePageState extends State<CompanyHomePage>
    with SingleTickerProviderStateMixin {
  late LoginController controller;

  // late AttendanceController attendanceController;
  // late TripListController tripListController;

  late AnimationController _controller;
  late Animation<double> _fadeAnimation;
  late Animation<Offset> _slideAnimation;

  final baseTeal = const Color(0xff006784);

  final List<Map<String, dynamic>> buttonData = [
    {
      'label': 'Attendance',
      'imageAsset': 'assets/images/logo/attendance.jpg',
      'onTap': 'attendance',
    },
    {
      'label': 'Trip List',
      'imageAsset': 'assets/images/logo/location.jpg',
      'onTap': 'taskList',
    },
  ];

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(milliseconds: 1200),
      vsync: this,
    );

    _fadeAnimation = Tween<double>(
      begin: 0.0,
      end: 1.0,
    ).animate(CurvedAnimation(parent: _controller, curve: Curves.easeOut));
    _slideAnimation = Tween<Offset>(
      begin: const Offset(0, 0.3),
      end: Offset.zero,
    ).animate(CurvedAnimation(parent: _controller, curve: Curves.easeOut));
    _controller.forward();
    controller = Get.put(LoginController());
    // attendanceController = Get.put(AttendanceController(this));
    // tripListController = Get.put(TripListController());
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  // void handleAttendance(BuildContext context) {
  //   Navigator.push(
  //     context,
  //     MaterialPageRoute(builder: (context) => const AttendancePage()),
  //   );
  // }

  void handleTaskList(BuildContext context) {
    ScaffoldMessenger.of(
      context,
    ).showSnackBar(const SnackBar(content: Text('Task List button pressed')));
  }

  Widget _3dCircle({
    required double width,
    required double height,
    required Color color,
    required double blur,
    required Offset offset,
    double gradientStrength = 0.45,
    double highlightStrength = 0.38,
    double opacity = 1.0,
  }) {
    return Container(
      width: width,
      height: height,

      decoration: BoxDecoration(
        shape: BoxShape.circle,
        gradient: RadialGradient(
          colors: [
            Colors.white.withOpacity(highlightStrength),
            color.withOpacity(opacity * gradientStrength),
            color.withOpacity(opacity * 0.74),
            color.withOpacity(opacity),
          ],
          stops: const [0.25, 0.6, 0.79, 1.0],
        ),
        boxShadow: [
          BoxShadow(
            color: color.withOpacity(0.16),
            blurRadius: blur,
            offset: offset,
            spreadRadius: 2,
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final double screenWidth = MediaQuery.of(context).size.width;
    final double screenHeight = MediaQuery.of(context).size.height;
    final double logoSize = screenWidth * 0.45;
    final double cardSize = screenWidth * 0.36;

    return Layout(
      scrollNeed: false,
      child: Expanded(
        child: Stack(
          children: [
            Container(color: lighten(baseTeal, 0.99)),
            Positioned(
              top: -screenWidth * 0.28,
              left: -screenWidth * 0.21,
              child: _3dCircle(
                width: screenWidth * 0.86,
                height: screenWidth * 0.86,
                color: lighten(baseTeal, 0.77),
                blur: 44,
                offset: const Offset(12, 28),
                highlightStrength: 0.51,
                gradientStrength: 0.31,
                opacity: 0.72,
              ),
            ),
            // Top right (smaller)
            Positioned(
              top: screenWidth * 0.16,
              right: screenWidth * 0.09,
              child: _3dCircle(
                width: screenWidth * 0.31,
                height: screenWidth * 0.31,
                color: lighten(baseTeal, 0.89),
                blur: 34,
                offset: const Offset(-16, 10),
                highlightStrength: 0.58,
                gradientStrength: 0.21,
                opacity: 0.64,
              ),
            ),
            // Center right (medium)
            Positioned(
              top: screenHeight * 0.38,
              right: screenWidth * 0.27,
              child: _3dCircle(
                width: screenWidth * 0.36,
                height: screenWidth * 0.36,
                color: lighten(baseTeal, 0.89),
                blur: 19,
                offset: const Offset(2, 10),
                highlightStrength: 0.51,
                gradientStrength: 0.31,
                opacity: 0.50,
              ),
            ),
            // Center ellipse band
            Positioned(
              left: screenWidth * 0.21,
              top: screenHeight * 0.47,
              child: Transform.rotate(
                angle: -0.44,
                child: Container(
                  width: screenWidth * 0.86,
                  height: screenWidth * 0.15,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(screenWidth * 0.21),
                    gradient: LinearGradient(
                      begin: Alignment.bottomLeft,
                      end: Alignment.topRight,
                      colors: [
                        lighten(baseTeal, 0.835).withOpacity(0.25),
                        lighten(baseTeal, 0.995).withOpacity(0.16),
                        Colors.transparent,
                      ],
                    ),
                  ),
                ),
              ),
            ),
            // Middle, slightly left (small)
            Positioned(
              top: screenHeight * 0.63,
              left: screenWidth * 0.21,
              child: _3dCircle(
                width: screenWidth * 0.19,
                height: screenWidth * 0.19,
                color: lighten(baseTeal, 0.73),
                blur: 19,
                offset: const Offset(4, 15),
                highlightStrength: 0.68,
                gradientStrength: 0.225,
                opacity: 0.65,
              ),
            ),
            // Bottom left (medium)
            Positioned(
              bottom: -screenWidth * 0.15,
              left: -screenWidth * 0.08,
              child: _3dCircle(
                width: screenWidth * 0.33,
                height: screenWidth * 0.33,
                color: lighten(baseTeal, 0.79),
                blur: 18,
                offset: const Offset(8, 10),
                highlightStrength: 0.73,
                gradientStrength: 0.15,
                opacity: 0.82,
              ),
            ),
            // Small bottom right
            Positioned(
              bottom: screenWidth * 0.15,
              right: screenWidth * 0.18,
              child: _3dCircle(
                width: screenWidth * 0.13,
                height: screenWidth * 0.13,
                color: lighten(baseTeal, 0.95),
                blur: 12,
                offset: const Offset(0, 2),
                highlightStrength: 0.72,
                gradientStrength: 0.18,
                opacity: 0.55,
              ),
            ),
            // Center behind logo (main subtle 3D circle)
            Positioned(
              top: screenHeight * 0.13,
              left: (screenWidth - logoSize) / 2 - (screenWidth * 0.06),
              child: _3dCircle(
                width: logoSize * 1.25,
                height: logoSize * 1.1,
                color: lighten(baseTeal, 0.92),
                blur: 22,
                offset: const Offset(0, 18),
                highlightStrength: 0.58,
                gradientStrength: 0.19,
                opacity: 0.44,
              ),
            ),
            SafeArea(
              child: FadeTransition(
                opacity: _fadeAnimation,
                child: SlideTransition(
                  position: _slideAnimation,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(top: 16),
                        child: Align(
                          alignment: Alignment.topCenter,
                          child: TweenAnimationBuilder<double>(
                            duration: const Duration(milliseconds: 800),
                            tween: Tween(begin: 0.0, end: 1.0),
                            builder: (context, value, child) => Transform.scale(
                              scale: value,
                              child: SizedBox(
                                width: logoSize,
                                height: logoSize,
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(50),
                                  child: Padding(
                                    padding: const EdgeInsets.all(0),
                                    child: Image.asset(
                                      'assets/images/logo/company_logo.png',
                                      fit: BoxFit.contain,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(bottom: 32.0),
                        child: Wrap(
                          alignment: WrapAlignment.center,
                          spacing: 18,
                          runSpacing: 18,
                          children: buttonData.map((data) {
                            return _buildRoundedCardButton(
                              label: data['label'],
                              imageAsset: data['imageAsset'],
                              onTap: () {
                                if (data['onTap'] == 'attendance') {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute<void>(
                                      builder: (context) => const Attendance(),
                                    ),
                                  );
                                  // handleAttendance(context);
                                } else if (data['onTap'] == 'taskList') {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute<void>(
                                      builder: (context) => TripListScreen(),
                                    ),
                                  );
                                }
                              },
                              size: cardSize,
                            );
                          }).toList(),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildRoundedCardButton({
    required String label,
    required String imageAsset,
    required VoidCallback onTap,
    required double size,
  }) {
    bool _isPressed = false;

    return StatefulBuilder(
      builder: (context, setInnerState) => GestureDetector(
        onTapDown: (_) => setInnerState(() => _isPressed = true),
        onTapUp: (_) => setInnerState(() => _isPressed = false),
        onTapCancel: () => setInnerState(() => _isPressed = false),
        onTap: onTap,
        child: AnimatedScale(
          scale: _isPressed ? 0.97 : 1.0,
          duration: const Duration(milliseconds: 80),
          child: Container(
            width: size,
            height: size + 23,
            margin: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              gradient: const LinearGradient(
                colors: [Color(0xFFFDE9B5), Color(0xFFFFF6E0)],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
              borderRadius: BorderRadius.circular(26),
              boxShadow: [
                BoxShadow(
                  color: Colors.amber.withOpacity(0.19),
                  blurRadius: 30,
                  spreadRadius: 4,
                  offset: const Offset(0, 10),
                ),
              ],
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.asset(
                  imageAsset,
                  width: size * 0.58,
                  height: size * 0.58,
                  errorBuilder: (context, error, stackTrace) => const Icon(
                    Icons.image_not_supported,
                    size: 45,
                    color: Color(0xff795900),
                  ),
                ),
                SizedBox(height: size * 0.09),
                Text(
                  label,
                  style: TextStyle(
                    fontSize: size * 0.17,
                    fontWeight: FontWeight.w700,
                    color: const Color(0xff795900),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
