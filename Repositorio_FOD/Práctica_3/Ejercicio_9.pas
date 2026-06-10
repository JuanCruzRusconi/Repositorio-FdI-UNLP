Se necesita contabilizar los votos de las diferentes mesas electorales registradas por localidad en la
provincia de Buenos Aires. Para ello, se posee un archivo con la siguiente información: código de
localidad, número de mesa y cantidad de votos en dicha mesa. Presentar en pantalla un listado
como se muestra a continuación:
Código de Localidad Total de Votos
................................ ......................
................................ ......................
Total General de Votos: ………………
NOTAS:
● La información en el archivo no está ordenada por ningún criterio.
● Trate de resolver el problema sin modificar el contenido del archivo dado.
● Puede utilizar una estructura auxiliar, como por ejemplo otro archivo, para llevar el control
de las localidades que han sido procesadas.

program ejercicio9;
const
    valorAlto = 9999;
type
    mesa = record
        codLoc: integer;
        num: integer;
        cant: integer;
    end;
    archivo = file of mesa;

    localidad = record
        codLoc: integer;
        cant: integer;
    end;
    archAux = file of localidad;

    procedure leerM(var arch: archivo; var m: mesa);
    begin
        if(not EOF(arch)) then
            read(arch, m)
        else
            m.codLoc:= valorAlto;
    end;

    procedure leerAux(var aux: archAux; var l: localidad);
    begin
        if(not EOF(aux)) then
            read(aux, l)
        else
            l.codLoc:= valorAlto;
    end;

    procedure agregarAuxiliar(var aux: archAux; loc: integer; cant: integer);
    var
        l: localidad
    begin
        seek(aux, 0);
        leerAux(aux, l);

        while(l.codLoc <> valorAlto) and (l.codLoc <> loc) do
            leerAux(aux, l);

        if(l.codLoc = loc) then begin
            l.cant:= l.cant + cant;
            seek(aux, filePos(aux) - 1);
            write(aux, l);
        end
        else begin
            l.codLoc:= loc;
            l.cant:= cant;
            write(aux, l);
        end;
    end;

    procedure procesarDatos(var arch: archivo; var aux: archAux; var total: integer);
    var
        m: mesa;
    begin
        reset(arch);
        rewrite(aux);
        leerM(arch, m);

        total:= 0;

        while(m.codLoc <> valorAlto) do begin
            total:= total + m.cant;
            agregarAuxiliar(aux, m.codLoc, m.cant);
            leerM(arch, m);
        end;
        close(arch);
        close(aux);
    end;

    procedure presentarListado(var aux: archAux; total: integer);
    var
        l: localidad;
    begin
        reset(aux);
        leerAux(aux, l);
        while(l.codLoc <> valorAlto) do begin
            writeln("Codigo de localidad ", l.codLoc, " total de votos: ", l.cant);
            leerAux(aux, l);
        end;
        writeln("Total general de votos: ", total);
        close(aux);
    end;
var
    arch: archivo;
    aux: archAux;
    total: integer;
begin
    assign(arch, 'archivo_mesa');
    assign(aux, 'archivo_auxiliar');
    procesarDatos(arch, aux, total);
    presentarListado(aux, total);
end.