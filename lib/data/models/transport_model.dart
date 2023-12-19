
class Transport {
  final String id;
  final String name; // nombre del vehiculo
  final String mark; // marca
  final String model;
  final String placa; // modelo
  final int age; // a;os
  final int ntank; // numero de tanques
  final double capacityTank;
  final String fuel; // combustible
  final bool active;
  //final List<Task> tasks; // esta en activo?

  Transport(
      {required this.id,
      required this.name,
      required this.mark,
      required this.model,
      required this.placa,
      required this.age,
      required this.ntank,
      required this.capacityTank,
      required this.fuel,
      required this.active,
      //required this.tasks
    });
}
