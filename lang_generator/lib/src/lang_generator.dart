import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:analyzer/dart/element/element.dart';
import 'package:build/build.dart';

import 'package:path/path.dart';

import 'package:source_gen/source_gen.dart';

import '../annotations/lang_annotation.dart';

class LangGenerator extends GeneratorForAnnotation<LangAutomation> {
  Map<String, String> _keysMap;

  @override
  Future<FutureOr<String>> generateForAnnotatedElement(
      Element element, ConstantReader annotation, BuildStep buildStep) async {
    _keysMap = new Map();

    File file = File(annotation.read("filePath").stringValue);
    String data = file.readAsStringSync();

    Map<String, dynamic> words = json.decode(data);

    _generateKeys(words, "", "");

    _checkAllJsonFilesIdentity(file);

    return _generateClass();
  }

  void _generateKeys(
      Map<String, dynamic> words, String methodName, String lastKeys) {
    words.forEach((String key, dynamic value) {
      if (value is Map<String, dynamic>) {
        _generateKeys(
            value, methodName + capitalize(key), lastKeys + "['" + key + "']");
      } else if (value is String) {
        _keysMap.putIfAbsent(forfeit(methodName + capitalize(key)),
            () => lastKeys + "['" + key + "']");
      }
    });
  }

  String _generateClass() {
    String code = "class AppLocalizationsGenerated { \n"
        "  AppLocalizationsGenerated(this.words); \n \n"
        "  final Map<String, dynamic> words; \n \n";

    code += _generateCode();

    code += "}";

    return code;
  }

  String _generateCode() {
    String code = "";
    _keysMap.forEach((String key, String value) {
      code += "  String " +
          key +
          "() { \n"
          "    return words" +
          value +
          "; \n"
          "  }\n\n";
    });
    return code;
  }

  void _checkAllJsonFilesIdentity(File mainJsonFile) {
    File newFile = File('test/i18n/localization.g_test.dart');
    newFile.parent.create();
    newFile.create();
    newFile
        .writeAsStringSync(_generateTestCode(mainJsonFile.parent.listSync()));
  }

  String _generateTestCode(List<FileSystemEntity> allJsonFiles) {
    String functionCode = _generateTestingFunction();
    String testsCode = "import 'dart:convert';\n"
        "import 'dart:io';\n\n"
        "import 'package:athens_core/i18n/localization.dart';\n"
        "import 'package:flutter_test/flutter_test.dart';\n"
        "\n"
        "void main() {\n"
        "  String scriptPath = Platform.script.path;\n"
        "  String filePathForCoverage = '/' + scriptPath.substring(0, scriptPath.indexOf('test')).substring(1) + 'resources/lang/';\n";

    allJsonFiles.forEach((FileSystemEntity entity) {
      if (entity.path.endsWith(".json")) {
        String fileName = basename(entity.path);
        String locale = fileName.replaceAll(".json", "");
        testsCode += "\n"
            "  File ${locale}File = File(filePathForCoverage + '$fileName');\n"
            "  String ${locale}Data = ${locale}File.readAsStringSync();\n"
            "  Map<String, dynamic> ${locale}Words = json.decode(${locale}Data);\n"
            "  testAllMethods('$locale', AppLocalizationsGenerated(${locale}Words));\n";
      }
    });

    testsCode += "}\n"
        "\n"
        "$functionCode";

    return testsCode;
  }

  String _generateTestingFunction() {
    String functionCode = "void testAllMethods(String locale, AppLocalizationsGenerated localization) {\n";


    _keysMap.forEach((String key, String value) {
      functionCode += "  test(\"All methods for \$locale $key\", () async {\n"
          "    String $key = localization.$key();\n"
          "    expect(true, $key != \"\" && $key != null); \n"
          "  }); \n \n";
    });

    functionCode += "}";

    return functionCode;
  }

  String capitalize(String s) => s[0].toUpperCase() + s.substring(1);

  String forfeit(String s) => s[0].toLowerCase() + s.substring(1);
}
