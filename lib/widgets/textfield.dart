import 'package:flutter/material.dart';

class CustomTextField extends StatefulWidget {
  final String title;
  final TextEditingController controller;
  final String hinttext;
  final bool obscureText;

  const CustomTextField(
      {Key? key,
      required this.title,
      required this.controller,
      required this.hinttext,
      required this.obscureText})
      : super(key: key);

  @override
  State<CustomTextField> createState() => _CustomTextFieldState();
}

class _CustomTextFieldState extends State<CustomTextField> {
  late FocusNode focusnode;
  bool isInFocus = false;

  @override
  void initState() {
    super.initState();
    focusnode = FocusNode();

    focusnode.addListener(() {
      if (focusnode.hasFocus) {
        setState(() {
          isInFocus = true;
        });
      } else {
        setState(() {
          isInFocus = false;
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(bottom: 8.0),
          child: Text(
            widget.title,
            style: const TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
        const SizedBox(
          height: 5,
        ),
        Container(
          decoration: BoxDecoration(
            boxShadow: [
              isInFocus
                  ? BoxShadow(
                      color: Colors.orange.withOpacity(0.5),
                      blurRadius: 10,
                      spreadRadius: 3,
                    )
                  : const BoxShadow(
                      color: Color.fromARGB(31, 26, 25, 25),
                      blurRadius: 10,
                      spreadRadius: 3,
                    )
            ],
          ),
          child: TextField(
            focusNode: focusnode,
            maxLines: 1,
            controller: widget.controller,
            obscureText: widget.obscureText,
            decoration: InputDecoration(
                fillColor: Colors.white,
                filled: true,
                isDense: true,
                contentPadding: const EdgeInsets.all(13),
                hintText: widget.hinttext,
                border: OutlineInputBorder(
                  borderSide: const BorderSide(color: Colors.black54, width: 1),
                  borderRadius: BorderRadius.circular(5),
                ),
                focusedBorder: const OutlineInputBorder(
                    borderSide: BorderSide(
                  color: Colors.orange,
                  width: 1,
                ))
                // contentPadding: const EdgeInsets.symmetric(
                //   horizontal: 20,
                //   vertical: 10,
                // ),
                ),
          ),
        ),
      ],
    );
  }
}
