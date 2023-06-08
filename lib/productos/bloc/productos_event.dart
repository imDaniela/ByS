part of 'productos_bloc.dart';

abstract class ProductosEvent extends Equatable {
  const ProductosEvent();

  @override
  List<Object> get props => [];
}

class LoadProductos extends ProductosEvent {}
