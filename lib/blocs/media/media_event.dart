part of 'media_bloc.dart';

abstract class MediaEvent extends Equatable {
  const MediaEvent();

  @override
  List<Object> get props => [];
}

class ClearData extends MediaEvent {}

class SetImage extends MediaEvent {
  final String urlImagen;

  const SetImage(this.urlImagen);
}

class SetLoading extends MediaEvent {
  final bool isLoading;

  const SetLoading(this.isLoading);
}


class SetCategories extends MediaEvent {
  final List<Categoria> categories;

 const  SetCategories(this.categories);
}


