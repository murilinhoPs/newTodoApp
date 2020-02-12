import 'package:flutter/material.dart';
import 'package:new_todo_trianons/app/pages/hints/components/back_button.dart';

class Updates extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: MyBackButton(
          EdgeInsets.zero,
        ),
        actions: <Widget>[],
        automaticallyImplyLeading: false,
        centerTitle: true,
        elevation: 0.0,
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(10.0),
          child: Container(
            child: Divider(
              indent: 50.0,
              endIndent: 50.0,
              thickness: 2.0,
            ),
          ),
        ),
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          mainAxisSize: MainAxisSize.max,
          children: <Widget>[
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.03,
            ),
            Text(
              'Atualizações: ',
              style: TextStyle(
                fontFamily: 'Nunito',
                fontSize: 22,
                fontWeight: FontWeight.bold,
                //color: Cor().customColor
              ),
            ),
          ],
        ),
      ),
      body: Container(
        padding: EdgeInsets.all(MediaQuery.of(context).size.width * .05),
        child: Column(
          children: <Widget>[
            ListBody(
              mainAxis: Axis.vertical,
              children: <Widget>[
                // 1.2.0
                Padding(
                  padding: const EdgeInsets.only(top: 15.0),
                  child: ListTile(
                    title: Text(
                      '#  1. 2. 0',
                      style:
                          TextStyle(fontSize: 26, fontWeight: FontWeight.bold),
                    ),
                    subtitle: SelectableText(
                      '''

    • Adicionamos uma tela de bem-vindo para explicar sobre o app
    • Um menu de hambúrguer na lateral esquerda com mais informações
    • Corrigimos bugs quando o usuário mudava de página e do chat. ''',
                      style: TextStyle(fontSize: 16),
                      textAlign: TextAlign.left,
                    ),
                  ),
                ),

                //1.1.0
                Padding(
                  padding: const EdgeInsets.only(top: 15.0),
                  child: ListTile(
                    title: Text(
                      '#  1. 1. 0',
                      style:
                          TextStyle(fontSize: 26, fontWeight: FontWeight.bold),
                    ),
                    subtitle: SelectableText(
                      '''

    • Colocamos uma página de dicas sobre redes sociais.
    • Integramos o chat do app com o chat do Discord da Trianons ''',
                      style: TextStyle(fontSize: 16),
                      textAlign: TextAlign.left,
                    ),
                  ),
                ),

                //1.0.0
                Padding(
                  padding: const EdgeInsets.only(top: 15.0),
                  child: ListTile(
                    title: Text(
                      '# 1. 0. 0',
                      style:
                          TextStyle(fontSize: 26, fontWeight: FontWeight.bold),
                    ),
                    subtitle: SelectableText(
                      '''

    • Apenas a funcionalidade principal, criar tarefas de alguma rede socials específica.
    • Criação de template de tarefas e tarefas personalizadas. ''',
                      style: TextStyle(fontSize: 16),
                      textAlign: TextAlign.left,
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
