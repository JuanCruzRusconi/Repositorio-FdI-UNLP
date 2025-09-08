//Escribir un programa que:
//a. Implemente un módulo recursivo que genere y retorne una lista de números enteros
//“random” en el rango 100-200. Finalizar con el número 100.
//b. Un módulo recursivo que reciba la lista generada en a) e imprima los valores de la lista en el
//mismo orden que están almacenados.
//c. Implemente un módulo recursivo que reciba la lista generada en a) e imprima los valores de
//la lista en orden inverso al que están almacenados.
//d. Implemente un módulo recursivo que reciba la lista generada en a) y devuelva el mínimo
//valor de la lista.
//e. Implemente un módulo recursivo que reciba la lista generada en a) y un valor y devuelva
//verdadero si dicho valor se encuentra en la lista o falso en caso contrario.

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
        num: rangoNums;
    begin
        Randomize;
        num:= 100 + Random(110 - 100);
        if(num <> 100) then begin
            writeln('Numero generado: ', num);
            agregarAlFinal(l, num);
            generarListaRecursiva(l);
        end;
    end;

    procedure imprimirListaRecursiva(l: lista);
    begin
        if(l <> nil) then
            begin
                 writeln('Numero imprezo: ', l^.elem);
                 imprimirListaRecursiva(l^.sig);
            end;
    end;

    procedure imprimirListaRecursivaRevez(l: lista);
    begin
        if(l <> nil) then
            begin
                imprimirListaRecursivaRevez(l^.sig);
                writeln('Numero imprezo al revez: ', l^.elem);
            end;
    end;
   
    function devolverMinimo(l: lista; var minimo: integer): integer;
    begin
        if(l <> nil) then
            begin
                if(l^.elem < minimo) then minimo:= l^.elem;
                    devolverMinimo(l^.sig, minimo);
            end;
            devolverMinimo:= minimo;
    end;
   
    function encontrarValor(l: lista; var esta: boolean; valor: integer): boolean;
    begin
        if(l <> nil) and (esta = false) then
            begin
                if(l^.elem = valor) then esta:= true;
                    encontrarValor(l^.sig, esta, valor);
            end;
            encontrarValor:= esta;
    end;
   
var
    l: lista;
    minimo: integer;
    valor: integer;
    esta: boolean;
begin
    generarListaRecursiva(l);
    imprimirListaRecursiva(l);
    imprimirListaRecursivaRevez(l);
    minimo:= 201;
    minimo:= devolverMinimo(l, minimo);
    writeln('El numero minimo es: ', minimo);
    writeln('Ingrese un numero entre los valores 101 - 120');
    readln(valor);
    esta:= false;
    esta:= encontrarValor(l, esta, valor);
    writeln('El numero ingresado se encuentra dentro de la lista: ', esta);
end.