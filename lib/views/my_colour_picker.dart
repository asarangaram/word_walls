import 'package:flex_color_picker/flex_color_picker.dart';
import 'package:flutter/material.dart';
import 'package:shadcn_ui/shadcn_ui.dart';

import 'shad_popover_scrollable.dart';

class MyColourPicker extends StatefulWidget {
  const MyColourPicker({
    super.key,
    required this.color,
    required this.onColorChanged,
  });
  final Color color;
  final void Function(Color color) onColorChanged;

  @override
  State<MyColourPicker> createState() => _MyColourPickerState();
}

class _MyColourPickerState extends State<MyColourPicker> {
  final popoverController = ShadPopoverController();
  late TextEditingController textEditingController;
  @override
  void initState() {
    textEditingController = TextEditingController(
      text: "0x${widget.color.hex.toString().padLeft(8, '0')}",
    );
    super.initState();
  }

  @override
  void dispose() {
    textEditingController.dispose();
    super.dispose();
  }

  Color mildSmart(Color bg) {
    double l = bg.computeLuminance();
    double opacity = 0.65; // tweak softness
    return l > 0.5
        ? Colors.black.withValues(alpha: opacity)
        : Colors.white.withValues(alpha: opacity);
  }

  final GlobalKey _anchorKey = GlobalKey();
  @override
  Widget build(BuildContext context) {
    return ShadPopoverScrollable(
      controller: popoverController,
      key: _anchorKey,
      popover: (context) => SizedBox(
        width: 288,
        child: ColorPickerWrapper(
          currentColor: Colors.blue,

          onColorChanged: (color) {
            textEditingController.text =
                "0x${color.hex.toString().padLeft(8, '0')}";
            widget.onColorChanged(color);
          },
        ),
      ),
      padding: EdgeInsets.all(2),
      child: Row(
        spacing: 8,
        children: [
          IntrinsicWidth(
            child: GestureDetector(
              onTap: popoverController.toggle,
              child: ShadInput(
                enabled: false,

                controller: textEditingController,

                style: ShadTheme.of(
                  context,
                ).textTheme.p.copyWith(fontFamily: "Roboto"),
                textAlign: TextAlign.center,
                inputPadding: EdgeInsets.all(2),
                //enabled: false,
                decoration: ShadDecoration(
                  border: ShadBorder.all(color: Colors.black),
                ),
              ),
            ),
          ),
          InkWell(
            onTap: popoverController.toggle,
            child: DecoratedBox(
              decoration: BoxDecoration(
                color: widget.color,
                borderRadius: BorderRadius.circular(8),
              ),
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Center(
                  child: Icon(
                    LucideIcons.palette,
                    size: 24,
                    color: mildSmart(widget.color),
                  ),
                ),
              ),
            ),
          ),
          Spacer(),
        ],
      ),
    );
  }
}

class ColorPickerWrapper extends StatelessWidget {
  const ColorPickerWrapper({
    super.key,
    required this.currentColor,
    required this.onColorChanged,
  });

  final Color currentColor;
  final void Function(Color color) onColorChanged;

  @override
  Widget build(BuildContext context) {
    return ColorPicker(
      mainAxisSize: MainAxisSize.min,
      padding: EdgeInsets.zero,
      color: currentColor,
      onColorChanged: onColorChanged,
      width: kMinInteractiveDimension,
      height: kMinInteractiveDimension,
      borderRadius: 8,
      subheading: Text(
        'Select color shade',
        style: Theme.of(context).textTheme.titleSmall,
      ),
      wheelSubheading: Text(
        'Selected color and its shades',
        style: Theme.of(context).textTheme.titleSmall,
      ),
      showColorName: true,
      showColorCode: true,
      copyPasteBehavior: const ColorPickerCopyPasteBehavior(
        longPressMenu: true,
      ),
      materialNameTextStyle: Theme.of(context).textTheme.bodySmall,
      colorNameTextStyle: Theme.of(context).textTheme.bodySmall,
      colorCodeTextStyle: Theme.of(context).textTheme.bodySmall,
      pickersEnabled: const <ColorPickerType, bool>{
        ColorPickerType.both: false,
        ColorPickerType.primary: true,
        ColorPickerType.accent: true,
        ColorPickerType.bw: false,
        ColorPickerType.custom: false,
        ColorPickerType.wheel: true,
      },
    );
  }
}
