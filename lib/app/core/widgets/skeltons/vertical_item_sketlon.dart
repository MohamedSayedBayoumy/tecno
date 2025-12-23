import 'package:flutter/material.dart';
import '../common/skelton.dart';

class verticalItemSkelton extends StatelessWidget {
  double height;

  verticalItemSkelton({required this.height});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 10),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(10),
        child: Container(
          height: height,
          width: height * 1.5,
          decoration: const BoxDecoration(color: Colors.white),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                height: height / 2.2,
                width: height,
                margin: const EdgeInsets.symmetric(horizontal: 10),
                child: skelton(
                  height: 10,
                  width: 10,
                ),
              ),
              Expanded(
                  child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        skelton(height: 15, width: 80),
                        skelton(height: 20, width: 20),
                      ],
                    ),
                    Row(
                      children: [
                        skelton(height: 20, width: 20),
                        const SizedBox(
                          width: 5,
                        ),
                        skelton(height: 15, width: 80),
                        const Spacer(),
                        skelton(height: 15, width: 80),
                      ],
                    ),
                    const SizedBox(
                      height: 5,
                    ),
                    Row(
                      children: [
                        skelton(
                          height: 50,
                          width: 50,
                        ),
                        const VerticalDivider(),
                        Expanded(
                            child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            skelton(height: 15, width: 80),
                            Row(
                              children: [
                                skelton(height: 20, width: 20),
                                const SizedBox(
                                  width: 5,
                                ),
                                skelton(height: 15, width: 80),
                              ],
                            ),
                          ],
                        )),
                      ],
                    )
                  ],
                ),
              ))
            ],
          ),
        ),
      ),
    );
  }
}
