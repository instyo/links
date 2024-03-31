part of 'dashboard_screen.dart';

class DashboardController extends GetxController {
  late TabController tabController;
  final RxInt currentIndex = 0.obs;

  void initTabController({
    required TickerProvider vsync,
  }) {
    tabController = TabController(length: 2, vsync: vsync);
  }

  void changeIndex(int index) {
    currentIndex.value = index;
    tabController.animateTo(index);
  }
}
