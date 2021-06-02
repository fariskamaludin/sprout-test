import 'package:flutter/material.dart';

class CustomTile extends StatelessWidget {
  final Widget leading;
  final Widget title;
  final Widget subtitle;
  final Widget icon;
  final Widget trailing;
  final Widget time;
  final EdgeInsets margin;
  final bool mini;
  final GestureTapCallback onTap;
  final GestureLongPressCallback onLongPress;
  final BorderRadius borderRadius;
  final bool subSpaceBetween;

  CustomTile(
      {@required this.leading,
      @required this.title,
      @required this.subtitle,
      this.subSpaceBetween = false,
      this.icon,
      this.trailing,
      this.time,
      this.margin = const EdgeInsets.all(0),
      this.mini = true,
      this.onTap,
      this.onLongPress,
      this.borderRadius});

  @override
  Widget build(BuildContext context) {
    return Material(
      // color: Theme.of(context).backgroundColor,
      child: InkWell(
        onTap: onTap,
        onLongPress: onLongPress,
        child: Row(
          children: <Widget>[
            leading,
            Expanded(
              child: Container(
                margin: EdgeInsets.only(left: mini ? 10 : 15),
                padding: EdgeInsets.symmetric(vertical: mini ? 10 : 11),
                child: Padding(
                  padding: const EdgeInsets.only(left: 10),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          title,
                          time ?? SizedBox(),
                        ],
                      ),
                      SizedBox(height: 6),
                      Row(
                        mainAxisAlignment: subSpaceBetween
                            ? MainAxisAlignment.spaceBetween
                            : MainAxisAlignment.start,
                        children: <Widget>[
                          Flexible(fit: FlexFit.tight, child: subtitle),
                          // icon ?? SizedBox(),
                        ],
                      )
                    ],
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(right: 10),
              child: icon ?? SizedBox(),
            ),
            InkWell(
              onTap: () {},
              onLongPress: () {},
              child: trailing ?? SizedBox(),
            ),
            SizedBox(width: 10)
          ],
        ),
      ),
    );
  }
}
