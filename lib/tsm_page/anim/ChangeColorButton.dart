


import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app1/utils.dart';

class ChangeColorButton extends StatefulWidget{

  final Widget child;
  final Duration duration;
  final Color begin;
  final Color end;

  ChangeColorButton({@required this.child,this.duration=const Duration(seconds:1)  , this. begin=Colors.black87  ,this.end=Colors.black87});




  @override
  State<StatefulWidget> createState() =>_ChangeColorButtonState();
}



class _ChangeColorButtonState extends State<ChangeColorButton> with TickerProviderStateMixin {


  AnimationController _controller;
  Animation<Color> anim;
  @override
  void initState() {
    super.initState();
    _controller=AnimationController(duration: widget.duration,vsync: this);
    anim=ColorTween(begin: widget.begin,end: widget.end).animate(CurvedAnimation(parent: _controller,curve: Curves.easeOut)) ;
  }


  @override
  void dispose(){
    _controller.dispose();
    super.dispose();

  }



  @override
  void didUpdateWidget(ChangeColorButton oldWidget) {
    super.didUpdateWidget(oldWidget);
    controller.duration=widget.duration;
    if(widget.end!=widget.begin){
      anim=ColorTween(begin: oldWidget.end,end: widget.end).animate(CurvedAnimation(parent: _controller,curve: Curves.easeOut)) ;
      _controller..value=0..forward();
    }
  }

  AnimationController  get controller=>_controller;

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _controller,
      builder: (context,child)=>Container(
        color: anim.value,
        child: child,
      ),
      child: widget.child,
    );
  }

}