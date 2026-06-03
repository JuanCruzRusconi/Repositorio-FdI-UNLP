Se cuenta con un archivo con información de los casos de COVID-19 registrados en los diferentes hospitales
de la Provincia de Buenos Aires cada día. Dicho archivo contiene: código de localidad, nombre de localidad,
código de municipio, nombre de municipio, código de hospital, nombre de hospital, fecha y cantidad de casos
positivos detectados. El archivo está ordenado por localidad, luego por municipio y luego por hospital.
Escriba la definición de las estructuras de datos necesarias y un procedimiento que haga un listado con el
siguiente formato:
Nombre: Localidad 1
Nombre: Municipio 1
Nombre Hospital 1……………..Cantidad de casos Hospital 1
……………………..
Nombre Hospital N…………….Cantidad de casos Hospital N
Cantidad de casos Municipio 1
…………………………………………………………………….
Nombre Municipio N
Nombre Hospital 1……………..Cantidad de casos Hospital 1
……………………..
Nombre Hospital N…………….Cantidad de casos Hospital N
Cantidad de casos Municipio N
Cantidad de casos Localidad 1
-----------------------------------------------------------------------------------------
Nombre Localidad N
Nombre Municipio 1
Nombre Hospital 1……………..Cantidad de casos Hospital 1
……………………..
Nombre Hospital N…………….Cantidad de casos Hospital N
Cantidad de casos Municipio 1
…………………………………………………………………….
Nombre Municipio N
Nombre Hospital 1……………..Cantidad de casos Hospital 1
……………………..
Nombre Hospital N…………….Cantidad de casos Hospital N
Cantidad de casos Municipio N
Cantidad de casos Localidad N
Cantidad de casos Totales en la Provincia
Además del informe en pantalla anterior, es necesario exportar a un archivo de texto la siguiente información:
nombre de localidad, nombre de municipio y cantidad de casos del municipio, para aquellos municipios cuya
cantidad de casos supere los 1500. El formato del archivo de texto deberá ser el adecuado para recuperar la
información con la menor cantidad de lecturas posibles.
NOTA: El archivo debe recorrerse solo una vez.

Program ejercicio18;
const
    valorAlto = 9999;
type
    caso = record
        codLoc: integer;
        nomLoc: string[10];
        codMun: integer;
        nomMun: string[10];
        codHos: integer;
        nomHos: string[10];
        fecha: integer;
        cantCasos: integer;
    end;
    archMaestro = file of caso;

    procedure leer(var archivo: archMaestro; var c: caso);
    begin
        if(not EOF(archivo)) then
            read(archivo, c)
        else
            c.codLoc:= valorAlto;
    end;

    procedure procesarDatos(var archivo: archMaestro; var texto: text);
    var
        c: caso;
        locActual, munActual, hosActual: integer;
        casosLoc, casosMun, casosHos: integer;
        nomLocActual, nomMunActual, nomHosActual: string[10];
        casosTotProv: integer;
    begin
        leer(archivo, c);
        casosTotProv:= 0;
        while(c.codLoc <> valorAlto) do begin
            locActual:= c.codLoc;
            nomLocActual:= c.nomLoc;
            casosLoc:= 0;
            writeln('Nombre: Localidad: ', locActual, ' ', c.nomLoc);
            while(locActual = c.codLoc) do begin
                munActual:= c.codMun;
                nomMunActual:= c.nomMun;
                casosMun:= 0;
                writeln('Nombre Municipio: ', munActual, ' ', c.nomMun);
                while(locActual = c.codLoc) and (munActual = c.codMun) do begin
                    hosActual:= c.codHos;
                    nomHosActual:= c.nomHos;
                    casosHos:= 0;
                    while(locActual = c.codLoc) and (munActual = c.codMun) and (hosActual = c.codHos) do begin
                        casosHos:= casosHos + c.cantCasos;
                        leer(archivo, c);
                    end;
                    writeln('Nombre Hospital: ', hosActual, ' ', nomHosActual, ', cantidad de casos: ', casosHos);
                    casosMun:= casosMun + casosHos;
                end;
                if(casosMun > 1500) then
                    writeln(texto, nomLocActual, ' ', nomMunActual, ' ', casosMun);
                writeln('Cantidad de casos Municipio', munActual, ': ', casosMun);
                casosLoc:= casosLoc + casosMun;
            end;
            writeln('Cantidad de casos Localidad', locActual, ': ', casosLoc);
            casosTotProv:= casosTotProv + casosLoc;
        end;
        writeln('El total de casos de la provincia es: ', casosTotProv);
    end;
    
var
    maestro: archMaestro;
    texto: text;
begin
    assign(maestro, 'archivo_maestro');
    reset(maestro);

    assign(texto, 'archivo_texto');
    rewrite(texto);

    procesarDatos(maestro, texto);

    close(maestro);
    close(texto);
end.