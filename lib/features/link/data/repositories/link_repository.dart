part of '../../link_screen.dart';

abstract class BaseLinkRepository {
  Stream<List<LinkModel>> get linksStream;
  int get linksLength;
  Future<void> addLink(LinkModel link);
  Future<void> deleteLink(dynamic key);
  Future<void> updateLink(dynamic key, LinkModel link);
}

class LinkRepository implements BaseLinkRepository {
  final BaseLinkLocalDataSource localDataSource;

  const LinkRepository({
    required this.localDataSource,
  });

  @override
  Future<void> addLink(LinkModel link) async {
    await localDataSource.addLink(link);
  }

  @override
  Future<void> deleteLink(dynamic key) async {
    await localDataSource.deleteLink(key);
  }

  @override
  Future<void> updateLink(dynamic key, LinkModel link) async {
    await localDataSource.updateLink(key, link);
  }

  @override
  Stream<List<LinkModel>> get linksStream => localDataSource.linksStream;

  @override
  int get linksLength => localDataSource.linksLength;
}
