Realizar un programa para una tienda de celulares, que presente un menú con opciones para:
a. Crear un archivo de registros no ordenados de celulares y cargarlo con datos ingresados
desde un archivo de texto denominado “celulares.txt”. Los registros correspondientes a
los celulares deben contener: código de celular, nombre, descripción, marca, precio,
stock mínimo y stock disponible. El formato del archivo de texto de carga se especifica en
la NOTA 2 ubicada al final del ejercicio.
b. Listar en pantalla los datos de aquellos celulares que tengan un stock menor al stock
mínimo.
c. Listar en pantalla los celulares del archivo cuya descripción contenga una cadena de
caracteres proporcionada por el usuario.
d. Exportar el archivo binario creado en el inciso a) a un archivo de texto denominado
“celulares.txt” con todos los celulares del mismo. El archivo de texto generado podría ser
utilizado en un futuro como archivo de carga (ver inciso a), por lo que debería respetar el
formato dado para este tipo de archivos en la NOTA 2.
NOTA 1: El nombre del archivo binario de celulares debe ser proporcionado por el usuario
NOTA 2: El archivo de carga debe editarse de manera que cada celular se especifique en tres
líneas consecutivas. En la primera se especifica: código de celular, el precio y marca, en la
segunda el stock disponible, stock mínimo y la descripción y en la tercera nombre en ese orden.
Cada celular se carga leyendo tres líneas del archivo “celulares.txt”.

Program tienda;
const

type
    rangoOpciones = 1..4;
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
    nombre_arch_celulares, nombre_text_celulares: string[20];
    texto_celulares: text;
    c: celular;
    caracteres: string[30];
begin
    writeln("Opciones:");
    writeln("Opcion 1 - ...");
    writeln("Opcion 2 - ...");
    writeln("Opcion 3 - ...");
    writeln("Opcion 4 - ...");
    
    repeat 
        writeln("Ingrese la opcion a realizar, 1-4");
        readln(opcion);

        if(opcion = 1) then begin
            writeln("Ingrese el nombre del archivo a crear");
            readln(nombre_arch_celulares);
            assign(celulares, nombre_arch_celulares);

            writeln("Ingrese el nombre del archivo de texto");
            readln(nombre_text_celulares);
            assign(texto_celulares, nombre_text_celulares);

            reset(texto_celulares);
            rewrite(celulares);

            while(not eof(texto_celulares)) do begin
                readln(texto_celulares, c.cod, c.precio, c.marca);
                readln(texto_celulares, c.stockDis, c.stockMin, c.desc);
                readln(texto_celulares, c.nombre);
                write(celulares, c);
            end;
            close(texto_celulares);
            close(celulares);
        end
        else
            if(opcion = 2) then begin
                writeln("Ingrese el nombre del archivo a utilizar");
                readln(nombre_arch_celulares);
                assign(celulares, nombre_arch_celulares);
                reset(celulares);

                while(not eof(celulares)) do begin
                    read(celulares, c);
                    if(c.stockDis < c.stockMin) then
                        writeln(c.cod,' ', c.nombre, ' ', c.desc, ' ', c.marca, ' ', c.precio, ' ', c.stockMin, ' ', c.stockDis);
                end;
                close(celulares);
            end
            else
                if(opcion = 3) then begin
                    writeln("Ingrese el nombre del archivo a utilizar");
                    readln(nombre_arch_celulares);
                    assign(celulares, nombre_arch_celulares);
                    reset(celulares);

                    writeln("Ingrese la cadena de caracteres a buscar");
                    readln(caracteres);
                    while(not eof(celulares)) do begin
                        read(celulares, c);
                        if(c.desc = caracteres) then
                            writeln(c.cod,' ', c.nombre, ' ', c.desc, ' ', c.marca, ' ', c.precio, ' ', c.stockMin, ' ', c.stockDis);
                    end;
                    close(celulares);
                end
                else begin
                    writeln("Ingrese el nombre del archivo a exportar");
                    readln(nombre_arch_celulares);
                    assign(celulares, nombre_arch_celulares);

                    writeln("Ingrese el nombre del archivo de texto");
                    readln(nombre_text_celulares);
                    assign(texto_celulares, nombre_text_celulares);

                    reset(celulares);
                    rewrite(texto_celulares);
                    while(not eof(celulares)) do begin
                        read(celulares, c);
                        writeln(texto_celulares, c.cod, ' ', c.precio, ' ', c.marca);
                        writeln(texto_celulares, c.stockDis, ' ', c.stockMin, ' ', c.desc);
                        writeln(texto_celulares, c.nombre);
                    end;
                    close(celulares);
                    close(texto_celulares);
                end;

    until opcion = 0;
end.