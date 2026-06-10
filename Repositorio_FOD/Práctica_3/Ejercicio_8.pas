El encargado de ventas de un negocio de productos de limpieza desea administrar el stock de los
productos que vende. Para ello, genera un archivo maestro donde figuran todos los productos que
comercializa. De cada producto se maneja la siguiente información: código de producto, nombre
comercial, precio de venta, stock actual y stock mínimo. Diariamente se genera un archivo detalle
donde se registran todas las ventas de productos realizadas. De cada venta se registran: código de
producto y cantidad de unidades vendidas. Resuelve los siguientes puntos:
a. Se pide realizar un procedimiento que actualice el archivo maestro con el archivo detalle,
teniendo en cuenta que:
i. Los archivos no están ordenados por ningún criterio.
ii. Cada registro del maestro puede ser actualizado por 0, 1 ó más registros del archivo
detalle.
b. ¿Qué cambios realizaría en el procedimiento del punto anterior si se sabe que cada registro
del archivo maestro puede ser actualizado por 0 o 1 registro del archivo detalle?

program ejercicio8;
const
    valorAlto = 9999;
type
    producto = record
        codProd: integer;
        nombre: string[20]; 
        precio: real;
        stockAct: integer;
        stockMin: integer;
    end;
    archMaestro = file of producto;

    venta = record
        codProd: integer;
        cant: integer;
    end;
    archDetalle = file of venta;

    procedure leerD(var detalle: archDetalle; var v: venta);
    begin
        if(not EOF(detalle)) then
            read(detalle, v)
        else
            v.codProd:= valorAlto
    end;

    procedure leerM(var maestro: archMaestro; var p: producto);
    begin
        if(not EOF(maestro)) then
            read(maestro, p)
        else
            p.codProd:= valorAlto
    end;

    procedure procesarDatos(var maestro: archMaestro; var detalle: archDetalle);
    var
        p: producto;
        v: venta;
        codActual: integer;
    begin
        reset(maestro);
        reset(detalle);

        leerD(detalle, v);

        while(v.codProd <> valorAlto) do begin
            seek(maestro, 0);
            leerM(maestro, p);

            while(p.codProd <> v.codProd) do
                leerM(maestro, p);
            
            if(p.codProd = v.codProd) then begin
                p.stockAct:= p.stockAct - v.cant;
                seek(maestro, filePos(maestro) - 1);
                write(maestro, p);
            end;

            leerD(detalle, v);
        end;
        close(maestro);
        close(detalle);
    end;

var
    maestro: archMaestro;
    detalle: archDetalle;
begin
    assign(maestro, 'archivo_maestro');
    assign(detalle, 'archivo_detalle');
    procesarDatos(maestro, detalle);
end.