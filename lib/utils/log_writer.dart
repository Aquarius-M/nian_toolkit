part of '../toolkit.dart';

class LogWriter {
  static final LogWriter _instance = LogWriter._internal();
  factory LogWriter() => _instance;
  LogWriter._internal();

  File? _file;

  static void run(void Function() appRunner) {
    runZonedGuarded(
      () async {
        WidgetsFlutterBinding.ensureInitialized();
        await LogWriter().init();
        appRunner();
      },
      (error, stack) {
        final msg = 'Error: $error\nStack: $stack';
        log(msg);
        LogWriter().write(msg);
      },
      zoneSpecification: ZoneSpecification(
        print: (self, parent, zone, line) {
          parent.print(zone, line);
          LogWriter().write(line);
        },
      ),
    );
  }

  Future<void> init() async {
    final dir = await getApplicationDocumentsDirectory();
    final logDir = Directory('${dir.path}/log');
    if (!await logDir.exists()) {
      await logDir.create(recursive: true);
    }

    final fileName = '.${DateTime.now().toString().split(" ").first}.log';
    _file = File('${logDir.path}/$fileName');
  }

  void write(String msg) {
    final now = DateTime.now();
    final time =
        "${now.hour.toString().padLeft(2, '0')}:${now.minute.toString().padLeft(2, '0')}:${now.second.toString().padLeft(2, '0')}";
    final logMsg = '[$time]: $msg';

    _file?.writeAsStringSync(logMsg, mode: FileMode.append);
  }
}
