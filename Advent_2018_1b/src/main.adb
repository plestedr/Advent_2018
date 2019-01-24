with Ada.Text_IO;
with Ada.Integer_Text_IO;

procedure Main is
   Input_Loop_Counter : Natural := 1; -- Because Freq(1) := 0

   subtype Freq_Count is Natural range 1 .. 200000;
   type Freq_Accumulator_Type is array (Freq_Count) of Integer;
   Freq_Accumulator : Freq_Accumulator_Type := (others => 0);

   Input_File_Name : String := "Input.txt";
   Input_File : Ada.Text_IO.File_Type;
   Next_Value : Integer;
begin
   Ada.Text_IO.Open(File => Input_File,
                    Mode => Ada.Text_IO.In_File,
                    Name => Input_File_Name);

   while Input_Loop_Counter in Freq_Count'range loop
      Input_Loop_Counter := Input_Loop_Counter + 1;
      if Ada.Text_IO.End_Of_File(Input_File) then
         Ada.Text_IO.Reset(File => Input_File, Mode => Ada.Text_IO.In_File);
         Ada.Text_IO.Put_Line("Reset input");
      end if;
      Ada.Integer_Text_IO.Get(File => Input_File,
                              Item => Next_Value);
      Freq_Accumulator(Input_Loop_Counter) := Freq_Accumulator(Input_Loop_Counter - 1) + Next_Value;

      for I in Natural range 1 .. Input_Loop_Counter-1 loop
         if Freq_Accumulator(Input_Loop_Counter) = Freq_Accumulator(I) then
            Ada.Text_IO.Put_Line("Matched " & Freq_Accumulator(Input_Loop_Counter)'Image);
            goto Finished;
         end if;
      end loop;

   end loop;

   <<Finished>>
   Ada.Text_IO.Close(File => Input_File);

   Ada.Text_IO.Put("Final value is " & Freq_Accumulator(Input_Loop_Counter)'Image);
   Ada.Text_IO.Put_Line(" at loop counter " & Input_Loop_Counter'Image);

end Main;
