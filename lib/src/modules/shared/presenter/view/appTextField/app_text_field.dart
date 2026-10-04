import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:lucide_icons/lucide_icons.dart';

import 'package:pasal_sathi/src/core/config/colors/app_colors.dart';
import 'package:pasal_sathi/src/core/config/extensions/extensions.dart';
import 'package:pasal_sathi/src/core/config/textTheme/text_theme.dart';

final RegExp _emojiRegex = RegExp(
  r'[\u{1F300}-\u{1FAFF}\u{2600}-\u{27BF}\u{1F1E6}-\u{1F1FF}\u{2B00}-\u{2BFF}\u{FE0F}\u{200D}]',
  unicode: true,
);

class AppTextField extends ConsumerStatefulWidget {
  const AppTextField({
    required this.labelText,
    this.textEditingController,
    this.hintText,
    this.validator,
    this.isMandatory = false,
    this.maxlength,
    this.maxlines,
    this.style,
    this.keyboardType,
    this.isPassword = false,
    this.initialValue,
    this.onChanged,
    this.readOnly = false,
    this.onTap,
    this.suffixIcon,
    this.prefixIcon,
    this.prefixIconColor,
    this.prefixIconConstraints,
    this.prefixText,
    this.inputFormatters,
    this.borderRadius = 48,
    this.isEnabled = true,
    this.showLabel = true,
    this.bottomPadding,
    this.showBorder = true,
    this.filled = true,
    this.isDense = false,
    this.contentPadding,
    this.addPrefixIconPadding = false,
    this.errorText,
    this.focusNode,
    this.showCounterText = false,
    this.autofocus = false,
    this.onTapOutside,
    this.textInputAction,
    this.onFieldSubmitted,
    super.key,
  }) : assert(
         textEditingController != null ||
             onChanged != null ||
             initialValue != null,
         'Provide a textEditingController or use initialValue + onChanged.',
       );

  final TextEditingController? textEditingController;
  final String labelText;
  final String? hintText;
  final String? Function(String?)? validator;
  final bool isMandatory;
  final int? maxlength;
  final int? maxlines;
  final TextStyle? style;
  final TextInputType? keyboardType;
  final bool isPassword;
  final String? initialValue;
  final ValueChanged<String>? onChanged;
  final bool readOnly;
  final bool isEnabled;
  final bool showLabel;
  final VoidCallback? onTap;
  final Widget? suffixIcon;
  final Widget? prefixIcon;
  final Color? prefixIconColor;
  final BoxConstraints? prefixIconConstraints;
  final String? prefixText;
  final List<TextInputFormatter>? inputFormatters;
  final double borderRadius;
  final double? bottomPadding;
  final FocusNode? focusNode;
  final bool showBorder;
  final bool filled;
  final bool isDense;
  final EdgeInsetsGeometry? contentPadding;
  final bool addPrefixIconPadding;
  final String? errorText;
  final bool showCounterText;
  final bool autofocus;
  final TapRegionCallback? onTapOutside;
  final TextInputAction? textInputAction;
  final ValueChanged<String>? onFieldSubmitted;

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _AppTextFieldState();
}

class _AppTextFieldState extends ConsumerState<AppTextField>
    with WidgetsBindingObserver {
  bool isObscured = true;
  late FocusNode _focusNode;
  late TextEditingController _internalController;
  bool _isFocused = false;
  bool _touched = false;
  Timer? _ensureVisibleTimer;

  bool get _hasController => widget.textEditingController != null;

  TextEditingController get _effectiveController =>
      widget.textEditingController ?? _internalController;

  FocusNode get _effectiveFocusNode => widget.focusNode ?? _focusNode;

  @override
  void initState() {
    super.initState();
    _internalController = TextEditingController(text: widget.initialValue);
    _focusNode = FocusNode();
    _effectiveFocusNode.addListener(_handleFocusChange);
    _effectiveController.addListener(_handleTextChange);
    WidgetsBinding.instance.addObserver(this);
  }

  @override
  void didChangeMetrics() {
    if (_effectiveFocusNode.hasFocus) {
      _ensureFieldVisible();
    }
  }

  void _handleFocusChange() {
    final hasFocus = _effectiveFocusNode.hasFocus;
    setState(() {
      if (_isFocused && !hasFocus) {
        _touched = true;
      }
      _isFocused = hasFocus;
    });
    if (hasFocus) {
      _ensureFieldVisible();
    }
  }

  void _ensureFieldVisible() {
    if (!_effectiveFocusNode.hasFocus) return;
    _ensureVisibleTimer?.cancel();
    _ensureVisibleTimer = Timer(const Duration(milliseconds: 300), () {
      if (!mounted || !_effectiveFocusNode.hasFocus) return;
      _doEnsureVisible(context);
    });
  }

  void _scrollFieldIntoView() {
    _ensureVisibleTimer?.cancel();
    _ensureVisibleTimer = Timer(const Duration(milliseconds: 80), () {
      if (!mounted) return;
      _doEnsureVisible(context);
    });
  }

  void _doEnsureVisible(BuildContext ctx) {
    Scrollable.ensureVisible(
      ctx,
      alignment: 0.5,
      duration: const Duration(milliseconds: 200),
      curve: Curves.easeOut,
    );
  }

  void _handleTextChange() {
    setState(() {
      if (_effectiveController.text.isNotEmpty) {
        _touched = true;
      }
    });
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    _ensureVisibleTimer?.cancel();
    _effectiveFocusNode.removeListener(_handleFocusChange);
    if (widget.focusNode == null) {
      _focusNode.dispose();
    }
    _effectiveController.removeListener(_handleTextChange);
    if (!_hasController) {
      _internalController.dispose();
    }
    super.dispose();
  }

  bool get _hasText => _effectiveController.text.isNotEmpty;

  @override
  Widget build(BuildContext context) {
    final effectiveIsPassword = widget.isPassword;
    final effectiveMaxLines = effectiveIsPassword ? 1 : (widget.maxlines ?? 1);
    final isLightMode = Theme.of(context).brightness == Brightness.light;
    final showPrefix = widget.prefixText != null && (_isFocused || _hasText);

    final resolvedBorder = widget.showBorder
        ? OutlineInputBorder(
            borderRadius: BorderRadius.circular(widget.borderRadius),
            borderSide: BorderSide(
              color: isLightMode
                  ? AppColor.neutralSwatch.shade200
                  : AppColor.neutralSwatch.shade600,
            ),
          )
        : InputBorder.none;

    final resolvedFocusedBorder = widget.showBorder
        ? OutlineInputBorder(
            borderRadius: BorderRadius.circular(widget.borderRadius),
            borderSide: BorderSide(color: context.colorScheme.primary),
          )
        : InputBorder.none;

    final resolvedErrorBorder = widget.showBorder
        ? OutlineInputBorder(
            borderRadius: BorderRadius.circular(widget.borderRadius),
            borderSide: BorderSide(color: context.colorScheme.error),
          )
        : InputBorder.none;

    return Padding(
      padding: EdgeInsets.only(bottom: widget.bottomPadding ?? 12),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (widget.labelText.isNotEmpty && widget.showLabel) ...[
            Padding(
              padding: const EdgeInsets.only(left: 2),
              child: RichText(
                text: TextSpan(
                  text: widget.labelText,
                  style: (widget.style ?? AppTextStyles.bodySmall).copyWith(
                    color: context.theme.colorScheme.onSurface,
                  ),
                  children: widget.isMandatory
                      ? [
                          TextSpan(
                            text: ' *',
                            style: (widget.style ?? AppTextStyles.bodySmall)
                                .copyWith(
                                  color: context.theme.colorScheme.error,
                                ),
                          ),
                        ]
                      : const [],
                ),
              ),
            ),
            const SizedBox(height: 8),
          ],
          TextFormField(
            enabled: widget.isEnabled,
            controller: _effectiveController,
            focusNode: _effectiveFocusNode,
            autofocus: widget.autofocus,
            textAlignVertical: TextAlignVertical.center,
            onChanged: widget.onChanged,
            scrollPhysics: const ClampingScrollPhysics(),
            readOnly: widget.readOnly,
            onTap: () {
              widget.onTap?.call();
              if (_effectiveFocusNode.hasFocus) {
                _scrollFieldIntoView();
              }
            },
            maxLines: effectiveMaxLines,
            textDirection: TextDirection.ltr,
            maxLength: widget.maxlength,
            keyboardType: widget.keyboardType,
            textInputAction: widget.textInputAction,
            onFieldSubmitted: widget.onFieldSubmitted,
            inputFormatters: [
              FilteringTextInputFormatter.deny(_emojiRegex),
              ...?widget.inputFormatters,
            ],
            obscureText: effectiveIsPassword && isObscured,
            style: (widget.style ?? AppTextStyles.body).copyWith(
              fontWeight: FontWeight.w400,
              color: isLightMode ? AppColor.baseBlack : AppColor.baseWhite,
            ),
            decoration: InputDecoration(
              isDense: widget.isDense,
              filled: widget.filled,
              fillColor: widget.filled
                  ? (isLightMode
                        ? AppColor.baseWhite
                        : context.colorScheme.surface)
                  : Colors.transparent,
              contentPadding: widget.contentPadding,
              hintText: widget.hintText ?? widget.labelText,
              hintStyle: (widget.style ?? AppTextStyles.body).copyWith(
                color: context.colorScheme.onSurface.withValues(alpha: 0.5),
              ),
              prefixText: showPrefix ? widget.prefixText : null,
              prefixStyle: (widget.style ?? AppTextStyles.body).copyWith(
                fontWeight: FontWeight.w400,
                color: isLightMode ? AppColor.baseBlack : AppColor.baseWhite,
              ),
              labelStyle: AppTextStyles.label,
              errorStyle: AppTextStyles.label.copyWith(
                color: context.colorScheme.error,
              ),
              errorText: widget.errorText,
              errorMaxLines: 2,
              counterText: widget.showCounterText ? null : '',
              prefixIcon: widget.prefixIcon == null
                  ? null
                  : (widget.addPrefixIconPadding
                        ? Padding(
                            padding: const EdgeInsets.only(left: 12),
                            child: widget.prefixIcon,
                          )
                        : widget.prefixIcon),
              prefixIconColor: widget.prefixIconColor,
              prefixIconConstraints:
                  widget.prefixIconConstraints ??
                  const BoxConstraints(minWidth: 40, minHeight: 40),
              suffixIcon:
                  widget.suffixIcon ??
                  (effectiveIsPassword
                      ? IconButton(
                          icon: Icon(
                            isObscured ? LucideIcons.eyeOff : LucideIcons.eye,
                            color: context.colorScheme.onSurface,
                            size: 19,
                          ),
                          onPressed: () =>
                              setState(() => isObscured = !isObscured),
                        )
                      : null),
              enabledBorder: resolvedBorder,
              disabledBorder: resolvedBorder,
              focusedBorder: resolvedFocusedBorder,
              errorBorder: resolvedErrorBorder,
              focusedErrorBorder: resolvedErrorBorder,
            ),
            autovalidateMode: AutovalidateMode.onUserInteraction,
            validator: (value) {
              if (!_touched) return null;

              if (value != null && _emojiRegex.hasMatch(value)) {
                return '${widget.labelText} cannot contain emojis';
              }

              if (widget.isMandatory &&
                  (value == null || value.trim().isEmpty)) {
                return '${widget.labelText} is required';
              }
              if (widget.validator != null) {
                return widget.validator!(value);
              }
              if (widget.isMandatory && value!.trim().length < 3) {
                return '${widget.labelText} must be at least 3 characters';
              }
              return null;
            },
            onTapOutside:
                widget.onTapOutside ??
                (_) => FocusManager.instance.primaryFocus?.unfocus(),
          ),
        ],
      ),
    );
  }
}
