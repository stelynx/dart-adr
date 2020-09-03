import 'dart:io';

import 'package:path/path.dart' as path;

import '../adr.dart';

/// Data that is used in ADR file.
class AdrData {
  String title;
  String status;
  String deciders;
  String date;
  String techStory;
  String context;
  List<String> decisionDrivers;
  List<String> consideredOptions;
  String decisionOutcome;
  List<String> pros;
  List<String> cons;
  Map<String, List<String>> prosConsOpts;
  Map<String, String> links;

  AdrData({
    this.title,
    this.status,
    this.deciders,
    this.date,
    this.techStory,
    this.context,
    this.decisionDrivers,
    this.consideredOptions,
    this.decisionOutcome,
    this.pros,
    this.cons,
    this.prosConsOpts,
    this.links,
  });

  static bool isValidStringField(String value) {
    return value != null && value.isNotEmpty;
  }

  static bool isValidListField(List value) {
    return value != null && value.isNotEmpty;
  }

  static bool isValidMapField(Map value) {
    return value != null && value.isNotEmpty;
  }

  void save(String dir) {
    String prefix;

    final directory = Directory(dir);
    if (!directory.existsSync()) {
      directory.createSync(recursive: true);
      prefix = '0001';
    } else {
      final existingAdrs = DirectoryOps.existingAdrs(dir);
      if (existingAdrs.isEmpty) {
        prefix = '0001';
      } else {
        final lastAdrNumber =
            int.parse(existingAdrs.last.split('_').first.substring(3));
        prefix = '000${lastAdrNumber + 1}';
        prefix = prefix.substring(prefix.length - 4);
      }
    }

    final p = path.join(dir, 'ADR${prefix}_$title.md');

    final f = File(p);
    f.writeAsStringSync(_generateContent());
    stdout.writeln('File "$p" generated!');
  }

  String _generateContent() {
    // Title
    var content = '# $title\n\n';

    var addNewLine = false;

    // Status
    if (isValidStringField(status)) {
      content += '* Status: $status\n';
      addNewLine = true;
    }

    // Deciders
    if (isValidStringField(deciders)) {
      content += '* Deciders: $deciders\n';
      addNewLine = true;
    }

    // Date
    if (isValidStringField(date)) {
      content += '* Date: $date\n';
      addNewLine = true;
    }

    if (addNewLine) content += '\n';

    // TechStory
    if (isValidStringField(techStory)) {
      content += 'Technical Story: $techStory\n\n';
    }

    if (isValidStringField(context)) {
      content += '## Context and Problem Statement\n\n';
      content += context + '\n\n';
    }

    if (isValidListField(decisionDrivers)) {
      content += '## Decision Drivers\n\n';
      for (final decisionDriver in decisionDrivers) {
        content += '* $decisionDriver\n';
      }
      content += '\n';
    }

    if (isValidListField(consideredOptions)) {
      content += '## Considered Options\n\n';
      for (final consideredOption in consideredOptions) {
        content += '* $consideredOption\n';
      }
      content += '\n';
    }

    if (isValidStringField(decisionOutcome)) {
      content += '## Decision Outcome\n\n';
      content += decisionOutcome + '\n\n';
    }

    if (isValidListField(pros)) {
      content += '### Positive Consequences\n\n';
      for (final pro in pros) {
        content += '* $pro\n';
      }
      content += '\n';
    }

    if (isValidListField(cons)) {
      content += '### Negative Consequences\n\n';
      for (final con in cons) {
        content += '* $con\n';
      }
      content += '\n';
    }

    if (isValidMapField(prosConsOpts)) {
      content += '## Pros and Cons of the Options\n\n';
      for (final option in consideredOptions) {
        content += '### $option\n\n';

        if (!prosConsOpts.containsKey(option)) {
          content += 'Not disclosed.\n\n';
          continue;
        }

        for (final prosConsOpt in prosConsOpts[option]) {
          content += '* $prosConsOpt\n';
        }
        content += '\n';
      }
    }

    if (isValidMapField(links)) {
      content += '## Links\n\n';
      for (final link in links.entries) {
        content += '* [${link.key}](${link.value})\n';
      }
    }

    return content;
  }
}
