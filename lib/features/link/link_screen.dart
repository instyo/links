import 'dart:async';
import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:links/core/extensions/string_extension.dart';
import 'package:links/core/utils/assets.dart';
import 'package:links/core/utils/constants.dart';
import 'package:links/core/utils/validators.dart';
import 'package:links/features/link/data/models/link_model.dart';

part 'link_controller.dart';
part 'link_binding.dart';

part 'data/data_sources/link_local_data_source.dart';
part 'data/repositories/link_repository.dart';
part 'widgets/link_form_bottom_sheet.dart';
part 'widgets/link_item.dart';
part 'widgets/link_action_sheet.dart';

class LinkScreen extends StatelessWidget {
  const LinkScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<LinkController>();

    return Scaffold(
      appBar: AppBar(
        title: const Text("Links"),
      ),
      body: StreamBuilder(
        stream: controller.links$,
        builder: (context, snapshot) {
          final List<LinkModel> links = snapshot.data ?? [];
      
          if (links.isEmpty) {
            return const Center(
              child: Text("Link is empty"),
            );
          }
      
          return ListView.builder(
            itemCount: links.length,
            itemBuilder: (context, index) {
              final LinkModel link = links[index];
      
              return LinkItem(
                item: link,
                onTap: () {
                  LinkActionSheet.show(link: link);
                },
              );
            },
          );
        },
      ),
    );
  }
}
