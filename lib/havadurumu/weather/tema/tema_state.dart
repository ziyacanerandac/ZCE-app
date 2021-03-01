
part of 'tema_bloc.dart';


abstract class TemaState extends Equatable {
  const TemaState([List<Object> list]);
}

class TemaInitial extends TemaState {
  @override

  List<Object> get props => [];
}
class UygulamaTemasi extends TemaState{

 final ThemeData tema;
 final MaterialColor renk;
 UygulamaTemasi({@required this.tema, @required this.renk}):super([tema,renk]);

 @override
  // TODO: implement props
  List<Object> get props => [tema,renk];

}
