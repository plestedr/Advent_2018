with Ada.Text_IO;
with Ada.Strings;
with Ada.Strings.Fixed;

procedure Main is

   type Box_List_Type is array(Positive range <>) of String(1..26);

   Box_List : Box_List_Type(1 .. 250);
   Read_line : String(1..80);

   Test_Label : String(1..26);
   Compare_Label : String(1..26);
   Loc : Natural := 0;
   Found_It : Boolean := False;

   Str_Len : Natural := 0;

   Input_Loop_Counter : Natural := 0;

   Input_File_Name : String := "Input.txt";
   Input_File : Ada.Text_IO.File_Type;

   procedure Single_Diff(L1 : in String;
                         L2 : in String;
                         Index : out Natural;
                         Single : out Boolean) is
      mis_element : Natural := 0;
   begin

      for I in 1..L1'Length loop
         if L1(I) /= L2(I) then
            mis_element := mis_element + 1;
            Index := I;
         end if;
      end loop;

      Single := (mis_element = 1);

   end Single_Diff;

begin
   Ada.Text_IO.Open(File => Input_File,
                    Mode => Ada.Text_IO.In_File,
                    Name => Input_File_Name);

   For Input_Loop_Counter in 1..Box_List'Length loop

      Ada.Text_IO.Get_Line(File => Input_File,
                           Item => Read_line,
                           Last => Str_Len);
      Box_List(Input_Loop_Counter) := Read_line(1..Str_Len);
      Ada.Text_IO.Put_Line(Input_Loop_Counter'image & " " & Box_List(Input_Loop_Counter));

   end loop;

   For I in 1..Box_List'Length-1 loop
      Test_Label := Box_List(I);

      For J in I+1 .. Box_List'Length loop
         Compare_Label := Box_List(J);

         Single_Diff(L1 => Test_Label,
                     L2 => Compare_Label,
                     Index => Loc,
                     Single => Found_It );

         if Found_It then
            Ada.Text_IO.Put_Line("Located single miss at " & Loc'Image);
            Ada.Text_IO.Put_Line(Test_Label);
            Ada.Text_IO.Put_Line(Compare_Label);

            For I in 1..Test_Label'Length loop
               if I /= Loc then
                  Ada.Text_IO.Put(Test_Label(I));
               end if;
            end loop;

         end if;
      end loop; -- J
   end loop; -- I


<<Finished>>
Ada.Text_IO.Close(File => Input_File);

end Main;
