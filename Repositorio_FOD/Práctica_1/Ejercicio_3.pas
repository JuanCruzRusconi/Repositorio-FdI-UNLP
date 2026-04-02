Realizar un programa que presente un menú con opciones para:
a. Crear un archivo binario de registros no ordenados de empleados y completarlo con
datos ingresados desde teclado. De cada empleado se registra: número de empleado,
apellido, nombre, edad y DNI. Algunos empleados pueden ingresan el DNI con valor 0, lo
que significa que al momento de la carga puede no tenerlo. La carga finaliza cuando se
ingresa el String ‘fin’ como apellido.
b. Abrir el archivo anteriormente generado y
i. Listar en pantalla los datos de empleados que tengan un nombre o apellido
determinado, el cual se proporciona desde el teclado.
ii. Listar en pantalla los empleados de a uno por línea.
iii. Listar en pantalla los empleados mayores de 70 años, próximos a jubilarse.
NOTA: El nombre del archivo a crear o utilizar debe ser proporcionado por el usuario.

Program ejercicio3;
const
    apeLimite = 'fin';
type
    empleado = record
        num: integer;
        apellido: string[20];
        nombre: string[20];
        edad: integer;
        dni: integer;
    end;

    archivo_empleados = file of empleado;
var
    e: empleado;
    empleados: archivo_empleados;
    nombre_archivo: string[20];
    archivo_utilizar: string[20];
    nombreImp, apellidoImp: string[20];
begin
// Parte A
    writeln("Ingrese el nombre de archivo de empleados");
    readln(nombre_archivo);
    assign(empleados, nombre_archivo);
    rewrite(empleados);
    writeln("Ingrese el apellido de empleado);
    readln(e.apellido);
    while(e.apellido <> apeLimite) do begin
        writeln("Ingrese el nombre de empleado);
        readln(e.nombre);
        writeln("Ingrese el numero de empleado);
        readln(e.numero);
        writeln("Ingrese la edad de empleado);
        readln(e.edad);
        writeln("Ingrese el dni de empleado);
        readln(e.dni);
        write(empleados, e);
        writeln("Ingrese el apellido de empleado);
        readln(e.apellido);
    end;
    close(empleados);
    // Parte B
    writeln("Ingrese el nombre del archivo a utilizar");
    readln(archivo_utilizar);
    assign(empleados, archivo_utilizar);
    reset(empleados);
    writeln("Ingrese el apellido a buscar")
    readln(apellidoImp);
    writeln("Ingrese el nombre a buscar")
    readln(nombreImp);
    while(not eof(empleados)) do begin
        read(empleados, e);
        // Listar empleados con nombre determiando
        if(e.nombre = nombreImp) or (e.apellido = apellidoImp) then begin
            writeln("Empleado con nombre y/o apellido determiando:");
            writeln("Nombre: ", e.nombre, " apellido: ", e.apellido, " numero: ", e.num, " edad: ", e.edad, " dni: ", e.dni);
        end;
        // Listar empleados de a uno por lenia
        writeln("Nombre: ", e.nombre, " apellido: ", e.apellido, " numero: ", e.num, " edad: ", e.edad, " dni: ", e.dni);   
        // Listar empleados mayores a 70 años
        if(e.edad > 70) then begin
            writeln("Empleado mayor a 70 años:");
            writeln("Empleado nombre: ", e.nombre, " apellido: ", e.apellido, " numero: ", e.num, " edad: ", e.edad, " dni: ", e.dni);
        end;
    end;
    close(empleados);
end;    