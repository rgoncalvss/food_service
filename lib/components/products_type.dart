import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../AppState.dart';

class TaskTipoProduto extends StatefulWidget {
  final String urlImage;
  final int showTask;

  const TaskTipoProduto(this.urlImage, this.showTask, {Key? key}) : super(key: key);

  @override
  State<TaskTipoProduto> createState() => _TaskTipoProdutoState();
}

class _TaskTipoProdutoState extends State<TaskTipoProduto> {
  @override
  Widget build(BuildContext context) {
    return Consumer<AppState>(builder: (context, appState, _){return SizedBox(
      height: 50,
      width: 50,
      child: ElevatedButton(
          onPressed: () {
            appState.updateShowTasks(widget.showTask);
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
                widget.urlImage,
                fit: BoxFit.cover,
              ),
            ),
          )),
    );});
  }
}