Se desea modelar la información de una ONG dedicada a la asistencia de personas con carencias
habitacionales. La ONG cuenta con un archivo maestro conteniendo información como se indica a
continuación: Código pcia, nombre provincia, código de localidad, nombre de localidad, #viviendas sin
luz, #viviendas sin gas, #viviendas de chapa, #viviendas sin agua, # viviendas sin sanitarios.
Mensualmente reciben detalles de las diferentes provincias indicando avances en las obras de ayuda en
la edificación y equipamientos de viviendas en cada provincia. La información de los detalles es la
siguiente: Código pcia, código localidad, #viviendas con luz, #viviendas construidas, #viviendas con
agua, #viviendas con gas, #entrega sanitarios.
Se debe realizar el procedimiento que permita actualizar el maestro con los detalles recibidos, se reciben
10 detalles. Todos los archivos están ordenados por código de provincia y código de localidad.
Para la actualización del archivo maestro, se debe proceder de la siguiente manera:
● Al valor de viviendas sin luz se le resta el valor recibido en el detalle.
● Idem para viviendas sin agua, sin gas y sin sanitarios.
● A las viviendas de chapa se le resta el valor recibido de viviendas construidas
La misma combinación de provincia y localidad aparecen a lo sumo una única vez.
Realice las declaraciones necesarias, el programa principal y los procedimientos que requiera para la
actualización solicitada e informe cantidad de localidades sin viviendas de chapa (las localidades pueden
o no haber sido actualizadas).

Program ejercicio15;
const
    valorAlto = 99999;
type
    info = record
        codProv: integer;
        nomProv: string[10];
        codLoc: integer;
        nomLoc: string[10];
        cantSinLuz: integer;
        cantSinGas: integer;
        cantSinChapa: integer;
        cantSinAgua: integer;
        cantSinSani: integer;
    end;
    archMaestro = file of info;

    det = record
        codProv: integer;
        codLoc: integer;
        cantConstru: integer;
        cantConLuz: integer;
        cantConGas: integer;
        cantConAgua: integer;
        cantEntrSani: integer;
    end;
    archDetalle = file of det;

    vectorDetalle = array[1..10] of archDetalle;
    vectorRegistro = array[1..10] of det;

    procedure leerD(var archivo: archDetalle; var d: det);
    begin
        if(not EOF(archivo)) then
            read(archivo, d)
        else
            d.codProv:= valorAlto;
    end;

    procedure leerM(var maestro: archMaestro; var i: info);
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
        for i := 1 to 10 do begin
            assign(vD[i], 'archivo_detalle'+i);
            reset(vD[i]);
            leerD(vD[i], vR[i]);
        end;
    end;

    procedure calcularMinimo(var vD: vectorDetalle; var vR: vectorRegistro; var minimo: det);
    var
        i, pos: integer;
    begin
        minimo.codProv:= valorAlto;
        minimo.codLoc:= valorAlto;
        for i := 1 to 10 do begin
            if(vR[i].codProv < minimo.codProv) or ((vR[i].codProv = minimo.codProv) and (vR[i].codLoc < minimo.codLoc)) then begin
                minimo:= vR[i];
                pos:= i;
            end;
        end;
        if(minimo.codProv <> valorAlto) then leerD(vD[pos], vR[pos]);
    end;

    procedure procesarDatos(var maestro: archMaestro; var vD: vectorDetalle; var vR: vectorRegistro; var cantLocSinChapa: integer);
    var
        i: info;
        minimo: det;
        actualProv, actualLoc: integer;
    begin
        cargarDetalles(vD, vR);
        calcularMinimo(vD, vR, minimo);

        leerM(maestro, i);

        cantLocSinChapa:= 0;

        while(minimo.codProv <> valorAlto) do begin
            actualProv:= minimo.codProv;
            actualLoc:= minimo.codLoc;
            
            while(i.codProv <> actualProv) or ((i.codProv = actualProv) and (i.codLoc <> actualLoc)) do begin
                if(i.cantSinChapa = 0) then cantLocSinChapa:= cantLocSinChapa + 1;
                leerM(maestro, i);
            end;

            i.cantSinLuz:= i.cantSinLuz - minimo.cantConLuz;
            i.cantSinAgua:= i.cantSinAgua - minimo.cantConAgua;
            i.cantSinGas:= i.cantSinGas - minimo.cantConGas;
            i.cantSinSani:= i.cantSinSani - minimo.cantEntrSani;
            i.cantSinChapa:= i.cantSinChapa - minimo.cantConstru;

            if(i.cantSinChapa = 0) then cantLocSinChapa:= cantLocSinChapa + 1;

            seek(maestro, filePos(maestro) - 1);
            write(maestro, i);

            calcularMinimo(vD, vR, minimo);
            
            leerM(maestro, i);
        end;
        while(i.codProv <> valorAlto) do begin
            if(i.cantSinChapa = 0) then cantLocSinChapa:= cantLocSinChapa + 1;
            leerM(maestro, i);
        end;
    end;

    procedure cerrarDetalles(var vD: vectorDetalle);
    var
        i: integer;
    begin
        for i:= 1 to 10 do
            close(vD[i]);
    end;

var
    maestro: archMaestro;
    vD: vectorDetalle;
    vR: vectorRegistro;
    cantLocSinChapa: integer;
begin
    assign(maestro, 'archivo_maestro');
    reset(maestro);

    procesarDatos(maestro, vD, vR, cantLocSinChapa);
    writeln('La cantidad de localidades sin chapa es de ', cantLocSinChapa);

    close(maestro);
    cerrarDetalles(vD);
end;