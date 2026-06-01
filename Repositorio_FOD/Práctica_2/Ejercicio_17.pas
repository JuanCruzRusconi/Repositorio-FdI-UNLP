Una concesionaria de motos de la Ciudad de Chascomús, posee un archivo con información de las
motos que posee a la venta. De cada moto se registra: código, nombre, descripción, modelo, marca y
stock actual. Mensualmente se reciben 10 archivos detalles con información de las ventas de cada uno
de los 10 empleados que trabajan. De cada archivo detalle se dispone de la siguiente información:
código de moto, precio y fecha de la venta. Se debe realizar un proceso que actualice el stock del
archivo maestro desde los archivos detalles. Además se debe informar cuál fue la moto más vendida.
NOTA: Todos los archivos están ordenados por código de la moto y el archivo maestro debe ser recorrido
sólo una vez y en forma simultánea con los detalles.

Program ejercicio17;

const
    valorAlto = 9999;
type
    moto = record
        cod: integer;
        nombre: string[10];
        descr: string[20];
        modelo: string[10];
        marca: string[10];
        stockAct: integer;
    end;
    archMaestro = file of moto;

    venta = record
        cod: integer;
        precio: real;
        fecha: integer;
    end;
    archDetalle = file of venta;

    vectorDetalle = array[1..10] of archDetalle;
    vectorRegistro = array[1..10] of venta;

    procedure leer(var detalle: archDetalle; var v: venta);
    begin
        if(not EOF(detalle)) then
            read(detalle, v)
        else
            v.codigo:= valorAlto;
    end;

    procedure cargarDetalles(var vD: vectorDetalle; var vR: vectorRegistro);
    var
        i: integer;
    begin
        for i:= 1 to 10 do begin
            assign(vD[i], 'archivo_detalle'+i);
            reset(vD[i]);
            leer(vD[i], vR[i]);
        end;
    end;

    procedure calcularMinimo(var vD: vectorDetalle; var vR: vectorRegistro; var minimo: venta);
    var
        i, pos: integer;
    begin
        minimo.cod:= valorAlto;
        for i:= 1 to 10 do begin
            if(vR[i].cod < minimo.cod) then begin
                minimo:= vR[i];
                pos:= i;
            end;
        end;
        if(minimo.cod <> valorAlto) then leer(vD[pos], vR[pos]);
    end;

    procedure procesarDatos(var maestro: archMaestro; var vD: vectorDetalle; var vR: vectorRegistro; var maxVendCod, masVendCant: integer);
    var
        m: moto;
        minimo: venta;
        codActual: integer;
        cantActual: integer;
    begin
        read(maestro, m);
        calcularMinimo(vD, vR, minimo);
        masVendCant:= -1;
        while(minimo.cod <> valorAlto) do begin
            codActual:= minimo.cod;
            cantActual:= 0;
            while(codActual = minimo.cod) do begin
                cantActual:= cantActual + 1;
                calcularMinimo(vD, vR, minimo);
            end;

            if(cantActual > masVendCant) then begin
                masVendCant:= cantActual;
                masVendCod:= codActual;
            end;

            while(m.cod <> codActual) do
                read(maestro, m);

            m.stockAct:= m.stockAct - cantActual;
            seek(maestro, filePos(maestro) - 1);
            write(maestro, m);

            if(not EOF(maestro)) then read(maestro, m);
        end;
    end;

    procedure cerrarDetalles(var vD: vectorDetalle);
    var
        i: integer;
    begin
        for i:= 1 to 10 do 
            close(vD[i]);
    end;

var
    maestro: archMaestro;
    vD: vectorDetalle;
    vR: vectorRegistro;
    masVendCod, masVendCant: integer;
begin
    assign(maestro, 'archivo_maestro');
    reset(maestro);

    cargarDetalles(vD, vR);
    procesarDatos(maestro, vD, vR, masVendCod, masVendCant);

    writeln('La moto mas vendida fue: ', masVendCod, ' con una cantidad de: ', masVendCant);

    close(maestro);
    cerrarDetalles(vD);
end.