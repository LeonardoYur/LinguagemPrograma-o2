import 'dart:io';

void main() {
  print('Content-type: text/html; charset=iso-8859-1\n\n');

  String query = Platform.environment['QUERY_STRING'] ?? '';

  Uri uri = Uri(query: query);
  var params = uri.queryParameters;

  String nome = params["nome"] ?? "";
  String sexo = params["sexo"] ?? "";
  String bebida = params["bebida"] ?? "";

  if (nome.isNotEmpty && sexo.isNotEmpty && bebida.isNotEmpty) {
    String linha = "$nome;$sexo;$bebida\n";
    File('lista.txt').writeAsStringSync(linha, mode: FileMode.append);
  }

  File arquivo = File('lista.txt');

  int totalCerveja = 0;
  int totalRefrigerante = 0;

  if (arquivo.existsSync()) {
    List<String> linhas = arquivo.readAsLinesSync();

    for (var linha in linhas) {
      var dados = linha.split(';');
      if (dados.length != 3) continue;

      String sexoPessoa = dados[1];
      String bebidaPessoa = dados[2];

      if (bebidaPessoa == "cerveja") {
        if (sexoPessoa == "M") {
          totalCerveja += 2;
        } else {
          totalCerveja += 1;
        }
      } else if (bebidaPessoa == "refrigerante") {
        totalRefrigerante += 1;
      }
    }
  }

  print("RESULTADO");
  print("Cervejas: $totalCerveja");
  print("Refrigerantes: $totalRefrigerante");
}
