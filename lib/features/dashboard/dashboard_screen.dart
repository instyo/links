import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:links/features/empty/empty_screen.dart';
import 'package:links/features/link/link_screen.dart';

part 'dashboard_binding.dart';
part 'dashboard_controller.dart';
part 'widgets/bottom_navigation_bar.dart';

class DashboardScreen extends StatefulWidget {
  const DashboardScreen({super.key});

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen>
    with TickerProviderStateMixin {
  final DashboardController controller = Get.find<DashboardController>();

  @override
  void initState() {
    super.initState();
    controller.initTabController(vsync: this);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: TabBarView(
        controller: controller.tabController,
        physics: const NeverScrollableScrollPhysics(),
        children: const [
          EmptyScreen(),
          LinkScreen(),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          LinkFormBottomSheet.show();
        },
        child: const Icon(Icons.add),
      ),
      bottomNavigationBar: const BottomNavBar(),
    );
  }
}
