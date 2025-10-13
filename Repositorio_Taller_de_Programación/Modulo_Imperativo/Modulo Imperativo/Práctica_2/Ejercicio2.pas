1.- Implementar un programa que invoque a los siguientes m�dulos.
a. Un m�dulo recursivo que retorne un vector de a lo sumo 15 n�meros enteros �random� mayores a 10 y menores a 155 
(incluidos ambos). La carga finaliza con 
el valor 20.
b. Un m�dulo no recursivo que reciba el vector generado en a) e imprima el contenido del vector.
c. Un m�dulo recursivo que reciba el vector generado en a) e imprima el contenido del vector.
d. Un m�dulo recursivo que reciba el vector generado en a) y devuelva la suma de los valores pares contenidos en el vector.
e. Un m�dulo recursivo que reciba el vector generado en a) y devuelva el m�ximo valor del vector.
f. Un m�dulo recursivo que reciba el vector generado en a) y un valor y devuelva verdadero si dicho valor se encuentra en 
el vector o falso en caso contrario.
g. Un m�dulo que reciba el vector generado en a) e imprima, para cada n�mero contenido en el vector, sus d�gitos en el 
orden en que aparecen en el n�mero. 
Debe implementarse un m�dulo recursivo que reciba el n�mero e imprima lo pedido. Ejemplo si se lee el valor 142, se debe 
imprimir 1  4  2

Program Ejercicio;
const 
    dimF = 20;
type
    rangoNumeros = 10..155;

    vector = array[1..dimF] of rangoNumeros;

    procedure cargarVector(var v: vector; var dimL: integer);
    var
        num: integer;
    begin
        num:= 10 + Random(155 - 10);
        if(dimL < dimF) and (num <> 20) then 
            begin
                writeln('Numero cargado es: ', num);
                dimL:= dimL + 1;
                v[dimL]:= num;
                cargarVector(v, dimL);
            end;
    end;

    procedure imprimirVector(v: vector; dimL: integer);
    var
        i: integer;
    begin
        for i:= 1 to dimL do
            writeln('El numero en la posicion: ', i, ' es: ', v[i]);
    end;

    procedure imprimirVectorRecursivo(v: vector; dimL: integer);
    begin
        if(dimL > 0) then
            begin
                writeln('Numero posicion: ', dimL, ' es: ', v[dimL]);
                imprimirVectorRecursivo(v, dimL - 1);
            end;
    end;

    function sumaRecursiva(v: vector; dimL, pos: integer): integer;
    begin
        if(pos <= dimL) then
            begin
                if(v[pos] MOD 2 = 0) then 
                    sumaRecursiva:= sumaRecursiva(v, dimL, pos + 1) + v[pos]
                else
                    sumaRecursiva:= sumaRecursiva(v, dimL, pos + 1);
            end
        else
            sumaRecursiva:= 0;
    end;

    function sumaValoresPar(v: vector; dimL: integer): integer;
    var
        pos, total: integer;
    begin
        pos:= 1;
        total:= 0;
        total:= sumaRecursiva(v, dimL, pos);
        sumaValoresPar:= total;
    end;

var
    v: vector;
    dimL, total: integer;
begin
    Randomize;
    dimL:= 0;
    cargarVector(v, dimL);
    imprimirVector(v, dimL);
    imprimirVectorRecursivo(v, dimL);
    total:= sumaValoresPar(v, dimL);
    writeln('El total es: ', total);
    
end.



procedure imprimirVectorRecursivo(v: vector; dimL: integer; var max: integer);
    begin
        if(dimL > 0) then
            begin
                if(v[dimL] > max) then max:= v[dimL];
                imprimirVectorRecursivo(v, dimL - 1);
            end;
    end;