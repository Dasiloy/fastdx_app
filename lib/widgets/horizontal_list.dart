import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

import 'package:fastdx_app/core/core.dart';

class HorizontalList<T> extends StatelessWidget {
  final List<T> data;
  final bool isLoading;
  final double height;
  final double width;
  final int shimmerItemCount;
  final double borderRadius;
  final String emptyLabel;
  final TapBehavior tapBehavior;
  final Widget Function(BuildContext context, int index, T item) itemBuilder;

  final Widget? separator;
  final Widget? loadingWidget;
  final Widget? emptyWidget;
  final Widget? emptyIcon;
  final Color? shimmerContainerColor;
  final Color? shimmerBaseColor;
  final Color? shimmerHighlightColor;
  final void Function(BuildContext ctx, T item)? onTap;

  const HorizontalList({
    super.key,
    required this.data,
    required this.itemBuilder,
    this.isLoading = false,
    this.width = 150,
    this.height = 200,
    this.borderRadius = 12,
    this.shimmerItemCount = 3,
    this.emptyLabel = "No Items avaliable",
    this.tapBehavior = TapBehavior.gestureDetector,
    this.emptyIcon,
    this.onTap,
    this.separator,
    this.emptyWidget,
    this.loadingWidget,
    this.shimmerBaseColor,
    this.shimmerContainerColor,
    this.shimmerHighlightColor,
  });

  Widget _buildTappableItem(BuildContext ctx, T item, Widget child) {
    switch (tapBehavior) {
      case TapBehavior.gestureDetector:
        return GestureDetector(
          onTap: () => onTap?.call(ctx, item),
          child: child,
        );

      case TapBehavior.inkWell:
        return Material(
          color: Colors.transparent,
          child: InkWell(
            onTap: () => onTap?.call(ctx, item),
            borderRadius: BorderRadius.circular(12),
            child: child,
          ),
        );

      case TapBehavior.none:
        return child;
    }
  }

  Widget _buildShimmerItem(BuildContext context) {
    return Container(
      width: width,
      height: height,
      decoration: BoxDecoration(
        color:
            shimmerContainerColor ??
            Theme.of(
              context,
            ).colorScheme.surfaceContainerLowest.withValues(alpha: 0.85),
        borderRadius: BorderRadius.circular(borderRadius),
      ),
    );
  }

  Widget _buildLoadingView(BuildContext context) {
    return loadingWidget ??
        SizedBox(
          height: height,
          width: double.infinity,
          child: Shimmer.fromColors(
            baseColor:
                shimmerBaseColor ??
                Theme.of(context).colorScheme.primary.withValues(alpha: 0.05),
            highlightColor:
                shimmerHighlightColor ??
                Theme.of(
                  context,
                ).colorScheme.primaryContainer.withValues(alpha: 0.05),
            child: ListView.separated(
              scrollDirection: Axis.horizontal,
              itemCount: shimmerItemCount,
              separatorBuilder: (_, __) => separator ?? SizedBox(width: 12),
              itemBuilder: (_, __) => _buildShimmerItem(context),
            ),
          ),
        );
  }

  Widget _buildEmptyView(BuildContext context) {
    return emptyWidget ??
        SizedBox(
          height: height,
          width: double.infinity,
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                emptyIcon ??
                    Icon(
                      Icons.inbox_outlined,
                      size: 48,
                      color: Theme.of(
                        context,
                      ).colorScheme.onSurface.withValues(alpha: 0.7),
                    ),
                SizedBox(height: 8),
                Text(
                  emptyLabel,
                  style: Theme.of(context).textTheme.labelLarge!.copyWith(
                    fontWeight: FontWeight.w500,
                    color: Theme.of(
                      context,
                    ).colorScheme.onSurface.withValues(alpha: 0.5),
                  ),
                ),
              ],
            ),
          ),
        );
  }

  @override
  Widget build(BuildContext context) {
    if (isLoading) {
      return _buildLoadingView(context);
    }

    if (data.isEmpty) {
      return _buildEmptyView(context);
    }

    if (separator != null) {
      return ListView.separated(
        scrollDirection: Axis.horizontal,
        itemCount: data.length,
        separatorBuilder: (_, __) => separator!,
        itemBuilder: (ctx, index) {
          final item = data[index];
          return _buildTappableItem(ctx, item, itemBuilder(ctx, index, item));
        },
      );
    }

    return ListView.builder(
      scrollDirection: Axis.horizontal,
      itemCount: data.length,
      itemBuilder: (ctx, index) {
        final item = data[index];
        return _buildTappableItem(ctx, item, itemBuilder(ctx, index, item));
      },
    );
  }
}
