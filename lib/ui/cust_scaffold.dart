import 'package:flutter/material.dart';

class CustScaffold extends StatelessWidget {
  final Widget child;
  final Widget? leading;
  final String? title;
  final List<Widget>? actions;
  final bool showBackButton;

  const CustScaffold({
    super.key,
    required this.child,
    this.leading,
    this.title,
    this.actions,
    this.showBackButton = true,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.primary,
        leading: leading ??
            (showBackButton && Navigator.of(context).canPop()
                ? IconButton(
                    icon: const Icon(Icons.arrow_back),
                    onPressed: () => Navigator.of(context).pop(),
                  )
                : null),
        automaticallyImplyLeading: false,
        centerTitle: true,
        title: Text(
          title ?? 'Title',
          style: Theme.of(context).textTheme.titleLarge,
        ),
        actions: actions,
      ),
      body: Container(
        color: Theme.of(context).colorScheme.surface,
        child: SafeArea(
          bottom: false,
          child: child,
        ),
      ),
    );
  }
}
