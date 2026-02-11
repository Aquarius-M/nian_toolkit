part of '../../toolkit.dart';

class ColorPicker extends StatefulWidget implements PluggableWithNestedWidget {
  const ColorPicker({Key? key}) : super(key: key);

  @override
  _ColorPickerState createState() => _ColorPickerState();

  @override
  Widget buildWidget(BuildContext? context) => this;

  @override
  String get name => 'ColorPicker';

  @override
  void onTrigger() {}

  @override
  Widget? iconWidget() => PluginIcons.colorPicker;

  @override
  int get index => 9990;

  @override
  Widget buildNestedWidget(Widget child) {
    return EyeDrop(child: child);
  }
}

class _ColorPickerState extends State<ColorPicker> {
  final colorTextStyle = TextStyle(
      fontFamily: "Monospace", fontWeight: FontWeight.bold, fontSize: 20);

  Color? _color;

  double _toolBarY = 60.0;

  void _toolBarPanUpdate(DragUpdateDetails dragDetails) {
    final mediaQuery = MediaQuery.of(context);
    final minY = mediaQuery.padding.top;
    final maxY = (mediaQuery.size.height -
            kToolbarHeight -
            50.0 -
            mediaQuery.padding.bottom)
        .clamp(minY, mediaQuery.size.height);
    final newY = (dragDetails.globalPosition.dy - 40).clamp(minY, maxY);
    _toolBarY = newY.toDouble();
    setState(() {});
  }

  String get currentColor => _color != null
      ? "#${_color?.toARGB32().toRadixString(16).padLeft(8, '0').substring(2).toUpperCase()}"
      : "👈🏻Tap to pick";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: Stack(
        children: [
          Positioned(
            left: 0,
            right: 0,
            top: _toolBarY,
            child: GestureDetector(
              onVerticalDragUpdate: _toolBarPanUpdate,
              child: Center(
                child: Container(
                    decoration: ShapeDecoration(
                      shape: StadiumBorder(),
                      color: context.appColor.backgroundPopup,
                      shadows: [
                        BoxShadow(color: Colors.black54, blurRadius: 12),
                      ],
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        CircleAvatar(
                            radius: 40,
                            backgroundColor: _color,
                            child: EyedropperButton(
                              onColor: (color) =>
                                  setState(() => _color = color),
                              onColorChanged: (color) =>
                                  setState(() => _color = color),
                            )),
                        GestureDetector(
                          onTap: () {
                            if (_color != null) {
                              KitUtils.copy(context, currentColor,
                                  toastText: 'Color copied');
                            }
                          },
                          child: Container(
                            constraints: BoxConstraints(minWidth: 100),
                            padding: EdgeInsets.only(left: 8),
                            child: Text(
                              currentColor,
                              style: context.f16BoldTextPrimary,
                            ),
                          ),
                        )
                      ],
                    )),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
