// Consigna Parcial Fecha 1 Tema 2 - 2023
// Una panaderia artesanal del centro de La Plata vende productos de elaboración propia.
// La panaceria agrupo a sus productos en 20 calegorias (por ej.: 1. Pan; 2. Medialunas dulces: 3. Medialunas saladas, etc.). De cada categoría se conoce: nombre y 
// precio por kio del producto. La panaderia dispone de la información de las categorias.
// a Realizar un módulo que retorne, en una estructura de datos adecuada, la información de todas las compras efectuadas en el último ario. Dicha información se lee 
// desde teclado, ordenada por DNI del diente. De cada compra se lee: DNI del ciente. categoria del producto (entre 1 y 20) y cantidad de kilos comprados. La lectura 
// fnaliza cuando se ingresa el DNI -1 (que no debe procesarse).
// b Realizar un médulo que reaba la información de las categorias y la de todas las
// compras, y retorne:
// 1. DNi del ciente que menos dinero ha gastado.
// 2. Cantidad de compras por categoria.
// 3. Cantidad total de compras de clientes con DNi compuesto por, a lo sumo, 5
// digtos impares.
// NOTA: Implementar el programa principal.

Program panaderia;
const
    totalCategorias = 20;
type
    rangoCategorias = 1..20;
    categoria = record
        nombre: string;
        precio: real;
    end;
    vectorCategorias = array[rangoCategorias] of categoria;

    compra = record
        dni: integer;
        categoria: rangoCategorias;
        cant: real;
    end;
    listaCompras = ^nodo;
    nodo = record
        elem: compra;
        sig: listaCompras;
    end;

    vectorCantidad = array[rangoCategorias] of integer;

    procedure cargarCategorias(var v: vectorCategorias)
    var
        i: integer;
        c: categoria;
    begin
        for i:= 1 to totalCategorias do begin
            leerCategoria(c);
            v[i]:= c;
        end;
    end;
    
    procedure leerCompra(var c: compra)
    begin
        readln(c.dni);
        if(c.dni <> -1) do begin
            readln(categoria);
            readln(cant);
        end;
    end;

    procedure agregarALista(var l: listaCompras; c: compra)
    var
        nuevo: listaCompras;
    begin
        new(nuevo); nuevo^.elem:= c; nuevo^.sig:= nil;
        if(l = nil) then l:= nuevo;
        else begin
            nuevo^.sig:= l;
            l:= nuevo;
        end;
    end;

    procedure procesarCompras(var l: listaCompras)
    var
        c: compra;
    begin
        leerCompra(c);
        while(c.dni <> -1) do begin
            agregarALista(l, c);
            leerCompra(c;)
        end;
    end;

    procedure actualizarMinimo(cliente: integer; monto: real; var dniMenor: integer; var min: real)
    begin
        if(monto < min) then begin
            dniMenor:= cliente;
            min:= monto;
        end;
    end;

    function tiene5Impares(dni: integer): boolean;
    var
        par, impar: integer;
    begin
        par:= 0;
        impar:= 0;
        while(dni <> 0) do begin
            if(dni MOD 2 = 0) then par:= par + 1;
            else impar:= impar + 1;
            dni:= dni DIV 10;
        end;
        tiene5Impares:= (impar <= 5);
    end;

    procedure procesarInformacion(vC: vectorCategorias; lC: listaCompras; var dniMenor: integer; var vComp: vectorCantidad; var compDniImpar: integer;)
    var
        clienteActual: integer;
        montoActual: real;
        cantActual: integer;
        min: real;
    begin
        inicializarVector(vComp);
        min:= 9999;
        compDniImpar:= 0;
        while(l <> nil) do begin
            clienteActual:= l^.elem.dni;
            montoActual:= 0;
            cantActual:= 0;
            while(l <> nil) and (clienteActual = l^.elem.dni) do begin
                montoActual:= montoActual + l^.elem.cant * vC[l^.elem.categoria].precio;
                vComp[l^.elem.categoria]:= vComp[l^.elem.categoria] + 1;
                cantActual:= cantActual + 1;
                l:= l^.sig;
            end;
            actualizarMinimo(clienteActual, montoActual, dniMenor, min);
            if(tiene5Impares(clienteActual)) then compDniImpar:= compDniImpar + cantActual;
        end;
    end;

    procedure informarComprasXCategoria(v: vectorCantidad)
    var
        i: integer;
    begin
        for i:= 1 to totalCategorias do
            writeln("La categoria ", i, " tiene un total de compras de: ", v[i]);
    end;

var
    vC: vectorCategorias;
    lC: listaCompras;
    dniMenor: integer;
    vComp: vectorCantidad;
    compDniImpar: integer;
begin
    cargarCategorias(vC);
    lC:= nil;
    procesarCompras(lC);
    procesarInformacion(vC, lC, dniMenor, vComp, compDniImpar);
    writeln("Dni del cliente que menos gasto: ", dniMenor);
    informarComprasXCategoria(vComp);
    writeln("La cantidad total de compras de clientes con dni 5 impares es de: ", compDniImpar);
end.