


class Post {
  String? numero;
  String? numero_tarjeta;
  String? numero_placa;
  String? calle_principal;
  String? calle_transversal;
  String? fecha;
  String? hora;
  String? tipo_contravencion_a;
  String? tiempo_permanencia;
  String? supervisor_responsable;
  String? estado;
  String? observacion;
  String? valor_tiempo;
  String? inmovilizado;
  String? imagen1;
  String? imagen2;
  String? imagen3;
  String? estado_rev;
  String? latitud;
  String? longitud;

  Post({
    this.numero,
    this.numero_tarjeta,
    this.numero_placa,
    this.calle_principal,
    this.calle_transversal,
    this.fecha,
    this.hora,
    this.tipo_contravencion_a,
    this.tiempo_permanencia,
    this.supervisor_responsable,
    this.estado,
    this.observacion,
    this.valor_tiempo,
    this.inmovilizado,
    this.imagen1,
    this.imagen2,
    this.imagen3,
    this.estado_rev,
    this.latitud,
    this.longitud,
  });

// map json to post model

factory Post.fromJson(Map<String, dynamic> json) {
  return Post(
    numero: json['numero'],
    numero_tarjeta: json['numero_tarjeta'],
    numero_placa: json['numero_placa'],
    calle_principal: json['calle_principal'],
    calle_transversal: json['calle_transversal'],
    fecha: json['fecha'],
    hora: json['hora'],
    tipo_contravencion_a: json['tipo_contravencion_a'],
    tiempo_permanencia: json['tiempo_permanencia'],
    supervisor_responsable: json['supervisor_responsable'],
    estado: json['estado'],
    observacion: json['observacion'],
    valor_tiempo: json['valor_tiempo'],
    inmovilizado: json['inmovilizado'],
    imagen1: json['imagen1'],
    imagen2: json['imagen2'],
    imagen3: json['imagen3'],
    estado_rev: json['estado_rev'],
    latitud: json['latitud'],
    longitud: json['longitud'],
  );
}

}