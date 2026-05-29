Se tiene información en un archivo de las horas extras realizadas por los empleados de una empresa en
un mes. Para cada empleado se tiene la siguiente información: departamento, división, número de
empleado, categoría y cantidad de horas extras realizadas por el empleado. Se sabe que el archivo se
encuentra ordenado por departamento, luego por división y, por último, por número de empleado.
Presentar en pantalla un listado con el siguiente formato:
Departamento
División
Número de Empleado Total de Hs. Importe a cobrar
...... .......... .........
...... .......... .........
Total de horas división: ____
Monto total por división: ____
División
.................
Total horas departamento: ____
Monto total departamento: ____
Para obtener el valor de la hora se debe cargar un arreglo desde un archivo de texto al iniciar el
programa con el valor de la hora extra para cada categoría. La categoría varía de 1 a 15. En el
archivo de texto debe haber una línea para cada categoría con el número de categoría y el valor de la
hora, pero el arreglo debe ser de valores de horas, con la posición del valor coincidente con el
número de categoría.

Program ejercicio11;
const
    valorAlto = 9999;
type
    categoria = 1..15;
    empleado = record
        depto: integer;
        divi: integer;
        numEmp: integer;
        cate: categoria;
        cantHoras: real;
    end;
    archMaestro = file of empleado;

    vectorValorHora = array[categoria] of real;

    valor = record
        cate: categoria;
        monto: real;
    end;
    archTexto = text;

    procedure cargarVectorHora(var texto: archTexto; var vVH: vectorValorHora);
    var
        i: categoria;
        v: valor;
    begin
        for i:= 1 to 15 do begin
            readln(texto, v.cate, v.monto);
            vVH[v.cate]:= v.monto;
        end
    end;

    procedure leer(var maestro: archMaestro; var e: empleado);
    begin
        if(not EOF(maestro)) do
            read(maestro, e)
        else
            e.depto:= valorAlto;
    end;

    procedure procesarDatos(var maestro: archMaestro; var vVH: vectorValorHora);
    var
        e: empleado;
        deptoActual, divActual, empActual: integer;
        deptoActualMonto, deptoActualHoras, divActualMonto, divActualHoras, empActualMonto, empActualHoras: real;
    begin
        leer(maestro, e);
        while(e.depto <> valorAlto) do begin
            deptoActual:= e.depto;
            deptoActualMonto:= 0;
            deptoActualHoras:= 0;
            writeln('Departamento ', deptoActual);
            while(deptoActual = e.depto) do begin
                divActual:= e.divi;
                divActualMonto:= 0;
                divActualHoras:= 0;
                writeln('Division ', divActual);
                while(deptoActual = e.depto) and (divActual = e.divi) do begin
                    empActual:= e.numEmp;
                    empActualMonto:= 0;
                    empActualHoras:= 0;
                    while(deptoActual = e.depto) and (divActual = e.divi) and (empActual = e.numEmp) do begin
                        empActualHoras:= empActualHoras + e.cantHoras;
                        empActualMonto:= empActualMonto + (vVH[e.cate] * e.cantHoras);
                        leer(maestro, e);
                    end;
                    writeln('Numero de empleado ', empActual, ', Total de Hs ', empActualHoras, ', Importe a cobrar ', empActualMonto);
                    divActualMonto:= divActualMonto + empActualMonto;
                    divActualHoras:= divActualHoras + empActualHoras;
                end;
                writeln('Total de horas división ', divActualHoras);
                writeln('Monto total división ', divActualMonto);
                deptoActualMonto:= deptoActualMonto + divActualMonto;
                deptoActualHoras:= deptoActualHoras + divActualHoras;
            end;
            writeln('Total de horas departamento ', deptoActualHoras);
            writeln('Monto total departamento ', deptoActualMonto);
        end;
    end;

var
    maestro: archMaestro;
    texto: archTexto;
    vVH: vectorValorHora;
begin
    assign(maestro, 'archivo_maestro');
    reset(maestro);
    assign(texto, 'archivo_texto.txt');
    reset(texto);
    cargarVectorHora(texto, vVH);
    procesarDatos(maestro, vVH);
    close(texto);
    close(maestro);
end;