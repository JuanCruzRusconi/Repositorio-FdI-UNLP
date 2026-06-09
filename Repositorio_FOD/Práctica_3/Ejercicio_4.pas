Dada la siguiente estructura:
 type
reg_flor = record
nombre: String[45];
codigo: integer;
 end;
tArchFlores = file of reg_flor;
Se desea implementar un sistema de gestión de flores utilizando un archivo con reutilización de
espacio.
● Las bajas lógicas se realizan apilando los registros eliminados.
● Las altas deben reutilizar los espacios libres disponibles antes de agregar nuevos registros al final
del archivo.
● El registro en la posición 0 se utiliza como cabecera de la pila de registros borrados.
Política de reutilización:
● Si el campo código del registro cabecera es 0, significa que no hay registros borrados
disponibles.
● Si el campo código es -N, indica que el próximo registro libre se encuentra en la posición N del
archivo.
● Cada registro borrado debe almacenar en su campo codigo el valor negativo que apunte al
siguiente registro libre, formando así una pila enlazada.
a. Implementación requerida
Implementar el siguiente módulo:
{ Abre el archivo y agrega una flor, recibida como parámetro,
respetando la política de reutilización de espacio descripta }
procedure agregarFlor (var a: tArchFlores; nombre: string; codigo: integer);
b. Listado del archivo
Realizar un procedimiento que liste el contenido del archivo omitiendo las flores eliminadas (es
decir, aquellos registros que forman parte de la pila de libres).
Se permite modificar o agregar estructuras auxiliares si se considera necesario para obtener
correctamente el listado.
c. Implemente el siguiente módulo:
{Abre el archivo y elimina la flor recibida como parámetro manteniendo la
política descripta anteriormente}
procedure eliminarFlor (var a: tArchFlores; flor:reg_flor);

program ejercicio4;
const
    valorAlto = 9999;
type
    reg_flor = record
        nombre: String[45];
        codigo: integer;
    end;
    tArchFlores = file of reg_flor;

    procedure agregarFlor(var arch: tArchFlores; nom: string[45]; cod: integer);
    var
        nuevo, f, cabecera: reg_flor;
        posAlta: integer;
    begin
        assign(arch, 'archivo_flores');
        reset(arch);

        leer(arch, cabecera);

        nuevo.nombre:= nom;
        nuevo.cod:= cod;

        if(cabecera.cod < 0) then begin
            posAlta:= -cabecera.cod;
            seek(arch, posAlta);
            read(arch, f);

            cabecera.codigo:= f.codigo;
            seek(arch, 0);
            write(arch, cabecera);

            seek(arch, posAlta);
            write(arch, nuevo);
        end
        else begin
            seek(arch, fileSize(arch));
            write(arch, nuevo);
        end;
        close(arch);
    end;

    procedure listado(arch: tArchFlores);
    var
        f: reg_flor;
    begin
        assign(arch, 'archivo_flores');
        reset(arch);

        leer(arch, f);

        while(f.codigo <> valorAlto) do begin
            if(f.codigo > 0) then
                writeln(f.nombre, ' ', f.codigo);
            leer(arch, f);
        end;
        close(arch);
    end;

    procedure eliminarFlor(var arch: tArchFlores; codigo: integer);
    var
        f, cabecera: reg_flor;
        aux: integer;
    begin
        assign(arch, 'archivo_flores');
        reset(flores);

        leer(arch, f);
        cabecera:= f;

        while(f.cod <> valorAlto) and (cod <> f.cod) do begin
            leer(arch, f);
        
        if(cod = f.cod) then begin
            aux:= filePos(arch) - 1;
            f.cod:= cabecera.cod;

            seek(arch, aux);
            write(arch, f);

            cabecera.cod:= -aux;

            seek(arch, 0);
            write(arch, cabecera);
        end
        else
            writeln("Flor no enocntrado");
        close(arch);
    end;

    procedure procesarDatos(var arch: tArchFlores);
    var
        nom: string[45];
        cod: integer;
    begin
        writeln("Indique la accion a realizar");
        writeln("Opcion 1: agregar una flor");
        writeln("Opcion 2: listar las flores");
        writeln("Opcion 3: eliminar una flor");
        writeln("Opcion 0: salir);
        readln(opcion);

        while(opcion <> 0) do begin
            if(opcion = 0) then begin
                writeln("Indique el nombre de la flor a agregar:");
                readln(nom);
                writeln("Indique el codigo de la flor a agregar:");
                readln(cod);
                agregarFlor(arch, nom, cod);
            end
            else if(opcion = 2) then begin
                listado(arch);
            end
            else begin
                writeln("Indique el codigo de la flor a eliminar:");
                readln(cod);
                eliminarFlor(arch, cod);
            end;
            writeln("Indique la accion a realizar, 1, 2 o 0 (salir)");
            readln(opcion);
        end;
    end;
var
    arch: tArchFlores;
begin
    procesarDatos(arch);
end;
