import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'constants.dart';


class ReusableCard extends StatelessWidget {
  final Function onPress;
  ReusableCard({@required this.colour,this.cardChild,this.onPress});
  final Color colour;
  final Widget cardChild;


  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        onTap: onPress,

      child: Container(
        padding: EdgeInsets.all(10),
        child: cardChild,
        margin: EdgeInsets.all(10),
        decoration: BoxDecoration(
//          gradient: LinearGradient(
//            colors: [
//              colour,
//              colour.withOpacity(0.7),
//    ],
//
//          ),
          color: Color(0xff161020),
          borderRadius: BorderRadius.circular(10),

        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.5),
            spreadRadius: 5,
            blurRadius: 7,
            offset: Offset(0, 3), // changes position of shadow
          ),
        ],
        ),

    )
    );
  }
}
