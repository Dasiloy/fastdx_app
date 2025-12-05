import 'package:flutter/material.dart';

class Input extends StatefulWidget {
  // Component Props
  final String? label;
  final bool isPassword;
  final IconData? prefixIcon;

  // Extend all props of TextFormField
  final InputDecoration decoration;
  final TextEditingController? controller;
  final String? Function(String?)? validator;
  final TextInputType? keyboardType;
  final bool? enabled;
  final bool? autofocus;
  final bool? autocorrect;
  final TextStyle? style;
  final TextCapitalization textCapitalization;
  final void Function(String)? onChanged;
  final void Function(String)? onFieldSubmitted;
  final FocusNode? focusNode;
  final TextInputAction? textInputAction;
  final String? initialValue;
  final AutovalidateMode? autovalidateMode;
  final void Function(String?)? onSaved;

  const Input({
    super.key,
    this.label,
    this.isPassword = false,
    this.prefixIcon,
    this.controller,
    this.validator,
    this.keyboardType,
    this.enabled,
    this.autofocus = false,
    this.autocorrect = false,
    this.textCapitalization = TextCapitalization.none,
    this.onChanged,
    this.onFieldSubmitted,
    this.focusNode,
    this.style,
    this.textInputAction,
    this.initialValue,
    required this.decoration,
    this.onSaved,
    this.autovalidateMode = AutovalidateMode.onUserInteraction,
  });

  @override
  State<Input> createState() {
    return _State();
  }
}

class _State extends State<Input> {
  bool _obscure = false;

  Widget? get _passwordIcon {
    if (!widget.isPassword) {
      return null;
    }

    return IconButton(
      icon: Icon(
        _obscure ? Icons.visibility_off : Icons.visibility,
        size: 18,
        color: Theme.of(context).colorScheme.onSurface.withValues(alpha: 0.3),
      ),
      onPressed: () => setState(() => _obscure = !_obscure),
    );
  }

  @override
  void initState() {
    super.initState();
    if (widget.isPassword) {
      _obscure = true;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (widget.label != null) ...[
          Text(
            widget.label!,
            style: Theme.of(context).textTheme.labelLarge!.copyWith(
              fontWeight: FontWeight.w400,
              color: Theme.of(
                context,
              ).colorScheme.onSurface.withValues(alpha: 0.8),
            ),
          ),
          const SizedBox(height: 8),
        ],
        TextFormField(
          controller: widget.controller,
          validator: widget.validator,
          keyboardType: widget.keyboardType,
          enabled: widget.enabled,
          autofocus: widget.autofocus!,
          textCapitalization: widget.textCapitalization,
          onChanged: widget.onChanged,
          onFieldSubmitted: widget.onFieldSubmitted,
          focusNode: widget.focusNode,
          textInputAction: widget.textInputAction,
          initialValue: widget.initialValue,
          obscureText: _obscure,
          autocorrect: widget.autocorrect!,
          autovalidateMode: widget.autovalidateMode,
          decoration: widget.decoration.copyWith(
            fillColor: Theme.of(context).colorScheme.surfaceContainerLowest,
            suffixIcon: _passwordIcon,
          ),
          onSaved: widget.onSaved,
          style: Theme.of(
            context,
          ).textTheme.bodyMedium!.copyWith(fontSize: 14).merge(widget.style),
        ),
      ],
    );
  }
}
