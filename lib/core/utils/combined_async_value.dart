import 'package:flutter_riverpod/flutter_riverpod.dart';

AsyncValue<R> combineAsyncValues<A, B, R>(
  AsyncValue<A> a,
  AsyncValue<B> b,
  R Function(A, B) combiner,
) {
  if (a.isLoading || b.isLoading) {
    return const AsyncValue.loading();
  }
  if (a.hasError && a.stackTrace != null) {
    return AsyncValue.error(a.error!, a.stackTrace!);
  }
  if (b.hasError && b.stackTrace != null) {
    return AsyncValue.error(b.error!, b.stackTrace!);
  }

  return AsyncValue.data(combiner(a.value as A, b.value as B));
}
