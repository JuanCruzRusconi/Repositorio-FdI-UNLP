La editorial X, autora de diversos semanarios, posee un archivo maestro con la información
correspondiente a las diferentes emisiones de los mismos. De cada emisión se registra: fecha, código
de semanario, nombre del semanario, descripción, precio, total de ejemplares y total de ejemplares
vendidos.
Mensualmente se reciben 100 archivos detalles con las ventas de los semanarios en todo el país. La
información que poseen los detalles es la siguiente: fecha, código de semanario y cantidad de
ejemplares vendidos. Realice las declaraciones necesarias, la llamada al procedimiento y el
procedimiento que recibe el archivo maestro y los 100 detalles y realice la actualización del archivo
maestro en función de las ventas registradas. Además deberá informar fecha y semanario que tuvo más
ventas y la misma información del semanario con menos ventas.
Nota: Todos los archivos están ordenados por fecha y código de semanario. No se realizan ventas de
semanarios si no hay ejemplares para hacerlo.

Program ejercicio16;

const
    valorAlto = 9999;
    maxDetalles = 100;
type
    rangoDetalles = 1..maxDetalles;
    emision = record
        fecha: integer;
        codigo: integer;
        nombre: string[20];
        desc: string[20];
        precio: real;
        totalEj: integer;
        totalEjVen: integer;
    end;
    archMaestro = file of emision;

    venta = record
        fecha: integer;
        codigo: integer;
        totalEjVen: integer;
    end;
    archDetalle = file of venta;

    vectorDetalle = array[rangoDetalles] of archDetalle;
    vectorRegistro = array[rangoDetalles] of venta;

    procedure leer(var archivo: archDetalle; var v: venta);
    begin
        if(not EOF(archivo)) then
            read(archivo, v)
        else
            v.fecha:= valorAlto;
    end;

    procedure cargarDetalles(var vD: vectorDetalle; var vR: vectorRegistro);
    var
        i: rangoDetalles;
    begin
        for i:= 1 to maxDetalles do begin
            assign(vD[i], 'archivo_detalle'+i);
            reset(vD[i]);
            leer(vD[i], vR[i]);
        end;    
    end;

    procedure calcularMinimo(var vD: vectorDetalle; var vR: vectorRegistro; var minimo: venta);
    var
        i, pos: rangoDetalles;
    begin
        minimo.fecha:= valorAlto;
        minimo.codigo:= valorAlto;
        for i:= 1 to maxDetalles do begin
            if(vR[i].fecha < minimo.fecha) or (vR[i].fecha = minimo.fecha) and (vR[i].codigo < ) then begin
                minimo:= vR[i];
                pos:= i;
            end;
        end;
        if(minimo.fecha <> valorAlto) then leer(vD[pos], vR[pos]);
    end;

    procedure calcularMax(fecha: integer; sema: string; cant: integer; var maxFec: integer; var maxSema: string; var maxVend: integer);
    begin
        if(cant > maxVend) then begin
            maxVend:= cant;
            maxFec:= fecha;
            maxSema:= sema;
        end;
    end;

    procedure calcularMin(fecha: integer; sema: string; cant: integer; var minFec: integer; var minSema: string; var minVend: integer);
    begin
        if(cant < minVend) then begin
            minVend:= cant;
            minFec:= fecha;
            minSema:= sema;
        end;
    end;

    procedure cerrarDetalles(var vD: vectorDetalle);
    var 
        i: rangoDetalles;
    begin
        for i:= 1 to maxDetalles do
            close(vD[i]);
    end;

    procedure procesarDatos(var maestro: archMaestro; var vD: vectorDetalle; var vR: vectorRegistro);
    var
        e: emision;
        minimo: venta;
        cantVenActual: integer;
        fechaActual, semaActual: integer;
        cantSema: integer;
        maxSem, minSem: string[20];
        maxFec, minFec: integer;
        maxVentSem, minVentSem: integer;
    begin
        read(maestro, e);
        cargarDetalles(vD, vR);
        calcularMinimo(vD, vR, minimo);
        maxVentSem:= -1;
        minVentSem:= valorAlto;

        while(minimo.fecha <> valorAlto) do begin
            fechaActual:= minimo.fecha;
            semaActual:= minimo.codigo;
            cantSema:= 0;
            while(fechaActual = minimo.fecha) and (semaActual = minimo.codigo) do begin
                cantSema:= cantSema + minimo.totalEjVen;
                calcularMinimo(vD, vR, minimo);
            end;

                while(e.fecha <> fechaActual) or (e.fecha = fechaActual) and (e.codigo <> semaActual) do
                    read(maestro, e);

                e.totalEj:= e.totalEj - cantSema;
                e.totalEjVen:= e.totalEjVen + cantSema;

                calcularMax(fechaActual, semaActual, cantSema, maxFec, maxSem, maxVentSem);
                calcularMin(fechaActual, semaActual, cantSema, minFec, minSem, minVentSem);

                seek(maestro, filePos(maestro) - 1);
                write(maestro, e);

                if(not EOF(maestro)) then read(maestro, e);
            end;
        end;
        writeln('El maximo de ventas tiene la fecha: ', maxFec, ' el semanario nombre: ', maxSem, ' con un total de ventas de: ', maxVentSem);
        writeln('El minimo de ventas tiene la fecha: ', minFec, ' el semanario nombre: ', minSem, ' con un total de ventas de: ', minVentSem);
    end;
    
var
    maestro: archMaestro;
    vD: vectorDetalle;
    vR: vectorRegistro;
begin
    assign(maestro, 'archivo_maestro');
    reset(maestro);

    procesarDatos(maestro, vD, vR);

    close(maestro);
    cerrarDetalles(vD);
end.