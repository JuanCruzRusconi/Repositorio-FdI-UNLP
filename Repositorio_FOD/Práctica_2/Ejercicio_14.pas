Una compañía aérea dispone de un archivo maestro donde guarda información sobre sus próximos
vuelos. En dicho archivo se tiene almacenado el destino, fecha, hora de salida y la cantidad de asientos
disponibles. La empresa recibe todos los días dos archivos detalles para actualizar el archivo maestro.
En dichos archivos se tiene destino, fecha, hora de salida y cantidad de asientos comprados. Se sabe
que los archivos están ordenados por destino más fecha y hora de salida, y que en los detalles pueden
venir 0, 1 ó más registros por cada uno del maestro. Se pide realizar los módulos necesarios para:
a. Actualizar el archivo maestro sabiendo que no se registró ninguna venta de pasaje sin asiento
disponible.
b. Generar una lista con aquellos vuelos (destino y fecha y hora de salida) que tengan menos de
una cantidad específica de asientos disponibles. La misma debe ser ingresada por teclado.
NOTA: El archivo maestro y los archivos detalles sólo pueden recorrerse una vez.

Program ejercicio14;
const
    valorAlto = 'ZZZ';
type
    vuelo = record
        dest: string[20];
        fecha: integer;
        hora: integer;
        cantAsi: integer;
    end;
    archMaestro = file of vuelo;

    det = record
        dest: string[20];
        fecha: integer;
        hora: integer;
        cantAsi: integer;
    archDetalle = file of det;

    vueloL = record
        dest: string[20];
        fecha: integer;
        hora: integer;
    end;
    listaV = ^nodo;
    nodo = record
        elem: vueloL;
        sig: listaV;
    end;

    procedure leerD(var detalle: archDetalle; var d: det);
    begin
        if(not EOF(detalle)) then
            read(detalle, d)
        else
            d.dest:= valorAlto;
    end;

    procedure leerM(var maestro: archMaestro; var v: vuelo);
    begin
        if(not EOF(maestro)) then
            read(maestro, v)
        else
            v.dest:= valorAlto;
    end;

    procedure calcularMinimo(var detalle1, detalle2: archDetalle; var d1, d2, minimo: det);
    begin
        if(d1.dest < d2.dest) or ((d1.dest = d2.dest) and (d1.fecha < d2.fecha)) or ((d1.dest = d2.dest) and (d1.fecha = d2.fecha) and (d1.hora < d2.hora)) then begin
            minimo:= d1;
            leerD(detalle1, d1);
        end
        else begin
            minimo:= d2;
            leerD(detalle2, d2);
        end;
    end;

    procedure agregarLista(var l: listaV; dest: string[20]; fecha, hora: integer);
    var
        nuevo: listaV;
    begin
        new(nuevo); nuevo^.elem.dest:= dest; nuevo^.elem.fecha:= fecha; nuevo^.elem.hora:= hora; nuevo^.sig:= nil;
        if(l = nil) then l:= nuevo
        else begin
            nuevo^.sig:= l;
            l:= nuevo;
        end;
    end;

    procedure procesarDatos(var maestro: archMaestro; var detalle1, detalle2: archDetalle; var lista: listaV);
    var
        v: vuelo;
        d1, d2: det;
        minimo: det;
        destActual: string[20];
        fechaActual, horaActual: integer;
        cantAsiActual: integer;
        cantAsiDisp: integer;
    begin
        leerD(detalle1, d1);
        leerD(detalle2, d2);
        calcularMinimo(detalle1, detalle2, d1, d2, minimo);
        leerM(maestro, v);

        writeln('Ingrese la cantidad de asientos para generar la lista');
        readln(cantAsiDisp);

        while(minimo.dest <> valorAlto) do begin
            destActual:= minimo.dest;
            fechaActual:= minimo.fecha;
            horaActual:= minimo.hora;
            cantAsiActual:= 0;

            while(v.dest <> destActual) or (v.dest = destActual) and (v.fecha <> fechaActual) or 
                (v.dest = destActual) and (v.fecha = fechaActual) and (v.hora <> horaActual) do begin
                if(v.cantAsi < cantAsiDisp) then agregarLista(lista, v.dest, v.fecha, v.hora);
                leerM(maestro, v);
            end;
            
            while(destActual = minimo.dest) and (fechaActual = minimo.fecha) and (horaActual = minimo.hora) do begin
                cantAsiActual:= cantAsiActual + minimo.cantAsi;
                calcularMinimo(detalle1, detalle2, d1, d2, minimo);
            end;
            
            v.cantAsi:= v.cantAsi - cantAsiActual;
            seek(maestro, filePos(maestro) - 1);
            write(maestro, v);

            if(v.cantAsi < cantAsiDisp) then agregarLista(lista, destActual, fechaActual, horaActual);

            leerM(maestro, v);
        end;
        while(v.dest <> valorAlto) do begin
            if(v.cantAsi < cantAsiDisp) then agregarLista(lista, v.dest, v.fecha, v.hora);
            leerM(maestro, v);
        end;
    end;

var
    maestro: archMaestro;
    detalle1: archDetalle;
    detalle2: archDetalle;
    lista: listaV;
begin
    assign(maestro, 'archivo_maestro');
    reset(maestro);

    assign(detalle1, 'archivo_detalle1');
    reset(detalle1);

    assign(detalle2, 'archivo_detalle2');
    reset(detalle2);

    lista:= nil;

    procesarDatos(maestro, detalle1, detalle2, lista);

    close(maestro);
    close(detalle1);
    close(detalle2);
end.