import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

import 'package:fastdx_app/core/core.dart';

class DataList<T> extends StatelessWidget {
  final List<T> data;
  final bool isLoading;
  final double width;
  final double height;
  final int shimmerItemCount;
  final double borderRadius;
  final String emptyLabel;
  final TapBehavior tapBehavior;
  final Widget Function(BuildContext context, int index, T item) itemBuilder;

  final Widget? header;
  final EdgeInsets? padding;
  final Widget? separator;
  final Widget? loadingWidget;
  final Widget? emptyWidget;
  final Widget? emptyIcon;
  final Color? shimmerContainerColor;
  final Color? shimmerBaseColor;
  final Color? shimmerHighlightColor;
  final ScrollController? controller;
  final void Function(BuildContext ctx, T item)? onTap;

  const DataList({
    super.key,
    required this.data,
    required this.itemBuilder,
    this.isLoading = false,
    this.width = double.infinity,
    this.height = 102,
    this.borderRadius = 12,
    this.shimmerItemCount = 3,
    this.emptyLabel = "No Items avaliable",
    this.tapBehavior = TapBehavior.gestureDetector,
    this.header,
    this.padding,
    this.emptyIcon,
    this.onTap,
    this.controller,
    this.separator,
    this.emptyWidget,
    this.loadingWidget,
    this.shimmerBaseColor,
    this.shimmerContainerColor,
    this.shimmerHighlightColor,
  });

  int get itemCount {
    return header != null && !isLoading ? data.length + 1 : data.length;
  }

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
          height: double.infinity,
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
            child: Expanded(
              child: ListView.separated(
                scrollDirection: Axis.horizontal,
                itemCount: shimmerItemCount,
                separatorBuilder: (_, __) => separator ?? SizedBox(width: 12),
                itemBuilder: (_, __) => _buildShimmerItem(context),
              ),
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
                      size: 80,
                      color: Theme.of(
                        context,
                      ).colorScheme.onSurface.withValues(alpha: 0.7),
                    ),
                SizedBox(height: 8),
                Text(
                  emptyLabel,
                  style: Theme.of(context).textTheme.bodyLarge!.copyWith(
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
        padding: padding,
        controller: controller,
        scrollDirection: Axis.vertical,
        itemCount: itemCount,
        separatorBuilder: (_, __) => separator!,
        itemBuilder: (ctx, index) {
          if (header != null) {
            if (index == 0) {
              return header;
            }
            return _buildTappableItem(
              ctx,
              data[index - 1],
              itemBuilder(ctx, index - 1, data[index - 1]),
            );
          }
          return _buildTappableItem(
            ctx,
            data[index],
            itemBuilder(ctx, index, data[index - 1]),
          );
        },
      );
    }

    return ListView.builder(
      padding: padding,
      controller: controller,
      scrollDirection: Axis.vertical,
      itemCount: itemCount,
      itemBuilder: (ctx, index) {
        if (header != null) {
          if (index == 0) {
            return header;
          }
          return _buildTappableItem(
            ctx,
            data[index - 1],
            itemBuilder(ctx, index - 1, data[index - 1]),
          );
        }
        return _buildTappableItem(
          ctx,
          data[index],
          itemBuilder(ctx, index, data[index - 1]),
        );
      },
    );
  }
}
