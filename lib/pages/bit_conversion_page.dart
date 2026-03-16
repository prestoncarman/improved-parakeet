import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../models/bit_conversion_model.dart';

/// Page for the Bit Conversion tool.
///
/// Editing any field automatically updates the other two representations.
class BitConversionPage extends StatefulWidget {
  const BitConversionPage({super.key});

  @override
  State<BitConversionPage> createState() => _BitConversionPageState();
}

class _BitConversionPageState extends State<BitConversionPage> {
  final _binaryController = TextEditingController();
  final _decimalController = TextEditingController();
  final _hexController = TextEditingController();

  /// Guard flag to prevent feedback loops when model updates controllers.
  bool _programmaticUpdate = false;

  @override
  void dispose() {
    _binaryController.dispose();
    _decimalController.dispose();
    _hexController.dispose();
    super.dispose();
  }

  /// Sync controllers from the model without triggering onChanged callbacks.
  void _syncControllers(BitConversionModel model) {
    if (_programmaticUpdate) return;
    _programmaticUpdate = true;

    if (_binaryController.text != model.binary) {
      _binaryController.text = model.binary;
    }
    if (_decimalController.text != model.decimal) {
      _decimalController.text = model.decimal;
    }
    if (_hexController.text != model.hex) {
      _hexController.text = model.hex;
    }

    _programmaticUpdate = false;
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(24),
      child: Consumer<BitConversionModel>(
        builder: (context, model, _) {
          _syncControllers(model);

          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Bit Conversion Tool',
                style: Theme.of(context).textTheme.headlineMedium,
              ),
              const SizedBox(height: 8),
              Text(
                'Enter a value in any field to automatically convert to the other bases.',
                style: Theme.of(context).textTheme.bodyMedium,
              ),
              const SizedBox(height: 24),
              _ConversionField(
                controller: _binaryController,
                label: 'Binary',
                hint: 'e.g. 1010',
                onChanged: (v) {
                  if (!_programmaticUpdate) model.updateFromBinary(v);
                },
              ),
              const SizedBox(height: 16),
              _ConversionField(
                controller: _decimalController,
                label: 'Decimal',
                hint: 'e.g. 10',
                onChanged: (v) {
                  if (!_programmaticUpdate) model.updateFromDecimal(v);
                },
              ),
              const SizedBox(height: 16),
              _ConversionField(
                controller: _hexController,
                label: 'Hexadecimal',
                hint: 'e.g. A',
                onChanged: (v) {
                  if (!_programmaticUpdate) {
                    model.updateFromHex(v.toUpperCase());
                  }
                },
              ),
              if (model.errorMessage.isNotEmpty) ...[
                const SizedBox(height: 16),
                Text(
                  model.errorMessage,
                  style: TextStyle(
                    color: Theme.of(context).colorScheme.error,
                  ),
                ),
              ],
            ],
          );
        },
      ),
    );
  }
}

/// A labeled text field for one numeric base.
class _ConversionField extends StatelessWidget {
  final TextEditingController controller;
  final String label;
  final String hint;
  final ValueChanged<String> onChanged;

  const _ConversionField({
    required this.controller,
    required this.label,
    required this.hint,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
      onChanged: onChanged,
      decoration: InputDecoration(
        labelText: label,
        hintText: hint,
        border: const OutlineInputBorder(),
      ),
    );
  }
}
