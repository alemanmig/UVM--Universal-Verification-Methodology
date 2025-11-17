# Entendiendo el Factory Method y su Aplicación en UVM

### ¿Qué es el Factory Method?

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

### Ejemplo conceptual.

Imagina una aplicación que inicialmente solo maneja transporte por camión. Todo el código usa la clase Camion.

Cuando agregas Barco, tendrías que modificar decenas de líneas para soportarlo.
Con Factory Method, defines una interfaz común Transporte, y las clases derivadas (Camion, Barco) se crean desde un método fábrica. El código cliente no cambia.

### ¿Por qué es esencial en UVM?

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

### ¿Cómo funciona el UVM Factory?

Cuando declaras una clase UVM, la registras con:

```systemverilog
`uvm_component_utils(my_driver)
```

Esto permite:

- Registrar la clase en el factory.

- Habilitar creación dinámica con type_id::create.

- Permitir overrides (sustituciones).

Luego, desde un test o configuración, puedes cambiar qué clase se construye realmente.

### Override por tipo

```systemverilog
factory.set_type_override_by_type(
  my_driver::get_type(),
  my_driver_extended::get_type()
);
```

Cada vez que alguien haga:

```systemverilog
my_driver::type_id::create(...)
```

se creará un my_driver_extended.

### Override por instancia

```systemverilog
factory.set_inst_override_by_type(
  my_driver::get_type(),
  my_driver_log::get_type(),
  "env.agent0.drv"
);
```

## Ejemplo completo en SystemVerilog / UVM

Definición de componentes

```systemverilog
class my_driver extends uvm_driver #(my_transaction);
  `uvm_component_utils(my_driver)
  ...
endclass

class my_driver_extended extends my_driver;
  `uvm_component_utils(my_driver_extended)
  ...
endclass

```

## Uso del Factory en el test

```systemverilog
class my_test extends uvm_test;
  `uvm_component_utils(my_test)

  function void build_phase(uvm_phase phase);
    super.build_phase(phase);

    uvm_factory factory = uvm_factory::get();

    // Override por tipo
    factory.set_type_override_by_type(
      my_driver::get_type(),
      my_driver_extended::get_type()
    );
  endfunction
endclass
```

## ¿Qué pasa si NO usas el Factory en UVM?

Muchos novatos hacen esto:

```systemverilog
drv = new("drv", this); // ❌ MAL EN UVM

```

### Consecuencias:

- No puedes hacer overrides.

- No puedes cambiar implementaciones dinámicamente.

- Tu testbench queda rígido e irreciclable.

- Pierdes una de las características principales de UVM.