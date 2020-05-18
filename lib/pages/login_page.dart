import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';

class LoginPage extends StatefulWidget{
  @override
  State<StatefulWidget> createState(){
    return new LoginPageState();
  }
}



class LoginPageState extends State<LoginPage> {
  final _tLogin = TextEditingController();
  final _tSenha = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final _URI = "http://mtb.no-ip.org:6060/mtb/v0100/api/ValidaUsuario";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: Text("Informe login e senha")),
        body: new Padding(padding: EdgeInsets.all(16.0), child: _body(context)));
  }

  var _loginValidator =
      (String text) => text.isEmpty ? "Informe o login" : null;
  var _passwordValidator =
      (String text) => text.isEmpty ? "Informe a senha" : null;

  _body(BuildContext context) {
    return Form(
        key: _formKey,
        child: ListView(
          children: <Widget>[
            textFormFieldLogin(),
            textFormFieldPassword(),
            containerButton(context) 
          ],
        ));
  }

  containerButton(BuildContext context) {
    return Container(
        height: 40.0,
        margin: EdgeInsets.only(top: 10.0),
        child: RaisedButton(
          color: Colors.blue,
          child: Text(
            "Logar",
            style: TextStyle(color: Colors.white, fontSize: 20.0),
          ),
          onPressed: () {
            _OnClickLogin(context);
          },
        ));
  }

  textFormFieldPassword() {
    return TextFormField(
        controller: _tSenha,
        validator: _passwordValidator,
        obscureText: true,
        keyboardType: TextInputType.text,
        style: TextStyle(color: Colors.black),
        decoration: InputDecoration(
            labelText: "Senha",
            labelStyle: TextStyle(fontSize: 20.0, color: Colors.black)));
  }

  textFormFieldLogin() {
    return TextFormField(
        controller: _tLogin,
        validator: _loginValidator,
        keyboardType: TextInputType.text,
        style: TextStyle(color: Colors.black),
        decoration: InputDecoration(
            labelText: "Login",
            labelStyle: TextStyle(fontSize: 20.0, color: Colors.black)));
  }

  showSimpleAlertDialog(BuildContext context, String title, String information, bool isSucces){
    Widget okButton = FlatButton(onPressed: () => Navigator.pop(context), child: Text("OK"));
    AlertDialog dialog = new AlertDialog(
          title: Text(title),
          content: Text(information),
          actions: [okButton]);
    
    showDialog(context: context, builder: (BuildContext context){
      return dialog;
    });
  }

  Future _OnClickLogin(BuildContext context) async {
    if (!_formKey.currentState.validate()) return;

    var response = await http.get("${_URI}/${_tLogin.text}/${_tSenha.text}");
    Map<String, dynamic> resultObj = jsonDecode(response.body);

    if (resultObj['result'][0]['retorno'] != 1){
      showSimpleAlertDialog(context, "Informação", "Login ou senha incorretos!", false);
      _formKey.currentState.reset();
      return;
    }
    var dateFormat = DateFormat("dd/MM/yyyy").format(DateTime.parse(resultObj['result'][0]['dataCadastro'])); 
    showSimpleAlertDialog(context, "Sucesso", 
    "Código = ${resultObj['result'][0]['codigo']} \n" +
    "Cpf = ${resultObj['result'][0]['cpf']} \n"+
    "Data cadastro = $dateFormat \n" +
    "Nome = ${resultObj['result'][0]['nome']} \n" +
    "Cidade = ${resultObj['result'][0]['cidade']}" , true);
  }
}
