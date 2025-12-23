import 'package:flutter/material.dart';
import '../common/skelton.dart';

class paymentCardSkelton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
          color: Colors.white, borderRadius: BorderRadius.circular(10)),
      child: Column(
        children: [
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
                  skelton(
                    height: 15,
                    width: 80,
                  ),
                  Row(
                    children: [
                      skelton(
                        height: 20,
                        width: 20,
                      ),
                      const SizedBox(
                        width: 10,
                      ),
                      skelton(
                        height: 15,
                        width: 80,
                      ),
                      const Spacer(),
                      skelton(
                        height: 15,
                        width: 80,
                      )
                    ],
                  ),
                  Row(
                    children: [
                      skelton(
                        height: 20,
                        width: 20,
                      ),
                      const SizedBox(
                        width: 10,
                      ),
                      skelton(
                        height: 15,
                        width: 80,
                      )
                    ],
                  )
                ],
              ))
            ],
          ),
          Row(
            children: [
              Expanded(
                  child: Column(
                children: [
                  Row(
                    children: [
                      Expanded(
                          child: skelton(
                        height: 15,
                        width: 80,
                      )),
                      const SizedBox(
                        width: 20,
                      ),
                      Expanded(
                          child: skelton(
                        height: 15,
                        width: 80,
                      )),
                    ],
                  ),
                  Row(
                    children: [
                      Expanded(
                          child: skelton(
                        height: 15,
                        width: 80,
                      )),
                      const SizedBox(
                        width: 20,
                      ),
                      Expanded(
                          child: skelton(
                        height: 15,
                        width: 80,
                      )),
                    ],
                  ),
                ],
              )),
              const SizedBox(
                width: 20,
              ),
              skelton(
                height: 15,
                width: 80,
              )
            ],
          )
        ],
      ),
    );
  }
}
