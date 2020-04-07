library nlh_generator;

import 'package:build/build.dart';
import 'package:source_gen/source_gen.dart';

import 'src/lang_generator.dart';


Builder langGenerator(BuilderOptions options) =>
    SharedPartBuilder([LangGenerator()], 'lang-generate');
