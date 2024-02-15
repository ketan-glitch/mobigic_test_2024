import 'package:flutter/material.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  const CustomAppBar({
    Key? key,
    this.title,
    this.actions,
    this.leading,
    this.backButtonColor,
    this.centerTitle = false,
    this.bgColor = Colors.transparent,
  }) : super(key: key);

  final String? title;
  final List<Widget>? actions;
  final Widget? leading;
  final Color? backButtonColor;
  final Color? bgColor;
  final bool centerTitle;

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: bgColor,
      elevation: 0,
      centerTitle: centerTitle,
      leading: Navigator.canPop(context)
          ? Builder(builder: (context) {
              if (Navigator.canPop(context)) {
                if (leading != null) {
                  return leading!;
                }
                return BackButton(
                  color: backButtonColor ?? Colors.white,
                );
              }
              return const SizedBox.shrink();
            })
          : null,
      title: Builder(builder: (context) {
        if (title != null) {
          return Text(
            title!,
            style: Theme.of(context).textTheme.displayLarge?.copyWith(fontSize: 18.0, color: Colors.black),
          );
        } else {
          return const SizedBox.shrink();
        }
      }),
      actions: actions,
    );
  }
}
