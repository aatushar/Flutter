// home_controller.dart
import 'dart:async';
import 'package:get/get.dart';
import 'package:intl/intl.dart';


class HomeController extends GetxController {
  // Observables for countdown
  RxInt daysLeft = 0.obs;
  RxInt hoursLeft = 0.obs;
  RxInt minutesLeft = 0.obs;
  RxInt secondsLeft = 0.obs;

  // You could also store the current time or other data you want to show
  RxString currentTime = ''.obs;
  RxString currentDate = ''.obs;

  late Timer _timer;

  // Set the target date/time for Ramadan (Example: 2025-03-01 00:00:00)
  final DateTime ramadanStart = DateTime(2025, 3, 1);

  @override
  void onInit() {
    super.onInit();
    _initCountdown();
    _initTime();
  }

  void _initCountdown() {
    _updateCountdown(); // update immediately
    _timer = Timer.periodic(Duration(seconds: 1), (timer) {
      _updateCountdown();
    });
  }

  void _updateCountdown() {
    final now = DateTime.now();
    final difference = ramadanStart.difference(now);

    if (difference.isNegative) {
      // Ramadan has already started or passed
      daysLeft.value = 0;
      hoursLeft.value = 0;
      minutesLeft.value = 0;
      secondsLeft.value = 0;
      _timer.cancel(); // optional: stop timer if event is in the past
      return;
    }

    daysLeft.value = difference.inDays;
    hoursLeft.value = difference.inHours % 24;
    minutesLeft.value = difference.inMinutes % 60;
    secondsLeft.value = difference.inSeconds % 60;
  }

  void _initTime() {
    // Update time every second
    Timer.periodic(Duration(seconds: 1), (timer) {
      final now = DateTime.now();
      currentTime.value = DateFormat('hh:mm:ss a').format(now);
      // Example: 24 Sha’ban 1446 could be dynamically calculated or retrieved
      // For simplicity, just store the Gregorian date:
      currentDate.value = DateFormat('dd MMMM yyyy').format(now);
    });
  }

  @override
  void onClose() {
    _timer.cancel();
    super.onClose();
  }
}
