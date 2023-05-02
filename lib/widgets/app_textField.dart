import 'package:fitness_app/core/constants/color_constants.dart';
import 'package:flutter/material.dart';

class AppTextField extends StatefulWidget {
  final String title;
  final String placeholder;
  final String errorText;
  final bool obscureText;
  final bool isError;
  final TextEditingController controller;
  final VoidCallback onTextChanged;
  final TextInputAction textInputAction;
  final TextInputType? keyboardType;

  const AppTextField({
    required this.title,
    required this.placeholder,
    this.obscureText = false,
    this.isError = false,
    required this.controller,
    required this.onTextChanged,
    required this.errorText,
    this.textInputAction = TextInputAction.done,
    this.keyboardType,
    Key? key,
  }) : super(key: key);

  @override
  _AppTextFieldState createState() => _AppTextFieldState();
}

class _AppTextFieldState extends State<AppTextField> {
  final focusNode = FocusNode();
  bool stateObscureText = false;
  bool stateIsError = false;

  @override
  void initState() {
    super.initState();

    focusNode.addListener(
      () {
        setState(() {
          if (focusNode.hasFocus) {
            stateIsError = false;
          }
        });
      },
    );

    stateObscureText = widget.obscureText;
    stateIsError = widget.isError;
  }

  @override
  void didUpdateWidget(covariant AppTextField oldWidget) {
    super.didUpdateWidget(oldWidget);

    stateObscureText = widget.obscureText;
    stateIsError = focusNode.hasFocus ? false : widget.isError;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _getHeader(),
          const SizedBox(height: 5),
          _getTextFieldStack(),
          if (stateIsError) ...[
            _getError(),
          ],
        ],
      ),
    );
  }

  Widget _getHeader() {
    return Text(
      widget.title,
      style: TextStyle(
        color: _getUserNameColor(),
        fontSize: 14,
        fontWeight: FontWeight.w500,
      ),
    );
  }

  Color _getUserNameColor() {
    if (focusNode.hasFocus) {
      return ColorConstants.mainColor;
    } else if (stateIsError) {
      return ColorConstants.errorColor;
    } else if (widget.controller.text.isNotEmpty) {
      return ColorConstants.textBlack;
    }
    return ColorConstants.grey;
  }

  Widget _getTextFieldStack() {
    return Stack(
      children: [
        _getTextField(),
        if (widget.obscureText) ...[
          Positioned(
            right: 0,
            bottom: 0,
            top: 0,
            child: _getShowEye(),
          ),
        ],
      ],
    );
  }

  Widget _getTextField() {
    return TextField(
      focusNode: focusNode,
      controller: widget.controller,
      obscureText: stateObscureText,
      textInputAction: widget.textInputAction,
      keyboardType: widget.keyboardType,
      style: const TextStyle(
        color: ColorConstants.textBlack,
        fontSize: 16,
      ),
      decoration: InputDecoration(
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16.0),
          borderSide: BorderSide(
            color: stateIsError
                ? ColorConstants.errorColor
                : ColorConstants.textFieldBorder.withOpacity(0.4),
          ),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16.0),
          borderSide: const BorderSide(
            color: ColorConstants.mainColor,
          ),
        ),
        hintText: widget.placeholder,
        hintStyle: const TextStyle(
          color: ColorConstants.grey,
          fontSize: 16,
        ),
        filled: true,
        fillColor: ColorConstants.textFieldBackground,
      ),
      onChanged: (text) {
        setState(() {});
        widget.onTextChanged();
      },
    );
  }

  Widget _getShowEye() {
    return GestureDetector(
      onTap: () {
        setState(() {
          stateObscureText = !stateObscureText;
        });
      },
      child: Padding(
        padding: const EdgeInsets.all(12),
        child: Icon(
          stateObscureText ? Icons.visibility : Icons.visibility_off,
          color: widget.controller.text.isNotEmpty
              ? ColorConstants.mainColor
              : ColorConstants.grey,
        ),
      ),
    );
  }

  Widget _getError() {
    return Container(
      padding: const EdgeInsets.only(top: 2),
      child: Text(
        widget.errorText,
        style: const TextStyle(
          fontSize: 14,
          color: ColorConstants.errorColor,
        ),
      ),
    );
  }
}
