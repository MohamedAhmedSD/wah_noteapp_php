import 'package:flutter/material.dart';

class CardNote extends StatelessWidget {
  final String title;
  final String content;
  final void Function()? onTap;
  final void Function()? onDelete;
  const CardNote(
      {super.key, required this.title, required this.content, this.onTap, this.onDelete});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Card(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Expanded(
              flex: 1,
              child: Image.asset(
                "assets/logo.jpg",
                width: 100,
                height: 100,
                fit: BoxFit.fill,
              ),
            ),
            Expanded(
              flex: 2,
              child: ListTile(
                title: Text(title),
                subtitle: Text(content),
                trailing:
                    IconButton(onPressed: onDelete, icon: Icon(Icons.delete)),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
