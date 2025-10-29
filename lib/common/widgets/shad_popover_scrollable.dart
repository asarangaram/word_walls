import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:shadcn_ui/shadcn_ui.dart';

class ShadPopoverScrollable extends StatelessWidget {
  const ShadPopoverScrollable({
    super.key,
    /* OK */ required this.controller,
    /* OK */ required this.child,
    /* OK */ required this.popover,
    /* OK */ this.padding,
    /* OK */ this.shadows,
    /* OK */ this.decoration,
    /* NOT TESTED */ this.visible,
    /* NOT TESTED */ this.closeOnTapOutside = true,
    /* NOT TESTED */ this.useSameGroupIdForChild = true,
    /* NOT TESTED */ this.focusNode,
    /* NOT TESTED */ this.anchor,
    /* NOT TESTED */ this.effects,
    /* NOT TESTED */ this.reverseDuration,
    /* NOT TESTED */ this.filter,
    /* NOT TESTED */ this.groupId,
    /* NOT TESTED */ this.areaGroupId,
  });

  final ShadPopoverController controller;

  final Widget child;
  final Widget Function(BuildContext context) popover;
  final bool? visible;
  final bool closeOnTapOutside;
  final FocusNode? focusNode;
  final ShadAnchorBase? anchor;
  final List<Effect<dynamic>>? effects;
  final Duration? reverseDuration;
  final List<BoxShadow>? shadows;
  final EdgeInsetsGeometry? padding;
  final ShadDecoration? decoration;
  final ImageFilter? filter;
  final Object? groupId;
  final Object? areaGroupId;
  final bool useSameGroupIdForChild;

  @override
  Widget build(BuildContext context) {
    if (key is! GlobalKey) {
      throw Exception("key to scrillable must be GlobalKey");
    }
    final theme = ShadTheme.of(context);
    final effectiveShadows = shadows ?? theme.popoverTheme.shadows;
    var effectiveDecoration =
        (theme.popoverTheme.decoration ?? const ShadDecoration())
            .merge(decoration)
            .copyWith(shadows: effectiveShadows);

    final effectivePadding =
        padding ??
        theme.popoverTheme.padding ??
        const EdgeInsets.symmetric(horizontal: 12, vertical: 6);
    return ShadPopover(
      controller: controller,
      padding: EdgeInsets.zero,
      decoration: ShadDecoration(
        border: ShadBorder.none,
        color: Colors.transparent,
      ),
      shadows: [],
      visible: visible,
      closeOnTapOutside: closeOnTapOutside,
      focusNode: focusNode,
      anchor: anchor,
      effects: effects,
      reverseDuration: reverseDuration,
      filter: filter,
      groupId: groupId,
      areaGroupId: areaGroupId,
      useSameGroupIdForChild: useSameGroupIdForChild,

      popover: (context) => Builder(
        builder: (context) {
          final RenderBox? anchorBox =
              (key as GlobalKey).currentContext?.findRenderObject()
                  as RenderBox?;
          if (anchorBox == null) {
            return SizedBox(
              child: Placeholder(
                color: ShadTheme.of(context).colorScheme.destructive,
              ),
            );
          }

          final anchorPosition = anchorBox.localToGlobal(Offset.zero);
          final anchorHeight = anchorBox.size.height;
          final anchorWidth = anchorBox.size.height;

          final mediaQuery = MediaQuery.of(context);
          final double maxContentHeight;
          final double maxContentWidth;
          {
            final screenHeight = mediaQuery.size.height;
            final spaceBelow = screenHeight - anchorPosition.dy - anchorHeight;
            final spaceAbove = anchorPosition.dy;
            maxContentHeight =
                (spaceBelow > spaceAbove ? spaceBelow : spaceAbove) - 16;
          }
          {
            final screenWidth = mediaQuery.size.width;
            final spaceRight = screenWidth - anchorPosition.dx - anchorWidth;
            final spaceLeft = anchorPosition.dy;
            maxContentWidth =
                (spaceRight > spaceLeft ? spaceRight : spaceLeft) - 16;
          }

          return ConstrainedBox(
            constraints: BoxConstraints(
              maxHeight: maxContentHeight,
              maxWidth: maxContentWidth,
            ),
            child: GestureDetector(
              onTap: controller.hide,
              child: SizedBox(
                width: maxContentWidth,
                height: maxContentHeight,
                child: SingleChildScrollView(
                  child: Align(
                    alignment: Alignment.topCenter,
                    child: ShadDecorator(
                      decoration: effectiveDecoration,

                      child: Padding(
                        padding: effectivePadding,
                        child: popover(context),
                      ),
                    ),
                  ),
                ),
              ),
            ),
          );
        },
      ),
      child: child,
    );
  }
}
