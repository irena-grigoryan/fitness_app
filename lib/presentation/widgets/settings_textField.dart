import 'package:fitness_app/presentation/constants/color_constants.dart';
import 'package:flutter/material.dart';

class SettingsTextField extends StatefulWidget {
  final TextEditingController controller;
  final bool obscureText;
  final String placeHolder;

  const SettingsTextField({
    Key? key,
    required this.controller,
    this.obscureText = false,
    required this.placeHolder,
  }) : super(key: key);

  @override
  _SettingsTextFieldState createState() => _SettingsTextFieldState();
}

class _SettingsTextFieldState extends State<SettingsTextField> {
  final focusNode = FocusNode();
  bool stateObscureText = false;

  @override
  void initState() {
    super.initState();

    stateObscureText = widget.obscureText;
  }

  @override
  void didUpdateWidget(covariant SettingsTextField oldWidget) {
    super.didUpdateWidget(oldWidget);

    stateObscureText = widget.obscureText;
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Stack(
            children: [
              _createSettingsTextField(),
              if (widget.obscureText) ...[
                Positioned(
                  right: 0,
                  bottom: 0,
                  top: 0,
                  child: _createShowEye(),
                ),
              ],
            ],
          ),
        ],
      ),
    );
  }

  Widget _createSettingsTextField() {
    return TextField(
      textAlignVertical: TextAlignVertical.center,
      focusNode: focusNode,
      controller: widget.controller,
      obscureText: stateObscureText,
      style: const TextStyle(fontWeight: FontWeight.w600),
      decoration: InputDecoration(
        hintText: widget.placeHolder,
        hintStyle: const TextStyle(color: ColorConstants.grey, fontSize: 16),
        border: InputBorder.none,
        focusedBorder: InputBorder.none,
        enabledBorder: InputBorder.none,
        errorBorder: InputBorder.none,
        disabledBorder: InputBorder.none,
      ),
    );
  }

  Widget _createShowEye() {
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
}
