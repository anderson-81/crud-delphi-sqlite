unit User;

interface

type
    TUser = class
    private
       id : integer;
       username : string;
       password : string;
    public
       procedure setID(id:integer);
       function getID:integer;
       procedure setUsername(username:string);
       function getUsername:string;
       procedure setPassword(password:string);
       function getPassword:string;
    end;

implementation

{ TUser }

function TUser.getID: integer;
begin
   result := self.id;
end;

function TUser.getUsername: string;
begin
   result := self.username;
end;

function TUser.getPassword: string;
begin
   result := self.password;
end;

procedure TUser.setID(id: integer);
begin
  self.id := id;
end;

procedure TUser.setUsername(username: string);
begin
  self.username := username;
end;

procedure TUser.setPassword(password: string);
begin
  self.password := password;
end;

end.
