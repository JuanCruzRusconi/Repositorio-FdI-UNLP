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
        codLoc: integer;
        codCepa: integer; 
        cantAct: integer;
        cantNue: integer;
        cantRec: integer;
        cantFall: integer;
    end;
    archDetalle = file of casoD;

    casoM = record
        codLoc: integer;
        nomLoc: string[10]; 
        codCepa: integer;
        nomCepa: string[10];
        cantAct: integer;
        cantNue: integer; 
        cantRec: integer;
        cantFall: integer;
    end;
    archMaestro = file of casoM;

    vectorDetalle = array[1..10] of archDetalle;
    vectorReg = array[1..10] of casoD;

     procedure leer(var detalle: archDetalle; var c: casoD);
    begin
        if(not EOF(detalle)) then
            read(detalle, c)
        else
            c.localidad:= valorAlto;
    end;

    procedure cargarDetalles(var vD: vectorDetalle; var vR: vectorRegistro);
    var
        i: integer;
    begin
        for i:= 1 to 10 do begin
            assign(vD[i], 'archivo_detalle'+i);
            reset(vD[i]);
            leer(vD[i], vR[i]);
        end;    
    end;

    procedure calcularMinimo(var vD: vectorDetalle; var vR: vectorRegistro; var minimo: casoD);
    var
        i, pos: integer;
    begin
        minimo.codLoc:= valorAlto;
        minimo.codCepa:= valorAlto;
        for i:= 1 to 10 do begin
            if(vR[i].codLoc < minimo.codLoc) or (vR[i].codCepa = minimo.codLoc) and (vR[i].codLoc < minimo.codCepa) then begin
                minimo:= vR[i];
                pos:= i;
            end;
        end;
        if(minimo.codLoc <> valorAlto) then leer(vD[pos], vR[pos]);
    end;

    procedure cerrarDetalles(var vD: vectorDetalle);
    var
        i: integer;
    begin
        for i:= 1 to 10 do
            close(vD[i]);
    end;

    procedure procesarDatos(var maestro: archMaestro; var vD: vectorDetalle; var vR: vectorRegistro; var cant50LocAct: integer);
    var
        codLocActual, codCepaActual: integer;
        minimo: casoD;
        c: casoM;
        codLocActualMae, cantCasosActMae: integer;
        cantCasosActActual: integer;
        cantActActual: integer;
        cantNuevosActual: integer;
        cantRecActual: integer;
        cantFallActual: integer;
    begin
        cargarDetalles(vD, vR);
        calcularMinimo(vD, vR, minimo);
        read(maestro, c);

        while(minimo.codLoc <> valorAlto) do begin
            codLocActual:= minimo.codLoc;
            cantCasosActActual:= 0;

            while(c.codLoc < codLocActual) do begin
                codLocActualMae:= c.codLoc;
                cantCasosActMae:= 0;
                while(codLocActualMae = c.codLoc) do begin
                    cantCasosActMae:= cantCasosActMae + c.cantAct;
                    read(maestro, c);
                end;
                if(cantCasosActMae > 50) then cant50LocAct:= cant50LocAct + 1;
            end;

            while(codLocActual = minimo.codLoc) do begin
                codCepaActual:= minimo.codCepa;
                cantActActual:= 0;
                cantNuevosActual:= 0;
                cantRecActual:= 0;
                cantFallActual:= 0;
                while(codLocActual = minimo.codLoc) and (codCepaActual = minimo.codCepa) do begin
                    cantActActual:= cantActActual + minimo.cantAct;
                    cantNuevosActual:= cantNuevosActual + minimo.cantNue;
                    cantRecActual:= cantRecActual + minimo.cantRec;
                    cantFallActual:= cantFallActual + minimo.cantFall;
                    calcularMinimo(vD, vR, minimo);
                end;

                while(c.codLoc <> codLocActual) or (c.codLoc = codLocActual) and (c.codCepa <> codCepaActual) do begin
                    read(maestro, c);
                
                c.cantFall:= c.cantFall + cantFallActual;
                c.cantRec:= c.cantRec + cantRecActual;
                c.cantAct:= cantActActual;
                c.cantNue:= cantNueActual;

                cantCasosActActual:= cantCasosActActual + c.cantAct;

                seek(maestro, filePos(maestro) - 1);
                write(maestro, c);

                if(not EOF(maestro)) then read(maestro, c);
            end;
            if(cantCasosActActual > 50) then cantLoc50Act:= cantLoc50Act + 1;
        end;
        while(c.codLoc = codLocActual) do begin
            cantCasosActActual:= cantCasosActActual + c.cantAct;
            if(not EOF(maestro)) then
                read(maestro, c)
            else
                c.codLoc:= valorAlto;
        end;
        if(cantCasosActActual > 50) then cantLoc50Act:= cantLoc50Act + 1;
        while(not EOF(maestro)) do begin
            codLocActual:= c.codLoc;
            cantCasosActActual:= 0;
            while(codLocActual = c.codLoc) do begin
                cantCasosActActual:= cantCasosActActual + c.cantAct;
                read(maestro, c);
            end;
            if(cantCasosActActual > 50) then cantLoc50Act:= cantLoc50Act + 1;
        end;
    end;

var
    maestro: archMaestro;
    vD: vectorDetalle;
    vR: vectorRegistro;
    cantLoc50Act: integer;
begin
    assign(maestro, 'arch_maestro');
    reset(maestro);
    cantLoc50Act:= 0;
    procesarDatos(maestro, vD, vR, cantLoc50Act);
    writeln('La cantidad de localidades con mas de 50 casos axtivos es de ', cantLoc50Act);
    close(maestro);
    cerrarDetalles(vD);
end.
