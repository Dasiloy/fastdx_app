import 'package:fastdx_app/core/core.dart';
import 'package:flutter/material.dart';

import 'package:fastdx_app/widgets/widgets.dart';

class Sheet {
  static Widget _buildDragHandle(BuildContext context) {
    return Center(
      child: Container(
        width: 60,
        height: 6,
        margin: const EdgeInsets.only(top: 16, bottom: 6),
        decoration: BoxDecoration(
          color: Theme.of(context).colorScheme.onSurface.withValues(alpha: 0.3),
          borderRadius: BorderRadius.circular(25),
        ),
      ),
    );
  }

  static void openListSheet<T>({
    required BuildContext context,
    required List<T> list,
    required Widget Function(BuildContext ctx, int index, T item) itemBuilder,
    TapBehavior tapBehaviour = TapBehavior.gestureDetector,
    bool expandSheet = false,
    bool enableDrag = true,
    bool useSafeArea = false,
    bool showDragHandle = true,
    double initialChildSize = 0.4,
    double minChildSize = 0.2,
    double maxChildSize = 0.9,
    double pt = 12,
    double pb = 16,
    double pl = 20,
    double pr = 20,
    Widget? header,
    final Widget? separator,
  }) {
    showModalBottomSheet(
      showDragHandle: false,
      isScrollControlled: true,
      context: context,
      useSafeArea: useSafeArea,
      enableDrag: enableDrag,
      backgroundColor: Theme.of(context).colorScheme.surfaceContainerLowest,
      builder: (ctx) {
        return DraggableScrollableSheet(
          expand: expandSheet,
          initialChildSize: initialChildSize,
          minChildSize: minChildSize,
          maxChildSize: maxChildSize,
          builder: (cont, scrollController) {
            return Column(
              children: [
                if (showDragHandle) _buildDragHandle(cont),
                Expanded(
                  child: DataList(
                    data: list,
                    header: header,
                    separator: separator,
                    tapBehavior: tapBehaviour,
                    padding: EdgeInsets.only(
                      top: pt,
                      bottom: pb,
                      left: pl,
                      right: pr,
                    ),
                    itemBuilder: itemBuilder,
                    controller: scrollController,
                  ),
                ),
              ],
            );
          },
        );
      },
    );
  }
}
