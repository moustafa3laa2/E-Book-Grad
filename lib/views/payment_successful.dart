import 'package:bookstore/generated/l10n.dart';
import 'package:bookstore/views/user_nav_bar_m.dart';
import 'package:dotted_dashed_line/dotted_dashed_line.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class PaymentSuccess extends StatelessWidget {
  const PaymentSuccess({super.key, required this.price});
  final String price;

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        leading: IconButton(
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => const UserNavigationBar(),
              ),
            );
          },
          icon: const Icon(
            Icons.arrow_back,
            color: Colors.black,
            size: 30,
          ),
        ),
      ),
      body: Stack(
        children: [
          Center(
            child: Positioned(
              top: height * .01,
              left: width * .4,
              right: width * .5,
              child: Container(
                  width: width * (350 / 390),
                  height: height * (600 / 850),
                  decoration: BoxDecoration(
                      color: const Color(0xFFededed),
                      borderRadius: BorderRadius.circular(20)),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: Column(
                      children: [
                        SizedBox(
                          height: height * .07,
                        ),
                        Text(
                          S.of(context).PaymentSuccessful,
                          style: const TextStyle(
                              fontSize: 25, fontWeight: FontWeight.bold),
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        Text(
                          S.of(context).Thankyouforyourpurchase,
                          style: const TextStyle(
                              fontSize: 22, fontWeight: FontWeight.w400),
                        ),
                        const SizedBox(
                          height: 80,
                        ),
                        Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                S.of(context).Date,
                                style: const TextStyle(
                                    fontSize: 18, fontWeight: FontWeight.w400),
                              ),
                              Text(
                                DateTime.now().toString().substring(0, 10),
                                style: const TextStyle(
                                    fontSize: 18, fontWeight: FontWeight.w400),
                              ),
                            ]),
                        const SizedBox(
                          height: 20,
                        ),
                        Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                S.of(context).Time,
                                style: const TextStyle(
                                    fontSize: 18, fontWeight: FontWeight.w400),
                              ),
                              Text(
                                DateTime.now().toString().substring(11, 16),
                                style: const TextStyle(
                                    fontSize: 18, fontWeight: FontWeight.w400),
                              ),
                            ]),
                        const Divider(
                          thickness: 2,
                          color: Colors.black,
                          height: 60,
                        ),
                        Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                S.of(context).Totall,
                                style: const TextStyle(
                                    fontSize: 24, fontWeight: FontWeight.bold),
                              ),
                              Text(
                                '\$$price',
                                style: const TextStyle(
                                    fontSize: 24, fontWeight: FontWeight.bold),
                              ),
                            ]),
                        SizedBox(
                          height: height * .12,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            const Icon(
                              FontAwesomeIcons.barcode,
                              size: 64,
                            ),
                            Container(
                              width: width * .3,
                              height: height * .07,
                              decoration: ShapeDecoration(
                                shape: RoundedRectangleBorder(
                                  side: const BorderSide(
                                      color: Colors.black, width: 1.5),
                                  borderRadius: BorderRadius.circular(15),
                                ),
                              ),
                              child: Center(
                                child: Text(
                                  S.of(context).PAID,
                                  style: const TextStyle(
                                      fontSize: 24,
                                      fontWeight: FontWeight.bold),
                                ),
                              ),
                            )
                          ],
                        )
                      ],
                    ),
                  )),
            ),
          ),
          Positioned(
            top: height * .04,
            left: width * 0,
            right: width * .0,
            child: const CircleAvatar(
              backgroundColor: Color(0xFFededed),
              radius: 50,
              child: CircleAvatar(
                backgroundColor: Colors.green,
                radius: 40,
                child: Icon(
                  Icons.check,
                  color: Colors.white,
                  size: 50,
                ),
              ),
            ),
          ),
          Positioned(
              bottom: height * .25,
              left: 0,
              child: const CircleAvatar(
                backgroundColor: Colors.white,
              )),
          Positioned(
              bottom: height * .25,
              right: 0,
              child: const CircleAvatar(
                backgroundColor: Colors.white,
              )),
          Positioned(
              bottom: height * .28,
              right: 0,
              left: 0,
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: width * .12),
                child: const DottedDashedLine(
                  height: 0,
                  width: 0,
                  axis: Axis.horizontal,
                  dashColor: Colors.black,
                  dashSpace: 6,
                  strokeWidth: 2,
                ),
              )),
        ],
      ),
    );
  }
}
