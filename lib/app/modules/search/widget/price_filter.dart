import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../controllers/search_controller.dart';

class PriceRangeWidget extends StatefulWidget {
  const PriceRangeWidget({super.key});

  @override
  State<PriceRangeWidget> createState() => _PriceRangeWidgetState();
}

class _PriceRangeWidgetState extends State<PriceRangeWidget> {
  final controller = Get.find<SearchControllers>();

  RangeValues values = const RangeValues(1, 125000);
  TextEditingController minCtrl = TextEditingController(text: "1");
  TextEditingController maxCtrl = TextEditingController(text: "125000");

  _buildQuery(RangeValues values) {
    final from = values.start.toInt();
    final to = values.end.toInt();
    controller.setParam("min_price", from.toString());
    controller.setParam("max_price", to.toString());
  }

  @override
  void initState() {
    super.initState();
    initValues();
  }
  
  
  

  initValues() {
    if (controller.params.containsKey("min_price")) {
      minCtrl.text = controller.params["max_price"] ?? "1";
      values = RangeValues(
          double.parse(controller.params["min_price"].toString()), 125000);
    }
    if (controller.params.containsKey("max_price")) {
      maxCtrl.text = controller.params["max_price"] ?? "125000";
      values = RangeValues(
        double.parse(controller.params["min_price"].toString()),
        double.parse(controller.params["max_price"].toString()),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        // Range Slider with value indicator
        SliderTheme(
          data: SliderTheme.of(context).copyWith(
            showValueIndicator: ShowValueIndicator.always,
            valueIndicatorColor: Colors.indigo[900],
            valueIndicatorTextStyle: const TextStyle(
              color: Colors.white,
              fontSize: 12,
            ),
            overlayShape: SliderComponentShape.noOverlay,
          ),
          child: RangeSlider(
            values: values,
            min: 1,
            max: 125000,
            divisions: 100,
            activeColor: Colors.indigo[900],
            inactiveColor: Colors.grey.shade300,
            labels: RangeLabels(
              values.start.toInt().toString(),
              values.end.toInt().toString(),
            ),
            onChanged: (RangeValues newValues) {
              setState(() {
                values = newValues;
                minCtrl.text = newValues.start.toInt().toString();
                maxCtrl.text = newValues.end.toInt().toString();
                _buildQuery(values);
              });
            },
          ),
        ),

        const SizedBox(height: 30),

        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // min
            Expanded(
              child: TextField(
                controller: minCtrl,
                keyboardType: TextInputType.number,
                textAlign: TextAlign.center,
                decoration: const InputDecoration(
                  labelText: "من",
                  border: OutlineInputBorder(),
                ),
                onSubmitted: (val) {
                  setState(() {
                    double? parsed = double.tryParse(val);
                    if (parsed != null && parsed <= values.end) {
                      values = RangeValues(parsed, values.end);
                      _buildQuery(values);
                    }
                  });
                },
              ),
            ),
            const SizedBox(width: 10),

            // max
            Expanded(
              child: TextField(
                controller: maxCtrl,
                keyboardType: TextInputType.number,
                textAlign: TextAlign.center,
                decoration: const InputDecoration(
                  labelText: "إلى",
                  border: OutlineInputBorder(),
                ),
                onSubmitted: (val) {
                  setState(() {
                    double? parsed = double.tryParse(val);
                    if (parsed != null && parsed >= values.start) {
                      values = RangeValues(values.start, parsed);
                      _buildQuery(values);
                    }
                  });
                },
              ),
            ),
          ],
        ),
      ],
    );
  }
}
