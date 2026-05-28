Se necesita contabilizar los votos de las diferentes mesas electorales registradas por provincia y
localidad. Para ello, se posee un archivo con la siguiente información: código de provincia, código de
localidad, número de mesa y cantidad de votos en dicha mesa. Presentar en pantalla un listado como se
muestra a continuación:
Código de Provincia
Código de Localidad Total de Votos
................................ ......................
................................ ......................
Total de Votos Provincia: ____
Código de Provincia
Código de Localidad Total de Votos
................................ ......................
Total de Votos Provincia: ___
…………………………………………………………..
Total General de Votos: ___
NOTA: La información está ordenada por código de provincia y código de localidad.

Program ejercicio10;
const
    valorAlto = 9999;
type
    mesa = record
        codProv: integer;
        codLoc: integer;
        numMesa integer;
        cantVotos: integer;
    end;
    archMesa = file of mesa;

    procedure leer(var archivo: archMesa; var m: mesa);
    begin
        if(not EOF(archivo)) then
            read(archivo, m)
        else
            m.codProv:= valorAlto;
    end;

    procedure procesarDatos(var archivo: archMesa);
    var
        m: mesa;
        provActual, cantProv: integer;
        locActual, cantLoc: integer;
        totalGenVotos: integer;
    begin
        totalGenVotos:= 0;
        leer(archivo, m);
        while(m.codProv <> valorAlto) do begin
            provActual:= m.codProv;
            cantProv:= 0;
            writeln('Codigo de provincia ', provActual);
            while(provActual = m.codProv) do begin
                locActual:= m.codLoc;
                cantLoc:= 0;
                while(provActual = m.codProv) and (locActual = m.codLoc) do begin
                    cantLoc:= cantLoc + m.cantVotos;
                    leer(archivo, m);
                end;
                writeln('Codigo de localidad ', locActual, ' total de votos ', cantLoc);
                cantProv:= cantProv + cantLoc;
            end;
            writeln('Total de votos provincia ', cantProv);
            totalGenVotos:= totalGenVotos + cantProv;
        end;
        writeln('Total general de votos ', totalGenVotos);
    end;

var
    archivo: archMesa;
begin
    assign(archivo, 'archivo_mesa');
    reset(archivo);
    procesarDatos(archivo);
    close(archivo);
end;