import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

Widget asyncValueWrapper<T>({
  required AsyncValue<T> asyncValue,
  required Widget Function(T) data,
  Widget Function(Object, StackTrace)? error,
  Widget Function()? loading,
}) {
  return asyncValue.when(
    data: data,
    error: error ?? (e, _) => Center(child: Text('Erreur inconnue')),
    loading: loading ?? () => const Center(child: CircularProgressIndicator()),
  );
}
