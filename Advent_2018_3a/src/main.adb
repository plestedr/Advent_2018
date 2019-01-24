with Ada.Text_IO;
with Ada.Strings;
with Ada.Strings.Fixed;

with Claims;
with ClothTable; use ClothTable;

procedure Main is
   Read_line : String(1..80);
   Str_Len : Natural := 0;

   Input_File_Name : String := "input.txt";
   Input_File : Ada.Text_IO.File_Type;

   Next_Claim : Claims.ClaimType;

   x,y : Natural := 0;

   Multi_Count, Single_Count, None_Count : Natural := 0;

   Input_Loop_Counter : Natural := 0;

   package ATIO renames Ada.Text_IO;
begin
   Ada.Text_IO.Open(File => Input_File,
                    Mode => Ada.Text_IO.In_File,
                    Name => Input_File_Name);

   While not ATIO.End_Of_File(File => Input_File) loop
--     While Input_Loop_Counter >= 1355 loop

      Input_Loop_Counter := Input_Loop_Counter + 1;

      ATIO.Get_Line(File => Input_File,
                    Item => Read_line,
                    Last => Str_Len);

      Next_Claim := Claims.decom(ClaimString => Read_line, Length => Str_Len);

      For I in 1..Next_Claim.Delta_X loop
         x := Next_Claim.Anchor_X + I;

         For J in 1..Next_Claim.Delta_Y loop
            y := Next_Claim.Anchor_Y + J;

            if ClothTable.GetCell(Col => x, Row => y) = ClothTable.None then
               ClothTable.SetCell(Col => x, Row => y, Val => ClothTable.Single);
            elsif ClothTable.GetCell(Col => x, Row => y) = ClothTable.Single then
               ClothTable.SetCell(Col => x, Row => y, Val => ClothTable.Multi);
            end if;

         end loop;
      end loop;

   end loop;

   Ada.Text_IO.Close(File => Input_File);

   For I in 1..ClothTable.MaxCol loop
      For J in 1..ClothTable.MaxRow loop
         case ClothTable.GetCell(Col => I, Row => J) is
            when ClothTable.Multi => Multi_Count := Multi_Count + 1;
            when ClothTable.Single => Single_Count := Single_Count + 1;
            when ClothTable.None => None_Count := None_Count + 1;
         end case;
      end loop;
   end loop;

   ATIO.Put_Line("Cells claimed by more than one: " & Multi_Count'Image);
   ATIO.Put_Line("Cells claimed by only one: " & Single_Count'Image);
   ATIO.Put_Line("Cells claimed by none: " & None_Count'Image);

end Main;
