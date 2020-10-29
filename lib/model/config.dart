import 'dart:io';

import 'package:meta/meta.dart';
import 'package:yaml/yaml.dart';

/// Holds configuration from adr.yaml file if present or uses defaults.
class Config {
  final String outputDir;
  final RequiredFields requiredFields;

  static const String _configFilename = 'adr.yaml';

  const Config._({
    @required this.outputDir,
    @required this.requiredFields,
  });

  factory Config() {
    final f = File(_configFilename);

    if (!f.existsSync()) {
      stdout.write('File "$_configFilename" not found! Using defaults ...\n\n');
      return Config._(
        outputDir: 'docs/adr',
        requiredFields: RequiredFields._(),
      );
    }

    final yamlContents = f.readAsStringSync();
    final yamlMap = loadYaml(yamlContents) as Map;

    return Config._(
      outputDir: yamlMap['output_dir'],
      requiredFields: RequiredFields.fromMap(map: yamlMap['required_fields']),
    );
  }

  static void generate() {
    final string = '''
output_dir: docs/adr
required_fields:
  status: true
  deciders: true
  date: true
  techStory: false
  context: true
  decisionDrivers: false
  consideredOptions: true
  decisionOutcome: true
  pros: false
  cons: false
  prosConsOpts: false
  links: false
''';

    File(_configFilename).writeAsStringSync(string);

    stdout.writeln('File "adr.yaml" generated!');
  }
}

class RequiredFields {
  final bool status;
  final bool deciders;
  final bool date;
  final bool techStory;
  final bool context;
  final bool decisionDrivers;
  final bool consideredOptions;
  final bool decisionOutcome;
  final bool pros;
  final bool cons;
  final bool prosConsOpts;
  final bool links;

  RequiredFields._({
    this.status = true,
    this.deciders = true,
    this.date = true,
    this.techStory = false,
    this.context = true,
    this.decisionDrivers = false,
    this.consideredOptions = true,
    this.decisionOutcome = true,
    this.pros = false,
    this.cons = false,
    this.prosConsOpts = false,
    this.links = false,
  });

  factory RequiredFields.fromMap({@required Map map}) => RequiredFields._(
        status: map['status'],
        deciders: map['deciders'],
        date: map['date'],
        techStory: map['techStory'],
        context: map['context'],
        decisionDrivers: map['decisionDrivers'],
        consideredOptions: map['consideredOptions'],
        decisionOutcome: map['decisionOutcome'],
        pros: map['pros'],
        cons: map['cons'],
        prosConsOpts: map['prosConsOpts'],
        links: map['links'],
      );
}
