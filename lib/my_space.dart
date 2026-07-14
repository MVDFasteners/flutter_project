import 'dart:typed_data';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';

class TShirtDesignerPage extends StatefulWidget {
  const TShirtDesignerPage({super.key});

  @override
  State<TShirtDesignerPage> createState() => _TShirtDesignerPageState();
}

class _TShirtDesignerPageState extends State<TShirtDesignerPage> {
  // Shirt color
  Color _shirtColor = Colors.white;

  // Uploaded design image bytes
  Uint8List? _designImage;

  // Transform values for the design image
  Offset _designPosition = Offset.zero; // relative movement
  double _designScale = 1.0;

  // For gesture calculations
  Offset _initialFocalPoint = Offset.zero;
  Offset _initialPosition = Offset.zero;
  double _initialScale = 1.0;

  Future<void> _pickDesignImage() async {
    final result = await FilePicker.platform.pickFiles(type: FileType.image);
    if (result != null && result.files.single.bytes != null) {
      setState(() {
        _designImage = result.files.single.bytes;
        _designPosition = Offset.zero;
        _designScale = 1.0;
      });
    }
  }

  void _onScaleStart(ScaleStartDetails details) {
    _initialFocalPoint = details.focalPoint;
    _initialPosition = _designPosition;
    _initialScale = _designScale;
  }

  void _onScaleUpdate(ScaleUpdateDetails details) {
    final Offset delta = details.focalPoint - _initialFocalPoint;

    setState(() {
      _designPosition = _initialPosition + delta;
      _designScale = (_initialScale * details.scale).clamp(0.2, 5.0);
    });
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      appBar: AppBar(title: const Text('T-Shirt Designer')),
      body: Column(
        children: [
          const SizedBox(height: 8),
          Expanded(
            child: Center(
              child: AspectRatio(
                aspectRatio: 3 / 4, // T-shirt-ish ratio
                child: LayoutBuilder(
                  builder: (context, constraints) {
                    return Stack(
                      alignment: Alignment.center,
                      children: [
                        // Base colored T-shirt
                        _buildColoredTShirt(constraints),

                        // Design image on top (if selected)
                        if (_designImage != null)
                          GestureDetector(
                            onScaleStart: _onScaleStart,
                            onScaleUpdate: _onScaleUpdate,
                            child: Transform.translate(
                              offset: _designPosition,
                              child: Transform.scale(
                                scale: _designScale,
                                child: Image.memory(
                                  _designImage!,
                                  fit: BoxFit.contain,
                                  width: constraints.maxWidth * 0.5,
                                ),
                              ),
                            ),
                          ),
                      ],
                    );
                  },
                ),
              ),
            ),
          ),

          // Controls: color selector + upload button
          Padding(
            padding: const EdgeInsets.all(12.0),
            child: Column(
              children: [
                Text(
                  'Choose T-Shirt Color',
                  style: theme.textTheme.titleMedium,
                ),
                const SizedBox(height: 8),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    _colorDot(Colors.white),
                    _colorDot(Colors.black),
                    _colorDot(Colors.yellow),
                    _colorDot(Colors.red),
                    _colorDot(Colors.blue),
                  ],
                ),
                const SizedBox(height: 16),
                FilledButton.icon(
                  onPressed: _pickDesignImage,
                  icon: const Icon(Icons.upload),
                  label: const Text('Upload Design Image'),
                ),
                const SizedBox(height: 12),
                if (_designImage == null)
                  const Text(
                    'Tip: Upload your logo, text image or any design and drag it on the T-shirt.',
                    textAlign: TextAlign.center,
                  ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _colorDot(Color color) {
    final bool isSelected = _shirtColor.value == color.value;
    return GestureDetector(
      onTap: () {
        setState(() {
          _shirtColor = color;
        });
      },
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 6),
        width: 32,
        height: 32,
        decoration: BoxDecoration(
          color: color,
          shape: BoxShape.circle,
          border: Border.all(
            color: isSelected ? Colors.blue : Colors.grey.shade400,
            width: isSelected ? 3 : 1,
          ),
        ),
      ),
    );
  }

  Widget _buildColoredTShirt(BoxConstraints constraints) {
    return SizedBox(
      width: constraints.maxWidth,
      height: constraints.maxHeight,
      child: ColorFiltered(
        colorFilter: ColorFilter.mode(_shirtColor, BlendMode.srcATop),
        child: Image.asset(
          'assets/images/logo/t-shirt transparent.png',
          fit: BoxFit.contain,
        ),
      ),
    );
  }
}
