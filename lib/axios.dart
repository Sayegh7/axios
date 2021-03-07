import 'dart:io';
import 'dart:async';
import 'package:args/args.dart';
import 'package:http_server/http_server.dart';
import 'package:ansicolor/ansicolor.dart';

void printf(String string, bool silent, int statusCode) {
  if (silent) return;

  AnsiPen pen = AnsiPen()..green();
  if (statusCode > 400) {
    pen = AnsiPen()..red();
  }

  print("$string [${pen(statusCode)}]");
}

void main(List<String> arguments) {
  const address = 'address';
  const port = 'port';
  const directory = 'directory';
  const silent = 'silent';

  final parser = ArgParser()
    ..addOption(address, abbr: 'a', defaultsTo: '0.0.0.0')
    ..addOption(port, abbr: 'p', defaultsTo: '8080')
    ..addFlag(directory, abbr: 'd', defaultsTo: true, negatable: true)
    ..addFlag(silent, abbr: 's');

  ArgResults argResults = parser.parse(arguments);

  String addressValue = argResults[address];
  String portValue = argResults[port];
  bool directoryValue = argResults[directory];
  bool silentValue = argResults[silent];

  final String path = argResults.rest.isEmpty ? '.' : argResults.rest.first;
  var staticFiles = new VirtualDirectory(path)
    ..allowDirectoryListing = directoryValue;

  runZonedGuarded(() {
    HttpServer.bind(addressValue, int.parse(portValue)).then((server) {
      if (!silentValue) print('Server running');
      server.listen((HttpRequest request) async {
        String method = request.method;
        String uri = request.uri.toString();
        dynamic response =
            (await staticFiles.serveRequest(request)) as HttpResponse;
        printf("$method $uri", silentValue, response.statusCode);
      });
    });
  }, (e, stackTrace) => print('Oh noes! $e $stackTrace'));
}
