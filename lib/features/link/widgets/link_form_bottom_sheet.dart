part of '../link_screen.dart';

class LinkFormBottomSheet extends StatelessWidget {
  final LinkModel? link;
  final LinkController controller;

  const LinkFormBottomSheet({
    super.key,
    this.link,
    required this.controller,
  });

  static Future<void> show({
    LinkModel? link,
  }) async {
    final controller = Get.find<LinkController>();

    if (link != null) {
      controller.setFormData(link);
    }

    return await Get.bottomSheet(
      LinkFormBottomSheet(
        link: link,
        controller: controller,
      ),
      backgroundColor: Colors.white,
    ).then((_) => controller.clearFields());
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      child: SafeArea(
        child: Form(
          key: controller.formKey,
          autovalidateMode: AutovalidateMode.onUserInteraction,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              _buildDragIndicator(context),
              const SizedBox(height: 30),
              _buildDomainIcon(),
              TextFormField(
                controller: controller.urlController,
                decoration: const InputDecoration(
                  hintText: 'Website URL',
                  suffixIcon: Icon(Icons.link),
                ),
                validator: FieldValidators.validateUrl,
              ),
              const SizedBox(height: 20),
              TextFormField(
                controller: controller.customTitleController,
                decoration: const InputDecoration(
                  hintText: 'Title (Optional)',
                  suffixIcon: Icon(Icons.abc_outlined),
                ),
              ),
              const SizedBox(height: 30),
              _buildSaveButton(context)
            ],
          ),
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

  Widget _buildDomainIcon() {
    return Obx(
      () {
        final ShowSection data = controller.showSection.value;

        if (data.iconPath.isEmpty) {
          return const SizedBox();
        }

        return Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Image.asset(
              data.iconPath,
              width: 48,
              height: 48,
            ),
            const SizedBox(height: 10),
            Text(
              data.domainName,
              style: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w500,
              ),
            ),
            Text(
              data.title,
              style: const TextStyle(
                fontSize: 14,
                color: Colors.grey,
              ),
            ),
          ],
        );
      },
    );
  }

  Widget _buildSaveButton(BuildContext context) {
    return ElevatedButton(
      onPressed: () async {
        await controller.submitForm(link: link);
      },
      child: const Text('Save'),
    );
  }
}
