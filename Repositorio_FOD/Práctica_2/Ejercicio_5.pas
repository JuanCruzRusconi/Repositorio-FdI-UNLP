Suponga que trabaja en una oficina donde se encuentra instalada una red local (LAN). La misma está
conformada por 5 máquinas conectadas entre sí y a un servidor central.
Semanalmente, cada máquina genera un archivo detalle de logs que registra las sesiones abiertas por los
usuarios en cada terminal, junto con su duración. Cada archivo contiene los siguientes campos: código de
usuario, fecha y tiempo de sesión.
Se solicita desarrollar un procedimiento que reciba los archivos detalle y genere un archivo maestro con la
siguiente información: código de usuario, fecha y tiempo total de sesiones abiertas.
Notas:
● Cada archivo detalle está ordenado por código de usuario y fecha.
● Un usuario puede iniciar más de una sesión el mismo día, ya sea en la misma máquina o en
diferentes máquinas.
● El archivo maestro debe crearse en la siguiente ubicación física: /var/log.

Program ejercicio5;

const 
    valorAlto = 9999;
type
    sesion = record
        cod: integer;
        fecha: integer;
        tiempo: integer;
    end;
     
    archDetalle = file of sesion;
    archMaestro = file of sesion;

    vectorDetalle = array[1..5] of archDetalle;
    vectorSesion = array[1..5] of sesion;

    procedure leer(var detalle: archDetalle; var s: sesion);
    begin
        if(not EOF(detalle)) then
            read(detalle, s)
        else
            s.cod := valorAlto;
    end;

    procedure cargarDetalles(var vD: vectorDetalle; var vS: vectorSesion);
    var
        i: integer;
    begin
        for i:= 1 to 5 do begin
            assign(vD[i], 'archivo_detalle');
            reset(vD[i]);
            leer(vD[i], vS[i]);
        end;
    end;

    procedure calcularMinimo(var vD: vectorDetalle; var vS: vectorSesion; var minimo: sesion);
    var
        i, pos: integer;
    begin
        minimo.cod:= valorAlto;
        minimo.fecha:= valorAlto;
        for i:= 1 to 5 do begin
            if(vS[i].cod < minimo.cod) or
                (vS[i].cod = minimo.cod) and (vS[i].fecha < minimo.fecha) then begin
                    minimo := vS[i];
                    pos:= i;
                end;
            end;
        end;
        if(minimo.cod <> valorAlto) then leer(vD[pos], vS[pos]);
    end;

    procedure cerrarDetalles(var vD: vectorDetalle);
    var
        i: integer;
    begin
        for i:= 1 to 5 do
            close(vD[i]);
    end;

var
    s: sesion;
    vD: vectorDetalle;
    vS: vectorSesion;
    maestro: archMaestro;
    codActual: integer;
    fechaActual: integer;
    cantActual: integer;
    minimo: sesion;
begin
    assign(maestro, '/var/log/archivo_maestro');
    rewrite(maestro);

    cargarDetalles(vD, vS);
    calcularMinimo(vD, vS, minimo);

    while(minimo.cod <> valorAlto) do begin
        codActual:= minimo.cod;

        while(codActual = minimo.cod) do begin
            fechaActual:= minimo.fecha;
            cantActual:= 0;
            while(codActual = minimo.cod) and (fechaActual = minimo.fecha) do begin
                cantActual:= cantActual + minimo.tiempo;
                calcularMinimo(vD, vS, minimo);
            end;
            s.cod:= codActual;
            s.fecha:= fechaActual;
            s.tiempo:= cantActual;
            write(maestro, s);
        end;
    end;
    close(maestro);
    cerrarDetalles(vD);
end.