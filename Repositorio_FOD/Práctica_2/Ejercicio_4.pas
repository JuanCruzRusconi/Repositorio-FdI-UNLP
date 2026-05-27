Se cuenta con un archivo maestro de productos de una cadena de venta de alimentos congelados. De
cada producto se almacena la siguiente información: código de producto, nombre, descripción, stock
disponible, stock mínimo y precio.
Diariamente se recibe un archivo detalle por cada una de las 30 sucursales de la cadena. Cada archivo
detalle contiene: código de producto y cantidad vendida.
Se solicita desarrollar un procedimiento que reciba los 30 archivos detalle y actualice el stock del archivo
maestro.
Además, deberá generarse un archivo de texto que informe, para aquellos productos cuyo stock
disponible se encuentre por debajo del stock mínimo, los siguientes datos: nombre del producto,
descripción, stock disponible y precio.
Analizar alternativas para la generación de dicho informe: realizarlo en el mismo procedimiento de
actualización o en un procedimiento separado, indicando las ventajas y desventajas de cada opción.
Nota: Todos los archivos se encuentran ordenados por código de producto. En cada archivo detalle
puede haber cero, uno o más registros para un mismo producto.

Program ejercicio4;

const
    valorAlto = 9999;
type
    producto = record
        cod: integer;
        nombre: string;
        desc: string;
        stockDis: integer;
        stockMin: integer;
        precio: real;
    end;

    venta = record
        cod: integer;
        cant: integer;
    end;

    archivoMaestro = file of producto;
    archivoDetalle = file of venta;

    vectorDetalles = array[1..30] of archivoDetalle;
    vectorRegistros = array[1..30] of venta;

    procedure cargarDetalles(var vD: vectorDetalles; var vR: vectorRegistros);
    var
        i: integer;
    begin
        for i:= 1 to 30 do begin
            assign(vD[i], 'archivo_detalle');
            reset(vD[i]);
            leer(vD[i], vR[i]);
        end;
    end;

    procedure leer(var detalle: archivoDetalle, var v: venta);
    begin
        if(not EOF(detalle)) then
            read(detalle, v)
        else
            v.cod := valorAlto;
    end;

    procedure calcMinimo(var vD: vectorDetalles; var vR: vectorRegistros; var minimo: venta);
    var
        i, pos: integer;
    begin
        minimo.cod := valorAlto;
        for i:= 1 to 30 do begin
            if(vR[i].cod < minimo.cod) then begin
                minimo := vR[i];
                pos := i;
            end;
        end;
        if(minimo.cod <> valorAlto) then leer(vD[pos], vR[pos]);
    end;

var
    p: producto;
    v: venta;
    maestro: archivoMaestro;
    detalle: archivoDetalle;
    vD: vectorDetalles;
    vR: vectorRegistros;
    minimo: venta;
    prodActual: integer;
    cantActual: integer;
    texto: text;

begin
    assign(maestro, 'archivo_maestro');
    reset(maestro);

    assign(texto, 'archivo_texto');
    rewrite(texto);

    read(maestro, p);

    cargarDetalles(vD, vR);

    calcMinimo(vD, vR, minimo);

    while(minimo.cod <> valorAlto) do begin
        prodActual := minimo.cod;
        cantActual := 0;

        while(minimo.cod = prodActual) do begin
            cantActual := cantActual + minimo.cant;
            calcMinimo(vD, vR, minimo);
        end;

        while(p.cod <> prodActual) do
            read(maestro, p);
        
        p.stockDis := p.stockDis - cantActual;
        if(p.stockDis < p.stockMin) then 
            writeln(texto, p.nombre, ' ', p.desc, ' ', p.stockDis, ' ', p.precio);

        seek(maestro, filePos(maestro) - 1);
        write(maestro, p);

        if(not EOF(maestro)) read(maestro, p);
    end;

    close(maestro);
    
    for i:= 1 to 30 do
        close(vD[i]);
    close(texto);
end.