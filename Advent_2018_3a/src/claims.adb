with Ada.Strings;
with Ada.Strings.Fixed;

-- Input line has the format
-- # <number> @ <Anchor_X> , <Anchor_Y> : <Delta_X> x <Delta_Y>


package body Claims is

   function decom (ClaimString : in String; Length : in Natural)
                   return ClaimType is
      Hash_Pos : Natural := 0;
      At_Pos : Natural := 0;
      Comma_Pos : Natural := 0;
      Colon_Pos : Natural := 0;
      X_Pos : Natural := 0;
      
      Return_Record : ClaimType;
      
   package AS renames Ada.Strings;
   package ASF renames Ada.Strings.Fixed;   
   begin
      Hash_Pos := ASF.Index(Source => ClaimString(ClaimString'First..Length),
                            Pattern => "#" );
      At_Pos := ASF.Index(Source => ClaimString(ClaimString'First..Length),
                          Pattern => "@" );
      Comma_Pos := ASF.Index(Source => ClaimString(ClaimString'First..Length),
                             Pattern => "," );
      Colon_Pos := ASF.Index(Source => ClaimString(ClaimString'First..Length),
                             Pattern => ":" );
      X_Pos := ASF.Index(Source => ClaimString(ClaimString'First..Length),
                         Pattern => "x" );
      
      Return_Record.Number := Integer'Value(ClaimString(Hash_Pos+1..At_Pos-1));
      Return_Record.Anchor_X := Integer'Value(ClaimString(At_Pos+1..Comma_Pos-1));
      Return_Record.Anchor_Y := Integer'Value(ClaimString(Comma_Pos+1..Colon_Pos-1));
      Return_Record.Delta_X := Integer'Value(ClaimString(Colon_Pos+1..X_Pos-1));
      Return_Record.Delta_Y := Integer'Value(ClaimString(X_Pos+1..Length));
      
      return Return_Record;
                                            
   end decom;

end Claims;
