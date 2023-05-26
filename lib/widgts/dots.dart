import 'package:flutter/material.dart';
 
 class Dot extends StatelessWidget {
 
  int dotIndex = 0;
   int? i;
   Dot(this.i){
    dotIndex++;
   } 

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 8,
      height: 8,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(50),
        color: dotIndex == i? Color.fromARGB(255, 36, 191, 96):Colors.black,
      ),
      
     );
  }
}



