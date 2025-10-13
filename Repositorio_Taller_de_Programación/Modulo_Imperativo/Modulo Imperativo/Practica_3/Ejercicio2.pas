Escribir un programa que:
a. Implemente un módulo que genere aleatoriamente información de ventas de un comercio.
Para cada venta generar código de producto, fecha y cantidad de unidades vendidas. Finalizar
con el código de producto 0. Un producto puede estar en más de una venta. Se pide:
i. Generar y retornar un árbol binario de búsqueda de ventas ordenado por código de
producto. Los códigos repetidos van a la derecha.
ii. Generar y retornar otro árbol binario de búsqueda de productos vendidos ordenado por
código de producto. Cada nodo del árbol debe contener el código de producto y la
cantidad total de unidades vendidas.
iii. Generar y retornar otro árbol binario de búsqueda de productos vendidos ordenado por
código de producto. Cada nodo del árbol debe contener el código de producto y la lista de
las ventas realizadas del producto.
Nota: El módulo debe retornar TRES árboles.
b. Implemente un módulo que reciba el árbol generado en i. y una fecha y retorne la cantidad
total de productos vendidos en la fecha recibida.
c. Implemente un módulo que reciba el árbol generado en ii. y retorne el código de producto
con mayor cantidad total de unidades vendidas.
c. Implemente un módulo que reciba el árbol generado en iii. y retorne el código de producto
con mayor cantidad de ventas.


Program Ejercicio2;
type
    rangoCodigos = 0..20;

    rangoDias = 1..30;
    rangoMes = 1..12;

    fechaRegistro = record
        dia: rangoDias;
        mes: rangoMes;
        anio: integer;
    end;
    {Arbol Ventas}
    venta = record
        cod: integer;
        fecha: fechaRegistro;
        cant: integer;
    end;

    arbol = ^nodo;
    nodo = record
        elem: venta;
        hi: arbol;
        hd: arbol;
    end;

    {Arbol Productos}
    producto = record
        cod: rangoCodigos;
        cant: integer;
    end;

    arbolProductos = ^nodoProductos;
    nodoProductos = record
        elem: producto;
        hi: arbolProductos;
        hd: arbolProductos;
    end;

    {Arbol Productos + Lista}

    ventaLista = record
        cant: integer;
        fecha: fechaRegistro;
    end;

    listaProductos = ^nodoLista;
    nodoLista = record
        elem: ventaLista;
        sig: listaProductos;
    end;

    productoLista = record
        cod: rangoCodigos;
        lista: listaProductos;
    end;

    arbolProductosLista = ^nodoProductosLista;
    nodoProductosLista = record
        elem: productoLista;
        hi: arbolProductosLista;
        hd: arbolProductosLista;
    end;

    procedure generarFecha(var f: fechaRegistro);
    begin
        f.dia:= random(30) + 1;
        f.mes:= random(12) + 1;
        f.anio:= 2025;
    end;

    procedure generarVenta(var v: venta);
    var
        f: fechaRegistro;
    begin
        v.cod:= random(20 + 1);
        if(v.cod <> 0) then begin
            generarFecha(f);
            v.fecha:= f;
            v.cant:= random(10 + 1);
        end;
    end;

    procedure agregarAlArbol(var a: arbol; v: venta);
    begin
        if(a = nil) then begin
            new(a);
            a^.elem:= v;
            a^.hi:= nil;
            a^.hd:= nil;
        end
        else
            if(a^.elem.cod > v.cod) then agregarAlArbol(a^.hi, v)
            else agregarAlArbol(a^.hd, v);
    end;

    procedure agregarAlArbolProductos(var a: arbolProductos; v: venta);
    begin
        if(a = nil) then begin
            new(a);
            a^.elem.cod:= v.cod;
            a^.elem.cant:= v.cant;
            a^.hi:= nil;
            a^.hd:= nil;
        end
        else
            if(a^.elem.cod = v.cod) then begin
                a^.elem.cant:= a^.elem.cant + v.cant;
            end   
            else begin
                if (a^.elem.cod > v.cod) then agregarAlArbolProductos(a^.hi, v);
                else agregarAlArbolProductos(a^.hd, v);
            end;
    end;

    procedure agregarAdelanteLista(var l: listaProductos; f: fechaRegistro; cant: integer);
    var
        nuevo: listaProductos;
    begin
        new(nuevo); nuevo^.elem.cant:= cant; nuevo^.elem.fecha:= f; nuevo^.sig:= nil;
        if(l = nil) then l:= nuevo;
        else begin
            nuevo^.sig:= l;
            l:= nuevo;
        end;
    end;

    procedure agregarAlArbolProductosLista(var a: arbolProductosLista; v: venta);
    begin
        if(a = nil) then begin
            new(a);
            a^.elem.cod:= v.cod;
            a^.elem.lista:= nil;
            agregarAdelanteLista(a^.elem.lista, v.fecha, v.cant);
            a^.hi:= nil;
            a^.hd:= nil;
        end;
        else 
            if(a^.elem.cod = v.cod) then agregarAdelanteLista(a^.elem.lista, v.fecha, v.cant);
            else begin
                if(a^.elem.cod > v.cod) then agregarAlArbolProductosLista(a^.hi, v);
                else agregarAlArbolProductosLista(a^.hd, v);
            end;
        end;
    end;

    procedure generarArbol(var a: arbol; var aP: arbolProductos; var aPL: arbolProductosLista);
    var
        v: venta;
    begin
        generarVenta(v);
        while(v.cod <> 0) do begin
            writeln('Producto codigo: ', v.cod);
            writeln('Cantidad: ', v.cant);
            writeln('Fecha dia: ', v.fecha.dia);
            writeln('Fecha mes: ', v.fecha.mes);
            writeln('Fecha año: ', v.fecha.anio);
            agregarAlArbol(a, v);
            agregarAlArbolProductos(aP, v);
            agregarAlArbolProductosLista(aPL, v);
            generarVenta(v);
        end;
    end;

    procedure imprimirNodos(v: venta);
    begin
        writeln('Producto codigo: ', v.cod);
        writeln('Cantidad: ', v.cant);
        writeln('Fecha dia: ', v.fecha.dia);
        writeln('Fecha mes: ', v.fecha.mes);
        writeln('Fecha año: ', v.fecha.anio);
    end;

    procedure imprimiArbolOrden(a: arbol);
    begin
        if(a <> nil) then begin
            imprimiArbolOrden(a^.hi);
            writeln('-----');
            imprimirNodos(a^.elem);
            imprimiArbolOrden(a^.hd);
        end;
    end;

    function productosVendidosXFecha(a: arbol; f: fechaRegistro): integer;
    begin
        if(a = nil) then productosVendidosXFecha:= 0;
        else begin
            if(a^.elem.fecha.dia = f.dia) and (a^.elem.fecha.mes = f.mes) then
                productosVendidosXFecha:= a^.elem.cant + productosVendidosXFecha(a^.hi, f) + productosVendidosXFecha(a^.hd, f);
            else productosVendidosXFecha:= productosVendidosXFecha(a^.hi) + productosVendidosXFecha(a^.hd);
        end;
    end;

    procedure calcularMaximo(cod: rangoCodigos; cant: integer, var cMax: rangoCodigos; var uMax: integer);
    begin
        if(cant > uMax) then begin
            uMax:= cant;
            cMax:= cod;
        end;
    end;

    procedure productoMasUnidadesVendidas(a: arbolProductos; var cMax: rangoCodigos; var uMax: integer);
    begin
        if(a <> nil) then 
        begin
            calcularMaximo(a^.elem.cod, a^.elem.cant, cMax, uMax);
            productoMasUnidadesVendidas(a^.hi, cMax, uMax);
            productoMasUnidadesVendidas(a^.hd, cMax, uMax);
        end;
    end;

    procedure recorrerLista(l: listaProductos; var cant: integer);
    begin
        cant:= 0;
        while(l <> nil) do begin
            cant:= cant + 1;
            l:= l^.sig;
        end;
    end;
    
    procedure productoMayorCantVentas(a: arbolProductosLista; var codMax: rangoCodigos; var cantMax: integer);
    var
        cantActuales: integer;
    begin
        if(a <> nil) then begin
            recorrerLista(a^.elem.lista, cantActuales);
            calcularMaximo(a^.elem.cod, cantActuales, codMax, cantMax);
            productoMayorCantVentas(a^.hi, codMax, cantMax);
            productoMayorCantVentas(a^.hd, codMax, cantMax);
        end;
    end;

var
    a: arbol;
    aP: arbolProductos;
    aPL: arbolProductosLista;
    cantXFecha: integer;
    fR: fechaRegistro;
    cMax: rangoCodigos;
    uMax: integer;
    codMax: rangoCodigos; 
    cantMax: integer;

begin
    Randomize;
    a:= nil;
    aP:= nil;
    aPL:= nil;
    generarArbol(a, aP, aPL);   
    imprimiArbolOrden(a);   
    writeln('Ingrese un dia: ');
    readln(fR.dia);
    writeln('Ingrese un mes: ');
    readln(fR.mes);
    fR.anio:= 2025;
    cantXFecha:= productosVendidosXFecha(a, fR);
    writeln('La cantidad total de unidades fendidas en la fecha: ', fR.dia,'/', fR.mes,'/',fR.anio, ' es de: ', cantXFecha);
    uMax:= 0;
    productoMasUnidadesVendidas(aP, cMax, uMax);
    writeln('El prducto con mas unidades vendidas es el producto: ', cMax, ' con una cantidad total de: ', uMax);
    cantMax:= 0;
    productoMayorCantVentas(aPL, codMax, cantMax);
    writeln('El producto con mas ventas es el producto: ', codMax, ' con una cantidad de: ', cantMax);
end.