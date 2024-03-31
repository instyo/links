part of '../../link_screen.dart';

abstract class BaseLinkLocalDataSource {
  Stream<List<LinkModel>> get linksStream;
  int get linksLength;
  Future<void> deleteLink(dynamic key);
  Future<void> addLink(LinkModel link);
  Future<void> updateLink(dynamic key, LinkModel link);
}

class LinkLocalDataSource implements BaseLinkLocalDataSource {
  final box = Hive.box<LinkModel>(Constants.linkBoxKey);

  @override
  Future<void> addLink(LinkModel link) async {
    await box.add(link);
  }

  @override
  Future<void> deleteLink(dynamic key) async {
    await box.delete(key);
  }

  @override
  Future<void> updateLink(dynamic key, LinkModel link) async {
    await box.put(key, link);
  }

  @override
  Stream<List<LinkModel>> get linksStream {
    final controller = StreamController<List<LinkModel>>()
      ..add(box.values.toList());

    box.listenable().addListener(() {
      controller.add(box.values.toList());
    });

    return controller.stream;
  }

  @override
  int get linksLength => box.values.length;
}
