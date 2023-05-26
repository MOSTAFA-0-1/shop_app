import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path/path.dart';
import 'package:shop_app_/bloc/user/current_user.dart';
import 'package:shop_app_/custom.dart';

class ImageContainer extends StatefulWidget {
  const ImageContainer({Key? key}) : super(key: key);

  @override
  State<ImageContainer> createState() => _ImageContainerState();
}

class _ImageContainerState extends State<ImageContainer> {
  ImagePicker picker = ImagePicker();
  XFile? imageFile;
  static File? image;
  FirebaseStorage firebaseStorage = FirebaseStorage.instance;
  late Reference snapshot;
  String? imagePath, url;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () async {
        imageFile = await picker.pickImage(source: ImageSource.gallery);
        if (imageFile != null) {
          setState(() {
            image = File(imageFile!.path);
          });
          imagePath = basename(imageFile!.path);
          snapshot = firebaseStorage.ref("images/$imagePath");
          await snapshot.putFile(image!);
        }
        url = await snapshot.getDownloadURL();
        custom.store
            .collection("users")
            .doc(CurrentUser.id)
            .update({"imageURL": url!});
        CurrentUser.serURL(url!);
      },
      child: Center(
        child: Container(
          height: 100,
          width: 100,
          decoration: BoxDecoration(
              image: CurrentUser.url != null
                  ? DecorationImage(
                      image: NetworkImage(CurrentUser.url!), fit: BoxFit.cover)
                  : null,
              borderRadius: BorderRadius.circular(50),
              border: Border.all(color: Colors.grey)),
          child: CurrentUser.url == null
              ? const Icon(
                  Icons.person,
                  size: 50,
                )
              : null,
        ),
      ),
    );
  }
}
