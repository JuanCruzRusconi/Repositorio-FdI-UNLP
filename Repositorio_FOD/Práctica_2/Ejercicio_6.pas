Se desea modelar la información necesaria para un sistema de recuento de casos de COVID del
Ministerio de Salud de la Provincia de Buenos Aires.
Diariamente se reciben 10 archivos detalle provenientes de distintos municipios. La información contenida
en cada uno de ellos es la siguiente: código de localidad, código de cepa, cantidad de casos activos,
cantidad de casos nuevos, cantidad de casos recuperados y cantidad de casos fallecidos.
El ministerio cuenta con un archivo maestro que almacena la siguiente información: código de localidad,
nombre de la localidad, código de cepa, nombre de la cepa, cantidad de casos activos, cantidad de casos
nuevos, cantidad de casos recuperados y cantidad de casos fallecidos.
Todos los archivos están ordenados por código de localidad y código de cepa.
Se solicita desarrollar el procedimiento que permita actualizar el archivo maestro a partir de los 10 archivos
detalle, teniendo en cuenta el siguiente criterio:
● A la cantidad de casos fallecidos del maestro se le debe sumar el valor recibido en el detalle.
● A la cantidad de casos recuperados del maestro se le debe sumar el valor recibido en el detalle.
● La cantidad de casos activos del maestro debe actualizarse con el valor recibido en el detalle.
● La cantidad de casos nuevos del maestro debe actualizarse con el valor recibido en el detalle.
Realizar las declaraciones necesarias, el programa principal y los procedimientos que se requieran para
efectuar la actualización solicitada.
Además, informar la cantidad de localidades que poseen más de 50 casos activos, independientemente de
que hayan sido actualizadas o no.

Program ejercicio6;

const
    valorAlto = 9999;
type
    casoD = record
        localidad: integer;
        cepa: integer;
        casosAct: integer;
        casosNue: integer;
        casosRec: integer;
        casosRip: integer;
    end;

    casoM = record
        localidad: integer;
        nomLocalidad: string[20];
        cepa: integer;
        nomCepa: string[20];
        casosAct: integer;
        casosNue: integer;
        casosRec: integer;
        casosRip: integer;
    end;

    archDetalle = file of casoD;
    archMaestro = file of casoM;

    vectorDetalle = array[1..10] of archDetalle;
    vectorCasosD = array[1..10] of casoD;

    procedure leer(var detalle: archDetalle; var c: casoD);
    begin
        if(not EOF(detalle)) then
            read(detalle, c)
        else
            c.localidad:= valorAlto;
    end;

    procedure cargarDetalles(var vD: vectorDetalle; var vCD: vectorCasoD);
    var
        i: integer;
    begin
        for i:= 1 to 10 do begin
            assign(vD[i], 'archivo_detalle' + i);
            reset(vD[i]);
            leer(vD[i], vCD[i]);
        end;
    end;

    procedure calcularMinimo(var vD: vectorDetalle; var vCD: vectorCasoD; var minimo: casoD);
    var
        i, pos: integer;
    begin
        minimo.localidad:= valorAlto;
        minimo.cepa:= valorAlto;
        for i:= 1 to 10 do begin
            if(vCD[i].localidad < minimo.localidad) or
            (vCD[i].localidad = minimo.localidad) and (vCD[i].cepa < minimo.cepa) then begin
                minimo:= vCD[i];
                pos:= i;
            end;
        end;
        if(minimo.localidad <> valorAlto) then leer(vD[pos], vCD[pos]);
    end;

var
    minimo: casoD;
    cM: casoM;
    maestro: archMaestro;
    vD: vectorDetalle;
    vCD: vectorCasoD;
    locActual: integer;
    cepActual: integer;
    cantActivosActual: integer;
    cantLocalidades50: integer;
    cantRip: integer;
    cantRec: integer;
    cantAct: integer;
    cantNue: integer;
begin
    assign(maestro, 'archivo_maestro');
    reset(maestro);

    cargarDetalles(vD, vCD);
    calcularMinimo(vD, vCD, minimo);

    read(maestro, cM);

    cantLocalidades50:= 0;

    while(minimo.localidad <> valorAlto) do begin
        locActual := minimo.localidad;
        cantActivosActual:= 0;
        while(minimo.localidad = locActual) do begin
            cepActual:= minimo.cepa;
            cantRip:= 0;
            cantRec:= 0;
            cantAct:= 0;
            cantNue:= 0;
            while(minimo.localidad = locActual) and (minimo.cepa = cepActual) do begin
                cantRip:= cantRip + minimo.casosRip;
                cantRec:= cantRec + minimo.casosRec;
                cantAct:= cantAct + minimo.casosAct;
                cantNue:= cantNue + minimo.casosNue;
                calcularMinimo(vD, vCD, minimo);
            end;

            cantActivosActual:= cantActivosActual + cantAct;

            while(cM.localidad <> locActual) do
                read(maestro, cM);
            
            while(cM.localidad = locActual) and
            (cM.cepa <> cepActual) do
                read(maestro, cM);

            cM.casosRip:= cM.casosRip + cantRip;
            cM.casosRec:= cM.casosRec + cantRec;
            cM.casosAct:= cantAct;
            cM.casosNue:= cantNue;

            seek(maestro, filePos(maestro) - 1);
            write(maestro, cM);
            if(not EOF(maestro)) then read(maestro, cM);

        end;
        if(cantActivosActual > 50) then cantLocalidades50:= cantLocalidades50 + 1;
    end;

    close(maestro);
    cerrarDetalles(vD);
    writeln('La cantidad de localidades con mas de 50 casos activos es de: ', cantLocalidades50);
end;