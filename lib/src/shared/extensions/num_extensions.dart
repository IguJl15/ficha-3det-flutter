extension FunctionOperators on num {
  num minus(num other) => this - other;
  num plus(num other) => this + other;
  num times(num other) => this * other;
  num div(num other) => this / other;

  num unaryMinus() => -this;
}
