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

program Panaderia

const
    totalCategorias = 20;
type
    rangoCategorias = 1..20;
    categoria = record
        nombre: string;
        precio: real;
    end;
    vectorCategorias = array[rangoCategorias] of catgoria;

    compra = record
        dni: integer;
        cat: rangoCategorias;
        cantKilos: integer;
    end;

    listaCompras = ^nodo
    nodo = record
        elem: compra;
        sig: ^listaCompras;
    end;
    vectorComprasPorCategoria = array[rangoCategorias] of integer;

    procedure cargarVectorCategorias ( var v: vectorCategorias ) // se dispone

    procedure leerCompra ( var c: compra )
    var

    begin
        read(c.dni);
        if(c.dni <> -1) then
        begin
            read(c.cat);
            read(c.cantKilos);
        end;
    end;

    procedure agregarAdelante ( var l: listaCompras; com: compra )
    var
        nuevo: listaCompras;
    begin
        new(nuevo); nuevo^.elem: com; nuevo^.sig:= nil;
        if( l = nil ) then l:= nuevo;
        else
            begin
                nuevo^.sig:= l;
                l:= nuevo;
            end;
    end;

    procedure cargarListaCompras ( var l: listaCompras )
    var
        c: compra; 
    begin
        leerCompra(c);
        while(c.dni <> -1) do
            begin
                agregarAdelante(l, c);
                leerCompra(c);
            end;
    end;

    procedure inicializarVectorComprasCategorias ( var v: vectorComprasPorCategoria )
    var
        i: rangoCategorias;
    begin
        for i:= 1 to totalCategorias do
            v[i]:= 0;
    end;

    procedure actualizarClienteMinimo ( dni: integer; dinero: real; dniMinimo: integer )
    var
        min: real;
    begin
        minimo:= 99999;
        if(dinero < minimo) then
            begin
                minimo:= dinero;
                dniMinimo:= dni;
            end;
    end;

    function tiene5DigImpares ( dni: integer ) : boolean
    var
        num; cant: integer;
    begin
        cant:= 0;
        while(dni <> 0) and (cant <= 5) do
            begin
                num:= dni MOD 10;
                if(num MOD 2 = 1) then cant:= cant + 1;
                num:= num DIV 10;
            end;
        if(cant > 5) then tiene5DigImpares:= false;
        else tiene5DigImpares:= true;
    end;

    procedure procesarInformacion ( v: vectorCategorias; l: listaCompras; var vCP: vectorComprasPorCategoria;
                                    dniMin: integer; cantCom5Imp: integer)
    var
        dniActual: integer; dineroActual: real; cantComprasActual: integer;
    begin
        inicializarVectorComprasCategorias(vCPC);
        cantCom5Imp:= 0;
        while (l<> nil) do
            begin
                dniActual:= l^.elem.dni;
                dineroActual:= 0;
                cantCompras:= 0;
                while (l<> nil) and (dniActual = l^.elem.dni) do
                    begin
                        dineroActual:= dineroActual + (l^.elem.cantKilos * vC[l^.elem.cat].precio );
                        vCPC[l^.elem.cat]:= vCPC[l^.elem.cat] + 1;
                        cantComprasActual:= cantComprasActual + 1;
                        l:= l^.sig;
                    end;
                actualizarClienteMinimo(dniActual, dineroActual, dniMin);
                if(tiene5DigImpares(dniActual)) then cantCom5Imp:= cantCom5Imp + cantComprasActual;
            end;
    end;

    procedure informarCantidadComprasPorCategoria ( vCat: vectorCategorias; vComCat: vectorComprasPorCategoria )
    var
        i: rangoCategorias;
    begin
        for i:= 1 to totalCategorias do
            begin
                write("Categoria: ", vCat[i].nombre);
                write("Cantidad de compras: ", vComCat[i]);
            end;
    end;

var
    vC: vectorCategorias; lC: listaCompras; vCPC: vectorComprasPorCategoria; 
    dniMinimo: integer; cantCompras5Impares: integer;
begin
    cargarVectorCategorias(vC); // se dispone
    lC:= nil;
    cargarListaCompras(lC);
    procesarInformacion(vC, lC, vCPC, dniMinimo, cantCompras5Impares);
    write("El dni del cliente que menos ha gastado es: ", dniMinimo);
    informarCantidadComprasPorCategoria(vC, vCPC);
    write("La cantidad total de compras de clientes con dni con al menos 5 digitos imapares es: ", cantCompras5Impares);
end.