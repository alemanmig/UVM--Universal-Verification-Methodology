# Entendiendo el Factory Method y su Aplicación en UVM

1. ¿Qué es el Factory Method?

Factory Method es un patrón de diseño creacional que separa la creación de objetos de su uso.
En lugar de instanciar clases directamente con new, la creación se delega a un método fábrica, lo que permite que subclases decidan qué tipo de objeto producir.

“El Factory Method proporciona una interfaz para crear objetos en una superclase, mientras permite a las subclases alterar el tipo de objetos que se crearán.”
— Refactoring Guru

### ¿Qué problema resuelve?

Cuando tu código está lleno de:
```systemverilog
obj = new(...);
```

queda acoplado a tipos concretos. Agregar nuevas clases exige modificar muchos archivos, introducir condicionales y duplicar código.
El Factory Method evita ese acoplamiento, centralizando la creación.

2. Ejemplo conceptual (versión simplificada)

Imagina una aplicación que inicialmente solo maneja transporte por camión. Todo el código usa la clase Camion.

Cuando agregas Barco, tendrías que modificar decenas de líneas para soportarlo.
Con Factory Method, defines una interfaz común Transporte, y las clases derivadas (Camion, Barco) se crean desde un método fábrica. El código cliente no cambia.

3. ¿Por qué es esencial en UVM?

En UVM (Universal Verification Methodology), la extensibilidad y la reutilización son fundamentales.
El UVM Factory permite:

Sustituir componentes sin modificar su código.

Elegir distintas implementaciones en tiempo de simulación.

Reconfigurar el testbench para diferentes escenarios sin recompilar.

Reutilizar el entorno por completo.

En UVM nunca se debe instanciar un componente con new.
Siempre se debe usar:

```systemverilog
component = my_class::type_id::create("inst_name", parent);
```
Esto le da al factory la oportunidad de cambiar el tipo concreto del objeto.

