Un comercio dispone de la información de sos ventas. De cada venta se conoce: código de producto, DNI del cliente, 
fecha, cantidad y precio unitario. Implementar un programa que genere una nueva estructura de datos en donde se tenga 
una única vez cada Dni del cliente junto al monto total en compras que realizó.

Program comercio;
const
type
    venta = record;
        cod: integer;
        dni: integer;
        fecha: integer;
        cant: integer;
        precio: real;
    end;
    listaVentas = ^nodo;
    nodo = record
        elem: venta;
        sig: listaVentas;
    end;

    total = record
        dni: integer;
        monto: real;
    end;
    listaTotal = ^nodoTotal;
    nodoTotal = record
        elem: total;
        sig: listaTotal;
    end;

    procedure cargarLista(var l: listaVentas) // se dispone

    procedure insertarLista(var l: listaTotal; dni: integer; monto: real)
    var
        nuevo, ant, actual: listaMonto;
    begin
        new(nuevo); nuevo^.elem.dni:= dni; nuevo^.elem.monto:= monto; nuevo^.sig:= nil;
        if(l = nil) then l:= nuevo;
        else begin
            ant:= l;
            actual:= l;
            while(actual <> nil) and (actual^.elem.dni < nuevo^.elem.dni) do begin
                ant:= actual;
                actual:= actual^.sig;
            end;
        end;
        if(actual = l) then begin
            nuevo^.sig:= l;
            l:= nuevo;
        end
        else
        begin
            ant^.sig:= nuevo;
            nuevo^.sig:= actual;
        end;
    end;

    procedure agregarNuevaLista(var l: listaTotal; dni: integer; monto: real)
    var
        aux: listaTotal;
    begin
        if(l = nil) then insertarLista(l, dni, monto);
        else begin
            aux:= l;
            while(aux <> nil) and (aux^.elem.dni < dni) do
                aux:= aux^.sig;
            if(aux <> nil) and (aux^.elem.dni = dni) then begin
                aux^.elem.monto:= aux^.elem.monto + monto;
            else
                insertarLista(l, dni, monto);
        end;
    end;

    procedure procesarVentas(l: listaVentas; var lT: listaTotal)
    var
        dni: integer;
        monto: real;
    begin
        while(l <> nil) do begin
            dni:= l^.elem.dni;
            monto:= l^.elem.cant * l^.elem.precio;
            agregarNuevaLista(lT, dni, monto);
            l:= l^.sig;
        end;
    end;

var
    l: listaVentas;
    lT: listaTotal;
begin
    l:= nil;
    cargarLista(l); // se dispone
    lT:= nil;
    procesarVentas(l, lT);
end;