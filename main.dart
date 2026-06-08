import  'package:flutter/material.dart' ;

void  main () {
  runApp ( const  MiAppIMC ());
}

clase  MiAppIMC  extiende  StatelessWidget {
  const  MiAppIMC ({ super .key});

  @anular
  Widget  build ( BuildContext context) {
    devolver  MaterialApp (
      debugShowCheckedModeBanner :  falso ,
      título :  'Calculadora IMC Pro' ,
      tema :  ThemeData (
        primarySwatch :  Colores .teal,
        scaffoldBackgroundColor :  const  Color ( 0xFFF5F7FA ),
      ),
      inicio :  const  PantallaPrincipal (),
    );
  }
}

clase  PantallaPrincipal  extiende  StatefulWidget {
  const  PantallaPrincipal ({ super .key});

  @anular
  Estado < PantallaPrincipal > crearEstado () =>  _PantallaPrincipalState ();
}

clase  _PantallaPrincipalState  extiende  State < PantallaPrincipal > {
  int _índiceActual =  0 ;

  // Variables para la calculadora
  final  TextEditingController _pesoController =  TextEditingController ();
  final  TextEditingController _alturaController =  TextEditingController ();
  String _perfilSeleccionado =  'Persona Común' ;
  
  // Resultados
  doble _imc =  0.0 ;
  Cadena _resultadoTexto =  '' ;
  String _dietaSugerida =  'Calculá tu IMC para ver tu dieta.' ;
  String _rutinaSugerida =  'Calculá tu IMC para ver tu rutina.' ;
  String _mensajeMotivacional =  '¡Tu salud es lo primero! Cuidá tu cuerpo cada día.' ;
  Lista < Cadena > _riesgos = [];

  // Lista para el historial de avances
  final  List < String > _historialAvances = [ 'Registro inicial: App lista para usar' ];

  void  _calcularIMC () {
    final  double ? peso =  double . tryParse (_pesoController.text);
    final  double ? altura =  double . tryParse (_alturaController.text);

    if (peso ==  null  || altura ==  null  || altura <=  0  || peso <=  0 ) {
      ScaffoldMessenger . de (contexto). mostrarSnackBar (
        const  SnackBar (contenido :  Texto ( 'Por favor, ingresá valores válidos.' )),
      );
      devolver ;
    }

    // Calcular IMC (Peso / Altura^2)
    establecerEstado (() {
      _imc = peso / (altura * altura);
      _riesgos.clear ( );

      if (_perfilSeleccionado ==  'Embarazada' ) {
        _resultadoTexto =  'IMC Actual: ${ _imc . toStringAsFixed ( 1 )} \n Nota: El IMC gestacional varía según la semana de embarazo.' ;
        _mensajeMotivacional =  '¡Felicidades por esta hermosa etapa! Recordá que estás creando vida. Tu peso actual es el adecuado para proteger a tu bebé.' ;
        _dietaSugerida =  'Dieta Nutritiva: \n - Incrementará el consumo de ácido fólico y hierro (espinacas, legumbres). \n - Proteínas magras (pollo, pescado bien cocido, huevos). \n - Lácteos pasteurizados y mucha agua.' ;
        _rutinaSugerida =  'Rutina de Bajo Impacto: \n - Caminatas suaves de 20 a 30 minutos. \n - Estiramientos ligeros. \n - Ejercicios de respiración y yoga prenatal (evitando rebotes).' ;
      }
      else  if (_perfilSeleccionado ==  'Deportista' ) {
        si (_imc >=  25 ) {
          _resultadoTexto =  'IMC: ${ _imc . toStringAsFixed ( 1 )} (Musculatura Elevada)' ;
          _mensajeMotivacional =  '¡Excelente estado físico! Tu IMC es alto debido a tu gran masa muscular, no por grasa. ¡Seguí entrenando con todo!' ;
        } demás {
          _resultadoTexto =  'IMC: ${ _imc . toStringAsFixed ( 1 )} (Atlético)' ;
          _mensajeMotivacional =  '¡Nivel de deportista óptimo! Mantenés una gran relación entre peso y masa muscular.' ;
        }
        _dietaSugerida =  'Dieta Hiperproteica e Energética: \n - Carbohidratos complejos (avena, arroz integral) para rendir. \n - Proteínas de alta calidad para reparar músculo. \n - Grasas saludables (palta, frutos secos).' ;
        _rutinaSugerida =  'Rutina de Alto Rendimiento: \n - 4 a 5 días de entrenamiento de fuerza/hipertrofia. \n - 2 sesiones de cardio HIIT a la semana. \n - Enfoque en sobrecarga progresiva.' ;
      }
      demás {
        // Persona Común
        si (_imc <  18.5 ) {
          _resultadoTexto =  'IMC: ${ _imc . toStringAsFixed ( 1 )} (Bajo peso)' ;
          _mensajeMotivacional =  'Es importante asegurar que estés sumando los nutrientes necesarios. ¡Cuidate!' ;
          _dietaSugerida =  'Dieta para ganar masa limpia: \n - Superávit calórico controlado. \n - Frutos secos, lácteos enteros, carnes y legumbres.' ;
          _rutinaSugerida =  'Rutina Funcional: \n - Ejercicios con el propio peso corporal (flexiones, sentadillas). \n - Cardio moderado 2 veces por semana.' ;
        } else  if (_imc >=  18.5  && _imc <  25 ) {
          _resultadoTexto =  'IMC: ${ _imc . toStringAsFixed ( 1 )} (Peso Saludable)' ;
          _mensajeMotivacional =  '¡Espectacular! Estás en tu rango ideal. Mantené estos buenos hábitos.' ;
          _dietaSugerida =  'Dieta de Mantenimiento: \n - Plato equilibrado (50% verduras, 25% proteína, 25% carbohidratos). \n - Frutas frescas y agua.' ;
          _rutinaSugerida =  'Rutina Saludable: \n - 150 minutos de actividad física moderada a la semana. \n - Caminatas, bicicleta o natación.' ;
        } demás {
          _resultadoTexto =  'IMC: ${ _imc . toStringAsFixed ( 1 )} (Sobrepeso/Obesidad)' ;
          _mensajeMotivacional =  '¡Vos podés! Cada pequeño cambio en tus hábitos diarios cuenta para mejorar tu bienestar.' ;
          _dietaSugerida =  'Dieta de Déficit Calórico Saludable: \n - Reducir azúcares refinados y ultraprocesados. \n - Más porciones de verduras y proteínas saciantes.' ;
          _rutinaSugerida =  'Rutina de Quema de Grasa y Fuerza: \n - Cardio de bajo impacto para cuidar articulaciones (elíptica, caminata rápida). \n - Circuitos de fuerza livianos.' ;
          
          // Agregar factores de riesgo médicos si el IMC es alto
          _riesgos = [
            'Cardiovascular: Mayor esfuerzo del corazón y presión arterial elevada.' ,
            'Metabólico: Riesgo de resistencia a la insulina o diabetes tipo 2.' ,
            'Articular: Sobrecarga en rodillas, tobillos y columna debido al peso.'
          ];
        }
      }

      // Guardar de forma automática en la pestaña de avances
      _avanceshistorial. insert ( 0 , 'Fecha actual - Peso: ${ peso }kg - Perfil: $ _perfilSeleccionado - IMC: ${ _imc . toStringAsFixed ( 1 )}' );
    });

    // Cambiar automáticamente a la pestaña de aviones para ver la rutina
    establecerEstado (() {
      _índiceActual =  1 ;
    });
  }

  @anular
  Widget  build ( BuildContext context) {
    // Definir las 3 pantallas principales
     Lista final < Widget > pantallas = [
      _construirPantallaCalculadora (),
      _construirPantallaPlanes (),
      _construirPantallaAvances (),
    ];

     andamio de retorno (
      appBar :  AppBar (
        título :  const  Text ( 'Calculadora IMC Inteligente' , style :  TextStyle (fontWeight :  FontWeight.bold )),
        backgroundColor :  Colores .teal,
        color de primer plano :  Colores .blanco,
        centerTitle :  verdadero ,
      ),
      cuerpo : pantallas[_indiceActual],
      BottomNavigationBar :  BottomNavigationBar (
        currentIndex : _indiceActual,
        onTap : (índice) {
          establecerEstado (() {
            _índiceActual = índice;
          });
        },
        selectedItemColor :  Colores .teal,
        unselectedItemColor :  Colores .gris,
        elementos :  const [
          BottomNavigationBarItem (icono :  Icono ( Iconos.calculate ), etiqueta :  'Calculadora' ),
          BottomNavigationBarItem (icono :  Icono ( Iconos.asignación ), etiqueta :  'Mis Planes' ),
          BottomNavigationBarItem (icono :  Icono ( Iconos.trending_up ), etiqueta :  'Mis Avances' ),
        ],
      ),
    );
  }

  Widget  _construirPantallaCalculadora () {
    devolver  SingleChildScrollView (
      relleno :  const  EdgeInsets.all ( 20.0 ) ,​
      niño :  Columna (
        Alineación del eje transversal : Alineación  del eje transversal.estirar ,
        niños : [
          const  Texto (
            'Seleccionará tu Perfil' ,
            estilo :  TextStyle (fontSize :  16 , fontWeight :  FontWeight.bold , color :  Colors.teal ),
          ),
          const  SizedBox (altura :  10 ),
          DropdownButtonFormField < String >(
            valor : _perfilSeleccionado,
            decoración :  InputDecoration (
              borde :  OutlineInputBorder (borderRadius :  BorderRadius.circular ( 12 ) ) ,
              relleno :  verdadero ,
              fillColor :  Colores .blanco,
            ),
            artículos : [ 'Persona Común' , 'Deportista' , 'Embarazada' ]. mapa (( valor de cadena ) {
              return  DropdownMenuItem < String >(value : valor, child :  Text (valor));
            }). toList (),
            onChanged : (nuevoValor) {
              establecerEstado (() {
                _perfilSeleccionado = nuevoValor ! ;
              });
            },
          ),
          const  SizedBox (altura :  20 ),
          Campo de texto (
            controlador : _pesoController,
            tipo de teclado :  tipo de entrada de texto .número,
            decoración :  InputDecoration (
              labelText :  'Peso en Kilogramos (ej: 75.5)' ,
              prefixIcon :  const  Icon ( Icons.scale ),
              borde :  OutlineInputBorder (borderRadius :  BorderRadius.circular ( 12 ) ) ,
              relleno :  verdadero ,
              fillColor :  Colores .blanco,
            ),
          ),
          const  SizedBox (altura :  15 ),
          Campo de texto (
            controlador : _alturaController,
            tipo de teclado :  tipo de entrada de texto .número,
            decoración :  InputDecoration (
              labelText :  'Altura en Metros (ej: 1.75)' ,
              prefixIcon :  const  Icon ( Icons.height ),
              borde :  OutlineInputBorder (borderRadius :  BorderRadius.circular ( 12 ) ) ,
              relleno :  verdadero ,
              fillColor :  Colores .blanco,
            ),
          ),
          const  SizedBox (altura :  25 ),
          Botón elevado (
            onPressed : _calcularIMC,
            estilo :  ElevatedButton.styleFrom (​​
              backgroundColor :  Colores .teal,
              color de primer plano :  Colores .blanco,
              relleno :  const  EdgeInsets.simétrico ( vertical : 15 ) , 
              forma :  BordeRectánguloRedondeado (radioBorde : BorderRadius.circular  ( 12 ) ) ,
            ),
            hijo :  const  Text ( 'CALCULAR Y PLANOS GENERALES' , style :  TextStyle (fontSize :  16 , fontWeight :  FontWeight.bold )),
          ),
          const  SizedBox (altura :  25 ),
          si (_imc >  0 ) ...[
            Tarjeta (
              color :  Colores .blanco,
              elevación :  4 ,
              forma :  BordeRectánguloRedondeado (radioBorde :  BorderRadius.circular ( 15 ) ) ,
              niño :  Relleno (
                relleno :  const  EdgeInsets.all ( 16.0 ) ,​
                niño :  Columna (
                  niños : [
                    Texto (_resultadoTexto, textAlign :  TextAlign .center, style :  const  TextStyle (fontSize :  18 , fontWeight :  FontWeight .bold, color :  Colors .black87)),
                    const  SizedBox (altura :  10 ),
                    Texto (_mensajeMotivacional, textAlign :  TextAlign .center, style :  const  TextStyle (fontSize :  14 , fontStyle :  FontStyle .italic, color :  Colors .teal)),
                  ],
                ),
              ),
            ),
          ],
          si (_riesgos.isNotEmpty) ...[
            const  SizedBox (altura :  20 ),
            const  Text ( 'Factores de Riesgo Médicos Asociados:' , estilo :  TextStyle (fontSize :  15 , fontWeight :  FontWeight .bold, color :  Colors .redAccent)),
            const  SizedBox (altura :  8 ),
            ..._riesgos. mapa ((riesgo) =>  Relleno (
              relleno :  const  EdgeInsets.only ( bottom : 6.0 ) , 
              niño :  fila (
                niños : [
                  const  Icon ( Icons .warning_amber_rounded, color :  Colors .redAccent, size :  20 ),
                  const  SizedBox (ancho :  8 ),
                  Expandido (hijo :  Texto (riesgo, estilo :  const  TextStyle (fontSize :  13 , color :  Colors.black87 ))),
                ],
              ),
            )),
          ]
        ],
      ),
    );
  }

  Widget  _construirPantallaPlanes () {
    devolver  SingleChildScrollView (
      relleno :  const  EdgeInsets.all ( 20.0 ) ,​
      niño :  Columna (
        Alineación del eje transversal : Alineación  del eje transversal.estirar ,
        niños : [
          Tarjeta (
            elevación :  3 ,
            forma :  BordeRectánguloRedondeado (radioBorde : BorderRadius.circular  ( 12 ) ) ,
            niño :  Relleno (
              relleno :  const  EdgeInsets.all ( 16.0 ) ,​
              niño :  Columna (
                Alineación del eje transversal : Alineación  del eje transversal.inicio ,
                niños : [
                  const  Fila (
                    niños : [
                      Icono ( Iconos .restaurante, color :  Colores .naranja),
                      SizedBox (ancho :  10 ),
                      Texto ( 'Plan de Alimentación Asignado' , estilo :  TextStyle (fontSize :  16 , fontWeight :  FontWeight .bold)),
                    ],
                  ),
                  const  Divider (altura :  20 ),
                  Texto (_dietaSugerida, estilo :  const  TextStyle (fontSize :  14 , color :  Colors .black87, altura :  1.4 )),
                ],
              ),
            ),
          ),
          const  SizedBox (altura :  20 ),
          Tarjeta (
            elevación :  3 ,
            forma :  BordeRectánguloRedondeado (radioBorde : BorderRadius.circular  ( 12 ) ) ,
            niño :  Relleno (
              relleno :  const  EdgeInsets.all ( 16.0 ) ,​
              niño :  Columna (
                Alineación del eje transversal : Alineación  del eje transversal.inicio ,
                niños : [
                  const  Fila (
                    niños : [
                      Icono ( Iconos .fitness_center, color :  Colores .azul),
                      SizedBox (ancho :  10 ),
                      Texto ( 'Guía de Ejercicios y Rutina' , estilo :  TextStyle (fontSize :  16 , fontWeight :  FontWeight .bold)),
                    ],
                  ),
                  const  Divider (altura :  20 ),
                  Texto (_rutinaSugerida, estilo :  const  TextStyle (fontSize :  14 , color :  Colors .black87, altura :  1.4 )),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget  _construirPantallaAvances () {
     Relleno de retorno (
      relleno :  const  EdgeInsets.all ( 20.0 ) ,​
      niño :  Columna (
        Alineación del eje transversal : Alineación  del eje transversal.inicio ,
        niños : [
          const  Text ( 'Historial de Cambios' , style :  TextStyle (fontSize :  18 , fontWeight :  FontWeight .bold, color :  Colors .teal)),
          const  SizedBox (altura :  5 ),
          const  Text ( 'Cada vez que calculás un nuevo peso, se registra automáticamente.' , estilo :  TextStyle (fontSize :  12 , color :  Colors .grey)),
          const  Divider (altura :  25 ),
          Ampliado (
            hijo :  ListView.builder (​​
              itemCount : _historialAvances.length,
              itemBuilder : (contexto, índice) {
                 Tarjeta de devolución (
                  margen :  const  EdgeInsets.only ( bottom :  8 ) ,
                  niño :  ListTile (
                    líder :  const  Icon ( Icons.show_chart , color :  Colors.teal ),
                    título :  Texto (_historialAvances[index], estilo :  const  TextStyle (fontSize :  13 , fontWeight :  FontWeight.w500 )),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
