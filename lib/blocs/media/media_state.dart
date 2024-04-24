part of 'media_bloc.dart';

class MediaState extends Equatable {
  final String urlImagenCategoria;
  final List<Categoria> categorias;
   final List<Tematica> tematicas;
  final bool loading;

  const MediaState({required this.urlImagenCategoria, required this.categorias, this.loading = false, required this.tematicas });
    
    MediaState copyWith({
    String? urlImagenCategoria,
    List<Categoria>? categorias,
    List<Tematica>? tematicas,
    bool? loading
     }) =>
      MediaState(
          urlImagenCategoria: urlImagenCategoria ?? this.urlImagenCategoria,
          categorias: categorias ?? this.categorias,
          tematicas: tematicas ?? this.tematicas,
          loading: loading ?? this.loading
          );

  @override
  List<Object> get props => [ urlImagenCategoria, categorias, loading, tematicas ];
}
