import 'package:flutter/material.dart';
import 'package:flutterzitproject/config/palette.dart';
import 'package:flutterzitproject/screens/screen/bill/07_A_previous_bill_list_screen.dart';


class PayBillStatus extends StatefulWidget {
  @override
  _PaySuccessfullyPageState createState() => _PaySuccessfullyPageState();
}

class _PaySuccessfullyPageState extends State<PayBillStatus> with TickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _lineAnimation;
  bool _showSuccessMessage = false;  // To track when to show the success message

  @override
  void initState() {
    super.initState();

    // Animation controller for the transmission line movement
    _animationController = AnimationController(
      duration: const Duration(seconds: 2), // Set the animation duration
      vsync: this,
    );

    // Animation for line from first tower to second
    _lineAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: _animationController, curve: Curves.easeIn),
    );

    // Start the animation as soon as the page is loaded
    _animationController.forward();

    // Show the success message after the transmission animation completes
    Future.delayed(Duration(seconds: 2), () {
      setState(() {
        _showSuccessMessage = true;  // Show the success message
      });
    });
  }

  @override
  void dispose() {
    _animationController.dispose(); // Dispose the controller when the page is disposed
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Palette.backgroundColor,
      appBar: AppBar(
        backgroundColor: Palette.backgroundColor,
        elevation: 1,
        leading: IconButton(
          icon: Icon(Icons.menu, color: Colors.black),
          onPressed: () {
            // Handle menu action
          },
        ),
        title: Text(
          "Pay Bill Status",
          style: TextStyle(
            color: Palette.iconColor,
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
        actions: [
          IconButton(
            icon: const Icon(Icons.history, color: Colors.black),
            onPressed: () {
              // Navigator.push(context, MaterialPageRoute(builder:  (context) => PaymentHistory));
            },
          ),
        ],
      ),
      body: Center(
        child: Stack(
          children: [
            // First Tower (Start of the transmission)
            Positioned(
              left: 50,
              top: 200,
              child: Icon(
                Icons.power,
                size: 50,
                color:  Color(0xFF2D4F52),
              ),
            ),
            // Second Tower (End of the transmission)
            Positioned(
              right: 50,
              top: 200,
              child: Icon(
                Icons.power,
                size: 50,
                color:  Color(0xFF2D4F52),
              ),
            ),
            // Animated Power Line (Transmission)
            AnimatedBuilder(
              animation: _lineAnimation,
              builder: (context, child) {
                return CustomPaint(
                  size: Size(double.infinity, double.infinity),
                  painter: PowerLinePainter(
                    progress: _lineAnimation.value,
                    startX: 50.0,
                    startY: 200.0,
                    endX: MediaQuery.of(context).size.width - 50,
                    endY: 200.0,
                  ),
                );
              },
            ),
            // Fade-in success message after animation
            Positioned.fill(
              child: Align(
                alignment: Alignment.center,
                child: FadeTransition(
                  opacity: _showSuccessMessage
                      ? _lineAnimation
                      : AlwaysStoppedAnimation(0.0), // Only show message after animation
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.check_circle_outline,
                        size: 100,
                        color: Color(0xFF2D4F52),
                      ),
                      SizedBox(height: 16),
                      Text(
                        'Pay Bill Successful!',
                        style: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                          color:  Color(0xFF2D4F52),
                        ),
                      ),
                      SizedBox(height: 20),
                      ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor:Color(0xFF2D4F52), // Teal color
                          padding: const EdgeInsets.symmetric(vertical: 16.0, horizontal: 100),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8.0),
                          ),
                        ),
                        onPressed: () {
                          // Navigate to the previous screen or another page
                          Navigator.push(context, MaterialPageRoute(builder: (context) => PreviousBillListScreen())); // Go back to the previous screen
                        },
                        child: Text(
                          'Bill History',
                          style: TextStyle(fontSize: 18, color: Colors.white),
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
}

class PowerLinePainter extends CustomPainter {
  final double progress;
  final double startX, startY, endX, endY;

  PowerLinePainter({
    required this.progress,
    required this.startX,
    required this.startY,
    required this.endX,
    required this.endY,
  });

  @override
  void paint(Canvas canvas, Size size) {
    Paint paint = Paint()
      ..color = Colors.orange
      ..strokeWidth = 4.0
      ..style = PaintingStyle.stroke;

    // Draw line from start to end based on progress
    double currentX = startX + (endX - startX) * progress;
    double currentY = startY + (endY - startY) * progress;

    canvas.drawLine(Offset(startX, startY), Offset(currentX, currentY), paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}
