import 'package:flutter/material.dart';

class DicasState extends ChangeNotifier {
  String _dicas = 'Lembrete';

  String get dicas => _dicas;

  set dicas(String value) {
    _dicas = value;

    notifyListeners();
    print(_dicas);
  }

  carregarDicas(String value) {
    switch (value) {
      case 'Facebook':
        return Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Text('• Fuja do conteúdo padrão (imagem + texto)'),
            Divider(),
            Text(
                '• Experimente criar conteúdo em formatos diferentes. Que tal experimentar um vídeo ou uma transmissão ao vivo. ')
          ],
        );

        break;
      case 'Instagram':
        return Column(
          children: <Widget>[
            Text('• Use imagens bonitas, coloridas e com alta definição.'),
            Divider(),
            Text(
                '• O instagram é uma rede muito mais visual, lembre-se disso quando estiver criando. '),
          ],
        );
        break;
      case 'WhatsApp':
        return Column(
          children: <Widget>[
            Text(
                '• Criar um grupo ou faça parte de grupos de Whatsapp com discussão sobre seu mercado de trabalho '),
            Divider(),
            Text(
                '• É possível criar Links para convidar pessoas para grupos ou mesmo um link para enviar mensagens automaticamente para seu celular. Use esses recursos em campanhas, no seu site e em materiais promocionais')
          ],
        );

        break;
      case 'Youtube':
        return Column(
          children: <Widget>[
            Text(
                '• Youtube é o site de vídeos mais acessado do mundo. Aqui, a regra é não ter vergonha de gravar um vídeo nem que seja um material curto de 3 minutos.'),
            Divider(),
            Text(
                '• Sem ideias para vídeos ou com vergonha para aparecer no seu conteúdo, sem problemas; experimente usar plataformas de criação de vídeos como: biteable.com, videolean, Powtoon, Animoto entre muitos outros.')
          ],
        );

        break;
      case 'Linkedin':
        return Column(
          children: <Widget>[
            Text(
                '• Um bom artigo pode ser uma excelente maneira para alcançar pessoas relevantes no seu segmento profissional.'),
            Text('• Conteúdo inspiracional é bem vindo, mas evite excessos.')
          ],
        );
        break;
      case 'Twitter':
        return Column(
          children: <Widget>[
            Text(
                '• O microblog twitter é uma rede que funciona em TEMPO REAL (Real Time).'),
            Divider(),
          ],
        );
        break;
      case 'Pinterest':
        return Column(
          children: <Widget>[
            Text(
                '• O Pinterest é um site para novas ideias e inspirações. Um site muito utilizado na hora de planejar, ter ideias e inspirações.'),
            Divider(),
            Text(
                '• Ao criar cada conteúdo não esqueça de preencher com carinho todos os campos inclusive o link para uma um site de destino.')
          ],
        );
        break;
      case 'Google':
        return Column(
          children: <Widget>[
            Text(
                '• O Google possui dezenas de ferramentas importantes todas elas integradas entre suas soluções.'),
            // Divider(),
            // Text('• Mantenha atualizado seu cadastro no Google Meu Negócios e publique novidades regularmente. Novas fotos, notícias e dicas.')
          ],
        );
        break;
      case 'Blog':
        return Column(
          children: <Widget>[
            Text(
                '• Artigos em Blog são excelentes para melhorar o resultado do seu site em SEO.'),
            Divider(),
            Text(
                '• É importante descobrir quais as palavras chaves de forma inteligente e estratégica.')
          ],
        );
        break;
      case 'TikTok':
        return Column(
          children: <Widget>[
            Text('• Uma nova rede que vale a pena prestar atenção. '),
            Divider(),
          ],
        );
        break;
      case 'Snapchat':
        return Column(
          children: <Widget>[
            Text('• Foi Criado para Nudes, mas pode ser usado para trabalho.'),
            Divider(),
            Text('• Se você não usar agora, talvez não use nunca.')
          ],
        );
        break;
      case 'SlideShare':
        return Column(
          children: <Widget>[
            Text(
                '• Este é um excelente local para você compartilhar suas apresentações comerciais. Também pode ser um local para referência.'),
            Divider(),
          ],
        );
        break;
      case 'Flickr':
        return Column(
          children: <Widget>[
            Text(
                '• Publicar suas fotos no Flickr é pode ser uma excelente maneira para divulgar seu negócio.'),
            Divider(),
          ],
        );
        break;
    }
  }
}
