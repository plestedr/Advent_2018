with Ada.Text_IO;
with Ada.Strings;
with Ada.Strings.Fixed;
with Ada.Characters.Conversions; use Ada.Characters.Conversions;

procedure Main is



   Input_Loop_Counter : Natural := 0;

   Next_Value : String(1 ..40) ;
   String_len : Natural := 0;

   Input_File_Name : String := "Input.txt";
   Input_File : Ada.Text_IO.File_Type;

   Exactly_Two : Boolean := False;
   Exactly_Three : Boolean := False;

   Running_Two : Natural := 0;
   Running_Three : Natural := 0;
   Check_Sum : Natural := 0;

   Procedure Count_Two_Three (Test_String : in String; Two : out Boolean; Three : out Boolean) is
      subtype Lower_Case is Character range 'a' .. 'z';

      Match_Count : Natural := 0;

      Local_String : String := Test_String;
   begin
      for soup in Lower_Case loop
         Match_Count := Ada.Strings.Fixed.Count(Source => Local_String,
                                                Pattern => ("" & soup) );

         Case Match_Count is
            when 2 => Two := True;
            when 3 => Three := True;
            when others => null;
         end case;

      end loop;


   end Count_Two_Three;

begin
   Ada.Text_IO.Open(File => Input_File,
                    Mode => Ada.Text_IO.In_File,
                    Name => Input_File_Name);

   while not Ada.Text_IO.End_Of_File(Input_File) loop
      Input_Loop_Counter := Input_Loop_Counter + 1;

      Ada.Text_IO.Get_Line(File => Input_File,
                           Item => Next_Value,
                           Last => String_len);

      Ada.Text_IO.Put(Input_Loop_Counter'image & " " & String_len'image & " ");
      Ada.Text_IO.Put(Next_Value(1..String_len) & " ");

--      Ada.Text_IO.Put_Line(
--      Ada.Strings.Fixed.Count(Source => Next_Value(1..String_len), Pattern => "h")'image);

      Count_Two_Three(Next_Value(1..String_len), Exactly_Two, Exactly_Three);

      Ada.Text_IO.Put_Line(Exactly_Two'Image & " " & Exactly_Three'Image);

      If Exactly_Two then
         Running_Two := Running_Two + 1;
      end if;
      If Exactly_Three then
         Running_Three := Running_Three + 1;
      end if;

   end loop;

   <<Finished>>
   Ada.Text_IO.Close(File => Input_File);

   Check_Sum := Running_Two * Running_Three;

   Ada.Text_IO.Put_Line("Checksum is " & Check_Sum'image );

end Main;
