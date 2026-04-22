import 'package:usuarios/usuarios.dart' as usuarios;
import 'dart:io';

void main() {
  print('Content-type: text/html; charset=utf-8\n\n');

  String query = Platform.environment['QUERY_STRING'] ?? '';
  Uri uri = Uri(query: query);
  var params = uri.queryParameters;

  String nome = params["nome"] ?? "";
  String idade = params["idade"] ?? "";

  if (nome.isNotEmpty && idade.isNotEmpty) {
    File('usuarios.txt')
        .writeAsStringSync("$nome;$idade\n", mode: FileMode.append);
  }

  String listaHtml = "";
  File arquivo = File('usuarios.txt');

  if (arquivo.existsSync()) {
    var linhas = arquivo.readAsLinesSync();

    for (var linha in linhas) {
      var dados = linha.split(';');
      if (dados.length != 2) continue;

      listaHtml += "<li>${dados[0]} - ${dados[1]} anos</li>";
    }
  }

  File htmlFile = File('../htdocs/index.html');
  String html = htmlFile.readAsStringSync();

  html = html.replaceAll("{{lista}}", listaHtml);

  print(html);
}
