import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class CustomTextFiled extends StatefulWidget {
  final TextEditingController? textEditingController;
  final String title;
  final String hintText;
  final Widget? suffixIcon;
  final Function(String)? onChanged;
  final TextInputType textInputType;
  final List<TextInputFormatter>? inputFormatters;
  const CustomTextFiled({
    super.key,
    this.textEditingController,
    required this.title,
    required this.hintText,
    this.suffixIcon,
    this.onChanged,
    this.textInputType = TextInputType.text,
    this.inputFormatters,
  });

  @override
  State<CustomTextFiled> createState() => _CustomTextFiledState();
}

class _CustomTextFiledState extends State<CustomTextFiled> {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      margin: const EdgeInsets.only(top: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          RichText(
            text: TextSpan(
              style: const TextStyle(
                fontFamily: 'Nunito Sans',
                fontSize: 14,
                color: Colors.black,
                fontWeight: FontWeight.w500,
              ),
              children: [
                TextSpan(
                  text: widget.title,
                ),
                const TextSpan(
                  text: " * ",
                  style: TextStyle(
                    fontFamily: 'Nunito Sans',
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                    color: Colors.red,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 5),
          TextField(
            controller: widget.textEditingController,
            keyboardType: widget.textInputType,
            cursorColor: Colors.grey,
            inputFormatters: widget.inputFormatters,
            decoration: InputDecoration(
              isDense: true,
              hintText: widget.hintText,
              hintStyle: const TextStyle(
                fontFamily: 'NunitoSans',
                fontStyle: FontStyle.normal,
                fontWeight: FontWeight.w400,
                fontSize: 14,
              ),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(6),
                borderSide: const BorderSide(color: Colors.grey),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(6),
                borderSide: const BorderSide(color: Colors.grey),
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(6),
                borderSide: const BorderSide(color: Colors.grey),
              ),
              counterText: '',
              suffixIcon: widget.suffixIcon,
            ),
            onChanged: widget.onChanged,
            style: TextStyle(
              color: Theme.of(context).brightness == Brightness.dark
                  ? Colors.white
                  : Colors.black,
              fontFamily: 'NunitoSans',
              fontSize: 14,
              fontStyle: FontStyle.normal,
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
    );
  }
}
