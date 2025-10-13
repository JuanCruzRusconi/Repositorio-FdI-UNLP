Una librería requiere el procesamiento de la información de sus productos. De cada
producto se conoce el código del producto, código de rubro (del 1 al 6) y precio.
Implementar un programa que invoque a módulos para cada uno de los siguientes puntos:
a. Lea los datos de los productos y los almacene ordenados por código de producto y
agrupados por rubro, en una estructura de datos adecuada. El ingreso de los productos finaliza
cuando se lee el precio -1.
b. Una vez almacenados, muestre los códigos de los productos pertenecientes a cada rubro.
c. Genere un vector (de a lo sumo 20 elementos) con los productos del rubro 3. Considerar que
puede haber más o menos de 20 productos del rubro 3. Si la cantidad de productos del rubro 3
es mayor a 20, almacenar los primeros 30 que están en la lista e ignore el resto.
d. Ordene, por precio, los elementos del vector generado en c) utilizando alguno de los dos
métodos vistos en la teoría.
e. Muestre los precios del vector resultante del punto d).
f. Calcule el promedio de los precios del vector resultante del punto d)

Program Ejercicio3;
type
    rangoRubros = 1..6;
    rangoProds3 = 1..20;
    producto = record
        cod: integer;
        rub: rangoRubros;
        precio: real;
    end;

    listaProductos = ^nodo;
    nodo = record
        elem: producto;
        sig: listaProductos;
    end;

    vectorRubros = array[rangoRubros] of listaProductos;

    vectorProds3 = array[rangoProds3] of producto;

    procedure inicializarVector(var v: vectorRubros);
    var
        i: rangoRubros;
    begin
        for i:= 1 to 6 do
            v[i]:= nil;
    end;

    procedure leerProducto(var p: producto);
    begin
        writeln('Ingrese el precio.');
        readln(p.precio);
        if(p.precio <> -1) then begin
            writeln('Ingrese el codigo.');
            readln(p.cod);
            writeln('Ingrese el rubro.');
            readln(p.rub);
        end;
    end;

    procedure insertarLista(var l: listaProductos; p: producto);
    var
        nuevo, anterior, actual: listaProductos;
    begin
        new(nuevo); nuevo^.elem:= p; nuevo^.sig:= nil;
        if(l = nil) then l:= nuevo
        else begin
            actual:= l; anterior:= l;
            while(actual <> nil) and (actual^.elem.cod < nuevo^.elem.cod) do
                begin
                    anterior:= actual;
                    actual:= actual^.sig;
                end;
        end;
        if(actual = l) then
        begin
            nuevo^.sig:= l; l:= nuevo;
        end
        else
        begin
            anterior^.sig:= nuevo;
            nuevo^.sig:= actual;
        end;
    end;

    procedure procesarInformacion(var lista: listaProductos; var vec: vectorRubros);
    var
        p: producto;
    begin
        inicializarVector(vec);
        leerProducto(p);
        while(p.precio <> -1) do begin
            insertarLista(vec[p.rub], p);
            leerProducto(p);
        end;
    end;

    procedure recorrerLista(l: listaProductos);
    begin
        while(l <> nil) do begin
            writeln('Producto codigo: ', l^.elem.cod);
            l:= l^.sig;
        end;
    end;

    procedure mostrarCodigos(v: vectorRubros);
    var
        i: rangoRubros;
    begin
        for i:= 1 to 6 do
        begin
            writeln('Prodcutos del rubro: ', i);
            recorrerLista(v[i]);
        end;
    end;

    procedure cargarVectorProds3(vecR: vectorRubros; var vecP3: vectorProds3; var dimL: integer);
    var
        l: listaProductos;
    begin
        dimL:= 0;
        l:= vecR[3];
        while(dimL <= 20) do begin
            while (dimL <= 20) and (l <> nil) do begin
                dimL:= dimL + 1;
                vecP3[dimL]:= l^.elem;
                l:= l^.sig;
            end;
        end;
    end;

    procedure ordenarVectorProds3(var v: vectorProds3; dimL: integer);
    var
        pos, i, j: integer;
        item: producto;
    begin
        for i: 1 to dimL-1 do
        begin
            pos:= i;
            for j:= i+1 to dimL do
                if(v[j].precio < v[pos].precio) then pos:= j;
            item:= v[pos];
            v[pos]: v[i];
            v[i]:= item;
        end;
    end;

    procedure mostrarPrecios(vec: vectorProds3, dimL: integer);
    var
        i: integer;
    begin
        for i: 1 to dimL do
            writeln('Producto codigo: ', v[i].cod, ' tiene un precio de: ', v[i].precio);
    end;

    function calcularPromedio(v: vectorProds3; dimL: integer):real;
    var
        i: integer;
        total: real;
    begin
        total:= 0;
        for i:= 1 to dimL do
        begin
            total:= total + v[i].precio;
        end;
        calcularPromedio:= total / dimL;
    end;

var
    listaP: listaProductos;
    vecR: vectorRubros;
    vecProds3: vectorProds3;
    dimL: integer;
    promedio: real;
begin
    procesarInformacion(listaP, vecR);
    mostrarCodigos(vecR);
    cargarVectorProds3(vecR, vecProds3, dimL);
    ordenarVectorProds3(vecProds3, dimL);
    mostrarPrecios(vecProds3, dimL);
    promedio:= calcularPromedio(vecProds3, dimL);
    writeln('El promedio de todos los precios es: ', promedio);
end.



// procedure seleccion(var v: vector; dimL: integer);
// var
//     i, j, pos: integer;
//     item: tipo;
// begin
//     for i:= 1 to dimL-1 do begin
//         pos:= i;
//         for j:= i+1 to dimL do
//             if(v[j].elem < v[pos].elem) then pos:= j;
//         item:= v[pos];
//         v[pos]:= v[i];
//         v[i]:= item;
//     end;
    
// end;

// procedure insercion(var v: vector; dimL: integer);
// var

// begin
    
// end;