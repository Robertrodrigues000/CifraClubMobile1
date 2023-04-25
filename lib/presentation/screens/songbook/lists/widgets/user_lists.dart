// coverage:ignore-file
import 'package:cifraclub/domain/songbook/models/songbook.dart';
import 'package:cifraclub/presentation/screens/songbook/lists/widgets/list_image_group.dart';
import 'package:flutter/material.dart';

class UserLists extends StatelessWidget {
  const UserLists({super.key, required this.lists});
  final List<Songbook> lists;

  @override
  Widget build(BuildContext context) {
    return SliverList(
      delegate: SliverChildBuilderDelegate(
        (context, index) {
          return ListTile(
            leading: const ListImageGroup(images: [
              "https://akamai.sscdn.co/letras/250x250/fotos/6/d/6/f/6d6fa97176b534f832b9befb757f0072.jpg",
              "https://akamai.sscdn.co/letras/250x250/fotos/a/f/2/a/af2afaf58a0326b09939c0372ea3e55b.jpg",
              "https://akamai.sscdn.co/letras/250x250/fotos/a/3/7/7/a37711ead0b38bea3314a9b9ae98b332.jpg",
              "https://akamai.sscdn.co/letras/250x250/fotos/f/0/6/9/f0693498fd636b0d0da8582912e2f4e8.jpg"
            ]),
            title: Text(lists[index].name),
          );
        },
        childCount: lists.length,
      ),
    );
  }
}
