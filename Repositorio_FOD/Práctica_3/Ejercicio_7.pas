Se cuenta con un archivo con información de las diferentes distribuciones de linux existentes. De
cada distribución se conoce: nombre, año de lanzamiento, número de versión del kernel, cantidad
de desarrolladores y descripción. El nombre de las distribuciones no puede repetirse. Este archivo
debe ser mantenido realizando bajas lógicas y utilizando la técnica de reutilización de espacio libre
llamada lista invertida. Escriba la definición de las estructuras de datos necesarias y los siguientes
procedimientos:
a. BuscarDistribucion: módulo que recibe por parámetro el archivo, un nombre de
distribución y devuelve la posición dentro del archivo donde se encuentra el registro
correspondiente a la distribución dada (si existe) o devuelve -1 en caso de que no
exista..
b. AltaDistribucion: módulo que recibe como parámetro el archivo y el registro que
contiene los datos de una nueva distribución, y se encarga de agregar la distribución al
archivo reutilizando espacio disponible en caso de que exista. El control de unicidad lo
debe realizar utilizando el módulo anterior. En caso de que la distribución que se quiere
agregar ya exista se debe informar “ya existe la distribución”.
c. BajaDistribucion: módulo que recibe como parámetro el archivo y el nombre de una
distribución, y se encarga de dar de baja lógicamente la distribución dada. Para marcar
una distribución como borrada se debe utilizar el campo cantidad de desarrolladores
para mantener actualizada la lista invertida. Para verificar que la distribución a borrar
exista debe utilizar el módulo BuscarDistribucion. En caso de no existir se debe informar
“Distribución no existente”.

program ejercicio7;
const
    valorAlto = 'ZZZ';
type
    linux = record
        nombre: string[10];
        año: integer;
        verKer: integer; 
        cantDes: integer;
        descripción: string[20];
    end;
    archivo = file of linux;

    procedure leer(var arch: archivo; var l: linux);
    begin
        if(not EOF(arch))
            read(arch, l)
        else
            l.nombre:= valorAlto;
    end;

    procedure buscarDsitribucion(var arch: archivo; nombre: string[10]; var pos: integer);
    var
        l: linux;
    begin
        reset(arch);
        pos:= 0;
        leer(arch, l);
        while(l.nombre <> valorAlto) and (l.nombre <> nombre) do
            leer(arch, l);
        if(l.nombre = nombre) then
            pos:= filePos(arch) - 1;
        else
            pos:= -1;
        close(arch);
    end;

    procedure agregarDistribucion(var arch: archivo);
    var
        nueva, cabecera, l: linux;
        posLibre: integer;
    begin
        leerDistribucion(nueva);
        buscarDistribucion(arch, nueva.nombre, pos);
        reset(arch);
        if(pos = -1) then begin
            seek(arch, 0);
            read(arch, cabecera);
            if(cabecera.cantDes <> 0) then begin
                posLibre:= -cabecera.cantDes;

                seek(arch, posLibre);
                read(arch, l);

                cabecera.cantDes:= l.cantDes;

                seek(arch, posLibre);
                write(arch, nueva);

                seek(arch, 0);
                write(arch, cabecera);
            end
            else begin
                seek(arch, fileSize(arch));
                write(arch, nueva);
            end;
        end
        else
            writeln("La distribucion ya existe");
        close(arch);
    end;

    procedure eliminarDistribucion(var arch: archivo; nom: string[10]);
    var
        l, cabecera: linux;
        pos: integer;
    begin
        buscarDistribucion(arch, nom, pos);
        if(pos <> -1) then begin
            seek(arch, 0);
            read(arch, cabecera);
            
            seek(arch, pos);
            read(arch, l);

            l.cantDes:= cabecera.cantDes;
            seek(arch, pos);
            write(arch, l);

            cabecera.cantDes:= -pos;
            seek(arch, 0);
            write(arch, cabecera);            
        end
        else
            writeln("Dsitribucion no encontrada");
        close(arch);
    end;

var
    arch: archivo;
    opcion: integer;
    nomDis: string[10];
    pos: integer;
    disEli: string[10];
begin
    assign(arch, 'archivo_linux');
    writeln("Ingrese la opcion a realizar");
    writeln("1: Buscar distribucion");
    writeln("2: Dar de alta una distribucion");
    writeln("3: Dar de baja una distribucion");
    readln(opcion);

    while(opcion <> 0) do begin
        if(opcion = 1) then begin
            writeln("Ingrese el nombre de la distribucion a buscar");
            readln(nomDis);
            buscarDistribucion(arch, nomDis, pos);
        end
        else
        begin
            if(opcion = 2) then begin
                agregarDistribucion(arch);
            end
            else begin
                writeln("Escriba el nombre de la dsitribucion a eliminar");
                readln(disEli);
                eliminarDistribucion(arch, disEli);
            end;
        end;
    end;
end.