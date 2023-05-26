import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:shop_app_/bloc/explor%20cubit/explore_states.dart';
import 'package:shop_app_/responsive/screen_size.dart';
import 'package:shop_app_/widgts/explore_item.dart';
import 'package:shop_app_/widgts/new_item.dart';
import '../bloc/explor cubit/explore_cubit.dart';

// ignore: must_be_immutable
class Explore extends StatelessWidget {
  Explore({Key? key}) : super(key: key);

  bool isIn = false;
  Map<String, dynamic> item = {};
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Padding(
              padding: EdgeInsets.only(top: 25, bottom: 20),
              child: Text(
                "Find Products",
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 24),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(bottom: 10),
              child: SizedBox(
                width: MediaQuery.of(context).size.width * .9,
                child: TextField(
                  onChanged: (value) {
                    BlocProvider.of<ExploreCubit>(context).getSearchItems([
                      "laptops",
                      "groceries",
                      "fragrances",
                      "home-decoration",
                      "skincare",
                      "smartphones"
                    ], value);
                  },
                  decoration: InputDecoration(
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(20)),
                      prefixIcon: const Icon(Icons.search),
                      hintText: "Search store"),
                ),
              ),
            ),
            BlocBuilder<ExploreCubit, ExploreStates>(
              builder: (context, state) {
                switch (state.exploreStatesEnum) {
                  case ExploreStatesEnum.search:
                  if(state.items.isEmpty){
                    return const Expanded(child:  Center(child: Text("Not Found"),));
                  }
                    return Expanded(
                        child: state.items.isNotEmpty
                            ? AnimationLimiter(
                                child: GridView.builder(
                                  itemCount: state.items.length,
                                  gridDelegate:
                                      const SliverGridDelegateWithFixedCrossAxisCount(
                                          crossAxisSpacing: 7,
                                          mainAxisSpacing: 10,
                                          childAspectRatio: .6,
                                          crossAxisCount: 2),
                                  itemBuilder: (context, index) {
                                    return AnimationConfiguration.staggeredGrid(
                                        position: index,
                                        columnCount: 2,
                                        child: SlideAnimation(
                                          duration:
                                              const Duration(milliseconds: 500),
                                          verticalOffset: index % 2 == 0
                                              ? ScreenSize.height
                                              : -ScreenSize.height!,
                                          child: FadeInAnimation(
                                              child: NewItem(
                                                  item: state.items[index])),
                                        ));
                                  },
                                ),
                              )
                            : const SizedBox());

                  case ExploreStatesEnum.initial:
                    return Expanded(
                        child: StreamBuilder(
                            stream: FirebaseFirestore.instance
                                .collection("categorys")
                                .snapshots(),
                            builder: (context,
                                AsyncSnapshot<QuerySnapshot> snapshot) {
                              if (snapshot.hasData) {
                                snapshot.data!.docs.map((element) {
                                  item = element.data() as Map<String, dynamic>;
                                  if (state.items.isEmpty) {
                                    state.items.add(item);
                                  } else {
                                    for (int i = 0;
                                        i < state.items.length;
                                        i++) {
                                      if (state.items[i]["category"] ==
                                          item["category"]) {
                                        isIn = true;
                                        state.items[i] = item;
                                        break;
                                      } else {
                                        isIn = false;
                                      }
                                    }
                                    if (!isIn) {
                                      state.items.add(item);
                                    }
                                  }
                                }).toList();

                                if (ScreenSize.width! <= 380) {}

                                return Padding(
                                  padding:
                                      const EdgeInsets.symmetric(horizontal: 6),
                                  child: GridView.builder(
                                    itemCount: state.items.length,
                                    gridDelegate:
                                        const SliverGridDelegateWithFixedCrossAxisCount(
                                            crossAxisSpacing: 7,
                                            mainAxisSpacing: 10,
                                            childAspectRatio: .87,
                                            crossAxisCount: 2),
                                    itemBuilder: (context, index) {
                                      return ExploreItem(
                                          color: const Color.fromRGBO(
                                              232, 215, 106, 1),
                                          title: state.items[index]["category"]??"",
                                          url: state.items[index]["url"] ??
                                              "images/impty_bag.jpg");
                                    },
                                  ),
                                );
                              } else {
                                return const Center(
                                  child: CircularProgressIndicator(),
                                );
                              }
                            }));

                  default:
                    return const Center(
                      child: CircleAvatar(),
                    );
                }
              },
            ),
          ],
        ),
      ),
    );
  }
}
