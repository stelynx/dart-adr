import 'dart:io';

import 'package:adr/adr.dart';

void main(List<String> arguments) {
  final config = Config();
  final options = Cli.parseCliArguments(arguments);

  if (options[CliOpts.newAdr]) {
    Cli.printWelcomeMessage();
    final adr = Cli.queryUserForAdr(
      requiredFields: config.requiredFields,
    );
    adr.save(config.outputDir);
  } else if (options[CliOpts.generateConfig]) {
    Config.generate();
  } else if (options[CliOpts.count]) {
    stdout.write('Number of ADRs in "${config.outputDir}": ');
    stdout.writeln(DirectoryOps.numberOfAdrs(config.outputDir));
  } else if (options[CliOpts.indexCreation]) {
    Cli.generateIndex(config.outputDir);
  } else {
    Cli.showUsage();
  }
}
