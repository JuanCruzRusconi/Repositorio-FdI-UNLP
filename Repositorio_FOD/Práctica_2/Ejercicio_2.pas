El encargado de ventas de un negocio de productos de limpieza desea administrar el stock de los productos
que comercializa. Para ello, dispone de un archivo maestro en el que se registran todos los productos.
De cada producto se almacena la siguiente información: código de producto, nombre comercial, precio de venta,
stock actual y stock mínimo.
Diariamente se genera un archivo detalle donde se registran todas las ventas realizadas. De cada venta se
almacena: código de producto y cantidad de unidades vendidas.
Se solicita desarrollar un programa que permita:
a) Actualizar el archivo maestro a partir del archivo detalle, teniendo en cuenta que:
● Ambos archivos están ordenados por código de producto.
● Cada registro del archivo maestro puede ser actualizado por cero, uno o más registros del archivo
detalle.
● El archivo detalle sólo contiene registros cuyos códigos existen en el archivo maestro.
b) Generar un archivo de texto llamado “stock_minimo.txt” que contenga aquellos productos cuyo stock actual se
encuentre por debajo del stock mínimo permitido.

Program Ejercicio2;

const
    valorAlto = 9999;
type
    producto = record
        cod: integer;
        nombre: string[20];
        precio: real;
        stockAct: integer;
        stockMin: integer;
    end;

    archMaestro = file of producto;

    venta = record
        cod: integer;
        cant: integer;
    end;

    archDetalle = file of venta;

    procedure leer(var archivo: archDetalle; var v: venta);
    begin
        if not(EOF(archivo)) then
            read(archivo, v)
        else
            v.cod:= valorAlto;
    end;

var
    p: producto;
    v: venta;
    maestro: archMaestro;
    detalle: archDetalle;
    stockMinimo: text;
    codActual: integer;
    cantActual: integer;
begin
    assign(maestro, 'archivo_maestro');
    reset(maestro);

    assign(detalle, 'archivo_detalle');
    reset(detalle);

    assign(stockMinimo, 'stock_minimo.txt');
    rewrite(stockMinimo);

    read(maestro, p);
    leer(detalle, v);

    while(v.cod <> valorAlto) do begin
        codActual := v.cod;
        cantActual := 0;

        while(codActual = v.cod) do begin
            cantActual:= cantActual + v.cant;
            leer(detalle, v);
        end;

        while(p.cod <> codActual) do
            read(maestro, p);

        p.stockAct := p.stockAct - cantActual;

        if(p.stockAct < p.stockMin) then begin
            writeln(stockMinimo, p.cod, ' ', p.nombre, ' ', p.precio, ' ', p.stockAct, ' ', p.stockMin);
        end;

        seek(maestro, filePos(maestro) - 1);
        write(maestro, p);

        if(not(EOF(maestro))) then read(maestro, p);
    end;

    close(maestro);
    close(detalle);
    close(stockMinimo);

end.