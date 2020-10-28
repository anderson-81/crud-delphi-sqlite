unit Person;

interface

uses
    SysUtils;

type
    IPerson = interface(IInterface)
        procedure setID(id : integer);
        function getID : integer;
        procedure setName(name : string);
        function getName : string;
        procedure setEmail(email:string);
        function getEmail : string;
    end;

implementation

end.


