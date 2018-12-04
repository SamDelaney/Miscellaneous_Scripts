-- Name: Sam Delaney
-- Student Number: 564284
-- CMPT 360 Fall 2018
-- Lab 5
-- Minesweeper

with Ada.Numerics.Discrete_Random;
with Ada.Text_IO;

procedure Main is
   package IO renames Ada.Text_IO;
   package Nat_IO is new IO.Integer_IO (Natural);
   package R is new Ada.Numerics.Discrete_Random (Natural);

   type SquareContents is (Unsure, Cleared, Mine);
   type Grid is array (Positive range <>, Positive range <>) of SquareContents;

   -- method headings defined before implementation: Ada standard
   procedure MakeGuess (Field : Grid; X, Y : Positive);
   procedure GetInput (Field : Grid);
   function IsInRange(Field : Grid; X, Y : Positive) return Boolean;
   function HaveWon(Field : Grid) return Boolean;

   -- counts how many mines are in the adjacent squares
   function AdjacentMines (Field : Grid; X, Y : Positive) return Natural is
      Result : Natural := 0;
   begin
      -- left side
      if X > Field'First (1) then
         if Y > Field'First (2) then
            if Field (X - 1, Y - 1) = Mine then
               Result := Result + 1;
            end if;
         end if;
         if Field (X - 1, Y) = Mine then
            Result := Result + 1;
         end if;
         if Y < Field'Last (2) then
            if Field (X - 1, Y + 1) = Mine then
               Result := Result + 1;
            end if;
         end if;
      end if;
      -- right side
      if X < Field'Last (1) then
         if Y > Field'First (2) then
            if Field (X + 1, Y - 1) = Mine then
               Result := Result + 1;
            end if;
         end if;
         if Field (X + 1, Y) = Mine then
            Result := Result + 1;
         end if;
         if Y < Field'Last (2) then
            if Field (X + 1, Y + 1) = Mine then
               Result := Result + 1;
            end if;
         end if;
      end if;
       -- above
      if Y > Field'First (2) then
         if Field (X, Y - 1) = Mine then
            Result := Result + 1;
         end if;
      end if;
      -- below
      if Y < Field'Last (2) then
         if Field (X, Y + 1) = Mine then
            Result := Result + 1;
         end if;
      end if;
      return Result;
   end AdjacentMines;

   -- prints grid
   procedure DrawField (Field : Grid) is
   begin
      for Y in Field'Range (2) loop
         for X in Field'Range (1) loop
            if Field (X, Y) = Cleared then
              IO.Put(Integer'Image(AdjacentMines(Field, X, Y)));
            else
              IO.Put(" X");
            end if;
         end loop;
         IO.New_Line;
      end loop;
   end DrawField;

   -- interacts with grid data
   procedure MakeGuess (Field : Grid; X, Y : Positive) is
   tempField : Grid(1..3, 1..3);
   begin
      -- cannot set values in parameters
      tempField := Field;
      if tempField (X, Y) = Mine then
         IO.Put("YOU LOSE!");
      else
         tempField(X, Y) := Cleared;
         if HaveWon(tempField) then
            IO.Put("YOU WIN!");
            return;
         end if;
         DrawField(tempField);
         GetInput(tempField);
      end if;

   end MakeGuess;

   -- gets input from the user
   procedure GetInput (Field : Grid) is
      X, Y : Positive;
   begin
      IO.Put("Enter X coordinate: ");
      Nat_IO.Get(X);
      IO.Put("Enter Y coordinate: ");
      Nat_IO.Get(Y);

      if(IsInRange(Field, X, Y)) then
         MakeGuess(Field, X, Y);
      else
         IO.Put_Line("Invalid Input");
         GetInput(Field);
      end if;
      exception
      when Constraint_Error =>
         IO.Put_Line("Invalid Input");
         GetInput(Field);
   end GetInput;

   -- validates input from the user
   function IsInRange(Field : Grid; X, Y : Positive) return Boolean is
   begin
      if X < 0 or Y < 0 then
         return False;
      end if;
      if X > 3 or Y > 3 then
         return False;
      end if;
      return True;
   end IsInRange;

   -- instantiates grid
   function MakeGrid (dimensions : Positive) return Grid is
      RNG : R.Generator;
      returnGrid : Grid(1 .. dimensions, 1 .. dimensions);
   begin
      R.Reset(RNG);
      for Y in returnGrid'Range (2) loop
         for X in returnGrid'Range (1) loop
            if(R.Random (RNG) mod 5 = 0) then
               returnGrid (X, Y) := Mine;
            else
               returnGrid (X, Y) := Unsure;
            end if;

         end loop;
      end loop;
      return returnGrid;
   end MakeGrid;

   -- checks if player has won
   function HaveWon (Field : Grid) return Boolean is
   begin
      for Y in Field'Range (2) loop
         for X in Field'Range (1) loop
            if Field (X, Y) = Unsure then
               return False;
            end if;
         end loop;
      end loop;
      return True;
   end HaveWon;

begin
   declare
      Field : Grid(1 .. 3, 1 .. 3);
   begin
      Field := MakeGrid(3);
      IO.Put("Welcome to Minesweeper!");
      IO.New_Line;
      GetInput(Field);
   end;
end Main;
