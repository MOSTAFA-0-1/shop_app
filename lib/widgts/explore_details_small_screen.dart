
  import 'package:flutter/cupertino.dart';

import 'new_item.dart';

class ExploreDetailsSmallScreen{
     static Widget smallScreen(List items){
      return ListView.builder(
                  itemCount: items.length ,
                  itemBuilder: (context, index) {
                    return Padding(
                      padding: const EdgeInsets.symmetric(
                        vertical: 5,
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          NewItem(
                            item: items[index],
                          ),
                        ],
                      ),
                    );
                  },
                );
     }
}