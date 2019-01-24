package ClothTable is

   type CellStateType is (None, Single, Multi);
   type TableType is array (Positive range <>, Positive range <>) of CellStateType;

   procedure SetCell (Row : in Positive; Col : in Positive; Val : in CellStateType);
   function GetCell (Row : in Positive; Col : in Positive) return CellStateType;
  
   MaxRow : Positive := 1_000;
   MaxCol : Positive := 1_000;

   My_Cloth : TableType (1..MaxRow, 1..MaxCol) := (Others => (Others => None));
     
end ClothTable;
