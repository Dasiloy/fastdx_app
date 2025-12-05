import 'package:flutter/material.dart' hide Orientation;
import 'package:pin_input_text_field/pin_input_text_field.dart';

class PinInput extends StatefulWidget {
  final int? pins;
  final double? height;
  final GlobalKey<FormState>? formKey;
  final TextEditingController? controller;
  final Function(String? pin)? onSaved;

  const PinInput({
    super.key,
    this.formKey,
    this.controller,
    this.onSaved,
    this.height = 62,
    this.pins = 4,
  });

  @override
  State<PinInput> createState() => _PinInputState();
}

class _PinInputState extends State<PinInput> {
  bool _hasError = false;
  String? _errorText;
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    final bgColorBuilder = PinListenColorBuilder(
      colorScheme.primary.withValues(alpha: 0.08), // unfocued color
      colorScheme.surfaceContainerLowest,
    );

    return SizedBox(
      width: double.infinity,
      height: widget.height!,
      child: PinInputTextFormField(
        key: widget.formKey,
        autoFocus: true,
        pinLength: widget.pins!,
        controller: widget.controller,
        onSaved: widget.onSaved,
        textInputAction: TextInputAction.go,
        onSubmit: (pin) {
          if (widget.formKey == null) {
            return;
          }
          if (widget.formKey!.currentState!.validate()) {
            widget.formKey!.currentState!.save();
          }
        },
        cursor: Cursor(
          height: 2,
          width: 32,
          offset: 16,
          enabled: true,
          color: Theme.of(context).colorScheme.primary,
          radius: Radius.circular(1),
          orientation: Orientation.horizontal,
        ),
        keyboardType: TextInputType.numberWithOptions(
          decimal: false,
          signed: false,
        ),
        decoration: BoxLooseDecoration(
          strokeWidth: 0,
          gapSpace: 26,
          errorText: _hasError ? _errorText : null,
          errorTextStyle: theme.textTheme.bodySmall?.copyWith(
            color: colorScheme.error,
            fontWeight: FontWeight.w500,
          ),
          strokeColorBuilder: PinListenColorBuilder(
            Colors.transparent,
            Colors.transparent,
          ),
          bgColorBuilder: bgColorBuilder,
          radius: Radius.circular(6),
        ),
        validator: (pin) {
          if (pin?.isEmpty == true) {
            setState(() {
              _hasError = true;
              _errorText = "Pin is empty";
            });
            return "Pin is empty";
          }
          if (pin!.length < widget.pins!) {
            setState(() {
              _hasError = true;
              _errorText = "Pin is not completed.";
            });
            return 'Pin is not completed.';
          }
          setState(() {
            _errorText = null;
            _hasError = false;
          });
          return null;
        },
      ),
    );
  }
}
