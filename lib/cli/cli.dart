import 'dart:io';

import 'package:args/args.dart';
import 'package:meta/meta.dart';

import '../adr.dart';
import '../model/adr_data.dart';
import '../model/config.dart';
import 'cli_opts.dart';

/// Command-line utilities.
class Cli {
  static ArgResults parseCliArguments(List<String> args) {
    final parser = ArgParser()
      ..addFlag(CliOpts.count, abbr: 'c')
      ..addFlag(CliOpts.generateConfig, abbr: 'g')
      ..addFlag(CliOpts.indexCreation, abbr: 'i')
      ..addFlag(CliOpts.newAdr, abbr: 'n');

    return parser.parse(args);
  }

  static void printWelcomeMessage() {
    stdout.writeln('==================================');
    stdout.writeln('Welcome to Dart ADR manager!');
    stdout.writeln('Fields marked with * are required.');
    stdout.writeln('==================================');
    stdout.writeln();
  }

  static void showUsage() {
    printWelcomeMessage();
    stdout.writeln('Usage:');
    stdout.writeln(
        '\t-c\tPrint number of ADRs currently present in configured directory.');
    stdout.writeln('\t-g\tGenerate adr.yaml config file with defaults.');
    stdout.writeln('\t-i\tCreate index file "ADR000_index.md".');
    stdout.writeln('\t-n\tStart creation of new ADR.');
    stdout.writeln();
  }

  static AdrData queryUserForAdr({
    @required RequiredFields requiredFields,
  }) {
    final adr = AdrData();

    while (adr.title == null || adr.title.isEmpty) {
      stdout.write('* Title: ');
      adr.title = stdin.readLineSync().trim();
    }

    if (requiredFields.status) {
      while (!AdrData.isValidStringField(adr.status)) {
        stdout.write('* Status: ');
        adr.status = stdin.readLineSync();
      }
    } else {
      stdout.write('Status: ');
      adr.status = stdin.readLineSync();
    }

    if (requiredFields.deciders) {
      while (!AdrData.isValidStringField(adr.deciders)) {
        stdout.write('* Deciders: ');
        adr.deciders = stdin.readLineSync().trim();
      }
    } else {
      stdout.write('Deciders: ');
      adr.deciders = stdin.readLineSync().trim();
    }

    if (requiredFields.date) {
      while (!AdrData.isValidStringField(adr.date)) {
        stdout.write('* Date: ');
        adr.date = stdin.readLineSync().trim();
      }
    } else {
      stdout.write('Date: ');
      adr.date = stdin.readLineSync().trim();
    }

    if (requiredFields.techStory) {
      while (!AdrData.isValidStringField(adr.techStory)) {
        stdout.write('* Technical story: ');
        adr.techStory = stdin.readLineSync().trim();
      }
    } else {
      stdout.write('Technical story: ');
      adr.techStory = stdin.readLineSync().trim();
    }

    if (requiredFields.context) {
      while (!AdrData.isValidStringField(adr.context)) {
        stdout.write('* Context: ');
        adr.context = stdin.readLineSync().trim();
      }
    } else {
      stdout.write('Context: ');
      adr.context = stdin.readLineSync().trim();
    }

    adr.decisionDrivers = <String>[];
    if (requiredFields.decisionDrivers) {
      while (!AdrData.isValidListField(adr.decisionDrivers)) {
        stdout.write('* Decision drivers: ');
        var decisionDriver = stdin.readLineSync();
        while (decisionDriver.isNotEmpty) {
          adr.decisionDrivers.add(decisionDriver);
          stdout.write('- ');
          decisionDriver = stdin.readLineSync();
        }
      }
    } else {
      stdout.write('Decision drivers: ');
      var decisionDriver = stdin.readLineSync();
      while (decisionDriver.isNotEmpty) {
        adr.decisionDrivers.add(decisionDriver);
        stdout.write('- ');
        decisionDriver = stdin.readLineSync();
      }
    }

    adr.consideredOptions = <String>[];
    if (requiredFields.consideredOptions) {
      while (!AdrData.isValidListField(adr.consideredOptions)) {
        stdout.write('* Considered options: ');
        var consideredOption = stdin.readLineSync();
        while (consideredOption.isNotEmpty) {
          adr.consideredOptions.add(consideredOption);
          stdout.write('- ');
          consideredOption = stdin.readLineSync();
        }
      }
    } else {
      stdout.write('Considered options: ');
      var consideredOption = stdin.readLineSync();
      while (consideredOption.isNotEmpty) {
        adr.consideredOptions.add(consideredOption);
        stdout.write('- ');
        consideredOption = stdin.readLineSync();
      }
    }

    if (requiredFields.decisionOutcome) {
      while (!AdrData.isValidStringField(adr.decisionOutcome)) {
        stdout.write('* Decision outcome: ');
        adr.decisionOutcome = stdin.readLineSync().trim();
      }
    } else {
      stdout.write('Decision outcome: ');
      adr.decisionOutcome = stdin.readLineSync().trim();
    }

    adr.pros = <String>[];
    if (requiredFields.pros) {
      while (!AdrData.isValidListField(adr.pros)) {
        stdout.write('* Pros: ');
        var pro = stdin.readLineSync();
        while (pro.isNotEmpty) {
          adr.pros.add(pro);
          stdout.write('- ');
          pro = stdin.readLineSync();
        }
      }
    } else {
      stdout.write('Pros: ');
      var pro = stdin.readLineSync();
      while (pro.isNotEmpty) {
        adr.pros.add(pro);
        stdout.write('- ');
        pro = stdin.readLineSync();
      }
    }

    adr.cons = <String>[];
    if (requiredFields.cons) {
      while (!AdrData.isValidListField(adr.cons)) {
        stdout.write('* Cons: ');
        var con = stdin.readLineSync();
        while (con.isNotEmpty) {
          adr.cons.add(con);
          stdout.write('- ');
          con = stdin.readLineSync();
        }
      }
    } else {
      stdout.write('Cons: ');
      var con = stdin.readLineSync();
      while (con.isNotEmpty) {
        adr.cons.add(con);
        stdout.write('- ');
        con = stdin.readLineSync();
      }
    }

    adr.prosConsOpts = <String, List<String>>{};
    for (final option in adr.consideredOptions) {
      adr.prosConsOpts[option] = <String>[];
      if (requiredFields.prosConsOpts) {
        while (!AdrData.isValidListField(adr.prosConsOpts[option])) {
          stdout.write('* Pros and cons for option "$option": ');
          var prosConsOpt = stdin.readLineSync();
          while (prosConsOpt.isNotEmpty) {
            adr.prosConsOpts[option].add(prosConsOpt);
            stdout.write('- ');
            prosConsOpt = stdin.readLineSync();
          }
        }
      } else {
        stdout.write('Pros and cons for option "$option": ');
        var prosConsOpt = stdin.readLineSync();
        while (prosConsOpt.isNotEmpty) {
          adr.prosConsOpts[option].add(prosConsOpt);
          stdout.write('- ');
          prosConsOpt = stdin.readLineSync();
        }
        if (adr.prosConsOpts[option].isEmpty) {
          adr.prosConsOpts.remove(option);
        }
      }
    }

    adr.links = <String, String>{};
    if (requiredFields.links) {
      while (!AdrData.isValidMapField(adr.links)) {
        stdout.write('* Links: ');
        var link = stdin.readLineSync();
        while (link.isNotEmpty) {
          final linkParts = link.split(',');
          if (linkParts.length != 2) {
            stdout.writeln('Link must be in form "<description>,<url>"!');
            link = stdin.readLineSync();
            continue;
          }
          adr.links[linkParts[0]] = linkParts[1];
          stdout.write('- ');
          link = stdin.readLineSync();
        }
      }
    } else {
      stdout.write('Links: ');
      var link = stdin.readLineSync();
      while (link.isNotEmpty) {
        final linkParts = link.split(',');
        if (linkParts.length != 2) {
          stdout.writeln('Link must be in form "<description>,<url>"!');
          link = stdin.readLineSync();
          continue;
        }
        adr.links[linkParts[0]] = linkParts[1];
        stdout.write('- ');
        link = stdin.readLineSync();
      }
    }
    return adr;
  }

  static void generateIndex(String directory) {
    stdout.writeln('Generating index in "$directory/ADR0000_index.md" ...');

    var content = '# Architectural Decision Records Index\n\n';

    final adrs = DirectoryOps.existingAdrs(directory);
    for (final adr in adrs) {
      final splitterIdx = adr.indexOf('_');
      final lastDotIdx = adr.lastIndexOf('.');
      final adrNumber = adr.substring(0, splitterIdx);
      final adrTitle = adr.substring(splitterIdx + 1, lastDotIdx);
      content +=
          '- [$adrNumber: $adrTitle]($directory/${adr.replaceAll(' ', '%20')})\n';
    }

    final indexFile = File('$directory/ADR0000_index.md');
    indexFile.writeAsStringSync(content);

    stdout.writeln('Index generated!');
  }
}
