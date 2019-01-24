
with Ada.Text_IO;
with Ada.Strings;
with Ada.Strings.Fixed;

with Claims;

procedure Main is
   Read_line : String(1..80);
   Str_Len : Natural := 0;

   Input_File_Name : String := "input.txt";
   Input_File : Ada.Text_IO.File_Type;

   -- Next_Claim : Claims.ClaimType;

   Claim_record : array (Positive range 1..2000) of Claims.ClaimType;
   Input_Loop_Counter : Natural := 0;

   Claim_is_unique : Boolean := False;

   package ATIO renames Ada.Text_IO;

begin
   ATIO.Open(File => Input_File,
             Mode => Ada.Text_IO.In_File,
             Name => Input_File_Name);

   while not ATIO.End_Of_File(File => Input_File) loop
      Input_Loop_Counter := Input_Loop_Counter + 1;

      ATIO.Get_Line(File => Input_File,
                    Item => Read_line,
                    Last => Str_Len);

      Claim_record(Input_Loop_Counter) := Claims.decom(ClaimString => Read_line, Length => Str_Len);

   end loop;

   -- Assuming there is exaclty one claim that does not overlap any others.
   -- This test may fail if the last claim is the one we're seeking.
   -- A more robust and generalized test is warranted in real life.
   for I in 1 .. (Input_Loop_Counter -1) loop
      Claim_is_unique := True;
      for J in (I+1) .. Input_Loop_Counter loop
       --  ATIO.Put_line(I'Image & "  " & J'Image);
         if Claims.overlap_test(TestClaim => Claim_record(I),
                                ListElement => Claim_record(J)) then
            Claim_is_unique := False;
            exit;
         end if;
      end loop;
      -- If the claim is still good after the inner loop...
      if Claim_is_unique then
         ATIO.Put_Line("Valid claim is " & Claim_record(I).Number'Image);
         exit;
      end if;
   end loop;


end Main;
