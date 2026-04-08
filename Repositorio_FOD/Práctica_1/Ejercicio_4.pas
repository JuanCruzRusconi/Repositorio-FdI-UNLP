Agregar al menú del programa del ejercicio 3, opciones para:
a. Añadir uno o más empleados al final del archivo con sus datos ingresados por teclado.
Tener en cuenta que no se debe agregar al archivo un empleado con un número de
empleado ya registrado (control de unicidad).
b. Modificar la edad de un empleado dado.
c. Exportar el contenido del archivo a un archivo de texto llamado “todos_empleados.txt”.
d. Exportar a un archivo de texto llamado “faltaDNIEmpleado.txt”, los empleados que no
tengan cargado el DNI (DNI en 0).
NOTA: Las búsquedas deben realizarse por número de empleado.

Program ejercicio4;
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
    archivo_texto, archivo_texto_dni: string[20];
    todos_empleados, faltaDNIEmpleado: text;
    opcion: integer;
    existe: boolean;
    // Parte A
    numAgre: integer;
    // Parte B
    numMod, edadMod: integer
    // Parte C
begin
    writeln("Opciones:");
    writeln("Opcion 1 - ...");
    writeln("Opcion 2 - ...");
    writeln("Opcion 3 - ...");
    writeln("Opcion 4 - ...");

    repeat
        writeln("Ingrese una opcion a realizar");
        readln(opcion);
       // Parte A
        if(opcion = 1) then begin
            writeln("Ingrese el nombre del archivo a utilizar");
            readln(nombre_archivo);
            assign(empleados, nombre_archivo);
            reset(empleados);

            writeln("Ingrese el numero de empleado");
            readln(numAgre);
            while(numAgre <> -1) do begin
                seek(empleados, 0);
                existe:= false;
                while(not eof(empleados)) and (not existe) do begin
                    read(empleados, c);
                    if(c.num = numAgre) then
                        existe:= true;
                end;
                if(not existe) then begin
                    seek(empleados, fileSize(empleados));
                    writeln("Ingrese el apellido de empleado");
                    readln(e.apellido);
                    writeln("Ingrese el nombre de empleado");
                    readln(e.nombre);
                    e.num:= numAgre;
                    writeln("Ingrese la edad de empleado");
                    readln(e.edad);
                    writeln("Ingrese el dni de empleado");
                    readln(e.dni);
                    write(empleados, e);
                end;
                writeln("Ingrese el numero de empleado");
                readln(numAgre);
            end;
            close(empleados);
        end
        else
            // Parte B
            if(opcion = 2) then begin
                writeln("Ingrese el nombre del archivo a utilizar");
                readln(archivo_utilizar);
                assign(empleados, archivo_utilizar);
                reset(empleados);

                writeln("Ingrese el numero de la persona a modificar")
                readln(numMod);
                writeln("Ingrese la edad");
                readln(edadMod);
                existe:= false;
                while(not eof(empleados)) and (not existe) do begin
                    read(empleados, e);
                    if(e.num = numMod) then begin
                        seek(empleados, filePos(empleados)-1);
                        e.edad:= edadMod;
                        write(empleados, e);
                        existe:= true;
                    end;
                    if(existe = false) then
                        write("Empleado no encontrado");
                end;
                close(empleados);
            end
            else
                // Parte C
                if(opcion = 3) then begin
                    writeln("Ingrese el nombre del archivo a utilizar");
                    readln(nombre_archivo);
                    assign(empleados, nombre_archivo);
                    reset(empleados);

                    writeln("Ingrese el nombre del archivo de texto a cargar");
                    readln(archivo_utilizar);
                    assign(todos_empleados, archivo_utilizar);
                    rewrite(todos_empleados);
                    
                    while(not eof(empleados)) do begin
                        read(empleados, e);
                        writeln(todos_empleados, e.num, ' ', e.nombre, ' ', e.apellido, ' ', e.edad, ' ', e.dni);
                    end;
                    close(empleados);
                    close(todos_empleados);
                end
                // Parte D
                else begin
                    writeln("Ingrese el nombre de archivo a utilizar");
                    readln(nombre_archivo);
                    assign(empleados, nombre_archivo);
                    reset(empleados);

                    writeln("Ingrese el nombre de archivo de texto a cargar");
                    readln(archivo_utilizar);
                    assign(faltaDNIEmpleado, archivo_utilizar);
                    rewrite(faltaDNIEmpleado);
                    
                    while(not eof(empleados)) do begin
                        read(empleados, e);
                        if(e.dni = 0) then
                            write(faltaDNIEmpleado, e.num, ' ', e.nombre, ' ', e.apellido, ' ', e.edad, ' ', e.dni);
                    end;
                    close(empleados);
                    close(faltaDNIEmpleado);
                end;
    
    until opcion = 0;
end.