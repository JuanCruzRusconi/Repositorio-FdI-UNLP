El administrador de un edificio de oficinas tiene la información del pago de las expensas
de dichas oficinas. Implementar un programa con:
a) Un módulo que retorne un vector, sin orden, con a lo sumo las 300 oficinas que
administra. Se deben cargar, para cada oficina, el código de identificación, DNI del
propietario y valor de la expensa. La lectura finaliza cuando llega el código de
identificación 0.
b) Un módulo que reciba el vector retornado en a) y retorne dicho vector ordenado por
código de identificación de la oficina. Ordenar el vector aplicando uno de los métodos
vistos en la cursada.
c) Un módulo que realice una búsqueda dicotómica. Este módulo debe recibir el vector
generado en b) y un código de identificación de oficina. En caso de encontrarlo, debe
retornar la posición del vector donde se encuentra y en caso contrario debe retornar 0.
Luego el programa debe informar el DNI del propietario o un cartel indicando que no
se encontró la oficina.
d) Un módulo recursivo que retorne el monto total acumulado de las expensas.

Program Ejercicio1;
const
    maxOfi = 300;
type
    rangoOficinas = 1..maxOfi;
    expensa = record
        cod: integer;
        dni: integer;
        valor: real;
    end;

    vector = array[rangoOficinas] of expensa;

    procedure generarDatos(var e: expensa);
    begin
        readln(e.cod);
        if(e.cod <> 0) then begin
            readln(e.dni);
            readln(e.valor);
        end;
    end;

    procedure agregarAlVector(var v: vector; var dimL: integer; e: expensa);
    begin
        if(dimL < maxOfi) then begin
            dimL:= dimL + 1;
            v[dimL]:= e;
        end;
    end;

    procedure cargarDatos(var v: vector; var dimL: integer);
    var
        e: expensa;
    begin
        generarDatos(e);
        while(e.cod <> 0) and (dimL < maxOfi) do begin
            writeln('Codigo: ', e.cod);
            agregarAlVector(v, dimL, e);
            generarDatos(e);
        end;
    end;

    procedure imprimirVector(v: vector; dimL: integer);
    var
        i: integer;
    begin
        for i:= 1 to dimL do
            begin
                writeln('Oficina: ', i);
                writeln('Codigo', v[i].cod);
                writeln('Dani', v[i].dni);
                writeln('Valor', v[i].valor);
            end;
    end;

    procedure ordenarVector(var v: vector; dimL: integer);
    var
        i, j, pos: integer;
        item: expensa;
    begin
        for i: 1 to dimL-1 do begin
            pos:= i;
            for j:= i+1 to dimL do
                if(v[j] > v[i]) then pos:= j;
            item:= v[pos];
            v[pos]:= v[i];
            v[i]:= item;
        end;
    end;

    procedure montoTotalExpensa(v: vector; dimL: integer; var montoTotal);
    var

    begin
        if(dimL > 0) then begin
            montoTotal:= montoTotal + v[dimL];
            montoTotalExpensa(v, dimL-1, montoTotal);
        end;
    end;

var
    v: vector;
    dimL: integer;
begin
    Randomize;
    dimL:= 0;
    cargarDatos(v, dimL);
    imprimirVector(v, dimL);
    montoTotal:= 0;
    montoTotalExpensa(v, dimL);
end.