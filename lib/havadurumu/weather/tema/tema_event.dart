part of 'tema_bloc.dart';

abstract class TemaEvent extends Equatable {
  const TemaEvent([List<String> list]);
}
class TemadegistirEvent extends TemaEvent{
 final String havadurumukisaltmasi;
 TemadegistirEvent({@required this.havadurumukisaltmasi}):super([havadurumukisaltmasi]);

  @override
  // TODO: implement props
  List<Object> get props => [havadurumukisaltmasi];

}