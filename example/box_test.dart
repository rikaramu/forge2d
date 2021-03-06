library box_test;

import 'dart:math' as math;
import 'demo.dart';

import 'package:forge2d/forge2d.dart';

class BoxTest extends Demo {
  /// Constructs a new BoxTest.
  BoxTest() : super("Box test");

  /// Entrypoint.
  static void main() {
    final boxTest = BoxTest();
    boxTest.initialize();
    boxTest.initializeAnimation();
    boxTest.runAnimation();
  }

  @override
  void initialize() {
    assert(null != world);
    _createGround();
    _createBox();
  }

  void _createGround() {
    // Create shape
    final PolygonShape shape = PolygonShape();

    // Define body
    final BodyDef bodyDef = BodyDef();
    bodyDef.position.setValues(0.0, 0.0);

    // Create body
    final Body ground = world.createBody(bodyDef);

    // Set shape 3 times and create fixture on the body for each
    shape.setAsBoxXY(50.0, 0.4);
    ground.createFixtureFromShape(shape);
    shape.setAsBox(0.4, 50.0, Vector2(-10.0, 0.0), 0.0);
    ground.createFixtureFromShape(shape);
    shape.setAsBox(0.4, 50.0, Vector2(10.0, 0.0), 0.0);
    ground.createFixtureFromShape(shape);

    // Add composite body to list
    bodies.add(ground);
  }

  void _createBox() {
    // Create shape
    final PolygonShape shape = PolygonShape();
    shape.setAsBox(3.0, 1.5, Vector2.zero(), math.pi / 2);

    // Define fixture (links body and shape)
    final FixtureDef activeFixtureDef = FixtureDef();
    activeFixtureDef.restitution = 0.5;
    activeFixtureDef.density = 0.05;
    activeFixtureDef.shape = shape;

    // Define body
    final BodyDef bodyDef = BodyDef();
    bodyDef.type = BodyType.DYNAMIC;
    bodyDef.position = Vector2(0.0, 30.0);

    // Create body and fixture from definitions
    final Body fallingBox = world.createBody(bodyDef);
    fallingBox.createFixture(activeFixtureDef);

    // Add to list
    bodies.add(fallingBox);
  }
}

void main() {
  BoxTest.main();
}
