with Ada.Strings;
with Ada.Strings.Fixed;

package Claims is

   type ClaimType is 
      record
         Number : Positive;
         Anchor_X : Natural;
         Anchor_Y : Natural;
         Delta_X : Positive;
         Delta_Y : Positive;
      end record;
   
   function decom (ClaimString : in String; Length : in Natural)
                   return ClaimType;
   
   function overlap_test (TestClaim : in ClaimType ; ListElement : in ClaimType) return Boolean;

end Claims;
