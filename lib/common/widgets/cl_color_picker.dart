import 'package:flex_color_picker/flex_color_picker.dart';
import 'package:flutter/material.dart';
import 'package:shadcn_ui/shadcn_ui.dart';

import 'shad_popover_scrollable.dart';

class CLColorPickerFormField extends ShadFormBuilderField<Color> {
  CLColorPickerFormField({
    super.key,
    super.id,

    super.validator,
    super.onSaved,
    super.initialValue,
    this.onColorChanged,
  }) : super(
         builder: (FormFieldState<Color> state) {
           return CLColorPicker(
             color: state.value ?? Colors.black,
             onColorChanged: (color) {
               state.didChange(color);
               onColorChanged?.call(color);
             },
           ); // build UI here
         },
       );
  final void Function(Color color)? onColorChanged;
}

class CLColorPicker extends StatefulWidget {
  const CLColorPicker({
    super.key,
    required this.color,
    required this.onColorChanged,
  });
  final Color color;
  final void Function(Color color) onColorChanged;

  @override
  State<CLColorPicker> createState() => _CLColorPickerState();
}

class _CLColorPickerState extends State<CLColorPicker> {
  late final ShadPopoverController popoverController;
  late final TextEditingController textEditingController;
  final GlobalKey _anchorKey = GlobalKey();
  List<Color> recentColors = [];

  @override
  void initState() {
    textEditingController = TextEditingController(
      text: "0x${widget.color.hexAlpha.toString().padLeft(8, '0')}",
    );
    popoverController = ShadPopoverController();
    super.initState();
  }

  @override
  void dispose() {
    textEditingController.dispose();
    popoverController.dispose();
    super.dispose();
  }

  Color mildSmart(Color bg) {
    double l = bg.computeLuminance();
    double opacity = 0.65; // tweak softness
    return l > 0.5
        ? Colors.black.withValues(alpha: opacity)
        : Colors.white.withValues(alpha: opacity);
  }

  @override
  Widget build(BuildContext context) {
    return ShadPopoverScrollable(
      controller: popoverController,
      key: _anchorKey,
      popover: (context) => SizedBox(
        width: 288,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Align(
              alignment: Alignment.bottomRight,
              child: ShadButton.link(
                onPressed: popoverController.hide,
                child: Text('Done'),
              ),
            ),
            ColorPickerWrapper(
              currentColor: Colors.blue,
              recentColors: recentColors,

              onColorChanged: (color) {
                recentColors.insert(0, color);
                recentColors = recentColors.take(5).toList();
                print(color);
                textEditingController.text =
                    "0x${color.hexAlpha.toString().padLeft(8, '0')}";
                widget.onColorChanged(color);
                //popoverController.hide();
              },
            ),
          ],
        ),
      ),
      padding: EdgeInsets.all(2),
      child: Row(
        mainAxisSize: MainAxisSize.min,
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
    required this.recentColors,
  });

  final Color currentColor;
  final List<Color> recentColors;
  final void Function(Color color) onColorChanged;

  @override
  Widget build(BuildContext context) {
    return ColorPicker(
      mainAxisSize: MainAxisSize.min,
      padding: EdgeInsets.zero,
      color: currentColor,
      onColorChanged: onColorChanged,
      //width: kMinInteractiveDimension,
      //height: kMinInteractiveDimension,
      borderRadius: 8,
      subheading: Text(
        'Select color shade',
        style: Theme.of(context).textTheme.titleSmall,
      ),
      showRecentColors: recentColors.isNotEmpty,
      recentColors: recentColors,
      wheelSubheading: Text(
        'Selected color and its shades',
        style: Theme.of(context).textTheme.titleSmall,
      ),
      recentColorsSubheading: Text(
        'Recently used',
        style: Theme.of(context).textTheme.titleSmall,
      ),
      //showColorName: true,
      //showColorCode: true,
      /* copyPasteBehavior: const ColorPickerCopyPasteBehavior(
        longPressMenu: true,
      ), */
      //materialNameTextStyle: Theme.of(context).textTheme.bodySmall,
      //colorNameTextStyle: Theme.of(context).textTheme.bodySmall,
      //colorCodeTextStyle: Theme.of(context).textTheme.bodySmall,
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
