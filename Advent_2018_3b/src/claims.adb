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
   
   function overlap_test (TestClaim : in ClaimType ; ListElement : in ClaimType) return Boolean is
      -- Returns TRUE if two rectangles overlap
      TestResult : Boolean := False;
      TC : ClaimType renames TestClaim;
      LE : ClaimType renames ListElement;
   begin
      -- Test whether the vertex of any square is within the confines of any other.
      -- Take advantage of this problem's geometry restriction. All polygons are rectangles
      -- with horizontal or vertical edges. Don't need the general point inside a poly test.
      
      if ((TC.Anchor_X+1 >= LE.Anchor_X+1 and TC.Anchor_X+1 <= LE.Anchor_X+LE.Delta_X) or else
          (TC.Anchor_X+TC.Delta_X >= LE.Anchor_X+1 and TC.Anchor_X+1 <= LE.Anchor_X+LE.Delta_X))
        and then
         ((TC.Anchor_Y+1 >= LE.Anchor_Y+1 and TC.Anchor_Y+1 <= LE.Anchor_Y+LE.Delta_Y) or else
            (TC.Anchor_Y+TC.Delta_Y >= LE.Anchor_Y+1 and TC.Anchor_Y+1 <= LE.Anchor_Y+LE.Delta_Y))
      then
         TestResult := True;
      end if;      
      
--      TestResult := ((TC.Anchor_X+1) in (LE.Anchor_X+1)..(LE.Anchor_X+LE.Delta_X) and 
--                       ( (TC.Anchor_Y+1) in (LE.Anchor_Y+1)..(LE.Anchor_Y+LE.Delta_Y) or
--                          (TC.Anchor_Y+TC.Delta_Y) in (LE.Anchor_Y+1)..(LE.Anchor_Y+LE.Delta_Y ))) 
--        or
--          ((TC.Anchor_X+TC.Delta_X) in (LE.Anchor_X+1)..(LE.Anchor_X+LE.Delta_X) and 
--             ( (TC.Anchor_Y+1) in (LE.Anchor_Y+1)..(LE.Anchor_Y+LE.Delta_Y) or
--                    (TC.Anchor_Y+TC.Delta_Y) in (LE.Anchor_Y+1)..(LE.Anchor_Y+LE.Delta_Y )));
      
      return TestResult;
      
      end overlap_test;

   end Claims;
