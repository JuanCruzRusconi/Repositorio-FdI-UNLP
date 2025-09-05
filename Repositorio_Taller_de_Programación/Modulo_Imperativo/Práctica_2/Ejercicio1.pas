Escribir un programa que:
a. Implemente un módulo recursivo que genere y retorne una lista de números enteros
“random” en el rango 100-200. Finalizar con el número 100.
b. Un módulo recursivo que reciba la lista generada en a) e imprima los valores de la lista en el
mismo orden que están almacenados.
c. Implemente un módulo recursivo que reciba la lista generada en a) e imprima los valores de
la lista en orden inverso al que están almacenados.
d. Implemente un módulo recursivo que reciba la lista generada en a) y devuelva el mínimo
valor de la lista.
e. Implemente un módulo recursivo que reciba la lista generada en a) y un valor y devuelva
verdadero si dicho valor se encuentra en la lista o falso en caso contrario.

Program Ejercicio1;
type
    rangoNums = 100..200;

    lista = ^nodo;
    nodo = record
        elem: integer;
        sig: lista;
    end;

    procedure agregarAlFinal(var l: lista; num: integer);
    var
        nuevo, aux: lista;
    begin
        new(nuevo); nuevo^.elem:= num; nuevo^.sig:= nil;
        if(l = nil) then l:= nuevo
        else
        begin
            aux:= l;
            while(aux^.sig <> nil) do
                aux:= aux^.sig;
            aux^.sig:= nuevo;
        end;
    end;

    procedure generarListaRecursiva(var l: lista);
    var
        num: integer;
    begin
        //Randomize;
        //num:= 10 + Random(15 - 10 + 1);
        readln(num);
        if(num <> 15) then begin
            writeln('Numero generadp: ', num);
            agregarAlFinal(l, num);
            //num:= 10 + Random(15 - 10 + 1);
            readln(num);
            writeln('Numero generadp: ', num);
            generarListaRecursiva(l);
        end;
    end;

    procedure imprimirListaRecursiva(l: lista);
    begin
        if(l <> nil) then 
            begin
                imprimirListaRecursiva(l^.sig);
                 writeln('Numero imprezo: ', l^.elem);
            end
            else    
                writeln('Lista vacia');
    end;

var
    l: lista;
begin
    generarListaRecursiva(l);
    imprimirListaRecursiva(l);
end.