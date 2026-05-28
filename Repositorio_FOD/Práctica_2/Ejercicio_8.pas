Se desea gestionar la información correspondiente al consumo de yerba mate en las distintas provincias
de la Argentina.
Para ello, se dispone de un archivo maestro que contiene la siguiente información: código de provincia,
nombre de la provincia, cantidad de habitantes y cantidad total histórica de kilos de yerba consumidos.
Mensualmente, se reciben 16 archivos detalle con información relevada sobre el consumo de yerba mate
en distintos puntos del país. Cada archivo detalle contiene: código de provincia y cantidad de kilos de yerba
consumidos en ese relevamiento.
Un archivo detalle puede contener información correspondiente a una o varias provincias, y una misma
provincia puede aparecer cero, uno o más veces en los distintos archivos detalle.
Tanto el archivo maestro como los archivos detalle están ordenados por código de provincia.
Se solicita desarrollar un programa que actualice el archivo maestro a partir de la nueva información de
consumo.
Además, se debe informar por pantalla aquellas provincias (código y nombre) cuya cantidad total histórica
de yerba consumida supere los 10.000 kilos, indicando también el promedio de consumo por habitante.
Para este informe deben considerarse tanto las provincias actualizadas como aquellas que no hayan
recibido modificaciones.
Nota: Cada archivo debe recorrerse una única vez.

program ej8;
const
    valorAlto = 9999;
type
    info = record
        codProv: integer;
        nomProv: string[10]; 
        cantHab: integer;
        cantTotYerba: integer;
    end;

    archMaestro = file of info;

    det = record
        codProv: integer;
        cantYerba: integer;
    end;

    archDetalle = file of det;

    vectorDetalle = array[1..16] of archDetalle;
    vectorRegistro = array[1..16] of det;

    procedure leer(var detalle: archDetalle; var d: det);
    begin
        if(not EOF(detalle)) then
            read(detalle, d)
        else
            d.codProv:= valorAlto;
    end;

    procedure leerMaestro(var maestro: archMaestro; var i: info);
    begin
        if(not EOF(maestro)) then
            read(maestro, i)
        else
            i.codProv:= valorAlto;
    end;

    procedure cargarDetalles(var vD: vectorDetalle; var vR: vectorRegistro);
    var
        i: integer;
    begin
        for i:= 1 to 16 do begin
            assign(vD[i], 'archivo_detalle'+i);
            reset(vD[i]);
            leer(vD[i], vR[i]);
        end;
    end;

    procedure calcularMinimo(var vD: vectorDetalle; var vR: vectorRegistro; var minimo: det);
    var
        i, pos: integer;
    begin
        minimo.codProv:= valorAlto;
        for i:= 1 to 16 do begin
            if(vR[i].codProv < minimo.codProv) then begin
                minimo:=  vR[i];
                pos:= i;
            end;
        end;
        if(minimo.codProv <> valorAlto) then leer(vD[pos], vR[pos]);
    end;

    procedure procesarProvincia(i: info);
    var
        prom: real;
    begin
        if(i.cantTotYerba > 10000) then begin
            prom:= i.cantTotYerba / i.cantHab;
            writeln('Provincia ', i.codProv, ' ', i.nomProv, ' tiene un promedio de ', prom);
        end;
    end;

    procedure cerrarDetalles(var vD: vectorDetalles);
    var
        i: integer;
    begin
        for i:= 1 to 16 do
            close(vD[i]);
    end;

    procedure procesarDatos(var maestro: archMaestro; var vD: vectorDetalle; var vR: vectorRegistro);
    var
        i: info;
        minimo: det;
        provActual: integer;
        cantActual: integer;
    begin
        read(maestro, i);
        calcularMinimo(vD, vR, minimo);
        while(minimo.codProv <> valorAlto) do begin
            provActual:= minimo.codProv;
            cantActual:= 0;

            while(i.codProv <> provActual) do begin
                procesarProvincia(i);
                leerMaestro(maestro, i);
            end;

            while(provActual = minimo.codProv) do begin
                cantActual:= cantActual + minimo.cantYerba;
                calcularMinimo(vD, vR, minimo);
            end;

            i.cantTotYerba:= i.cantTotYerba + cantActual;
            procesarProvincia(i);

            seek(maestro, filePos(maestro) - 1);
            write(maestro, i);

            leerMaestro(maestro, i);
        end;
        while(i.codProv <> valorAlto) do begin
            procesarProvincia(i);
            leerMaestro(maestro, i);
        end;
    end;

var
    maestro: archMaestro;
    vD: vectorDetalle;
    vR: vectorRegistro;
begin
    assign(maestro, 'archivo_maestro');
    reset(maestro);
    cargarDetalles(vD, vR);
    procesarDatos(maestro, vD, vR);
    close(maestro);
    cerrarDetalles(vD);
end.