import 'package:flutter/material.dart';
import 'package:shop_app_/custom.dart';
import 'package:shop_app_/responsive/screen_size.dart';
import 'package:shop_app_/widgts/button.dart';
import 'package:shop_app_/widgts/counter.dart';
import 'package:shop_app_/widgts/expansion_tile.dart';
import 'package:shop_app_/widgts/favourite_icon.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import '../refrence.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';

// ignore: must_be_immutable
class Details extends StatelessWidget {
  Details({Key? key}) : super(key: key);
  // ignore: non_constant_identifier_names
  PageController PageViewController = PageController();
  int i = 0;
  Ref ref = Ref(value: 1);
  List? images;
  @override
  Widget build(BuildContext context) {
    images = custom.getBloc(context).item["images"] as List;
    double height = MediaQuery.of(context).size.height;
    return Scaffold(
      body: SingleChildScrollView(
        child: AnimationLimiter(
          child: Column(
              children: AnimationConfiguration.toStaggeredList(
            childAnimationBuilder: (columnItem) {
              return SlideAnimation(
                  duration: Duration(milliseconds: i++ * 400),
                  verticalOffset: ScreenSize.height! / 1.5,
                  child: FadeInAnimation(
                    child: columnItem,
                  ));
            },
            children: [
              SizedBox(
                height: 40,
                child: Row(
                  children: [
                    IconButton(
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        icon: const Icon(Icons.arrow_back)),
                  ],
                ),
              ),
              SizedBox(
                height: height / 3,
                child: PageView.builder(
                  controller: PageViewController,
                  itemCount: images!.length,
                  itemBuilder: (context, index) {
                    return Image.network(images![index]);
                  },
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 10),
                child: SmoothPageIndicator(
                  controller: PageViewController,
                  count: images!.length,
                  effect: SlideEffect(
                      dotWidth: 10,
                      dotHeight: 10,
                      spacing: 15,
                      dotColor: Colors.grey,
                      activeDotColor: Theme.of(context).primaryColor),
                ),
              ),
             
          Column(
            children: [
                  SizedBox(
                height: 50,
                child: Padding(
                  padding: const EdgeInsets.only(right: 15),
                  child: Row(
                    children: [
                      Expanded(
                        child: ListTile(
                          title: Text(
                            custom.getBloc(context).item["title"],
                            style: const TextStyle(
                                fontSize: 20, fontWeight: FontWeight.bold),
                          ),
                          subtitle: Text(
                            custom.getBloc(context).item["brand"],
                            style: const TextStyle(
                                fontSize: 17, color: Colors.grey),
                          ),
                        ),
                      ),
                      FavoriteIcon()
                    ],
                  ),
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    SizedBox(
                        width: 160,
                        child: Counter(
                          counter: ref,
                        )),
                    Text(
                      "${custom.getBloc(context).item["price"].toString()}\$",
                      style: const TextStyle(
                          fontSize: 20, fontWeight: FontWeight.bold),
                    )
                  ],
                ),
              ),
              MyExoansionTile(
                  title: "Product details",
                  child: custom.getBloc(context).item["description"]),
              MyExoansionTile(
                  title: "Product details",
                  child:
                      "data of discription data of discription data of discription data of discription data of discription"),
              MyExoansionTile(
                  title: "Product details", child: "data of discription"),
              BasedButton(
                  function: () async {
                    await custom
                        .getBloc(context)
                        .setCartItem(context, custom.getBloc(context).item);

                    // ignore: use_build_context_synchronously
                    custom.getBloc(context).updateCounter(
                        // ignore: use_build_context_synchronously
                        custom.getBloc(context).item["title"],
                        ref.value);
                  },
                  text: "Add To Basket"),
          
            ],
          )  ],
          )),
        ),
      ),
    );
  }
}
