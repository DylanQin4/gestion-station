CREATE OR REPLACE DIRECTORY data_pump_dir AS 'D:\Partage\Dev\github\S5\MrTahinaS5\S5 p16Win\S5 p16\station-personnel\gestion-station-ejb\bdd\base.dmp';
CREATE USER impots IDENTIFIED BY impots;
GRANT DBA TO impots;
GRANT READ, WRITE ON DIRECTORY data_pump_dir TO impots;
imp impots/impots FILE='D:\base.dmp' LOG=import.log FULL=Y
