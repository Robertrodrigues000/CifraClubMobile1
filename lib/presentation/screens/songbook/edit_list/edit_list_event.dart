import 'package:cifraclub/domain/shared/request_error.dart';

sealed class EditListEvent {}

class ReorderError extends EditListEvent {
  final bool sortError;
  final bool deleteError;
  final RequestError error;

  ReorderError({required this.error, required this.deleteError, required this.sortError});
}

class ReorderSuccess extends EditListEvent {}
