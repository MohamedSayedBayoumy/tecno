import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../core/widgets/buttons/custom_app_button.dart';
import '../../../core/widgets/inputs/custom_text_form_field.dart';

class RateBottomSheet extends StatefulWidget {
  const RateBottomSheet(
      {super.key, required this.title, required this.onSubmit});
  final String title;
  final void Function(int, String) onSubmit;

  @override
  State<RateBottomSheet> createState() => _RateBottomSheetState();
}

class _RateBottomSheetState extends State<RateBottomSheet> {
  int _rating = 0;
  final TextEditingController _commentController = TextEditingController();

  Widget _buildStars() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: List.generate(5, (index) {
        return IconButton(
          icon: Icon(
            index < _rating
                ? Icons.star_rate_rounded
                : Icons.star_border_rounded,
            color: Colors.amber,
            size: 32,
          ),
          onPressed: () {
            setState(() {
              _rating = index + 1;
            });
          },
        );
      }),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(
        bottom: MediaQuery.of(context).viewInsets.bottom,
      ),
      child: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                width: 40,
                height: 4,
                margin: const EdgeInsets.only(bottom: 16),
                decoration: BoxDecoration(
                  color: Colors.grey[400],
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
              Text(
                widget.title.tr,
                style:
                    const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 16),
              _buildStars(),
              const SizedBox(height: 16),
              CustomTextFormFieldWidget(
                title: "comment_hint",
                controller: _commentController,
                maxLines: 8,
                action: (p0) {},
              ),
              const SizedBox(height: 20),
              CustomAppButton(
                text: "Apply",
                action: () {
                  Navigator.pop(context);
                  widget.onSubmit(_rating, _commentController.text);
                },
              ),
              const SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }
}
