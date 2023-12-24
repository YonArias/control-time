enum Combustible {
  GASO_REGULAR,
  GASO_PREMIUN,
  PETROLEO,
  GAS,
}

enum StateTransport {
  ACTIVE, // En proceso
  AWAIT, // En espera
  INNACTIVE, // Sin funcion
  AVAILABLE, // Listo para escoger
  INAVAILABLE
}

List<String> rol = [
  'OPERARIO',
  'SUPERVISOR',
  'ADMIN'
];
