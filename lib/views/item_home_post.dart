import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:http_todo_service/models/post_model.dart';

class ItemOfHome extends StatelessWidget {
  const ItemOfHome({Key? key, required this.post, this.update, this.delete}) : super(key: key);

  final Post post;
  final void Function(BuildContext)? update;
  final void Function(BuildContext)? delete;

  @override
  Widget build(BuildContext context) {
    return Slidable(
      child: Padding(
        padding: const EdgeInsets.only(left: 20, right: 20, top: 20),
        child: SizedBox(
          width: MediaQuery.of(context).size.width,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                post.title!.toUpperCase(),
                style: const TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 5),
              Text(post.body!),
            ],
          ),
        ),
      ),
      startActionPane: ActionPane(
        extentRatio: 1 / 4,
        motion: const ScrollMotion(),
        children: [
          SlidableAction(
            label: 'Update',
            backgroundColor: Colors.indigo,
            icon: Icons.edit,
            onPressed: update,
          ),
        ],
      ),
      endActionPane: ActionPane(
        extentRatio: 1 / 4,
        motion: const ScrollMotion(),
        children: [
          SlidableAction(
            label: 'Delete',
            backgroundColor: Colors.red,
            icon: Icons.delete,
            onPressed: delete,
          ),
        ],
      ),
    );
  }
}
