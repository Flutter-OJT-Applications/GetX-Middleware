import 'package:flutter/material.dart';

import 'common_widget.dart';

class TodoTile extends StatelessWidget {
  final Icon icon;
  final int id;
  final String title;
  final String description;
  final List<Widget>? trailing;
  final TodoTileCallback onTap;

  const TodoTile({
    super.key,
    required this.icon,
    required this.id,
    required this.title,
    required this.description,
    this.trailing,
    required this.onTap
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: ()=>onTap(id),
      child: Card(
        color: CommonWidget.appColors.shade200,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15)
          ),
          child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Expanded(child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: icon,
                    ),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(title, style: CommonWidget.secondaryTitleText(),),
                        Text(description),
                      ],
                    )
                  ],
                )),
                Padding(
                  padding: const EdgeInsets.only(right: 8.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: trailing??[],
                  ),
                )
              ],
            )
          ],
        ),
      )),
    );
  }
}
