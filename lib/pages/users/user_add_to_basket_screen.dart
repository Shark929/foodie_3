import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:foodie_3/components/button_component1.dart';
import 'package:foodie_3/pages/users/user_home_screen.dart';

class AddToBasketScreen extends StatefulWidget {
  final String username;
  final QueryDocumentSnapshot<Map<String, dynamic>> foodData;
  const AddToBasketScreen(
      {super.key, required this.foodData, required this.username});

  @override
  State<AddToBasketScreen> createState() => _AddToBasketScreenState();
}

class _AddToBasketScreenState extends State<AddToBasketScreen> {
  String choice = "";
  int quantity = 1;
  double totalAmount = 0;
  double price = 0;
  double additionPrice = 0;
  // bool isCheck = false;
  List isCheck = [];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(),
        body: Stack(
          children: [
            SingleChildScrollView(
              child: SizedBox(
                height: MediaQuery.of(context).size.height,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      height: 230,
                      width: MediaQuery.of(context).size.width,
                      decoration: BoxDecoration(
                          image: DecorationImage(
                              image: NetworkImage(widget.foodData['image']),
                              fit: BoxFit.cover)),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      child: Row(
                        children: [
                          Text(
                            widget.foodData['item_name'],
                            style: const TextStyle(
                                fontSize: 18, fontWeight: FontWeight.w600),
                          ),
                          const Spacer(),
                          Text(
                            double.parse(widget.foodData['price'])
                                .toStringAsFixed(2),
                            style: const TextStyle(
                                fontSize: 18, fontWeight: FontWeight.w600),
                          ),
                        ],
                      ),
                    ),
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      alignment: Alignment.centerRight,
                      child: const Text(
                        "Base price",
                        style: TextStyle(
                            color: Colors.grey, fontWeight: FontWeight.w600),
                      ),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      alignment: Alignment.centerLeft,
                      child: Text(
                        widget.foodData["item_description"],
                        style: const TextStyle(
                            color: Colors.grey, fontWeight: FontWeight.w400),
                      ),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      child: const Text(
                        "Your choices",
                        style: TextStyle(
                            fontSize: 16, fontWeight: FontWeight.w600),
                      ),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16.0),
                      child: StreamBuilder(
                          stream: FirebaseFirestore.instance
                              .collection("Customization")
                              .snapshots(),
                          builder: (context, snapshot) {
                            if (snapshot.hasData) {
                              return ListView.builder(
                                  physics: const NeverScrollableScrollPhysics(),
                                  shrinkWrap: true,
                                  itemCount: snapshot.data!.docs.length,
                                  itemBuilder: (context, index) {
                                    if (snapshot.data!.docs[index]
                                            ['item_code'] ==
                                        widget.foodData['item_code']) {
                                      for (int i = 0;
                                          i < snapshot.data!.docs.length;
                                          i++) {
                                        if (isCheck.isEmpty ||
                                            isCheck.length <
                                                snapshot.data!.docs.length) {
                                          isCheck.add("0");
                                        }
                                      }

                                      return Padding(
                                        padding:
                                            const EdgeInsets.only(bottom: 8.0),
                                        child: Row(
                                          children: [
                                            InkWell(
                                              onTap: () {
                                                if (isCheck[index] == "0") {
                                                  setState(() {
                                                    isCheck[index] = "1";
                                                  });
                                                } else {
                                                  setState(() {
                                                    isCheck[index] = "0";
                                                  });
                                                }

                                                if (isCheck[index] == "1") {
                                                  choice = snapshot.data!
                                                      .docs[index]['choice'];
                                                  price = double.parse(
                                                      widget.foodData['price']);
                                                  additionPrice = double.parse(
                                                      snapshot.data!.docs[index]
                                                          ['price']);
                                                }
                                                print(snapshot.data!.docs[index]
                                                    ['price']);
                                              },
                                              child: Container(
                                                width: 25,
                                                height: 25,
                                                decoration: BoxDecoration(
                                                  border: Border.all(
                                                      color: Colors.black),
                                                  borderRadius:
                                                      BorderRadius.circular(50),
                                                ),
                                                child: isCheck[index] == "1"
                                                    ? Image.asset(
                                                        "assets/check-mark.png",
                                                        color: Colors.amber,
                                                      )
                                                    : const SizedBox(),
                                              ),
                                            ),
                                            const SizedBox(
                                              width: 16,
                                            ),
                                            Text(snapshot.data!.docs[index]
                                                ['choice']),
                                            const Spacer(),
                                            Text(
                                                "+ RM${double.parse(snapshot.data!.docs[index]['price']).toStringAsFixed(2)}")
                                          ],
                                        ),
                                      );
                                    }
                                    return const SizedBox();
                                  });
                            }
                            return const SizedBox();
                          }),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        InkWell(
                          onTap: () {
                            if (quantity > 1) {
                              setState(() {
                                quantity--;
                              });
                            }
                          },
                          child: Container(
                            width: 30,
                            height: 30,
                            decoration: BoxDecoration(
                                border: Border.all(),
                                borderRadius: BorderRadius.circular(8)),
                            child: const Icon(
                              Icons.remove,
                              color: Colors.amber,
                            ),
                          ),
                        ),
                        const SizedBox(
                          width: 16,
                        ),
                        Text(
                          quantity.toString(),
                          style: const TextStyle(
                              fontWeight: FontWeight.w600, fontSize: 18),
                        ),
                        const SizedBox(
                          width: 16,
                        ),
                        InkWell(
                          onTap: () {
                            if (quantity < 100) {
                              setState(() {
                                quantity++;
                              });
                            }
                          },
                          child: Container(
                            width: 30,
                            height: 30,
                            decoration: BoxDecoration(
                                border: Border.all(),
                                borderRadius: BorderRadius.circular(8)),
                            child: const Icon(
                              Icons.add,
                              color: Colors.amber,
                            ),
                          ),
                        )
                      ],
                    ),
                  ],
                ),
              ),
            ),
            Positioned(
                bottom: 0,
                right: 16,
                left: 16,
                child: Column(
                  children: [
                    ButtonComponent1(
                      buttonFunction: () {
                        /**
                         * Calculation of total amount before add to basket
                         */
                        print("add ${widget.username}");
                        print("additional price: $additionPrice");
                        print("base price: $price");
                        totalAmount = (price + additionPrice) * quantity;
                        print("totalAmount: $totalAmount");
                        DateTime now = DateTime.now();
                        // String time =
                        //     "${now.day} ${now.month} ${now.year} at ${now.hour}:${now.minute}";
                        FirebaseFirestore.instance.collection("Cart").add({
                          "order_number": "",
                          "time": "${now.hour}:${now.minute}",
                          "day": "${now.day}",
                          "month": "${now.month}",
                          "year": "${now.year}",
                          "username": widget.username,
                          "total_price": totalAmount.toStringAsFixed(2),
                          "image": widget.foodData['image'],
                          "item_name": widget.foodData['item_name'],
                          "choice": choice,
                          "quantity": quantity,
                          "vendor": widget.foodData['username'],
                          "price": price.toStringAsFixed(2),
                          "pick_up": "",
                          "cart_code": "1",
                          "reason": "",
                          "dine_in_code": "1", // 1-dinein, 0-takeaaway
                          /**
                           * cart code
                           * 0 - cancelled
                           * 1 - add to cart
                           * 2 - paid
                           * 3 - order confirm
                           * 4 - order in progress
                           * 5 - order completed
                           * 6 - vendor cancel order
                           */
                        }).then((value) {
                          Navigator.pushAndRemoveUntil(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => UserHomeScreen(
                                        username: widget.username,
                                      )),
                              (route) => false);
                        });
                      },
                      buttonTitle: 'Add To Basket',
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                  ],
                ))
          ],
        ));
  }
}
