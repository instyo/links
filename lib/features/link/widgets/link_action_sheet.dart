part of '../link_screen.dart';

class LinkActionSheet extends StatelessWidget {
  final LinkModel link;

  const LinkActionSheet({
    super.key,
    required this.link,
  });

  static Future<void> show({
    required LinkModel link,
  }) async {
    return await Get.bottomSheet(
      LinkActionSheet(link: link),
      backgroundColor: Colors.white,
    );
  }

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<LinkController>();

    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            _buildDragIndicator(context),
            ListTile(
              contentPadding: EdgeInsets.zero,
              leading: const Icon(Icons.edit),
              title: const Text("Edit"),
              onTap: () {
                Get.back();
                LinkFormBottomSheet.show(link: link);
              },
            ),
            ListTile(
              contentPadding: EdgeInsets.zero,
              leading: const Icon(Icons.delete),
              title: const Text("Delete"),
              onTap: () {
                Get.back();
                controller.deleteLink(link.key);
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildDragIndicator(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width * 0.25,
      height: 10,
      decoration: BoxDecoration(
        color: Colors.grey.shade400,
        borderRadius: BorderRadius.circular(10),
      ),
    );
  }
}
