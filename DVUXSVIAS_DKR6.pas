uses Crt;

const
  MAX_NODES = 100;

type
  TNode = record
    data: integer;
    next: ^TNode;
    prev: ^TNode;
  end;

var
  head, tail: ^TNode;
  nodeArray: array [1..MAX_NODES] of TNode;
  nodeCounter: integer;

procedure CreateNode(var node: ^TNode; data: integer);
begin
  new(node);
  node^.data := data;
  node^.next := nil;
  node^.prev := nil;
end;

procedure InsertNode(var head, tail: ^TNode; data: integer);
var
  node: ^TNode;
begin
  Inc(nodeCounter);
  CreateNode(node, data);

  if head = nil then
  begin
    head := node;
    tail := node;
  end
  else
  begin
    tail^.next := node;
    node^.prev := tail;
    tail := node;
  end;
end;

procedure DeleteNode(var head, tail: ^TNode; data: integer);
var
  node, prevNode, nextNode: ^TNode;
begin
  node := head;

  while (node <> nil) and (node^.data <> data) do
  begin
    node := node^.next;
  end;

  if node <> nil then
  begin
    prevNode := node^.prev;
    nextNode := node^.next;

    if prevNode <> nil then
    begin
      prevNode^.next := nextNode;
    end
    else
    begin
      head := nextNode;
    end;

    if nextNode <> nil then
    begin
      nextNode^.prev := prevNode;
    end
    else
    begin
      tail := prevNode;
    end;

    Dec(nodeCounter);
    Dispose(node);
  end;
end;

procedure PrintList(head: ^TNode);
var
  node: ^TNode;
begin
  node := head;

  while node <> nil do
  begin
    Write(node^.data, ' ');
    node := node^.next;
  end;

  Writeln;
end;

var
  choice: integer;
  data: integer;

begin
  head := nil;
  tail := nil;
  nodeCounter := 0;

  repeat
    Writeln('Введите число: ');
    Writeln('1. Ввод данных');
    Writeln('2. Удаление данных');
    Writeln('3. Вывести данные');
    Writeln('4. Выйти из программы');
    Readln(choice);

    case choice of
      1: begin
           Write('Введите данные: ');
           Readln(data);
           InsertNode(head, tail, data);
         end;
      2: begin
           Write('Введите данные: ');
           Readln(data);
           DeleteNode(head, tail, data);
         end;
      3: begin
           Writeln('Список данных:');
           PrintList(head);
         end;
    end;
  until (choice = 4);
end.