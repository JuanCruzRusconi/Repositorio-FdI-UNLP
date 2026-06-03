A partir de un siniestro ocurrido se perdieron las actas de nacimiento y fallecimientos de toda la
provincia de buenos aires de los últimos diez años. En pos de recuperar dicha información, se deberá
procesar 2 archivos por cada una de las 50 delegaciones distribuidas en la provincia, un archivo de
nacimientos y otro de fallecimientos y crear el archivo maestro reuniendo dicha información.
Los archivos detalles con nacimientos, contendrán la siguiente información: nro partida nacimiento,
nombre, apellido, dirección detallada (calle, nro, piso, depto, ciudad), matrícula del médico, nombre y
apellido de la madre, DNI madre, nombre y apellido del padre, DNI del padre.

En cambio, los 50 archivos de fallecimientos tendrán: nro partida nacimiento, DNI, nombre y apellido del
fallecido, matrícula del médico que firma el deceso, fecha y hora del deceso y lugar.

Realizar un programa que cree el archivo maestro a partir de toda la información de los archivos
detalles. Se debe almacenar en el maestro: nro partida nacimiento, nombre, apellido, dirección detallada
(calle, nro, piso, depto, ciudad), matrícula del médico, nombre y apellido de la madre, DNI madre,
nombre y apellido del padre, DNI del padre y si falleció, además matrícula del médico que firma el
deceso, fecha y hora del deceso y lugar. 

Se deberá, además, listar en un archivo de texto la información recolectada de cada persona.
Nota: Todos los archivos están ordenados por nro partida de nacimiento que es única. Tenga en cuenta
que no necesariamente va a fallecer en el distrito donde nació la persona y además puede no haber
fallecido.

Program ejercicio19;

const
    valorAlto = 9999;
type
    direccion = record
        calle: string[10];
        nro: integer;
        piso: integer;
        depto: integer;
        ciudad: string[20];
    end;

    nacimiento = record
        nroPart: integer;
        nombre: string[10];
        apellido: string[10];
        direc: direccion;
        matriMed: integer;
        nomMad: string[10];
        dniMad: integer;
        nomPad: string[10];
        dniPad: integer;
    end;
    archNacimiento = file of nacimiento;

    fallecimiento = record
        nroPart: integer;
        dni: integer;
        nombre: string[10];
        apellido: string[10];
        matriMed: integer;
        fecha: integer;
        hora: integer;
        lugar: string[20];
    end;
    archFallecimiento = file of fallecimiento;

    registro = record
        nroPart: integer;
        nombre: string[10];
        apellido: string[10];
        direc: direccion;
        matriMed: integer;
        nomMad: string[10];
        dniMad: integer;
        nomPad: string[10];
        dniPad: integer;
        falleció: boolean;
        matriMedDec: integer;
        fecha: integer;
        hora: integer;
        lugar: string[20];
    end;

    vectorNaci = array[1..50] of archNacimiento;
    vectorRegNaci = array[1..50] of nacimiento;
    vectorFalle = array[1..50] of archFallecimiento;
    vectorRegFalle = array[1..50] of fallecimiento;

    archMaestro = file of registro;

    procedure leerNac(var archivo: archNacimiento; var n: nacimiento);
    begin
        if(not EOF(archivo)) then
            read(archivo, n)
        else
            n.nroPart:= valorAlto;
    end;

    procedure leerFall(var archivo: archFallecimiento; var f: fallecimiento);
    begin
        if(not EOF(archivo)) then
            read(archivo, f)
        else
            f.nroPart:= valorAlto;
    end;

    procedure cargarDetalles(var vN: vectorNaci; var vF: vectorFalle; var vRN: vectorRegNaci; var vRF: vectorRegFalle);
    var
        i: integer;
    begin
        for i:= 1 to 50 do begin
            assign(vN[i], 'archivo_nacimiento'+i);
            assign(vF[i], 'archivo_fallecimiento'+i);
            reset(vN[i]);
            reset(vF[i]);
            leerNac(vN[i], vRN[i]);
            leerFall(vF[i], vRF[i]);
        end;
    end;

    procedure calcularMinimoNac(var vN: vectorNaci; var vRN: vectorRegNaci; var minimoN: nacimiento);
    var
        i, pos: integer;
    begin
        minimoN.nroPart:= valorAlto;
        for i:= 1 to 50 do begin
            if(vRN[i].nroPart < minimoN.nroPart) then begin
                minimoN:= vRN[i];
                pos:= i;
            end;
        end;
        if(minimo.nroPart <> valorAlto) then leerNac(vN[pos], vRN[pos]);
    end;

    procedure calcularMinimoFall(var vF: vectorFalle; var vRF: vectorRegFalle; var minimoF: fallecimiento);
    var
        i, pos: integer;
    begin
        minimoF.nroPart:= valorAlto;
        for i:= 1 to 50 do begin
            if(vRF[i].nroPart < minimoF.nroPart) then begin
                minimoF:= vRF[i];
                pos:= i;
            end;
        end;
        if(minimoF.nroPart <> valorAlto) then leerNac(vF[pos], vRF[pos]);
    end;

    procedure procesarDatos(var maestro: archMaestro; var texto: text; var vN: vectorNaci; var vF: vectorFalle; var vRN: vectorRegNaci; var vRF: vectorRegFalle);
    var
        minimoN: nacimiento;
        minimoF: fallecimiento;
        partMin: integer;
        r: registro
    begin
        calcularMinimoNac(vN, vRN, minimoN);
        calcularMinimoFall(vFN, vRF, minimoF);
        while(minimoN.nroPart <> valorAlto) do begin
            r.nroPart:= minimoN.nroPart;
                r.nombre:= minimoN.nombre;
                r.apellido:= minimoN.apellido;
                r.direc.calle:= minimoN.direc.calle;
                r.direc.nro:= minimoN.direc.nro;
                r.direc.piso:= minimoN.direc.piso;
                r.direc.depto:= minimoN.direc.depto;
                r.direc.ciudad:= minimoN.direc.ciudad; 
                r.matriMed:= minimoN.matriMed;
                r.nomMad:= minimoN.nomMad;
                r.dniMad:= minimoN.dniMad;
                r.nomPad:= minimoN.nomPad;
                r.dniPad:= minimoN.dniPad;

                if(minimoN.nroPart = minimoF.nroPart) then begin
                    r.falleció:= true;
                    r.matriMedDec:= minimoF.matriMed;
                    r.fecha:= minimoF.fecha;
                    r.hora:= minimoF.hora;
                    r.lugar:= minimoF.lugar;
                    calcularMinimoFall(vFN, vRF, minimoF);
                end else
                    r.fallecio:= false;

                calcularMinimoNac(vFN, vRF, minimoF);
                write(maestro, r);
                writeln(texto, minimoN.nroPart, ' ', minimoN.nombre, ' '...);
            end;   
        end;    
    end;

    procedure cerrarDetallesNac(var vN: vectorNaci);
    var
        i: integer;
    begin
        for i:= 1 to 50 do
            close(vN[i]);
    end;

    procedure cerrarDetallesFall(var vF: vectorFalle);
    var
        i: integer;
    begin
        for i:= 1 to 50 do
            close(vF[i]);
    end;

var
    vN: vectorNaci;
    vRN: vectorRegNaci;
    vF: vectorFalle;
    vRF: vectorRegFalle;
    maestro: archMaestro;
    texto: text;
begin
    assign(maestro, 'archivo_maestro');
    rewrite(maestro);

    assign(texto, 'archivo_texto');
    rewrite(texto);

    cargarDetalles(vN, vF, vRN, vRF);

    procesarDatos(maestro, texto, vN, vF, vRN, vRF);

    close(maestro);
    cerrarDetallesNac(vN);
    cerrarDetallesFall(vF);
end;

