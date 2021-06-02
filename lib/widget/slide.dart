import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';

enum SlidableAction { archive, share, more, delete }

class SlidableWidget<T> extends StatelessWidget {
  final Widget child;
  final Function(SlidableAction action) onDismissed;

  const SlidableWidget({
    @required this.child,
    @required this.onDismissed,
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) => Slidable(
        actionPane: SlidableDrawerActionPane(),
        child: child,
        secondaryActions: <Widget>[
          IconSlideAction(
            caption: 'Call',
            color: Colors.black45,
            icon: Icons.call,
            onTap: () => onDismissed(SlidableAction.more),
          ),
          IconSlideAction(
            caption: 'Chat',
            color: Colors.blue,
            icon: Icons.chat_bubble_outline,
            onTap: () => onDismissed(SlidableAction.delete),
          ),
        ],
      );
}
