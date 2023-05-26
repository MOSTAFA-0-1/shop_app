import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path/path.dart';
import 'package:shop_app_/controller%20panel/text_field_widget.dart';
import 'package:shop_app_/custom.dart';
import 'package:shop_app_/widgts/button.dart';
import 'package:shop_app_/widgts/toast.dart';

class AddItem extends StatelessWidget {
  AddItem({Key? key}) : super(key: key);
  String? brand, title, discribtion;
  double? price, discountPercentage;
  List<String> itemImagesUrl = [];
  ImagePicker picker = ImagePicker();
  List<File>? imagesFile;
  List<XFile>? imagesXfile;
  FirebaseStorage firebaseStorage = FirebaseStorage.instance;
  Reference? snapshot;
  String? imageName;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(8),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              MyTextForm(
                title: "Title",
                function: (value) {
                  title = value;
                },
              ),
              MyTextForm(
                title: "brand",
                function: (value) {
                  brand = value;
                },
              ),
              MyTextForm(
                title: "discribtion",
                function: (value) {
                  discribtion = value;
                },
              ),
              MyDigitalTextForm(
                title: "price",
                function: (value) {
                  price = value;
                },
              ),
              MyDigitalTextForm(
                title: "discountPercentage",
                function: (value) {
                  discountPercentage = value;
                },
              ),
              ElevatedButton(
                  onPressed: () async {
                    imagesXfile = await picker.pickMultiImage();
                    if (imagesXfile != null) {
                      for (int i = 0; i < imagesXfile!.length; i++) {
                        imagesFile![i] = File(imagesXfile![i].path);
                      }
                      // ignore: use_build_context_synchronously
                      BlocProvider.of<ListImagesCubit>(context).rebuild();
                    }
                  },
                  child: const Text("Upload images")),
              // if (imagesFile != null) ImagesListview(imagesFile: imagesFile!),
              BasedButton(
                  function: () async {
                    if (imagesXfile != null &&
                        title != null &&
                        discountPercentage != null &&
                        discribtion != null &&
                        price != null) {
                      for (var i = 0; i < imagesFile!.length; i++) {
                        imageName = basename(imagesXfile![i].name);
                        snapshot = firebaseStorage.ref("images/$imageName");
                        await snapshot!.putFile(imagesFile![i]);
                        itemImagesUrl.add(await snapshot!.getDownloadURL());

                        custom.store
                            .collection("categorys")
                            .doc()
                            .collection("products")
                            .add({
                          "title": title,
                          "brand": brand,
                          "images": itemImagesUrl,
                          "price": price,
                          "discountPercentage": discountPercentage,
                          "discribtion": discribtion,
                        });
                      }
                    } else {
                      MyToast("please fill all fields", context);
                    }
                  },
                  text: "add to database")
            ],
          ),
        ),
      ),
    );
  }
}

class ImagesListview extends StatelessWidget {
  ImagesListview({Key? key, required this.imagesFile}) : super(key: key);
  List<File> imagesFile;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ListImagesCubit, ListImagesState>(
      builder: (context, state) {
        return ListView.builder(
          itemCount: imagesFile.length,
          itemBuilder: (context, index) {
            return SizedBox(
              width: 80,
              height: 150,
              child: Image.file(imagesFile[0]),
            );
          },
        );
      },
    );
  }
}

class ListImagesCubit extends Cubit<ListImagesState> {
  ListImagesCubit() : super(ListImagesInitial());
  rebuild() {
    emit(RebuildTheList());
  }
}

abstract class ListImagesState {}

class ListImagesInitial extends ListImagesState {}

class RebuildTheList extends ListImagesState {}
