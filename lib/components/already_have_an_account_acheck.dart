import 'package:flutter/material.dart';
import 'package:food_service_fetin/constants.dart';

class AlreadyHaveAnAccountCheck extends StatelessWidget {
  final bool login;
  final Function? press;
  const AlreadyHaveAnAccountCheck({
    Key? key,
    this.login = true,
    required this.press,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Text(
          login ? "Não tem uma conta ? " : "Ja tem uma conta ? ",
          style: const TextStyle(color: Colors.black87),
        ),
        GestureDetector(
          onTap: press as void Function()?,
          child: Text(
            login ? "Cadastrar-se" : "Entrar",
            style: const TextStyle(
              color: Colors.black,
              fontWeight: FontWeight.bold,
            ),
          ),
        )
      ],
    );
  }
}
