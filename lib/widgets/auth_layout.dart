import 'package:flutter/material.dart';

import 'package:fastdx_app/helpers/helpers.dart';

class AuthLayout extends StatefulWidget {
  final List<Widget> children;
  final String title;
  final String description;
  final Widget? headerLabel;
  final bool? showBackButton;
  final GlobalKey<FormState> formKey;

  const AuthLayout({
    required this.formKey,
    required this.children,
    required this.title,
    required this.description,
    this.showBackButton = false,
    this.headerLabel,
    super.key,
  });

  @override
  State<AuthLayout> createState() => _AuthLayoutState();
}

class _AuthLayoutState extends State<AuthLayout> {
  bool _showCollapsedTitle = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.secondary,
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            pinned: true,
            automaticallyImplyLeading: false,
            backgroundColor: Theme.of(context).colorScheme.secondary,
            foregroundColor: Theme.of(context).colorScheme.onSecondary,
            expandedHeight: Utils.getDeviceHeight(context) * 0.27,
            title: Padding(
              padding: const EdgeInsets.only(bottom: 10),
              child: Row(
                children: [
                  if (widget.showBackButton!)
                    AnimatedContainer(
                      duration: const Duration(milliseconds: 200),
                      width: _showCollapsedTitle ? 32 : 40,
                      height: _showCollapsedTitle ? 32 : 40,
                      decoration: const BoxDecoration(
                        color: Colors.white,
                        shape: BoxShape.circle,
                      ),
                      child: IconButton(
                        padding: EdgeInsets.only(
                          left: _showCollapsedTitle ? 8 : 6,
                        ),
                        constraints: const BoxConstraints(),
                        iconSize: _showCollapsedTitle ? 18 : 22,
                        icon: Icon(
                          Icons.adaptive.arrow_back,
                          color: Colors.black87,
                        ),
                        onPressed: () => Navigator.of(context).maybePop(),
                      ),
                    ),
                  const SizedBox(width: 12),
                  AnimatedOpacity(
                    opacity: _showCollapsedTitle ? 1.0 : 0.0,
                    duration: const Duration(milliseconds: 200),
                    child: Text(
                      widget.title,
                      style: Theme.of(
                        context,
                      ).textTheme.headlineSmall!.copyWith(color: Colors.white),
                    ),
                  ),
                ],
              ),
            ),
            flexibleSpace: LayoutBuilder(
              builder: (context, constraints) {
                final collapsed =
                    constraints.biggest.height <=
                    kToolbarHeight + MediaQuery.of(context).padding.top + 5;

                WidgetsBinding.instance.addPostFrameCallback((_) {
                  if (_showCollapsedTitle != collapsed) {
                    setState(() => _showCollapsedTitle = collapsed);
                  }
                });

                return FlexibleSpaceBar(
                  background: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const SizedBox(height: 70),
                      Text(
                        widget.title,
                        style: Theme.of(
                          context,
                        ).textTheme.displaySmall!.copyWith(color: Colors.white),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        widget.description,
                        style: Theme.of(context).textTheme.titleMedium!
                            .copyWith(
                              color: Colors.white,
                              fontWeight: FontWeight.normal,
                            ),
                      ),
                      if (widget.headerLabel != null) ...[
                        const SizedBox(height: 4),
                        widget.headerLabel!,
                      ],
                    ],
                  ),
                );
              },
            ),
          ),
          SliverFillRemaining(
            hasScrollBody: true,
            child: Container(
              decoration: BoxDecoration(
                color: Theme.of(context).colorScheme.surface,
                borderRadius: BorderRadius.only(
                  topRight: Radius.circular(_showCollapsedTitle ? 0 : 24),
                  topLeft: Radius.circular(_showCollapsedTitle ? 0 : 24),
                ),
              ),
              padding: const EdgeInsets.all(24),
              child: Form(
                key: widget.formKey,
                child: SingleChildScrollView(
                  physics: const BouncingScrollPhysics(),
                  child: Column(
                    // crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: widget.children,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
