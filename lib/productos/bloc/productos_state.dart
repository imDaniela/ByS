part of 'productos_bloc.dart';

abstract class ProductosState extends Equatable {
  final List<Producto> productos, productos_all;
  const ProductosState(
      {this.productos = const [], this.productos_all = const []});

  @override
  List<Object> get props => [];
}

class ProductosLoading extends ProductosState {}

class ProductosInitial extends ProductosState {
  final List<Producto> productos, productos_all;
  const ProductosInitial(
      {this.productos = const [], this.productos_all = const []});
}
