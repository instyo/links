part of '../link_screen.dart';

class LinkItem extends StatelessWidget {
  final LinkModel item;
  final VoidCallback onTap;

  const LinkItem({
    super.key,
    required this.item,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: onTap,
      leading: Image.asset(
        item.icon,
        width: 30,
        height: 30,
      ),
      title: Text(item.mainTitle),
      subtitle: Text(item.url),
      trailing: const Icon(Icons.chevron_right),
    );
  }
}
