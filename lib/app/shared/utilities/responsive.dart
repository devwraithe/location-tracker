import 'package:flutter_screenutil/flutter_screenutil.dart';

class Responsive {
  static bool isMobile = ScreenUtil().screenWidth < 600;

  static double headlineMedium = isMobile ? 22.sp : 12.sp;
  static double bodyLarge = isMobile ? 16.sp : 8.sp;
}
