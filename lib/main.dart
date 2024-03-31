import 'package:flutter/material.dart';
import 'package:get/route_manager.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:links/core/utils/constants.dart';
import 'package:links/features/dashboard/dashboard_screen.dart';
import 'package:links/features/empty/empty_screen.dart';
import 'package:links/features/link/data/models/link_model.dart';
import 'package:links/features/link/link_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Hive.initFlutter();
  Hive.registerAdapter(LinkModelAdapter());
  await Hive.openBox<LinkModel>(Constants.linkBoxKey);

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Links',
      getPages: [
        GetPage(
          name: '/',
          page: () => const DashboardScreen(),
          bindings: [
            DashboardBinding(),
            LinkBinding(),
          ],
          children: [
            GetPage(
              name: '/link',
              page: () => const LinkScreen(),
            ),
            GetPage(
              name: '/empty',
              page: () => const EmptyScreen(),
            ),
          ],
        ),
      ],
      initialRoute: '/',
    );
  }
}
