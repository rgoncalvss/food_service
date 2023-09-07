import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../AppState.dart';

class CartProductType extends StatefulWidget {
  final String picture;
  final int showTask;
  final int len;

  const CartProductType(this.picture, this.showTask, this.len,  {Key? key}) : super(key: key);

  @override
  State<CartProductType> createState() => _CartProductTypeState();
}

class _CartProductTypeState extends State<CartProductType> {
  @override
  Widget build(BuildContext context) {
    return Consumer<AppStateCart>(builder: (context, appState, _){return SizedBox(
      height: 50,
      width: 50,
      child: ElevatedButton(
          onPressed: () {
            appState.updateShowTasksCart(widget.showTask, widget.len);
          },
          style: ElevatedButton.styleFrom(
              padding: EdgeInsets.zero,
              primary: Color.fromRGBO(255, 255, 153, 1) // 255,255,153,1
          ),
          child: SizedBox(
            width: 40,
            height: 40,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(4),
              child: Image.asset(
                widget.picture,
                fit: BoxFit.cover,
              ),
            ),
          )),
    );});
  }
}