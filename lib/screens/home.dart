import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:shop_app_/widgts/new_item.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'explore_details.dart';

// ignore: must_be_immutable
class HomeScreen extends StatelessWidget {
  HomeScreen({Key? key}) : super(key: key);

  // ignore: non_constant_identifier_names
  PageController PageViewController = PageController();

  List<String> banners = [
    "images/frag.jpg",
    "images/laptops.jpg",
    "images/phones.jpg",
  ];
  int itemIndex = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(top: 20),
                    child: SizedBox(
                      height: MediaQuery.of(context).size.height * .15,
                      width: 370,
                      child: PageView(
                        controller: PageViewController,
                        children: [
                          Image.asset(
                            banners[0],
                            fit: BoxFit.fill,
                          ),
                          Image.asset(
                            banners[1],
                            fit: BoxFit.cover,
                          ),
                          Image.asset(
                            banners[2],
                            fit: BoxFit.contain,
                          ),
                        ],
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 10),
                    child: SmoothPageIndicator(
                      controller: PageViewController,
                      count: 3,
                      effect: ExpandingDotsEffect(
                          dotWidth: 10,
                          dotHeight: 10,
                          spacing: 15,
                          dotColor: Colors.grey,
                          activeDotColor: Theme.of(context).primaryColor),
                    ),
                  )
                ],
              ),
            ),
            ListViewItems(context: context, title: "Laptops", id: "laptops"),
            const SizedBox(
              height: 40,
            ),
            ListViewItems(
                context: context, title: "Smartphones", id: "smartphones"),
            const SizedBox(
              height: 40,
            ),
          ],
        ),
      ),
    );
  }

  // ignore: non_constant_identifier_names
  Column ListViewItems({
    required BuildContext context,
    required String title,
    required String id,
  }) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                title,
                style:
                    const TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
              ),
              TextButton(
                child: Text(
                  "See all",
                  style: TextStyle(
                      fontSize: 15,
                      color: Theme.of(context).primaryColor,
                      fontWeight: FontWeight.bold),
                ),
                onPressed: () {
                  Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) =>
                        ExploreDetails(id: title.toLowerCase()),
                  ));
                },
              )
            ],
          ),
        ),
        SizedBox(
          height: 300,
          child: StreamBuilder(
            stream: FirebaseFirestore.instance
                .collection("categorys")
                .doc(id)
                .collection("products")
                .snapshots(),
            builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
              if (!snapshot.hasData) {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              }
              return ListView(
                scrollDirection: Axis.horizontal,
                children: snapshot.data!.docs.map((item) {
                  return NewItem(item: item.data() as Map);
                }).toList(),
              );
            },
          ),
        )
      ],
    );
  }

  // Widget doubleListViewItems({
  //   required BuildContext context,
  //   required String title,
  //   required List<String> itemNames,
  //   required String subTitle,
  //   required String price,
  //   required String imageUrl,
  // }) {
  //   return SizedBox(
  //       height: MediaQuery.of(context).size.height * 0.6,
  //       width: double.infinity,
  //       child: Column(
  //         children: [
  //           Padding(
  //             padding: const EdgeInsets.symmetric(horizontal: 8.0),
  //             child: Row(
  //               mainAxisAlignment: MainAxisAlignment.spaceBetween,
  //               children: [
  //                 Text(
  //                   title,
  //                   style: const TextStyle(
  //                       fontSize: 25, fontWeight: FontWeight.bold),
  //                 ),
  //                 TextButton(
  //                   child: Text(
  //                     "See all",
  //                     style: TextStyle(
  //                         fontSize: 15,
  //                         color: Theme.of(context).primaryColor,
  //                         fontWeight: FontWeight.bold),
  //                   ),
  //                   onPressed: () {},
  //                 )
  //               ],
  //             ),
  //           ),
  //           SizedBox(
  //               height: 100,
  //               width: double.infinity,
  //               child: ListView.builder(
  //                 scrollDirection: Axis.horizontal,
  //                 itemCount: 2,
  //                 itemBuilder: (context, index) {
  //                   return Container(
  //                     decoration: BoxDecoration(
  //                       border: Border.all(color: Colors.grey),
  //                       borderRadius: BorderRadius.circular(20),
  //                       color: Color.fromRGBO(83, 177, 117, .4),
  //                     ),
  //                     margin: const EdgeInsets.symmetric(horizontal: 10),
  //                     height: 50,
  //                     width: MediaQuery.of(context).size.width * .6,
  //                     child: LayoutBuilder(
  //                       builder: (context, constraints) => Row(
  //                         children: [
  //                           SizedBox(
  //                             width: constraints.maxWidth / 2.7,
  //                             child: Image.asset("images/logo.png"),
  //                           ),
  //                           Text("data")
  //                         ],
  //                       ),
  //                     ),
  //                   );
  //                 },
  //               )),
  //           Expanded(
  //               child: ListView.builder(
  //                   itemCount: 3,
  //                   scrollDirection: Axis.horizontal,
  //                   itemBuilder: (context, index) {
  //                     return Padding(
  //                       padding: const EdgeInsets.all(8.0),
  //                       child: Container(
  //                         height: MediaQuery.of(context).size.height * 0.3,
  //                         width: MediaQuery.of(context).size.width / 2.1,
  //                         decoration: BoxDecoration(
  //                             // color: Colors.redAccent,
  //                             border: Border.all(color: Colors.grey, width: .7),
  //                             borderRadius: BorderRadius.circular(25)),
  //                         child: LayoutBuilder(
  //                           builder: (context, constraints) => Padding(
  //                             padding: const EdgeInsets.all(8.0),
  //                             child: Column(
  //                               mainAxisAlignment: MainAxisAlignment.start,
  //                               crossAxisAlignment: CrossAxisAlignment.start,
  //                               children: [
  //                                 Container(
  //                                     margin: const EdgeInsets.only(bottom: 10),
  //                                     height: constraints.maxHeight / 2.2,
  //                                     width: double.infinity,
  //                                     child:
  //                                         Center(child: Image.asset(imageUrl))),
  //                                 Text(
  //                                   itemNames[index],
  //                                   style: const TextStyle(
  //                                       fontSize: 20,
  //                                       fontWeight: FontWeight.bold),
  //                                 ),
  //                                 Text(
  //                                   subTitle,
  //                                   style: const TextStyle(
  //                                       fontSize: 18, color: Colors.grey),
  //                                 ),
  //                                 const Spacer(),
  //                                 Row(
  //                                   mainAxisAlignment:
  //                                       MainAxisAlignment.spaceBetween,
  //                                   children: [
  //                                     Text(
  //                                       "$price\$",
  //                                       style: const TextStyle(
  //                                           fontSize: 20,
  //                                           fontWeight: FontWeight.bold),
  //                                     ),
  //                                     ElevatedButton(
  //                                         style: ButtonStyle(
  //                                             minimumSize:
  //                                                 MaterialStateProperty.all<
  //                                                     Size>(const Size(50, 50)),
  //                                             backgroundColor:
  //                                                 MaterialStateProperty.all<
  //                                                     Color>(
  //                                               const Color.fromRGBO(
  //                                                   83, 177, 117, 1),
  //                                             ),
  //                                             shape: MaterialStateProperty.all<
  //                                                     RoundedRectangleBorder>(
  //                                                 RoundedRectangleBorder(
  //                                                     borderRadius:
  //                                                         BorderRadius.circular(
  //                                                             15)))),
  //                                         onPressed: () {},
  //                                         child: const Icon(
  //                                           Icons.add,
  //                                           size: 30,
  //                                         )),
  //                                   ],
  //                                 )
  //                               ],
  //                             ),
  //                           ),
  //                         ),
  //                       ),
  //                     );
  //                   })),
  //         ],
  //       ));
  // }

}
