import 'package:flutter/material.dart';
import 'package:render_objects_playground/widgets/bullet_point.dart';

class BulletPointsDemoPage extends StatelessWidget {
  BulletPointsDemoPage({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Custom Bullet Point Demo'),
      ),
      body: Center(
          child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          BulletPoint(
              bullet: BulletType.arrow,
              child:
                  Text("Arrow styled bullet", style: TextStyle(fontSize: 18))),
          SizedBox(height: 10),
          BulletPoint(
              bullet: BulletType.circleFilled,
              child: Text("Filled circle styled bullet",
                  style: TextStyle(fontSize: 18))),
          SizedBox(height: 10),
          BulletPoint(
              bullet: BulletType.circleOutlined,
              outlineColor: Colors.orangeAccent,
              child: Text("Outlined circle styled bullet",
                  style: TextStyle(fontSize: 18))),
          SizedBox(height: 10),
          BulletPoint(
              bullet: BulletType.squareFilled,
              fillColor: Colors.blueGrey,
              child: Text("Filled square styled bullet",
                  style: TextStyle(fontSize: 18))),
          SizedBox(height: 10),
          BulletPoint(
              bullet: BulletType.squareOutlined,
              outlineColor: Colors.redAccent,
              child: Text("Outlined square styled bullet",
                  style: TextStyle(fontSize: 18))),
          SizedBox(height: 10),
          BulletPoint(
              bullet: BulletType.dash,
              child:
                  Text("Dash styled bullet", style: TextStyle(fontSize: 18))),
          SizedBox(height: 10),
          BulletPoint(
              bullet: BulletType.dash,
              child: Row(
                children: [
                  FlutterLogo(),
                  SizedBox(width: 10),
                  Expanded(
                    child: Text(
                        "Dash styled bullet with non RenderParagraph object",
                        style: TextStyle(fontSize: 18)),
                  ),
                ],
              )),
        ],
      )),
    );
  }
}
