Una empresa dispone de una estructura de datos con las ventas de su comercio. De cada venta se conoce número de venta, 
cantidad de productos y tipo de pago (efectivo o tarjeta). Se pide implementar un programa que genere una segunda 
estructura con las ventas cuya cantidad de productos tenga más dígitos pares que impares. En la estructura generada deben 
quedar almacenadas las ventas de tipo de pago efectivo antes que des tipo de pago con tarjeta.

Program empresa;

type
    venta = record  
        num: integer;
        cant: integer;
        tipo: string;
    end;
    listaVentas = ^nodo;
    nodo = record
        elem: venta;
        sig: listaVentas;
    end;

    procedure cargarDatos(var l: listaVentas) // se dispone

    function masPares(cant: integer): boolean
    var
        dig, pares, impares: integer;
    begin
        pares:= 0;
        impares:= 0;
        while(cant <> 0) do begin
            dig:= cant MOD 10;
            if(dig MOD 2 = 0) then pares:= pares + 1;
            else impares:= impares + 1;
            cant:= cant DIV 10;
        end;
        masPares:= (pares > impares;)
    end;

    procedure agregarAdelante(var lNue: listaVentas; v: venta)
    var 
        nuevo: listaVentas;
    begin
        new(nuevo); nuevo^.elem:= v; nuevo^.sig:= nil;
        if(lNue = nil) then lNue:= nuevo;
        else begin
            nuevo^.sig:= lNue;
            lNue:= nuevo;
        end;
    end;

    procedure agregarAtras(var lNue: listaVentas; v: venta)
    var
        nuevo, aux: listaVentas;
    begin
        new(nuevo); nuevo^.elem:= v; nuevo^.sig:= nil;
        if(lNue = nil) then lNue:= nuevo;
        else begin
            aux:= lNue;
            while(aux^.sig <> nil) do
                aux:= aux^.sig;
            aux^.sig:= nuevo;
        end;
    end;

    procedure procesarVentas(l: listaVentas; var l2: listaVentas)
    begin
        while(l <> nil) do begin
            if(masPares(l^.elem.cant)) then begin
                if(l^.elem.tipo = 'efectivo') then agregarAdelante(l2, l^.elem);
                else agregarAtras(l2, l^.elem);
            end;
            l:= l^.sig;
        end;
    end;

var
    l1, l2: listaVentas;
begin
    l1:= nil;
    cargarDatos(l1); // se dispone
    l2:= nil;
    procesarDatos(l1, l2);
end.