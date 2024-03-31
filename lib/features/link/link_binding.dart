part of 'link_screen.dart';

class LinkBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut<BaseLinkLocalDataSource>(
      () => LinkLocalDataSource(),
    );

    Get.lazyPut<BaseLinkRepository>(
      () => LinkRepository(
        localDataSource: Get.find<BaseLinkLocalDataSource>(),
      ),
    );

    Get.lazyPut<LinkController>(
      () => LinkController(),
    );
  }
}
