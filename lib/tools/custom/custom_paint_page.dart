import 'package:flutter/material.dart';

class CustomPaintPage extends StatefulWidget {
  @override
  State<CustomPaintPage> createState() => _CustomPaintPageState();
}

class _CustomPaintPageState extends State<CustomPaintPage> {
  List<Piece> pieces = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("棋盘"),
      ),
      body: Center(
        child: Listener(
          onPointerUp: (event) {
            pieces.add(Piece.black(event.localPosition));
            setState(() {});
          },
          child: CustomPaint(
            size: Size(300, 300), // 指定画布大小
            painter: MyPainter(pieces),
          ),
        ),
      ),
    );
  }
}

class MyPainter extends CustomPainter {
  Paint _paint = Paint()
    ..color = Colors.amber
    ..isAntiAlias = true;

  List<Piece> pieces;

  MyPainter(this.pieces);

  Paint _piecePaint = Paint()
    ..color = Colors.amber
    ..isAntiAlias = true;

  @override
  void paint(Canvas canvas, Size size) {
    Rect rect = Rect.fromPoints(Offset(0, 0), Offset(size.width, size.height));
    canvas.drawRect(rect, _paint);

    double w = size.width / 15;

    _paint.color = Colors.black87;
    _paint.strokeWidth = 1;

    for (int i = 0; i < 16; i++) {
      Offset of1 = Offset(w * i, 0);
      Offset of2 = Offset(w * i, size.height);
      canvas.drawLine(of1, of2, _paint);
    }

    for (int i = 0; i < 16; i++) {
      Offset of1 = Offset(0, w * i);
      Offset of2 = Offset(size.width, w * i);
      canvas.drawLine(of1, of2, _paint);
    }

    pieces.forEach((piece) {
      _piecePaint.color = piece.color;
      canvas.drawCircle(piece._offset, 5, _piecePaint);
    });
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}

class Piece {
  Color color;
  Offset _offset;

  Piece(this.color, this._offset);

  Piece.white(this._offset) : color = Colors.white;

  Piece.black(this._offset) : color = Colors.black87;
}
