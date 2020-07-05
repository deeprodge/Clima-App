import 'package:flutter/material.dart';
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
        child: cardChild,
        margin: EdgeInsets.all(10),
        decoration: BoxDecoration(
          color: colour,
          borderRadius: BorderRadius.circular(10),

        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.5),
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
