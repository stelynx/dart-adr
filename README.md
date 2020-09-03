# Architectural Design Records Utility

[![Pub Version](https://img.shields.io/pub/v/adr?color=%233dc6fd&logo=flutter&logoColor=%233dc6fd)](https://pub.dev/packages/adr)

Utility for maintaining consistent Architectural Design Records (ADRs) for Dart/Flutter projects.

## About

Developing more complex applications, either by complexity or simply by number of lines in codebase,
the ideas from the start of the project easily vanish from developers minds. Not to mention when new
folks come to the project, they have no idea why and how something is implemented. Usually, the main
architect has an overview over the whole application, but this is not necessarily the case. Also, in start-ups, such roles are often implicitely defined and decisions are taken in a larger group of people.
This can easily lead to some crucial architectural or technological decision made in the past to vain in memory, be forgotton, or even become misinterpreted as the time goes by.

With this being said, each project needs a way of collecting this decisions in an organized and condensed manner.
This is the point where this project comes to the rescue, big times.

## Usage

This application can be installed and used in two different ways. We shall describe both of them in the coming subsections.

### Global installation

The package can be installed globaly simply by executing

```bash
pub global activate adr
```

Then, from any directory on your machine, run

```bash
adr
```

### Per-application installation

Require the package in your application's `pubspec.yaml` file in `dev_dependencies` like

```yaml
dev_dependencies:
  adr: ^1.0.0
```

Then, in the root of your project, run

```bash
pub run adr
```

### Flags

Command `adr` is always meant to be run with **exactly one flag**. Running `adr` with no flags, will print help to the console, listing all available flags.

Available flags are:

<table>
  <tr>
    <th>Flag</th>
    <th>Description</th>
  </tr>
  <tr>
    <td><code>-c</code></td>
    <td>Print number of ADRs currently present in configured directory.</td>
  </tr>
  <tr>
    <td><code>-g</code></td>
    <td>Generate adr.yaml config file with defaults.</td>
  </tr>
  <tr>
    <td><code>-i</code></td>
    <td>Create index file "ADR000_index.md".</td>
  </tr>
  <tr>
    <td><code>-n</code></td>
    <td>Start creation of new ADR.</td>
  </tr>
</table>

## Configuration

ADR can be configured using `adr.yaml` file in the directory of execution. If you are running the `adr` command in a project directory (same level as your `pubspec.yaml` file), then the `adr.yaml` should
be placed at the same level as the `pubspec.yaml`.

Example `adr.yaml` looks like this.

```yaml
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
```

Field `output_dir` specifies the directory path where the ADRs should be generated to, or are already there. The `required_fields` section specifies whether some fields are required or not. If omitting a field or `adr.yaml` at all, the defaults are used (values in the example above are defaults).

The structure of generated ADRs is the same as the
official [MADR](https://github.com/adr/madr) specification, except you can configure required fields to your own personal preference.
