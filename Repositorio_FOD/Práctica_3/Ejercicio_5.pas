Una cadena de tiendas de indumentaria dispone de un archivo maestro no ordenado que
contiene la información de las prendas que se encuentran a la venta. De cada prenda se registran
los siguientes datos: cod_prenda, descripción, colores, tipo_prenda, stock y precio_unitario.
Debido a un cambio de temporada, es necesario actualizar las prendas disponibles. Para ello, se
recibe un archivo detalle que contiene los códigos (cod_prenda) de aquellas prendas que
quedarán obsoletas. Se deberá implementar un procedimiento que reciba ambos archivos y
realice la baja lógica de las prendas indicadas; para ello, se deberá modificar el campo stock de la
prenda correspondiente asignándole un valor negativo como marca de eliminación.
Adicionalmente, se deberá implementar otro procedimiento que permita efectivizar las bajas
lógicas realizadas sobre el archivo maestro. Para ello, se deberá crear un archivo auxiliar en el cual
se copien únicamente aquellas prendas que no estén marcadas como eliminadas (es decir,
aquellas cuyo stock sea mayor o igual a cero).
Finalmente, una vez completado el proceso de compactación, el archivo auxiliar deberá
reemplazar al archivo maestro original, adoptando su mismo nombre.

program ejercicio5;
const
    valorAlto = 9999;
type
    prenda = record
        cod_prenda: integer;
        descripción: string[20];
        colores: string[20];
        tipo_prenda: string[20];
        stock: integer;
        precio_unitario: real;
    end;
    archMaestro = file of prenda;

    archDetalle = file of integer;

    procedure procesarDatos(var maestro: archMaestro; var detalle: archDetalle);
    var
        p: prenda;
        cod: integer;
    begin
        reset(maestro);
        reset(detalle);
        leerD(detalle, cod);

        while(cod <> valorAlto) do begin
            seek(maestro, 0);
            leerM(maestro, p);

            while(p.cod_prenda <> valorAlto) and (p.cod_prenda <> cod) do
                leerM(maestro, p);
            
            if(p.cod_prenda = cod) then begin
                p.stock:= -1;
                seek(maestro, filePos(maestro) - 1);
                write(maestro, p);
            end;

            leerD(detalle, cod);
        end;
        close(maestro);
        close(detalle);
    end;

    procedure cargarPrendas(var maestro: archMaestro; var auxiliar: archMaestro);
    var
        p: prenda;
    begin
        rewrite(auxiliar);
        reset(maestro);
        leerM(maestro, p);

        while(p.cod_prenda <> valorAlto) do begin
            if(p.stock > -1) then
                write(auxiliar, p);
            leerM(maestro, p);
        end;
        close(auxiliar);
        close(maestro);
    end;

var
    maestro: archMaestro;
    detalle: archDetalle;
    auxiliar: archMaestro;
begin
    assign(maestro, 'archivo_maestro');
    assign(detalle, 'archivo_detalle');
    assign(auxiliar, 'archivo_auxiliar');
    procesarDatos(maestro, detalle);
    cargarPrendas(maestro, auxiliar);
    rename(maestro, 'archivo_maestro_viejo');
    rename(auxiliar, 'archivo_maestro');
end;