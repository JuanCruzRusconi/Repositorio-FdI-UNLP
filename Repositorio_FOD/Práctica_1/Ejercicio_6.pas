6. Agregar al menú del programa del ejercicio 5, opciones para:
a. Añadir uno o más celulares al final del archivo con sus datos ingresados por teclado.
b. Modificar el stock de un celular dado.
c. Exportar el contenido del archivo binario a un archivo de texto denominado: ”SinStock.txt”,
con aquellos celulares que tengan stock 0.
NOTA: Las búsquedas deben realizarse por nombre de celular.

Program ejercicio6;
const

type
    rangoOpciones = 1..3;
    celular = record
        cod: integer;
        nombre: string;
        desc: string[30];
        marca: string[10];
        precio: real;
        stockMin: integer;
        stockDis: integer;
    end;

    archivo_celulares: file of celular;
var
    opcion: rangoOpciones;
    celulares: archivo_celulares;
    nombre_archivo: string[20];
    c: celular;
    nomCelular: string[20];
    existe: boolean;
    nuevoStock: integer;
    stockMod: integer;
    SinStock: text;

begin
    writeln("Opciones:");
    writeln("1 - Anadir celular");
    writeln("2 - Modificar stock");
    writeln("3 - Exportar");

    repeat
        writeln("Ingrese la opcion a realizar");
        readln(opcion);

        if(opcion = 1) then begin
            writeln("Ingrese el nombre del archivo");
            readln(nombre_archivo);
            assign(celulares, nombre_archivo);
            reset(celulares);

            writeln("Ingrese el numero de celular a ingresar");
            readln(nomCelular);

            while(nomCelular <> 'ZZZ') do begin
                seek(celulares, 0);
                existe:= false;
                while(not eof(celulares)) and (not existe) do begin
                    read(celulares, c);
                    if(c.nombre = nomCelular) then begin
                        existe:= true;
                        writeln("El celular ingresado ya existe");
                    end;
                end;

                if(existe = false) then begin
                    seek(celulares, fileSize(celulares));
                    writeln("Ingrese el codigo de celular");
                    readln(c.cod);
                    c.nombre:= nomCelular;
                    writeln("Ingrese la descripcion de celular");
                    readln(c.desc);
                    writeln("Ingrese la marca de celular");
                    readln(c.marca);
                    writeln("Ingrese el precio de celular");
                    readln(c.precio);
                    writeln("Ingrese el stock minimo de celular");
                    readln(c.stockMin);
                    writeln("Ingrese el stock disponible de celular");
                    readln(c.stockDis);
                    write(celulares, c);
                end;

                writeln("Ingrese el numero de celular a ingresar");
                readln(nomCelular);
            end;
            close(celulares);
        end
        else
            if(opcion = 2) then begin
                writeln("Ingrese el nombre de archivo a utilizar");
                readln(nombre_archivo);
                assign(celulares, nombre_archivo);
                reset(celulares);

                writeln("Ingrese el nombre de celular a modificar");
                readln(nomCelular);
                existe:= false;

                while(not eof(celulares)) and (not existe) do begin
                    read(celulares, c);
                    if(c.nombre = nomCelular) then begin
                        writeln("Ingrese el nuevo stock");
                        readln(nuevoStock);
                        c.stockDis:= nuevoStock;
                        seek(celulares, filePos(celulares)-1);
                        write(celulares, c);
                        existe:= true;
                    end;
                end;
                close(celulares);
            end
            else begin
                writeln("Ingrese el nombre de archivo a utilizar");
                readln(nombre_archivo);
                assign(celulares, nombre_archivo);

                assign(SinStock, 'SinStock.txt');

                reset(celulares);
                rewrite(SinStock);

                while(not eof(celulares)) do begin
                    read(celulares, c);
                    if(c.stockDis = 0) then
                        writeln(SinStock, c.cod, ' ', c.nombre, ' ', c.desc, ' ', c.marca, ' ', c.precio, ' ', c.stockMin, ' ', c.stockDis);
                end;
                close(celulares);
                close(SinStock);
            end;

    until opcion = 0;

end.