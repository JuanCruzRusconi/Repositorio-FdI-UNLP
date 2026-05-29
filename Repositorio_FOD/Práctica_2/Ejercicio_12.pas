La empresa de software ‘X’ posee un servidor web donde se encuentra alojado el sitio web de la
organización. En dicho servidor, se almacenan en un archivo todos los accesos que se realizan al sitio.
La información que se almacena en el archivo es la siguiente: año, mes, día, idUsuario y tiempo de
acceso al sitio de la organización. El archivo se encuentra ordenado por los siguientes criterios: año,
mes, día e idUsuario.
Se debe realizar un procedimiento que genere un informe en pantalla, para ello se indicará el año
calendario sobre el cual debe realizar el informe. El mismo debe respetar el formato mostrado a
continuación:
Año : ---
Mes:-- 1
día:-- 1
idUsuario 1 Tiempo Total de acceso en el dia 1 mes 1
--------
idUsuario N Tiempo total de acceso en el dia 1 mes 1
Tiempo total acceso dia 1 mes 1
-------------
día N
idUsuario 1 Tiempo Total de acceso en el dia N mes 1
--------
idUsuario N Tiempo total de acceso en el dia N mes 1
Tiempo total acceso dia N mes 1
Total tiempo de acceso mes 1
------
Mes 12
día 1
idUsuario 1 Tiempo Total de acceso en el dia 1 mes 12
--------
idUsuario N Tiempo total de acceso en el dia 1 mes 12
Tiempo total acceso dia 1 mes 12
-------------
día N
idUsuario 1 Tiempo Total de acceso en el dia N mes 12
--------
idUsuario N Tiempo total de acceso en el dia N mes 12
Tiempo total acceso dia N mes 12
Total tiempo de acceso mes 12
Total tiempo de acceso año
Se deberá tener en cuenta las siguientes aclaraciones:
● El año sobre el cual realizará el informe de accesos debe leerse desde el teclado.
● El año puede no existir en el archivo, en tal caso, debe informarse en pantalla “año no
encontrado”.
● Debe definir las estructuras de datos necesarias.
● El recorrido del archivo debe realizarse una única vez procesando sólo la información necesaria

Program ejercicio12;
const
    valorAlto = 9999;
type
    info = record
        año: integer; 
        mes: integer;
        día: integer;
        idUsuario: string[10];
        tiempoAcc: real;
    end;

    archivo = file of info;

    procedure leer(var arch: archivo; var i: info);
    begin
        if(not EOF(arch)) then
            read(arch, i)
        else
            i.ano = valorAlto;
    end;

var
    i: info;
    arch: archivo;
    anoActual: integer;
    mesActual: integer;
    diaActual: integer;
    idActual: string[10];
    tiempoTotUsu: real;
    tiempoTotDia: real;
    tiempoTotMes: real;
    tiempoTotAno: real;
    anoProcesar: integer;
begin
    assign(arch, 'archio_maestro');
    reset(arch);

    writeln('Ingrese e ano a procesar');
    readln(anoProcesar);

    leer(arch, i);

    while(i.ano <> anoProcesar) and (i.ano <> valorAlto) do
        leer(arch, i);
        
        if(i.ano = valorAlto) then writeln('Ano no enocntrado')
        else begin
            anoActual:= i.ano;
            writeln('Ano ', anoActual);
            tiempoTotAno:= 0;
            while(anoActual = i.ano) do begin
                mesActual:= i.mes;
                tiempoTotMes:= 0;
                writeln('Mes ', mesActual);
                while(anoActual = i.ano) and (mesActual = i.mes) do begin
                    diaActual:= i.dia;
                    tiempoTotDia:= 0;
                    writeln('Dia ', diaActual);
                    while(anoActual = i.ano) and (mesActual = i.mes) and (diaActual = i.dia) do begin
                        idActual:= i.idUsuario;
                        tiempoTotUsu:= 0;
                        while(anoActual = i.ano) and (mesActual = i.mes) and (diaActual = i.dia) and (idActual = i.idUsuario) do begin
                            tiempoTotUsu:= tiempoTotUsu + i.tiempoAcc;
                            leer(arch, i);
                        end;
                        writeln('IDUsuario ', idActual, ' tiempo total de acceso en el día ', diaActual, ' mes ', mesActual, ': ', tiempoTotUsu);
                        tiempoTotDia:= tiempoTotDia + tiempoTotUsu;
                    end;
                    writeln('Total tiempo de acceso en el dia ', diaActual, ' mes ', mesActual, ': ', tiempoTotDia);
                    tiempoTotMes:= tiempoTotMes + tiempoTotDia;
                end;
                writeln('Total tiempo de acceso en el mes ', mesActual, ': ', tiempoTotMes);
                tiempoTotAno:= tiempoTotAno + tiempoTotMes;
            end;
            writeln('Total tiempo de acceso en el ano ', anoActual, ': ', tiempoTotAno);
        end;
        close(arch);
end.