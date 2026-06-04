Definir un programa que genere un archivo con registros de longitud fija con información de
productos de un comercio. Los datos se ingresan por teclado y de cada producto se almacena:
código de producto, nombre, descripción, precio y stock disponible. Implementar un
procedimiento que, a partir del archivo de datos generado, realice la baja lógica de todos
aquellos productos cuyo stock disponible sea igual a 0.
La baja lógica debe indicarse marcando el registro con un carácter especial que se sitúa como
prefijo en algún campo de tipo string a su elección. Por ejemplo, se puede anteponer el carácter @
al nombre del producto: ‘@Arroz Gallo 1K’.

program ejercicio2;
const
    valorAlto = 9999;
type
    producto = record
        cod: integer;
        nom: string[10];
        descr: string[20];
        precio: real;
        stockDis: integer;
    end;
    archivo = file of producto;

    procedure leer(var arch: archivo; var p: producto);
    begin
        if(not EOF(arch)) then
            read(arch, p)
        else
            p.cod:= valorAlto;
    end;

    procedure realizarBajas(var arch: archivo);
    var
        p: producto;
    begin
        reset(arch);
        leer(arch, p);

        while(p.cod <> valorAlto) do begin
            if(p.stockDis = 0) then begin
                p.nom:= '*' + p.nom + '*';
                seek(arch, filePos(arch) - 1);
                write(arch, p);
            end;
            leer(arch, p);
        end;
    end;    

var
    arch: archivo;
    p: producto;
begin
    assign(arch, 'archivo_productos');
    rewrite(arch);

    writeln("Ingrese el codigo de producto");
    readln(p.cod);

    while(p.cod <> valorAlto) do begin
        writeln("Ingrese el nombre de producto");
        readln(p.nom);
        writeln("Ingrese el descripcion de producto");
        readln(p.descr);
        writeln("Ingrese el precio de producto");
        readln(p.precio);
        writeln("Ingrese el stock disponible de producto");
        readln(p.stockDis);

        write(arch, p);

        writeln("Ingrese el codigo de producto");
        readln(p.cod);
    end;
    close(arch);
    realizarBajas(arch);
    close(arch);
end;