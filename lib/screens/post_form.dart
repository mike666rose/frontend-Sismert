import 'dart:core';
import 'dart:io';
import 'package:blogapp/constant.dart';
import 'package:blogapp/models/api_response.dart';
import 'package:blogapp/models/post.dart';
import 'package:blogapp/screens/home.dart';
import 'package:blogapp/services/post_service.dart';
import 'package:blogapp/services/user_service.dart';
import 'package:flutter/material.dart';

import 'package:image_picker/image_picker.dart';
import 'package:shared_preferences/shared_preferences.dart';


class PostForm extends StatefulWidget {
  final Post? post;
  final String? title;

  PostForm({
    this.post,
    this.title
  });

  @override
  _PostFormState createState() => _PostFormState();
}

class _PostFormState extends State<PostForm> {
  
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  final TextEditingController _txtControllerNumero = TextEditingController();
   final TextEditingController _txtControllerNumero_tarjeta = TextEditingController();
    final TextEditingController _txtControllerNumero_placa = TextEditingController();
     final TextEditingController _txtControllerCalle_principal = TextEditingController();
      final TextEditingController _txtControllerCalle_transversal = TextEditingController();
       final TextEditingController _txtControllerFecha = TextEditingController();
        final TextEditingController _txtControllerHora = TextEditingController();
          final TextEditingController _txtControllerTipo_contravencion_a = TextEditingController();
          final TextEditingController _txtControllerTiempo_permanencia = TextEditingController();
            final TextEditingController _txtControllerSupervisor_responsable= TextEditingController();
             final TextEditingController _txtControllerEstado = TextEditingController();
             final TextEditingController _txtControllerObservacion = TextEditingController();
             final TextEditingController _txtControllerValor_tiempo = TextEditingController();
               final TextEditingController _txtControllerInmovilizado = TextEditingController();
                 final TextEditingController _txtControllerEstado_rev = TextEditingController();
                  final TextEditingController _txtControllerLatitud = TextEditingController();
                   final TextEditingController _txtControllerLongitud = TextEditingController();

  bool loading = false;
   File? _imageFile;
  final _picker = ImagePicker();

  Future getImage() async {
    final pickedFile = await _picker.getImage(source: ImageSource.gallery);
    if (pickedFile != null){
      setState(() {
        _imageFile = File(pickedFile.path);
      });
    }
  }

  void _createPost() async {
   
    String? imagen1 , imagen2 , imagen3 = _imageFile ==  null ? null : getStringImage(_imageFile);
   ApiResponse response = await createPost(_txtControllerNumero.text ,_txtControllerNumero_tarjeta.text,
   _txtControllerNumero_placa.text, _txtControllerCalle_principal.text,_txtControllerCalle_transversal.text,_txtControllerFecha.text,
   _txtControllerHora.text,_txtControllerTipo_contravencion_a.text,_txtControllerTiempo_permanencia.text,_txtControllerSupervisor_responsable.text,
   _txtControllerEstado.text,_txtControllerObservacion.text ,_txtControllerValor_tiempo.text ,_txtControllerInmovilizado.text,imagen1,imagen2,imagen3, _txtControllerEstado_rev.text,  _txtControllerLatitud.text,_txtControllerLongitud.text);
    if(response.error == null) {
      _saveAndRedirectToHome(response.data as Post);
    } 
    else {
      setState(() {
        loading = !loading;
      });
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text('${response.error}')
      ));
    }
  }

 // Save and redirect to home
  void _saveAndRedirectToHome(Post user) async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    await pref.setString('longitud', user.longitud ?? '');
    await pref.setString('latitud', user.latitud ?? '');
    await pref.setString('estado_rev', user.estado_rev ?? '');
    await pref.setString('inmovilizado', user.inmovilizado ?? '');
    await pref.setString('valor_tiempo', user.valor_tiempo ?? '');
    await pref.setString('observacion', user.observacion ?? '');
    await pref.setString('estado', user.estado ?? '');
    await pref.setString('supervisor_responsable', user.supervisor_responsable ?? '');
    await pref.setString('tiempo_permanencia', user.tiempo_permanencia ?? '');
    await pref.setString('tipo_contravencion_a', user.tipo_contravencion_a ?? '');
    await pref.setString('hora', user.hora ?? '');
    await pref.setString('fecha', user.fecha ?? '');
    await pref.setString('calle_transversal', user.calle_transversal ?? '');
    await pref.setString('calle_principal', user.calle_principal ?? '');
    await pref.setString('numero_placa', user.numero_placa ?? '');
    await pref.setString('numero_tarjeta', user.numero_tarjeta ?? '');
    await pref.setString('numero', user.numero ?? '');
    Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(builder: (context)=>Home()), (route) => false);
  }




  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Register'),
        centerTitle: true,
      ),
      body: Form(
        key: formKey,
        child: ListView(
          padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 32),
          children: [
            widget.post != null ? SizedBox() :
          Container(
            width: MediaQuery.of(context).size.width,
            height: 200,
            decoration: BoxDecoration(
              image: _imageFile == null ? null : DecorationImage(
                image: FileImage(_imageFile ?? File('')),
                fit: BoxFit.cover
              )
            ),
            child: Center(
              child: IconButton(
                icon: Icon(Icons.image, size:50, color: Colors.black38),
                onPressed: (){
                  getImage();
                },
              ),
            ),
          ),
            TextFormField(
              controller: _txtControllerNumero,
               keyboardType: TextInputType.number,
              validator: (val) => val!.isEmpty ? 'Numero Invalido' : null,
              decoration: kInputDecoration('Numero')
              
            ),
            SizedBox(height: 20,),
            TextFormField(
              controller: _txtControllerNumero_tarjeta,
              keyboardType: TextInputType.number,
              validator: (val) => val!.isEmpty ? 'Numero Targeta' : null,
              decoration: kInputDecoration('Numero targeta')
            ),
            SizedBox(height: 20,),
                TextFormField(
              controller: _txtControllerNumero_placa,
              keyboardType: TextInputType.number,
              validator: (val) => val!.isEmpty ? 'Numero Placa' : null,
              decoration: kInputDecoration('Numero Placa')
            ),
            SizedBox(height: 20,),
                  TextFormField(
              controller: _txtControllerCalle_principal,
              keyboardType: TextInputType.number,
              validator: (val) => val!.isEmpty ? 'Calle principal' : null,
              decoration: kInputDecoration('Calle principal')
            ),
            SizedBox(height: 20,),
                  TextFormField(
              controller: _txtControllerCalle_transversal,
              keyboardType: TextInputType.emailAddress,
              validator: (val) => val!.isEmpty ? 'Calle Tranversal' : null,
              decoration: kInputDecoration('Calle transversal')
            ),
            SizedBox(height: 20,),
                  TextFormField(
                     controller: _txtControllerFecha,
       decoration: InputDecoration(
       labelText: "Ingrese la Fecha Actual",
       hintText: "Año/Mes/Dia",), 
            ),
            SizedBox(height: 20,),
                    TextFormField(
                     controller: _txtControllerHora,
       decoration: InputDecoration(
       labelText: "Ingrese la Hora",
       hintText: "Hora/Minuto/Segundo",), 
            ),
            SizedBox(height: 20,),
                  TextFormField(
              controller: _txtControllerTipo_contravencion_a,
              keyboardType: TextInputType.emailAddress,
              validator: (val) => val!.isEmpty ? 'Tipo Contravension' : null,
              decoration: kInputDecoration('Tipo conrtraversion')
            ),
            SizedBox(height: 20,),
                  TextFormField(
              controller: _txtControllerTiempo_permanencia,
              keyboardType: TextInputType.number,
              validator: (val) => val!.isEmpty ? 'Tiempo permanecia' : null,
              decoration: kInputDecoration('Tiempo permanencia')
            ),

            SizedBox(height: 20,),
                  TextFormField(
              controller: _txtControllerSupervisor_responsable,
              keyboardType: TextInputType.emailAddress,
              validator: (val) => val!.isEmpty ? 'Supervisor Responsable' : null,
              decoration: kInputDecoration('Supervisor Responsable')
            ),
            SizedBox(height: 20,),
                  TextFormField(
              controller: _txtControllerEstado,
              keyboardType: TextInputType.emailAddress,
              validator: (val) => val!.isEmpty ? 'Estado' : null,
              decoration: kInputDecoration('Estado')
            ),
            SizedBox(height: 20,),
                   TextFormField(
              controller: _txtControllerObservacion,
              keyboardType: TextInputType.emailAddress,
              validator: (val) => val!.isEmpty ? 'Observacion' : null,
              decoration: kInputDecoration('Observacion')
            ),
            SizedBox(height: 20,),
                   TextFormField(
              controller: _txtControllerValor_tiempo,
              keyboardType: TextInputType.numberWithOptions(decimal: true),
              validator: (val) => val!.isEmpty ? 'Valor tiempo' : null,
              decoration: kInputDecoration('Valor tiempo')
            ),
            SizedBox(height: 20,),
                   TextFormField(
              controller: _txtControllerInmovilizado,
              keyboardType: TextInputType.numberWithOptions(decimal: true),
              validator: (val) => val!.isEmpty ? 'Inmovilizado' : null,
              decoration: kInputDecoration('Inmovilizado')
            ),
            SizedBox(height: 20,),
                   TextFormField(
              controller: _txtControllerEstado_rev,
              keyboardType: TextInputType.emailAddress,
              validator: (val) => val!.isEmpty ? 'Estado Rev' : null,
              decoration: kInputDecoration('Estado Rev')
            ),
            SizedBox(height: 20,),
             TextFormField(
              controller: _txtControllerLatitud,
              keyboardType: TextInputType.number,
              validator: (val) => val!.isEmpty ? 'Latitud' : null,
              decoration: kInputDecoration('Latitud')
            ),
            SizedBox(height: 20,),
             TextFormField(
              controller: _txtControllerLongitud,
              keyboardType: TextInputType.number,
              validator: (val) => val!.isEmpty ? 'Longitud' : null,
              decoration: kInputDecoration('Longitud')
            ),
            SizedBox(height: 20,),
            loading ? 
              Center(child: CircularProgressIndicator())
            : kTextButton('Registro', () {
                if(formKey.currentState!.validate()){
                  setState(() {
                    loading = !loading;
                    _createPost();
                  });
                }
              },
            ),
            SizedBox(height: 20,),
          ],
        ),
      ),
    );
  }
}
