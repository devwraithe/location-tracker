import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:location_tracker/app/app.dart';
import 'package:location_tracker/app/shared/services/di_service.dart' as di;

void main() {
  testWidgets('Should initialize the app', (tester) async {
    TestWidgetsFlutterBinding.ensureInitialized();

    di.init();

    await ScreenUtil.ensureScreenSize();

    await tester.pumpWidget(
      const LocationTracker(),
    );
  });
}
