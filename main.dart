import 'package:flutter/material.dart';

void main() {
  runApp(const MiAppIMC());
}

class MiAppIMC extends StatelessWidget {
  const MiAppIMC({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Calculadora IMC',
      theme: ThemeData(
        primarySwatch: Colors.teal,
        useMaterialDesign: true,
      ),
      home: const PantallaPrincipal(),
    );
  }
}

class PantallaPrincipal extends StatefulWidget {
  const PantallaPrincipal({super.key});

  @override
  State<PantallaPrincipal> createState() => _PantallaPrincipalState();
}

class _PantallaPrincipalState extends State<PantallaPrincipal> {
  int _currentIndex = 0;
  final TextEditingController _pesoController = TextEditingController();
  final TextEditingController _alturaController = TextEditingController();
  
  double? _imc;
  String _resultadoTexto = '';
  String _genero = 'Masculino';
  final List<String> _historial = [];

  void _calcularIMC() {
    final double? peso = double.tryParse(_pesoController.text);
    final double? altura = double.tryParse(_alturaController.text);

    if (peso == null || altura == null || altura <= 0) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Por favor, ingresa valores válidos')),
      );
      return;
    }

    // Altura asumida en metros si es menor a 3, sino en centímetros
    double alturaMetros = altura;
    if (altura > 3) {
      alturaMetros = altura / 100;
    }

    setState(() {
      _imc = peso / (alturaMetros * alturaMetros);
      
      if (_imc! < 18.5) {
        _resultadoTexto = 'Bajo peso';
      } else if (_imc! >= 18.5 && _imc! < 25) {
        _resultadoTexto = 'Peso normal';
      } else if (_imc! >= 25 && _imc! < 30) {
        _resultadoTexto = 'Sobrepeso';
      } else {
        _resultadoTexto = 'Obesidad';
      }

      _historial.add(
        '${DateTime.now().day}/${DateTime.now().month} - IMC: ${_imc!.toStringAsFixed(1)} ($_resultadoTexto)'
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    final List<Widget> pantallas = [
      _buildCalculadora(),
      _buildPlanes(),
      _buildHistorial(),
    ];

    return Scaffold(
      appBar: AppBar(
        title: const Text('IMC Inteligente', style: TextStyle(color: Colors.white)),
        backgroundColor: Colors.teal,
        centerTitle: true,
      ),
      body: pantallas[_currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        onTap: (index) {
          setState(() {
            _currentIndex = index;
          });
        },
        selectedItemColor: Colors.teal,
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.calculate), label: 'Calculadora'),
          BottomNavigationBarItem(icon: Icon(Icons.fitness_center), label: 'Planes'),
          BottomNavigationBarItem(icon: Icon(Icons.history), label: 'Historial'),
        ],
      ),
    );
  }

  Widget _buildCalculadora() {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(20.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          const Text(
            'Calcular Índice de Masa Corporal',
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.teal),
            textAlign: Center,
          ),
          const SizedBox(height: 20),
          DropdownButtonFormField<String>(
            value: _genero,
            decoration: const InputDecoration(labelText: 'Género', border: OutlineInputBorder()),
            items: ['Masculino', 'Femenino'].map((String value) {
              return DropdownMenuItem<String>(value: value, child: Text(value));
            }).toList(),
            onChanged: (newValue) {
              setState(() {
                _genero = newValue!;
              });
            },
          ),
          const SizedBox(height: 15),
          TextField(
            controller: _pesoController,
            keyboardType: TextInputType.number,
            decoration: const InputDecoration(labelText: 'Peso (kg)', border: OutlineInputBorder()),
          ),
          const SizedBox(height: 15),
          TextField(
            controller: _alturaController,
            keyboardType: TextInputType.number,
            decoration: const InputDecoration(labelText: 'Altura (cm o m)', border: OutlineInputBorder()),
          ),
          const SizedBox(height: 20),
          ElevatedButton(
            onPressed: _calcularIMC,
            style: ElevatedButton.styleFrom(backgroundColor: Colors.teal, padding: const EdgeInsets.all(15)),
            child: const Text('CALCULAR', style: TextStyle(color: Colors.white, fontSize: 16)),
          ),
          if (_imc != null) ...[
            const SizedBox(height: 30),
            Card(
              color: Colors.teal.shade50,
              elevation: 4,
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: Column(
                  children: [
                    Text('Tu IMC es: ${_imc!.toStringAsFixed(1)}', style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
                    const SizedBox(height: 10),
                    Text('Categoría: $_resultadoTexto', style: TextStyle(fontSize: 18, color: Colors.teal.shade900, fontWeight: FontWeight.w500)),
                  ],
                ),
              ),
            ),
          ]
        ],
      ),
    );
  }

  Widget _buildPlanes() {
    return ListView(
      padding: const EdgeInsets.all(15.0),
      children: [
        const Text('Planes Sugeridos', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.teal), textAlign: Center),
        const SizedBox(height: 15),
        _buildCardPlan('Plan de Alimentación', 'Desayuno: Avena con frutas.\nAlmuerzo: Pollo a la plancha con ensalada.\nMerienda: Yogur griego con nueces.\nCena: Pescado al horno con verduras al vapor.'),
        _buildCardPlan('Rutina de Ejercicios', 'Lunes: Cardio (30 min correr/bici).\nMiércoles: Fuerza (Sentadillas, flexiones, tren superior).\nViernes: HIIT o funcional (25 min).\nSábado: Caminata ligera o descanso activo.'),
      ],
    );
  }

  Widget _buildCardPlan(String titulo, String detalle) {
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 8),
      elevation: 2,
      child: ExpansionTile(
        title: Text(titulo, style: const TextStyle(fontWeight: FontWeight.bold, color: Colors.teal)),
        children: [Padding(padding: const EdgeInsets.all(15.0), child: Text(detalle, style: const TextStyle(fontSize: 15, height: 1.4)))],
      ),
    );
  }

  Widget _buildHistorial() {
    return Padding(
      padding: const EdgeInsets.all(15.0),
      child: Column(
        children: [
          const Text('Historial de Mediciones', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.teal)),
          const SizedBox(height: 15),
          _historial.isEmpty
              ? const Expanded(child: Center(child: Text('Aún no tienes registros guardados.', style: TextStyle(color: Colors.grey))))
              : Expanded(
                  child: ListView.builder(
                    itemCount: _historial.length,
                    itemBuilder: (context, index) {
                      return Card(
                        child: ListTile(
                          leading: const Icon(Icons.trending_up, color: Colors.teal),
                          title: Text(_historial[index]),
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
