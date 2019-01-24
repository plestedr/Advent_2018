with Ada.Strings;
with Ada.Strings.Fixed;

package Claims is

   type ClaimType is 
      record
         Number : Positive;
         Anchor_X : Natural;
         Anchor_Y : Natural;
         Delta_X : Natural;
         Delta_Y : Natural;
      end record;
   
   function decom (ClaimString : in String; Length : in Natural)
     return ClaimType;

end Claims;
