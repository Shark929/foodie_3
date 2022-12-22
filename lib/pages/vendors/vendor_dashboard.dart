import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class VendorDashboard extends StatefulWidget {
  final String vendorUsername;
  const VendorDashboard({super.key, required this.vendorUsername});

  @override
  State<VendorDashboard> createState() => _VendorDashboardState();
}

class _VendorDashboardState extends State<VendorDashboard> {
  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
        stream: FirebaseFirestore.instance.collection("Cart").snapshots(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            for (int i = 0; i < snapshot.data!.docs.length; i++) {
              if (snapshot.data!.docs[i]['username'] == widget.vendorUsername) {
                /**
                 * Sales of the day
                 * Sales of the month
                 * Sales of the year
                 * Revenue
                 * Customer
                 * percentage of dine in and takeaway
                 */

                DateTime now = DateTime.now();

                double dailySales = 0.0;
                double monthlySales = 0.0;
                double yearlySales = 0.0;
                double revenue = 0.0;
                int numberOfCustomers = 0;
                int totalOrders = 0; // total orders will get from quantity
                double dineInNumber = 0.0;
                double dineInPercentage = 0.0;
                double takeawayPercentage = 0.0;
                //calculate total daily sales
                for (int i = 0; i < snapshot.data!.docs.length; i++) {
                  if (snapshot.data!.docs[i]['vendor'] ==
                              widget.vendorUsername &&
                          snapshot.data!.docs[i]['day'] == now.day.toString() &&
                          snapshot.data!.docs[i]['cart_code'] != "0" ||
                      snapshot.data!.docs[i]['month'] == now.day.toString() &&
                          snapshot.data!.docs[i]['cart_code'] != "6") {
                    dailySales +=
                        double.parse(snapshot.data!.docs[i]['total_price']);
                  }
                  print("total ${now.day} sales: $dailySales");
                }
                //calculate total monthly sales
                for (int i = 0; i < snapshot.data!.docs.length; i++) {
                  if (snapshot.data!.docs[i]['vendor'] ==
                              widget.vendorUsername &&
                          snapshot.data!.docs[i]['month'] ==
                              now.month.toString() &&
                          snapshot.data!.docs[i]['cart_code'] != "0" ||
                      snapshot.data!.docs[i]['month'] == now.month.toString() &&
                          snapshot.data!.docs[i]['cart_code'] != "6") {
                    monthlySales +=
                        double.parse(snapshot.data!.docs[i]['total_price']);
                  }
                  print("total daily sales: $monthlySales");
                }
                //calculate total yearly sales
                for (int i = 0; i < snapshot.data!.docs.length; i++) {
                  if (snapshot.data!.docs[i]['vendor'] ==
                              widget.vendorUsername &&
                          snapshot.data!.docs[i]['year'] ==
                              now.year.toString() &&
                          snapshot.data!.docs[i]['cart_code'] != "0" ||
                      snapshot.data!.docs[i]['year'] == now.year.toString() &&
                          snapshot.data!.docs[i]['cart_code'] != "6") {
                    yearlySales +=
                        double.parse(snapshot.data!.docs[i]['total_price']);
                  }
                  print("total daily sales: $yearlySales");
                }

                //calculate total revenue
                for (int i = 0; i < snapshot.data!.docs.length; i++) {
                  if (snapshot.data!.docs[i]['cart_code'] != "0" &&
                      snapshot.data!.docs[i]['cart_code'] != "6") {
                    revenue +=
                        double.parse(snapshot.data!.docs[i]['total_price']);
                  }
                }

                //calculate total customers
                for (int i = 0; i < snapshot.data!.docs.length; i++) {
                  if (snapshot.data!.docs[i]['vendor'] ==
                          widget.vendorUsername &&
                      snapshot.data!.docs[i]['cart_code'] != "0" &&
                      snapshot.data!.docs[i]['cart_code'] != "6") {
                    numberOfCustomers++;
                  }
                  print("total numberOfOrders sales: $numberOfCustomers");
                }

                //calculate total orders
                for (int i = 0; i < snapshot.data!.docs.length; i++) {
                  if (snapshot.data!.docs[i]['vendor'] ==
                          widget.vendorUsername &&
                      snapshot.data!.docs[i]['cart_code'] != "0" &&
                      snapshot.data!.docs[i]['cart_code'] != "6") {
                    totalOrders += int.parse(
                        snapshot.data!.docs[i]['quantity'].toString());
                  }
                  print("total numberOfOrders sales: $totalOrders");
                }

                //calculate dineInPercentage
                for (int i = 0; i < snapshot.data!.docs.length; i++) {
                  if (snapshot.data!.docs[i]['vendor'] ==
                          widget.vendorUsername &&
                      snapshot.data!.docs[i]['cart_code'] != "0" &&
                      snapshot.data!.docs[i]['cart_code'] != "6" &&
                      snapshot.data!.docs[i]['dine_in_code'] == "1") {
                    dineInNumber++;
                  }
                  dineInPercentage = dineInNumber * 100 / numberOfCustomers;
                }

                takeawayPercentage = 100 - dineInPercentage;
                return SingleChildScrollView(
                  child: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const SizedBox(
                          height: 20,
                        ),
                        const Text(
                          "Sales",
                          style: TextStyle(fontSize: 24),
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Container(
                              width: MediaQuery.of(context).size.width / 3.5,
                              height: 100,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(8),
                                  border: Border.all(
                                      color: Colors.amber, width: 2)),
                              child: Column(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                children: [
                                  const Text(
                                    "Day",
                                    style: TextStyle(fontSize: 24),
                                  ),
                                  Text(
                                    "RM ${dailySales.toStringAsFixed(2)}",
                                    style: const TextStyle(
                                        fontSize: 20,
                                        fontWeight: FontWeight.w600),
                                  ),
                                ],
                              ),
                            ),
                            Container(
                              width: MediaQuery.of(context).size.width / 3.5,
                              height: 100,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(8),
                                  border: Border.all(
                                      color: Colors.amber, width: 2)),
                              child: Column(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                children: [
                                  const Text(
                                    "Month",
                                    style: TextStyle(fontSize: 24),
                                  ),
                                  Text(
                                    "RM ${monthlySales.toStringAsFixed(2)}",
                                    style: const TextStyle(
                                        fontSize: 20,
                                        fontWeight: FontWeight.w600),
                                  ),
                                ],
                              ),
                            ),
                            Container(
                              width: MediaQuery.of(context).size.width / 3.5,
                              height: 100,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(8),
                                  border: Border.all(
                                      color: Colors.amber, width: 2)),
                              child: Column(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                children: [
                                  const Text(
                                    "Year",
                                    style: TextStyle(fontSize: 24),
                                  ),
                                  Text(
                                    "RM ${yearlySales.toStringAsFixed(2)}",
                                    style: const TextStyle(
                                        fontSize: 20,
                                        fontWeight: FontWeight.w600),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        Container(
                          width: MediaQuery.of(context).size.width,
                          height: 100,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(8),
                              border:
                                  Border.all(color: Colors.amber, width: 2)),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              const Text(
                                "Revenue",
                                style: TextStyle(fontSize: 24),
                              ),
                              Text(
                                "RM ${revenue.toStringAsFixed(2)}",
                                style: const TextStyle(
                                    fontSize: 36, fontWeight: FontWeight.w600),
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Container(
                              width: MediaQuery.of(context).size.width / 2.5,
                              height: 100,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(8),
                                  border: Border.all(
                                      color: Colors.amber, width: 2)),
                              child: Column(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                children: [
                                  const Text(
                                    "Total Orders",
                                    style: TextStyle(fontSize: 24),
                                  ),
                                  Text(
                                    totalOrders.toString(),
                                    style: const TextStyle(
                                        fontSize: 36,
                                        fontWeight: FontWeight.w600),
                                  ),
                                ],
                              ),
                            ),
                            Container(
                              width: MediaQuery.of(context).size.width / 2.5,
                              height: 100,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(8),
                                  border: Border.all(
                                      color: Colors.amber, width: 2)),
                              child: Column(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                children: [
                                  const Text(
                                    "Customers",
                                    style: TextStyle(fontSize: 24),
                                  ),
                                  Text(
                                    numberOfCustomers.toString(),
                                    style: const TextStyle(
                                        fontSize: 36,
                                        fontWeight: FontWeight.w600),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Container(
                              width: MediaQuery.of(context).size.width / 2.5,
                              height: 100,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(8),
                                  border: Border.all(
                                      color: Colors.amber, width: 2)),
                              child: Column(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                children: [
                                  const Text(
                                    "Dine In",
                                    style: TextStyle(fontSize: 24),
                                  ),
                                  Text(
                                    "$dineInPercentage%",
                                    style: const TextStyle(
                                        fontSize: 32,
                                        fontWeight: FontWeight.w600),
                                  ),
                                ],
                              ),
                            ),
                            Container(
                              width: MediaQuery.of(context).size.width / 2.5,
                              height: 100,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(8),
                                  border: Border.all(
                                      color: Colors.amber, width: 2)),
                              child: Column(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                children: [
                                  const Text(
                                    "Take Away",
                                    style: TextStyle(fontSize: 24),
                                  ),
                                  Text(
                                    "$takeawayPercentage%",
                                    style: const TextStyle(
                                        fontSize: 32,
                                        fontWeight: FontWeight.w600),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                );
              }
            }
          }
          return const SizedBox();
        });
  }
}
