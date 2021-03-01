import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:zce/havadurumu/weather/tema/tema_bloc.dart';
class SehirSecWidget extends StatefulWidget {
  @override
  _SehirSecWidgetState createState() => _SehirSecWidgetState();
}

class _SehirSecWidgetState extends State<SehirSecWidget> {
 final _textController=TextEditingController();
  @override
  Widget build(BuildContext context) {
    return BlocBuilder(
      cubit: BlocProvider.of<TemaBloc>(context),
      builder: (context,TemaState state){
        return  Scaffold(
          backgroundColor:Colors.black38,
          floatingActionButton: FloatingActionButton(
            backgroundColor: (state as UygulamaTemasi).renk,
            onPressed: ()  {
              Navigator.pop(context);


            },
            child: Icon(Icons.arrow_back_outlined),
          ),
          body: Form(
            child: Form(

              child: Row(
                mainAxisSize: MainAxisSize.max,
                children: [

                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: TextFormField(
                        style:TextStyle(color: Colors.white) ,
                        controller: _textController,
                        decoration: InputDecoration(

                          labelText: 'şehir',
                          labelStyle:TextStyle(fontSize: 17.0, color: Colors.white),
                          hintText: 'şehir adı girin',
                          hintStyle: TextStyle(fontSize: 17.0, color: Colors.white),
                          border: OutlineInputBorder(),

                        ),
                      ),
                    ),
                  ),
                  IconButton(icon: Icon(Icons.search,color: Colors.white,), onPressed: (){
                    Navigator.pop(context,_textController.text);
                  })
                ],
              ),),
          ),
        );

      }


    );
  }
}
