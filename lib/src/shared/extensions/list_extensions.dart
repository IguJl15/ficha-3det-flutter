extension SumOfAny<E> on Iterable<E> {
  T sumOf<T extends num>(T Function(E element) getter) =>
      fold<T>(0 as T, (value, element) => value + getter(element) as T);
}
