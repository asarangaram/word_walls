import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:shadcn_ui/shadcn_ui.dart';
import 'package:word_walls/views/my_scaffold.dart';

import 'my_colour_picker.dart';

class PrefPage extends StatelessWidget {
  const PrefPage({super.key});

  @override
  Widget build(BuildContext context) {
    return MyScaffold(child: PrefForm());
  }
}

class PrefForm extends StatefulWidget {
  const PrefForm({super.key});

  @override
  State<PrefForm> createState() => _PrefFormState();
}

class _PrefFormState extends State<PrefForm> {
  final formKey = GlobalKey<ShadFormState>();
  final widthField = TextEditingController();
  final heigthField = TextEditingController();
  final wordPaddingField = TextEditingController();
  final wordOverlapField = TextEditingController();
  Color color = Colors.white;

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.topLeft,
      child: ShadForm(
        key: formKey,
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: ShadForm(
              child: Column(
                spacing: 8,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Table(
                    columnWidths: const <int, TableColumnWidth>{
                      0: IntrinsicColumnWidth(), // Column 0 will fit to the widest child
                      1: IntrinsicColumnWidth(), // Column 1 will take available space
                      //  2: FlexColumnWidth(),
                      /* 2: FixedColumnWidth(
                            100.0,
                          ), // Column 2 has a fixed width */
                    },
                    children: [
                      TableRow(
                        children: [
                          TableCell(
                            verticalAlignment:
                                TableCellVerticalAlignment.middle,
                            child: Align(
                              alignment: Alignment.centerLeft,
                              child: Text("Background Color: "),
                            ),
                          ),
                          TableCell(
                            verticalAlignment:
                                TableCellVerticalAlignment.middle,
                            child: MyColourPicker(
                              color: color,
                              onColorChanged: (color) {
                                setState(() {
                                  this.color = color;
                                });
                              },
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                  ShadButton(
                    onPressed: () {
                      // Handle form submission
                      /*  ScaffoldMessenger.of(context).showSnackBar(
                       SnackBar(
                          content: Text(
                            'Selected Color: ${model.selectedColor}',
                          ),
                          backgroundColor: model.selectedColor,
                        ),
                      ); */
                    },
                    child: const Text('Submit'),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class NonNegativeIntegerField extends StatelessWidget {
  final TextEditingController controller;
  final String? label;
  final String? id;
  final String? placeholder;
  final String? description;
  final void Function(String)? onChanged;

  NonNegativeIntegerField({
    super.key,
    TextEditingController? controller,
    this.label,
    this.onChanged,
    this.id,
    this.description,
    this.placeholder,
  }) : controller = controller ?? TextEditingController();

  @override
  Widget build(BuildContext context) {
    return ShadInputFormField(
      id: id,
      label: label != null ? Text(label!) : null,
      placeholder: placeholder != null ? Text(placeholder!) : null,
      description: description != null ? Text(description!) : null,
      controller: controller,
      keyboardType: TextInputType.number, // numeric keyboard
      inputFormatters: <TextInputFormatter>[
        FilteringTextInputFormatter.digitsOnly, // only digits allowed
      ],
      onChanged: onChanged,
    );
  }
}
