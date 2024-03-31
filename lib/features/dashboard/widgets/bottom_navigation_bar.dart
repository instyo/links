part of '../dashboard_screen.dart';

class BottomNavBar extends StatelessWidget {
  const BottomNavBar({super.key});

  @override
  Widget build(BuildContext context) {
    final DashboardController controller = Get.find<DashboardController>();
    return Container(
      decoration: BoxDecoration(
        border: Border(
          top: BorderSide(
            color: Colors.grey.shade200,
          ),
        ),
      ),
      child: Obx(
        () {
          final int currentIndex = controller.currentIndex.value;

          return BottomNavigationBar(
            showUnselectedLabels: true,
            currentIndex: currentIndex,
            onTap: controller.changeIndex,
            items: const [
              BottomNavigationBarItem(
                icon: Icon(Icons.home_filled),
                label: 'Empty',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.link_rounded),
                label: 'Links',
              ),
            ],
          );
        },
      ),
    );
  }
}
