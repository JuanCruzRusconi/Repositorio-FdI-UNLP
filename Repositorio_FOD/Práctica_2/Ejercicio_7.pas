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
        cod: integer;
        ape: string[10];
        nombre: string[10];
        cursadas: integer;
        finales: integer;
    end;

    info = record
        cod: integer;
        materia: integer;
        fecha: integer;
        nota: integer;
    end;

    archMaestro = file of alumno;
    archInfo = file of info;

    procedure leer(var archivo: archInfo; var i: info);
    begin
        if(not EOF(archivo)) then
            read(archivo, i)
        else
            i.cod:= valorAlto;
    end;

    procedure calcularMinimo(var cursada: archInfo; var c: info; var final: archInfo; var f: info; var minimo: info; var tipo: integer);
    begin
        if(c.cod < f.cod) or (c.cod = f.cod) and (c.materia <= f.materia) then begin
            minimo:= c;
            tipo:= 1;
             leer(cursada, c);
        end
        else begin
            minimo:= f;
            tipo:= 2;
            leer(final, f);
        end;
    end;

var
    a: alumno;
    c: info;
    f: info;
    minimo: info;
    codAlumActual: integer;
    maestro: archMaestro;
    cursada: archInfo;
    final: archInfo;
    cantCursadas: integer;
    cantFinales: integer;
    tipo: integer;
begin
    assign(maestro, 'archivo_maestro');
    reset(maestro);

    assign(cursada, 'archivo_cursada');
    reset(cursada);

    assign(final, 'archivo_final');
    reset(final);

    read(maestro, a);

    leer(cursada, c);
    leer(final, f);

    calcularMinimo(cursada, c, final, f, minimo, tipo);

    while(minimo.cod <> valorAlto) do begin
        codAlumActual:= minimo.cod;
        cantCursadas:= 0;
        cantFinales:= 0;
        while(codAlumActual = minimo.cod) do begin
            if(tipo = 1)
                if(minimo.nota >= 4) then cantCursadas := cantCursadas + 1;
            if(tipo = 2)
                if(minimo.nota >= 4) then cantFinales := cantFinales + 1;
            calcularMinimo(cursada, c, final, f, minimo, tipo);
        end;

        while(a.cod <> codAlumActual) do
            read(maestro, a);

        a.cursadas:= a.cursadas + cantCursadas;
        a.finales:= a.finales + cantFinales;
        seek(maestro, filePos(maestro) - 1);
        write(maestro, a);
        if(not eof(maestro)) then read(maestro, a);
    end;
    close(maestro);
    close(cursada);
    close(final);
end;