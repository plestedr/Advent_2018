package body ClothTable is

   procedure SetCell (Row : in Positive; Col : in Positive; Val : in CellStateType) is
   begin
      My_Cloth(Row, Col) := Val;
   end SetCell;
   
   function GetCell (Row : in Positive; Col : in Positive) return CellStateType is
   begin
      return My_Cloth(Row, Col);
   end GetCell;
   

end ClothTable;
