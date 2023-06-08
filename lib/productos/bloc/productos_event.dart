part of 'productos_bloc.dart';

abstract class ProductosEvent extends Equatable {
  const ProductosEvent();

  @override
  List<Object> get props => [];
}

class SearchProductos extends ProductosEvent {
  final String search;
  SearchProductos(this.search);
}

class LoadProductos extends ProductosEvent {}
