void debugPrintColor(String message, {String color = 'red'}) {
  final colors = {
    'red': '\x1B[31m',
    'green': '\x1B[32m',
    'yellow': '\x1B[33m',
    'blue': '\x1B[34m',
    'magenta': '\x1B[35m',
    'cyan': '\x1B[36m',
    'default': '\x1B[0m',
  };

  final colorCode = colors[color] ?? colors['default'];
  print('$colorCode$message\x1B[0m');
}
