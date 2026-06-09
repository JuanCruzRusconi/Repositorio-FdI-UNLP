Se cuenta con un archivo que almacena información sobre especies de aves en peligro de
extinción. De cada especie se registran los siguientes datos: código, nombre de la especie, familia,
descripción y zona geográfica. El archivo no se encuentra ordenado por ningún criterio.
Se desea desarrollar un programa que permita eliminar especies de aves extintas. Para ello, el
programa deberá contar con dos procedimientos:
Un procedimiento que, dado el código de una especie, la marque como borrada (baja lógica). En
caso de querer eliminar múltiples especies, este procedimiento podrá invocarse repetidamente.
Un procedimiento que realice la compactación del archivo (baja física), eliminando
definitivamente aquellas especies marcadas como borradas. Para ello, cada vez que se elimine un
registro, se deberá reemplazar su posición con el último registro del archivo y luego eliminar dicho
último registro, evitando así dejar espacios vacíos y registros duplicados.
Implemente además una variante de este procedimiento de compactación en la cual el archivo
sea truncado una única vez al finalizar el proceso.

program ejercicio6
const
    valorAlto = 9999;
type
    especie = record
        código: integer;
        nombre: string[20];
        familia: string[20];
        descripción: string[40];
        zona: string[20];
    end;
    archivo = file of especie;

    procedure procesarEspeces(var arch: archivo);
    var
        codEli: integer;
        e: especie;
    begin
        reset(arch);
        writeln("Ingrese el codigo de especie a eliminar, si desea terminar ingrese el 0");
        readln(codEli);

        while(codEli <> 0) do begin
            seek(arch, 0);
            leer(arch, e);
            while(e.codigo <> valorAlto) and (e.codigo <> codEli) do begin
                leer(arch, e);

            if(codEli = e.codigo) then
                p.codigo:= -1;
                seek(arch, filePos(arch) - 1);
                write(arch, p);
            end;
            writeln("Ingrese el codigo de especie a eliminar, si desea terminar ingrese el 0");
            readln(codEli);
        end;
        close(arch);
    end;

    procedure compactacionArchivo(var arch: archivo);
    var
        e: especie;
        posEliminar: integer;
        ultimo: e;
    begin
        reset(arch);

        leer(arch, e);
        while(e.codigo <> valorAlto) do begin
            if(e.codigo < 0) then begin
                posEliminar:= filePos(arch) - 1;
                
                seek(arch, fileSize(arch) - 1);
                read(arch, ultimo);

                seek(arch, posEliminar);
                write(arch, ultimo);

                seek(arch, fileSize(arch) - 1);
                truncate(arch);
            end;
            leer(arch, e);
        end;
        close(arch);
    end;

var
    arch: archivo;
begin
    assign(arch, 'archivo_especie');
    procesarEspecies(arch);
    compactacionArchivo(arch);
end.