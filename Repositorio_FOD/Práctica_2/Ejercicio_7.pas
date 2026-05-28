Se dispone de un archivo maestro con información de los alumnos de la Facultad de Informática. Cada
registro del archivo maestro contiene: código de alumno, apellido, nombre, cantidad de cursadas
aprobadas y cantidad de materias con final aprobado. El archivo maestro está ordenado por código de
alumno.
Además, se dispone de dos archivos detalle con información sobre el desempeño académico de los
alumnos: un archivo de cursadas y un archivo de exámenes finales.
El archivo de cursadas contiene información sobre las materias cursadas por los alumnos. Cada registro
incluye: código de alumno, código de materia, año de cursada y resultado (solo interesa determinar si la
cursada fue aprobada o desaprobada).
Por su parte, el archivo de exámenes finales contiene información sobre los exámenes rendidos. Cada
registro incluye: código de alumno, código de materia, fecha del examen y nota obtenida.

Ambos archivos detalle están ordenados por código de alumno y código de materia, y pueden contener
cero, uno o más registros por alumno.
Un alumno puede cursar una misma materia varias veces, así como también rendir el examen final en
múltiples ocasiones.
Se solicita desarrollar un programa que actualice el archivo maestro, modificando la cantidad de cursadas
aprobadas y la cantidad de materias con final aprobado, a partir de la información contenida en los archivos
detalle.
Las reglas de actualización son las siguientes:
● Si un alumno aprueba una cursada, se incrementa en uno la cantidad de cursadas aprobadas.
● Si un alumno aprueba un examen final (nota mayor o igual a 4), se incrementa en uno la cantidad de
materias con final aprobado.
Notas:
● Los archivos deben procesarse en un único recorrido.
● No es necesario verificar inconsistencias en la información de los archivos detalle. En particular, se
garantiza que un alumno no puede aprobar más de una vez la cursada de una misma materia. De
manera análoga, tampoco puede aprobar más de una vez el examen final de una misma materia.

Program ejercicio7;
const
    valorAlto = 9999;
type
    alumno = record
        codAlu: integer;
        apellido: string[10];
        nombre: string[10];
        cantCurApro: integer;
        cantFinApro: integer;
    end;
    archMaestro = file of alumno;

    cursada = record
        codAlu: integer;
        codMat: integer;
        ano: integer;
        resultado: boolean;
    end;

    final = record
        codAlu: integer;
        codMat: integer;
        fecha: integer;
        nota: integer;
    end;

    archCursada = file of cursada;
    archFinal = file of final;

    procedure leerC(var cursada: archCursada; var c: cursada);
    begin
        if(not EOF(cursada)) then 
            read(cursada, c)
        else
            c.codAlu:= valorAlto;
    end;

    procedure leerF(var final: archFinal; var f: final);
    begin
        if(not EOF(final)) then 
            read(final, f)
        else
            f.codAlu:= valorAlto;
    end;

    procedure calcularMinimos(var cursada: archCursada; var c: cursada; var minimoC: cursada; var final: archFinal; var f: final; var minimoF: final; var avanzar: integer);
    begin
        minimoC.codAlu:= valorAlto;
        minimoF.codAlu:= valorAlto;
        if((c.codAlu = f.codAlu) and (c.codMat = f.codMat)) then begin
            avanzar:= 0;
            minimoC:= c;
            minimoF:= f;
            leerC(cursada, c);
            leerF(final, f);
        end
        else if(c.codAlu < f.codAlu) or (c.codAlu = f.codAlu) and (c.codMat < f.codMat) then begin
            avanzar:= 1;
            minimoC:= c;
            leerC(cursada, c);
        end
        else begin
            avanzar:= 2;
            minimoF:= f;
            leerF(final, f);
        end;
    end;

    procedure procesarDatos(var maestro: archMaestro; var cursada: archCursada; var final: archFinal);
    var
        codAluActual, codMatActual: integer;
        a: alumno;
        c: cursada;
        f: final;
        minimoC: cursada;
        minimoF: final;
        avanzar: integer;
    begin
        read(maestro, a);
        leerC(cursada, c);
        leerF(final, f);

        calcularMinimos(cursada, c, minimoC, final, f, minimoF, avanzar);

        while(minimoC.codAlu <> valorAlto) or (minimoF.codAlu <> valorAlto) do begin
            if(avanzar = 0) then begin
                codAluActual:= minimoC.codAlu;
                
                while(a.codAlu <> codAluActual) do
                    read(maestro, a);

                if(minimoC.resultado = true) then begin
                    a.cantCurApro:= a.cantCurApro + 1;
                end;

                if(minimoF.nota >= 4) then begin
                    a.cantFinApro:= a.cantFinApro + 1;
                end;
            end
            else if(avanzar = 1) then begin
                codAluActual:= minimoC.codAlu;
                
                while(a.codAlu <> codAluActual) do
                    read(maestro, a);

                if(minimoC.resultado = true) then begin
                    a.cantCurApro:= a.cantCurApro + 1;
                end;
            end
            else begin
                codAluActual:= minimoF.codAlu;
                
                while(a.codAlu <> codAluActual) do
                    read(maestro, a);

                if(minimoF.nota >= 4) then begin
                    a.cantFinApro:= a.cantFinApro + 1;
                end;
            end;

            calcularMinimos(cursada, c, minimoC, final, f, minimoF, avanzar);

            seek(maestro, filePos(maestro) - 1);
            write(maestro, a);

            if(not EOF(maestro)) then read(maestro, a);
        end;
    end;

var
    maestro: archMaestro;
    cursada: archCursada;
    final: archFinal;
begin
    assign(maestro, 'archivo_maestro');
    reset(maestro);

    assign(cursada, 'archivo_cursada');
    reset(cursada);

    assign(final, 'archivo_final');
    reset(final);

    procesarDatos(maestro, cursada, final);

    close(maestro);
    close(cursada);
    close(final);
end;

