Suponga que usted es administrador de un servidor de correo electrónico. En los logs del mismo
(información guardada acerca de los movimientos que ocurren en el server) que se encuentra en la
siguiente ruta: /var/log/logmail.dat se guarda la siguiente información: nro_usuario, nombreUsuario,
nombre, apellido, cantidadMailEnviados. Diariamente el servidor de correo genera un archivo con la
siguiente información: nro_usuario, cuentaDestino, cuerpoMensaje. Este archivo representa todos los
correos enviados por los usuarios en un día determinado. Ambos archivos están ordenados por
nro_usuario y se sabe que un usuario puede enviar cero, uno o más mails por día.
a. Realice el procedimiento necesario para actualizar la información del log en un día particular.
Defina las estructuras de datos que utilice su procedimiento.
b. Genere un archivo de texto que contenga el siguiente informe dado un archivo detalle de un
día determinado:
nro_usuarioX…………..cantidadMensajesEnviados
………….
nro_usuarioX+n………..cantidadMensajesEnviados
Nota: tener en cuenta que en el listado deberán aparecer todos los usuarios que existen en
el sistema. Considere la implementación de esta opción de las siguientes maneras:
i- Como un procedimiento separado del punto a).
ii- En el mismo procedimiento de actualización del punto a). Qué cambios se
requieren en el procedimiento del punto a) para realizar el informe en el mismo
recorrido?

program ejercicio13;
const 
    valorAlto = 9999;
type
    log = record
        nroUsu: integer;
        nomUsu: string[10];
        nom: string[10];
        ape: string[10];
        cantMail: integer;
    end;
    archMaestro = file of log;

    det = record
        nroUsu: integer;
        cuenDes: string[20];
        cuerMes: string[30];
    end;
    archDetalle = file of det;

    archTexto = text;

    procedure leerD(var detalle: archDetalle; var d: det);
    begin
        if(not EOF(detalle)) then
            read(detalle, d)
        else
            d.nroUsu:= valorAlto;
    end;

    procedure leerM(var maestro: archMaestro; var l: log);
    begin
        if(not EOF(maestro)) then
            read(maestro, l)
        else
            l.nroUsu:= valorAlto;
    end;

    procedure procesarDatos(var maestro: archMaestro; var detalle: archDetalle; var texto: archTexto);
    var
        l: log;
        d: det;
        usuActual, cantActual: integer;
    begin
        leerD(detalle, d);
        leerM(maestro, l);

        while(d.nroUsu <> valorAlto) do begin
            usuActual:= d.nroUsu;
            cantActual:= 0;

            while(l.nroUsu <> usuActual) do begin
                writeln(texto, l.nroUsu, ' ....... ', 0);
                leerM(maestro, l);
            end;

            while(usuActual = d.nroUsu) do begin
                cantActual:= cantActual + 1;
                leerD(detalle, d);
            end;

            l.cantMail:= l.cantMail + cantActual;
            seek(maestro, filePos(maestro) - 1);
            writeln(texto, usuActual, ' ....... ', 0);
            write(maestro, l);

            leerM(maestro, l);
        end;
        while(l.nroUsu <> valorAlto) do begin
            writeln(texto, l.nroUsu, ' ....... ', 0);
            leerM(maestro, l);
        end;
    end;

var
    maestro: archMaestro;
    detalle: archDetalle;
    texto: archTexto;
begin
    assign(maestro, 'archivo_maestro');
    reset(maestro);
    
    assign(detalle, 'archivo_detalle');
    reset(detalle);

    assign(texto, 'archivo_texto.txt');
    rewrite(texto);

    procesarDatos(maestro, detalle, texto);

    close(maestro);
    close(detalle);
    close(texto);
end;