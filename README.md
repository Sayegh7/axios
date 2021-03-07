# axios

`axios` is a simple, zero-configuration command-line http server. Inspired by npm's `http-server`. In fact this package's API tries to closely match that of the API of `http-server`.

## Install

```
pub global activate axios
```

## Usage

```
axios [options] [path]
```

## Options

| Option  | Abbreviation  |  Description | Default  |
|---|---|---|---|
| `--address`  | `-a`  | Defines address to listen on  | `0.0.0.0`  |
| `--port` |  `-p` |  Defines which port to listen on |  8080 |
|  `--silent` |  `-s` | Suppress log messages from output  |  `false` |
| `--directory`  |  `-d` |  Allows directory listing |  `true` |
| `--version`  |  `-v` |  Prints current axios version |  |


The `path` defaults to current directory `./` unless otherwise specified.

## Upcoming features
- CORS
- TLS/SSL
