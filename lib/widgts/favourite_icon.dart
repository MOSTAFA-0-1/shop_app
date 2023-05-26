import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app_/bloc/favorite/favorite_icon_cubit.dart';
import 'package:shop_app_/custom.dart';

import '../bloc/user/current_user.dart';

class FavoriteIcon extends StatelessWidget {
  FavoriteIcon({Key? key}) : super(key: key);

  Color? color;
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<FavoriteIconCubit, FavoriteIconSates>(
      builder: (context, state) {
        if (!custom.pref!.containsKey(
                "${CurrentUser.id}${custom.getBloc(context).item["title"]}") ||
            custom.pref!.getBool(
                    "${CurrentUser.id}${custom.getBloc(context).item["title"]}")! ==
                false) {
          color = const Color.fromARGB(255, 227, 225, 225);
        } else {
          color = const Color.fromARGB(255, 255, 0, 0);
        }

        return IconButton(
            onPressed: () {
              // ignore: use_build_context_synchronously
              BlocProvider.of<FavoriteIconCubit>(context)
                  .getbool(custom.getBloc(context).item["title"], context);
            },
            icon: Icon(Icons.favorite, size: 45, color: color));
      },
    );
  }
}
