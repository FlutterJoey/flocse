typedef DependencyInjector<T> = void Function(T);

extension DependencySuperType<T> on DependencyInjector<T> {
  Type getType() => T;
}
