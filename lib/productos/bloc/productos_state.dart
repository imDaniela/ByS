part of 'productos_bloc.dart';

abstract class ProductosState extends Equatable {
  final List<Producto> productos;
  const ProductosState({this.productos = const []});

  @override
  List<Object> get props => [];
}

class ProductosInitial extends ProductosState {
  final List<Producto> productos;
  const ProductosInitial({this.productos = const []});
}
