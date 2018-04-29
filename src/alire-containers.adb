package body Alire.Containers is

   ---------------
   -- Excluding --
   ---------------

   function Excluding (Map : Release_Map; Name : Alire.Project) return Release_Map is
   begin
      return Filtered : Release_Map := Map do
         Filtered.Exclude (Name);
      end return;
   end Excluding;

   ---------------
   -- Including --
   ---------------

   function Including (Map : Release_Map; Release : Releases.Release) return Release_Map is
   begin
      return New_Map : Release_Map := Map do
         New_Map.Include (Release.Project, Release);
      end return;
   end Including;

   ---------------------
   -- To_Dependencies --
   ---------------------

   function To_Dependencies (Map : Release_Map) return Dependencies.Vectors.Vector is
   begin
      return Deps : Dependencies.Vectors.Vector do
         for R of Map loop
            Deps.Append (Dependencies.New_Dependency
                           (R.Project,
                            Semantic_Versioning.Exactly (R.Version)));
         end loop;
      end return;
   end To_Dependencies;

   ------------
   -- To_Map --
   ------------

   function To_Map (R : Releases.Release) return Release_Map is
   begin
      return M : Release_Map do
         M.Include (R.Project, R);
      end return;
   end To_Map;

end Alire.Containers;
