unit UPersonController;

interface

type
  TPersonController = class
  protected
    function GenerateID: integer; virtual; abstract;
    function InsertPerson: Integer; virtual; abstract;
  end;

implementation
end.
 