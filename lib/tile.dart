import 'package:flutter/material.dart';
import 'package:merlinativ/servAtividades.dart';

class TileAtiv extends StatefulWidget {

  final Atividade _atividade;
  const TileAtiv(this._atividade);

  get altura { return _atividade.altura; }

  @override
  _TileAtivState createState() => _TileAtivState();
}

class _TileAtivState extends State<TileAtiv> {

  var _selected = false;
  var _levelText = 'F'; 
  var _levelColor = Colors.green[300];

  _tileSelClick() {
    setState(() {
      _selected = !_selected;
    });
  }

  _tileLeveClick(){
    var nextLevel = 'F', nextColor = Colors.green[600];
    switch(_levelText){
      case 'F': nextLevel = 'M'; nextColor = Colors.yellow[600]; break;
      case 'M': nextLevel = 'D'; nextColor = Colors.red[600]; break;
      case 'D': nextLevel = 'F'; nextColor = Colors.green[600]; break;
    }

    setState(() {
      _levelText = nextLevel;
      _levelColor = nextColor;
    });
  }

  @override
  Widget build(BuildContext context) {

    final larguraBox = MediaQuery.of(context).size.width * .35;
    final larguraCheck = MediaQuery.of(context).size.width * .38;

    return Stack(
          children: <Widget>[

            Container(
                width: larguraBox,
                height: widget.altura,
                decoration: BoxDecoration(border: Border.all(width:4 , color:  _selected? Colors.pink[600] : Colors.white), color: Colors.white,
                borderRadius: BorderRadius.all(Radius.circular(20),)
              ),
                child: ClipRRect(
                borderRadius: BorderRadius.all(Radius.circular(15.0),),
                child: Image.asset(this.widget._atividade.assetImagem, fit: BoxFit.cover,)
                ),
              ),

            Container(
                width: larguraBox,
                height: widget.altura,
                child: Align(
                    alignment: Alignment.bottomCenter,
                    child: Padding(
                      padding: const EdgeInsets.fromLTRB(8, 0, 8, 10),
                      child: Text(this.widget._atividade.descricao, style: TextStyle(wordSpacing: -1,  fontSize: 14, color: widget._atividade.cor, ), textAlign: TextAlign.center,),
                    ),
                    ),
              ),
        

            Container(
              width: larguraCheck,
              height: widget.altura-30,
              padding: EdgeInsets.only(top: 20),
              alignment: Alignment.topRight,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  GestureDetector(
                      onTap: () => _tileLeveClick(),
                      child: CircleAvatar(
                      radius: 15,
                      backgroundColor: _levelColor,
                      child: Text( _levelText, style: TextStyle(fontSize: 16, color:Colors.white),),
                    ),
                  ),

                  GestureDetector(
                      onTap: () => _tileSelClick(),
                      child: CircleAvatar(
                      radius: 15,
                      backgroundColor: _selected? Colors.pink : Colors.white,
                      child: Text( _selected ? 'V' : '+', style: TextStyle(fontSize: 16, color: _selected? Colors.white : Colors.pink),),
                    ),
                  ),

                ],
              ),
            ),


      ]
    );

  }

}