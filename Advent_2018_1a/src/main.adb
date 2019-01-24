with Ada.Text_IO;
with Ada.Integer_Text_IO;

procedure Main is
   Freq_Accumulator : Integer := 0;
   Input_File_Name : String := "Input.txt";
   Input_File : Ada.Text_IO.File_Type;
   Next_Value : Integer;
begin
   Ada.Text_IO.Open(File => Input_File,
                    Mode => Ada.Text_IO.In_File,
                    Name => Input_File_Name);

   while not Ada.Text_IO.End_Of_File(Input_File) loop
      Ada.Integer_Text_IO.Get(File => Input_File,
                              Item => Next_Value);
      Ada.Integer_Text_IO.Put(Item => Next_Value);
      Ada.Text_IO.New_Line;
      Freq_Accumulator := Freq_Accumulator + Next_Value;
   end loop;

   Ada.Text_IO.Close(File => Input_File);

   Ada.Text_IO.Put_Line("Final value is " & Freq_Accumulator'Image);

end Main;
