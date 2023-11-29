class Usuario {

  String nombre;
  int edad;
  List<String> profesiones;

  Usuario({ required this.nombre, required this.edad, required this.profesiones })
  : assert(nombre != null );
  //whether we want to put an additional condition just we put comma and the next conditional
}