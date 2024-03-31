part of 'link_screen.dart';

typedef ShowSection = ({String iconPath, String domainName, String title});

class LinkController extends GetxController {
  final BaseLinkRepository linkRepository = Get.find<BaseLinkRepository>();
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  final TextEditingController customTitleController = TextEditingController();
  final TextEditingController urlController = TextEditingController();
  final Rx<ShowSection> showSection =
      (domainName: "", iconPath: "", title: "").obs;

  @override
  void onReady() {
    super.onReady();
    listenToUrlController();
  }

  void listenToUrlController() {
    urlController.addListener(
      () {
        final String url = urlController.text.toLowerCase();
        final Uri uri = Uri.parse(url);

        final String domain = uri.host;
        final String title = uri.path.isEmpty
            ? uri.host.getDomainName()
            : uri.path.getTitleFromPath();

        if (url.isEmpty) {
          showSection.value = ((
            domainName: "",
            iconPath: "",
            title: "",
          ));
          return;
        }

        if (domain.contains('facebook')) {
          showSection.value = ((
            domainName: domain,
            iconPath: Assets.facebookIcon,
            title: title,
          ));
          return;
        }

        if (domain.contains('tiktok')) {
          showSection.value = ((
            domainName: domain,
            iconPath: Assets.tiktokIcon,
            title: title,
          ));
          return;
        }

        if (domain.contains('instagram')) {
          showSection.value = ((
            domainName: domain,
            iconPath: Assets.instagramIcon,
            title: title,
          ));
          return;
        }

        showSection.value = ((
          domainName: domain,
          iconPath: Assets.webIcon,
          title: title,
        ));
      },
    );
  }

  void clearFields() {
    customTitleController.clear();
    urlController.clear();
    showSection.value = (domainName: "", iconPath: "", title: "");
  }

  void setFormData(LinkModel link) {
    customTitleController.text = link.customTitle;
    urlController.text = link.url;
  }

  bool get isFormValid => formKey.currentState?.validate() ?? false;

  LinkModel get linkData => LinkModel(
      url: urlController.text,
      title: showSection.value.title,
      icon: showSection.value.iconPath,
      customTitle: customTitleController.text);

  Stream<List<LinkModel>> get links$ => linkRepository.linksStream;

  Future<void> addLink() async {
    try {
      await linkRepository.addLink(linkData);
    } catch (e) {
      showSnackbar('Error occurred while adding link. Please try again');
    }
  }

  Future<void> updateLink(dynamic key) async {
    try {
      await linkRepository.updateLink(key, linkData);
    } catch (e) {
      showSnackbar('Error occurred while updating link. Please try again');
    }
  }

  Future<void> deleteLink(dynamic key) async {
    try {
      await linkRepository.deleteLink(key);
    } catch (e) {
      showSnackbar('Error occurred while deleting link. Please try again');
    }
  }

  Future<void> submitForm({
    LinkModel? link,
  }) async {
    try {
      if (!isFormValid) {
        return;
      }

      final bool isUpdate = link != null;
      final int linksLength = linkRepository.linksLength;

      if (!isUpdate && linksLength >= 3) {
        showSnackbar('You can only add up to 3 links');
        return;
      }

      !isUpdate ? await addLink() : await updateLink(link.key);

      Get.back();
    } catch (e) {
      showSnackbar(
        'Error occurred while submitting the form. Please try again',
      );
    }
  }

  void showSnackbar(String message) {
    Get.showSnackbar(
      GetSnackBar(
        message: message,
        isDismissible: true,
        duration: const Duration(seconds: 3),
      ),
    );
  }
}
