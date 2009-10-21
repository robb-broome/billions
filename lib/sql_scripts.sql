drop procedure load_part_tab; 
delimiter //
CREATE PROCEDURE load_part_tab()
begin
 declare v int default 0;
 while v < 40000000
 	do
	 insert into playlist_part (title, description, user_id, favorite_count)
	 values ('testing partitions','playlist_ddescription',CEILING(NOW()), 1);
	 set v = v + 1;
	 IF MOD(v,1000)=0 THEN
	   COMMIT; 
   END IF; 
	end while;
end
//
delimiter ; 
call load_part_tab; 
# adddate('1995-01-01',(rand(v)*36520) mod 3652)
-- SET randnum=ceiling(RAND()*10000000000) 
 -- declare randnum int default 0;