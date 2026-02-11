Una empresa dispone de una estructura de datos con las ventas de su comercio. De cada venta se conoce número de venta, 
cantidad de productos y tipo de pago (efectivo o tarjeta). Se pide implementar un programa que genere una segunda 
estructura con las ventas cuya cantidad de productos tenga más dígitos pares que impares. En la estructura generada deben 
quedar almacenadas las ventas de tipo de pago efectivo antes que des tipo de pago con tarjeta.

Program comercio;
type
    venta = record
        numVenta: integer;
        cantProds: integer;
        tipoPago: string;
    end;

    listaVentas = ^nodo;

    nodo = record
        elem: venta;
        sig: listaVentas;
    end;

    procedure cargarLista (var lV: listaVentas) // se dispone

    function masPares (num: integer): boolean
    var
        dig, cantPos, cantNeg: integer;
    begin
        cantPos:= 0;
        cantNeg:= 0;
        while(num <> 0) do begin
            dig:= num MOD 10;
            if(dig MOD 2 = 0) then cantPos:= cantPos + 1;
            else cantNeg:= cantNeg + 1;
            num:= num DIV 10;
        end;
        masPares:= cantPos > cantNeg;
    end;

    procedure agregarAdelante (var lVP: listaVentas; v: venta)
    var
        nuevo: listaVentas;
    begin
        new(nuevo); nuevo^.elem:= v; nuevo^.sig:= nil;
        if(lVP = nil) then lVP:= nuevo;
        else begin
            nuevo^.sig:= lVP;
            lVP:= nuevo;
        end;
    end;

    procedure agregarAtras (var lVP: listaVentas; v: venta)
    var
        nuevo, aux: listaVentas;
    begin
        new(nuevo); nuevo^.elem:= v; nuevo^.sig:= nil;
        if(lVP = nil) then lVP:= nuevo;
        else begin
            aux:= lVP;
            while(aux^.sig <> nil) do
                aux:= aux^.sig;
            aux^.sig:= nuevo;
        end;
    end;

    procedure cargarListaVProds (var lVP: listaVentas; v: venta)
    begin
        if(v.tipoPago = "efectivo") then agregarAdelante(lVP, v);
        else agregarAtras(lVP, v);
    end;

    procedure procesarVentas (lV: listaVentas; var lVProd: listaVentas)
    var

    begin
        while (lV <> nil) do begin
            if(masPares(lV^.elem.cantProds)) then
                cargarListaVProds(lVProd, lV^.elem);
            lV:= lV^.sig
        end;
    end;

var
    lV: listaVentas;
    lVProd: listaVentas;
begin
    lV:= nil;
    cargarLista(lV);
    lVProd:= nil;
    procesarVentas(lV, lVProd);
end.