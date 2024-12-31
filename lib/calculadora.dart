import 'package:expressions/expressions.dart';
import 'package:flutter/material.dart';
import 'dart:math';

class Calculadora extends StatefulWidget {
  const Calculadora({super.key});

  @override
  State<Calculadora> createState() => _CalculadoraState();
}

class _CalculadoraState extends State<Calculadora> {
  final String _clear = 'Clear';
  String _expressao = '';
  String _resultado = '';

  void _pressionarBotao(String valor) {
    setState(() {
      if (valor == _clear) {
        _expressao = '';
        _resultado = '';
      } else if (valor == '=') {
        _calcularResultado();
      } else {
        _expressao += valor;
      }
    });
  }

  void _calcularResultado() {
    try {
      _resultado = _calcularExpressao(_expressao).toString();
    } catch (e) {
      _resultado = 'Erro';
    }
  }

  double _calcularExpressao(String expressao) {
    // Substituições para compatibilidade com as funções esperadas
    expressao = expressao.replaceAll('×', '*');
    expressao = expressao.replaceAll('÷', '/');
    var contexto = {
      'sin': sin,
      'cos': cos,
      'tan': tan,
      'log': log,
      'sqrt': sqrt,
      'pi': pi,
      'e': e,
    };

    Expression parsedExpression = Expression.parse(expressao);
    ExpressionEvaluator avaliador = const ExpressionEvaluator();
    return avaliador.eval(parsedExpression, contexto);
  }

  Widget _botao(String valor, {Color? corFundo}) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        backgroundColor: corFundo ?? Colors.grey[700],
        padding: const EdgeInsets.all(16),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8),
        ),
      ),
      onPressed: () => _pressionarBotao(valor),
      child: Text(
        valor,
        style: const TextStyle(fontSize: 18, color: Colors.white),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        title: const Text('Calculadora Simples', style: TextStyle(color: Colors.white)),
        backgroundColor: Colors.grey[850],
        centerTitle: true,
      ),
      body: Column(
        children: [
          // Display
          Expanded(
            flex: 2,
            child: Container(
              alignment: Alignment.bottomRight,
              padding: const EdgeInsets.all(16),
              color: Colors.black,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Text(
                    _expressao,
                    style: const TextStyle(fontSize: 24, color: Colors.white),
                  ),
                  const SizedBox(height: 10),
                  Text(
                    _resultado,
                    style: const TextStyle(
                      fontSize: 32,
                      fontWeight: FontWeight.bold,
                      color: Colors.greenAccent,
                    ),
                  ),
                ],
              ),
            ),
          ),
          // Botões
          Expanded(
            flex: 5,
            child: Container(
              padding: const EdgeInsets.all(8),
              color: Colors.grey[900],
              child: GridView.count(
                crossAxisCount: 4,
                crossAxisSpacing: 8,
                mainAxisSpacing: 8,
                children: [
                  _botao('7'),
                  _botao('8'),
                  _botao('9'),
                  _botao('÷', corFundo: Colors.orange),
                  _botao('4'),
                  _botao('5'),
                  _botao('6'),
                  _botao('×', corFundo: Colors.orange),
                  _botao('1'),
                  _botao('2'),
                  _botao('3'),
                  _botao('-', corFundo: Colors.orange),
                  _botao('0'),
                  _botao('.'),
                  _botao('=', corFundo: Colors.green),
                  _botao('+', corFundo: Colors.orange),
                  _botao('('),
                  _botao(')'),
                  _botao(_clear, corFundo: Colors.red),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}