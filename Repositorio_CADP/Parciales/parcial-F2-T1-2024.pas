// Consigna Parcial Fecha 2 Tema 1 -2024
// Un supermercado está procesando las compras que realizaron sus clientes. Para ello, dispone de una estructura de datos con 
// todas las compras, sin ningún orden en particular. De cada compra se conoce código, mes, año (entre 2014 y 2024), monto y 
// el DNI del cliente. Un cliente puede haber realizado más de una compra.
// Realizar un programa lea de teclado un año y luego:
// a. Almacene en otra estructura de datos las compras realizadas en el año leído. Esta estructura debe
// quedar ordenada por DNI del cliente.
// b. Una vez almacenada la información, procese los datos del inciso a. e iniorme:
// 1. Para cada cliente, el monto total facturado entre todas sus compras.
// 2. Los dos meses con menor facturación.
// 3. COMPLETO: La cantidad de compras con código múltiplo de 10.

program Supermercado
const

type
    rangoMeses: 1..12;
    rangoAños: 2014..2024;

    compra = record
        cod: integer;
        mes: rangoMeses;
        año: rangoAños;
        monto: real;
        dni: integer;
    end;

    listaCompras = ^nodo
    nodo = record
        elem: compra;
        sig: listaCompras;
    end;

    vectorMeses = array[rangoMeses] of real;

    procedure cargarListaCompras( var l: listaCompras ) // se dispone

    procedure insertarNuevaLista( var l: listaCompras; c: compra )
    var
        anterior, actual, nuevo: listaCompras;
    begin
        new(nuevo); nuevo^.elem: c; nuevo^.sig: nil;
        if(l = nil) then l:= nuevo;
        else
            begin 
                anterior:= l; actual:= l;
                while(actual <> nil) and (actual^.elem.dni < nuevo^.elem.dni) do
                    begin
                        anterior:= actual;
                        actual:= actual^.sig;
                    end;
            end;
        if(actual = l) then
            begin
                nuevo^.sig:= l;
                l:= nuevo;
            end;
        else
            begin
                anterior^.sig:= nuevo;
                nuevo^.sig:= actual;
            end;
    end;

    procedure cargarListaComprasNueva( l: listaCompras; lN: listaCompras )
    var
        añoLeido: rangoAños;
    begin
        read(añoLeido);
        while(l <> nil) do
            begin
                if(l^.elem.año = añoLeido) then
                    begin
                        insertarNuevaLista(lN,l^.elem);
                    end;
                l:= l^.sig;
            end;
    end;

    procedure inicializarVector( var v: vectorMeses )
    var
        i: rangoMeses;
    begin
        for i:= 1 to 12 do 
            v[i]:= 0;
    end;

    function esMultiplo10( cod: integer ): boolean
    var
    begin
        if((cod MOD 10) = 0) then esMultiplo10:= true;
        else esMultiplo10:= false;
    end;

    procedure calcularMesesMinimos( v: vectorMeses; var mesMin1, mesMin2: rangoMeses )
    var
        i: rangoMeses; min1, min2: real;
    begin
        min1:= 99999;
        min2:= 99999;
        for i:= 1 to 12 do
            begin
                if(v[i] < min1) then
                    begin
                        min2:= min1;
                        mesMin2:= mesMin1;
                        min1:= v[i];
                        mesMin1:= i;
                    end;
                else
                    if(v[i] < min2) then
                        begin
                            min2:= v[i];
                            mesMin2:= i;
                        end;
            end;
    end;

    procedure procesarInformacion( l: listaCompras; var v: vectorMeses; var mesM1, mesM2: rangoMeses; var cantComp: integer )
    var 
        clienteActual: integer; montoActual: real; 
    begin
        inicializarVectorMeses(v);
        cantComp:= 0;
        while(l <> nil) do
            begin
                clienteActual:= l^.elem.dni;
                montoActual:= 0;
                while(l <> nil) and (l^.elem.dni = clienteActual) do
                    begin
                        montoActual:= montoActual + l^.elem.monto;
                        v[l^.elem.mes]:= v[l^.elem.mes] + l^.elem.monto;
                        if(esMultiplo10(l^.elem.cod)) then cantComp:= cantComp + 1;
                        l:= l^.sig;
                    end;
                write("El cliente: ", clienteActual, "el monto total facturado es: ", montoActual);
            end;
        calcularMesesMinimos(v, mesM1, mesM2);
    end;


var
    lC: listaCompras; lCNueva: listaCompras; vM: vectorMeses; mesMin1, mesMin2: rangoMeses; cantCompras10: integer;
begin
    lC:= nil;
    lCNueva:= nil;
    cargarListaCompras(lC); // se dispone
    cargarListaComprasNueva(lC, lCNueva);
    procesarInformacion(lCNueva, vM, mesMin1, mesMin2, cantCompras10);
    write("El mes con menor facturacion es: ", mesMin1, "y el segundo mes con menor facturacion es: ", mesMin2);
    write("La cantidad de compras con codigo multiplo de 10 es: ", cantCompras10);
end.


