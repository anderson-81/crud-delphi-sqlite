unit UPerson;

interface

uses
  SysUtils;

type
  TPerson = class
    procedure setID(id: integer); virtual; abstract;
    function getID: integer; virtual; abstract;
    procedure setName(name: string); virtual; abstract;
    function getName: string; virtual; abstract;
    procedure setEmail(email: string); virtual; abstract;
    function getEmail: string; virtual; abstract;
    procedure setStatus (status: integer); virtual; abstract;
    function getStatus: integer; virtual; abstract;
    procedure setComment(comment: string); virtual; abstract;
    function getComment: string; virtual; abstract;
    procedure setCreateAt (createAt: TDateTime); virtual; abstract;
    function getCreateAt: TDateTime; virtual; abstract;
  end;

implementation
end.


