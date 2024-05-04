import 'package:flutter/material.dart';

void main() {
  runApp(const marcadorTruco());
}

class marcadorTruco extends StatelessWidget {
  const marcadorTruco({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      title: 'Marcador de Truco',
      home: tela(), // Define a tela inicial como uma instância de tela
    );
  }
}

class tela extends StatefulWidget {
  const tela({super.key});

  @override
  pontuacao createState() =>
      pontuacao(); // Define o estado da tela como uma instância de pontuacao
}

class pontuacao extends State<tela> {
  int pontonos = 0; // Pontuação nós
  int pontoeles = 0; // Pontuação eles
  int ganha = 12; // Pontuação necessária para ganhar

  void aumentaPonto(int time) {
    // Função para aumentar a pontuação de um time
    setState(() {
      if (time == 1) {
        pontonos++;
        if (pontonos == ganha) {
          mostraGanhador('Nós'); // Verifica se o time "Nós" ganhou
        }
      } else {
        pontoeles++;
        if (pontoeles == ganha) {
          mostraGanhador('Eles'); // Verifica se o time "Eles" ganhou
        }
      }
    });
  }

  void diminuiPonto(int time) {
    // Função para diminuir a pontuação de um time
    setState(() {
      if (time == 1) {
        if (pontonos > 0) pontonos--;
      } else {
        if (pontoeles > 0) pontoeles--;
      }
    });
  }

  void mostraGanhador(String ganhador) {
    // Função para exibir o ganhador em um AlertDialog
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Jogo Finalizado'),
          content: Text('O time $ganhador venceu!'),
          actions: <Widget>[
            TextButton(
              child: const Text('OK'),
              onPressed: () {
                Navigator.of(context).pop();
                setState(() {
                  // Reseta pontos
                  pontonos = 0;
                  pontoeles = 0;
                });
              },
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Marcador de Truco'),
      ),
      body: Center(
        child: Column(
          children: <Widget>[
            Row(
              children: <Widget>[
                Column(
                  children: <Widget>[
                    const Text(
                      'Nós',
                      style: TextStyle(fontSize: 20),
                    ),
                    Text(
                      '$pontonos',
                      style: const TextStyle(fontSize: 32),
                    ),
                    Row(
                      children: <Widget>[
                        ElevatedButton(
                          onPressed: () => aumentaPonto(1),
                          child: const Text('+'),
                        ),
                        ElevatedButton(
                          onPressed: () => diminuiPonto(1),
                          child: const Text('-'),
                        ),
                      ],
                    ),
                  ],
                ),
                Column(
                  children: <Widget>[
                    const Text(
                      'Eles',
                      style: TextStyle(fontSize: 20),
                    ),
                    Text(
                      '$pontoeles',
                      style: const TextStyle(fontSize: 32),
                    ),
                    Row(
                      children: <Widget>[
                        ElevatedButton(
                          onPressed: () => aumentaPonto(2),
                          child: const Text('+'),
                        ),
                        ElevatedButton(
                          onPressed: () => diminuiPonto(2),
                          child: const Text('-'),
                        ),
                      ],
                    ),
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
