procedure insertarLista(var l: lista; e: elem)
var
    nuevo, anterior, actual: lista;
begin
    new(nuevo); nuevo^.elem:= e; nuevo^.sig:= nil;
    if(l = nil) then l:= nuevo;
    else begin
        anterior:= l; actual:= l;
        while(actual <> nil) and (actual^.elem > nuevo^.elem) do begin
            anterior:= actual;
            actual:= actual^.sig;
        end;
    end;
    if(actual = l) then begin
        nuevo^.sig:= l;
        l:= nuevo;
    end
    else begin
        anterior^.sig:= nuevo;
        nuevo^.sig:= actual;
    end;
end;

procedure agregarAdelante (var l: lista; e: elem)
var
    nuevo: lista;
begin
    new(nuevo); nuevo^.elem:= e; nuevo^.sig:= nil;
    if(l = nil) then l:= nuevo;
    else begin
        nuevo^.sig:= l;
        l:= nuevo;
    end;
end;

procedure agregarAtras (var l: lista; e: elem)
var
    nuevo, aux: lista;
begin
    new(nuevo); nuevo^.elem:= e; nuevo^.sig:= nil;
    if(l = nil) then l:= nuevo;
    else begin
        aux:= l;
        while(aux^.sig <> nil) do
            aux:= aux^.sig;
        aux^.sig:= nuevo;
    end;
end;

function palindromo(num: integer): boolean
var
    dig, original, nuevo: integer;
begin
    original:= num;
    nuevo:= 0;
    while(original <> 0) do begin
        dig:= original MOD 10;
        nuevo:= nuevo * 10 + dig;
        original:= original DIV 10;
    end;
    palindromo:= (num = nuevo);
end;

procedure eliminarDelVector(var v: vector; var dL: integer)
var
    i, j: integer;
begin
    i:= 1;
    while(i <= dL) do begin
        if(v[i].costo > 1000) then begin
            for j:= i to (dL - 1) do
                v[j]:= v[j+1];
            dL:= dL - 1;
        end
        else
            i:= i + 1;
    end;
end;

procedure insertarEnVector(var v: vector; var dL: integer; e: elem)
var
    i, j: integer;
    pude: boolean;
begin
    i:= 1;
    purde:= false;
    while(i <= dF) and (not pude) do begin
        if(v[i].gasto > e.gasto) then begin
            for j:= dF downto (i + 1) do
                v[j]:= v[j-1];
            v[i].gasto:= e;
            pude:= true
        end;
        i:= i + 1;
    end;
end;

procedure insertarPosicion(var v: vector; var dL: integer; var pude: boolean; e: elem; pos: integer)
var
    j: integer;
begin
    if(dL + 1 <= dF) then begin
        for j:= dL downto pos+1
            v[j]:= v[j-1];
        v[pos]:= e;
        dL:= dL + 1;
        pude:= true;
    end;
end;

procedure insertarVectordF(var v: vector; var dL: integer; e: elem)
var
    i, j: integer;
    pude: boolean;
begin
    i:= 1;
    pude: false;
    while(i <= dL) and (not pude) do begin
        if(v[i].gasto > e.gasto) then begin
            insertarPosicion(v, dL, pude, e, i);
        end;
        i:= i + 1;
    end;
end;

procedure insertarEnVector(var v: vector; var dL: integer; e: elem);
var
    i, j: integer;
    pude: boolean;
begin
    pude := false;
    i := 1;
    if (dL < dF) then begin
        while (i <= dL) and (not pude) do begin
            if (v[i].gasto > e.gasto) then begin
                for j := dL downto i do
                    v[j+1] := v[j];
                v[i] := e;
                pude := true;
            end;
            i := i + 1;
        end;
        if (not pude) then begin
            v[dL+1] := e;
        end;
        dL := dL + 1;
    end;
end;