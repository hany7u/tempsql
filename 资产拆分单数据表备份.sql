create table fa_assetsplit_b_180709 as  select * from fa_assetsplit_b;

create table fa_assetsplit_180709 as  select * from fa_assetsplit;

--delete from fa_assetsplit_b;
commit;
--delete from fa_assetsplit;
commit;


select * from fa_assetsplit_b for update;

create table fa_assetsplit_b_180709 as  select * from fa_assetsplit_b;

create table fa_assetsplit_180709 as  select * from fa_assetsplit;

--delete from fa_assetsplit_b;
commit;
--delete from fa_assetsplit;
commit;
