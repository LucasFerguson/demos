/**
 * Topics to demonstrate:
 * 
 * - Classes
 * - Constructors
 * - Getters & Setters
 * - Inheritance
 * - Mixins
 * - Operator overloading
 * - Object identity, equality, and constant objects
 */

import 'dart:math';

// Classes
abstract class Shape {
// we cam get rid of this definition by making the class abstract
  // double area() {
  //   return 0; // can we get rid of this definition?
  // }
}

// Inheritance
class Circle extends Shape {
  double radius;

  // Constructor
  Circle(this.radius);

  // Getters and Setters
  double get diameter =>
      radius * 2; // ah this is cool! ex: circle.diameter calles this method
  set diameter(double value) =>
      {radius = value / 2}; // wraping in curly braces is optional

  double area() {
    return 3.14159 * radius * radius;
  }

  // Operator overloading
  Circle operator +(Circle other) {
    return Circle(this.radius + other.radius);
  }
}

class Rectangle extends Shape {
  double width;
  double height;

  // Constructors
  Rectangle(this.width, this.height);

  double area() {
    return width * height;
  }
}

class Square extends Rectangle {
  // Constructor with initializer list
  // why strange new colan : syntax?
  // everything in the colan is executed before the constructor body, and is gurrenteed to run before anything in the class
  Square(double side) : super(side, side);
}

// most oo languages only have one parent class bc if 2 parents define methods with the same name, which do we choose? dart has mixins to fix this
// mixins are cool
// Mixin
mixin Positioned {
  double x = 0;
  double y = 0;

  double distanceTo(Positioned other) {
    final dx = x - other.x;
    final dy = y - other.y;
    return sqrt(dx * dx + dy * dy);
  }
}

class PositionedCircle extends Circle with Positioned {
  PositionedCircle(double radius, double x, double y) : super(radius) {
    this.x = x;
    this.y = y;
  }
}

class Blob with Positioned {
  final String name;

  Blob(this.name, double x, double y) {
    this.x = x;
    this.y = y;
  }
}

// Object identity, equality, and constant objects
class Foo {
  final int x;
  final int y;
  // late final int x; late is a keyword that tells dart, trust me, I will initialize this variable before I use it

  const Foo(this.x, this.y); // try making this const

  // this is like python dunder methods https://www.geeksforgeeks.org/dunder-magic-methods-python/
  bool operator ==(Object other) {
    if (other is Foo) {
      return x == other.x && y == other.y;
    }
    return false;
  }

  int get hashCode => x.hashCode ^ y.hashCode;
}

void main() {
  var circle = Circle(5);
  print('Circle Area: ${circle.area()}');
  print('Circle Diameter: ${circle.diameter}');
  print('Is Circle a Shape? ${circle is Shape}');

  circle.diameter = 50;
  print('Updated Circle Radius: ${circle.radius}');

  var circle2 = circle + Circle(8);
  print('Circle2 Radius: ${circle2.radius}');
  print('Circle2 Area: ${circle2.area()}');

  var rectangle = Rectangle(4, 6);
  print('Rectangle Area: ${rectangle.area()}');

  var square = Square(5);
  print('Is Square a Shape? ${square is Shape}');
  print('Is Square a Rectangle? ${square is Rectangle}');
  print('Square Area: ${square.area()}');

  var pCircle = PositionedCircle(8, 2, 5);

  print('Positioned Circle Area: ${pCircle.area()}');
  print('Positioned Circle Position: (${pCircle.x}, ${pCircle.y})');
  print('Is Positioned Circle a Circle? ${pCircle is Circle}');
  print('Is Positioned Circle Positioned? ${pCircle is Positioned}');

// blow dose not share the same parent class as PositionedCircle
  var blob = Blob('Flubber', 5, 1);
  print('Is Blob a Shape? ${blob is Shape}');
  print('Is Blob Positioned? ${blob is Positioned}');
  print(
      'Distance between Circle and Blob: ${pCircle.distanceTo(blob)}'); // this is very cool!

  // how to make the following const objects? what does it mean?
  const foo1 = Foo(5, 10);
  const foo2 = Foo(5, 10);

  print('foo1 == foo2? ${foo1 == foo2}');
  print('foo1.hashCode == foo2.hashCode? ${foo1.hashCode == foo2.hashCode}');
  print(
      'foo1 identity == foo2 identity? ${identical(foo1, foo2)}'); // ooohhh we want to make this true
  // yay!

  /* 
  Output:
  Updated Circle Radius: 25.0
  Circle2 Radius: 33.0
  Circle2 Area: 3421.1915099999997
  Rectangle Area: 24.0
  Is Square a Shape? true
  Is Square a Rectangle? true
  Square Area: 25.0
  Positioned Circle Area: 201.06176
  Positioned Circle Position: (2.0, 5.0)
  Is Positioned Circle a Circle? true
  Is Positioned Circle Positioned? true
  Is Blob a Shape? false
  Is Blob Positioned? true
  Distance between Circle and Blob: 5.0
  foo1 == foo2? true
  foo1.hashCode == foo2.hashCode? true
  foo1 identity == foo2 identity? true

  Exited.
  
  */
}
