use Spirit_dev
go

create table GorskiM.Person (
	id int,
	name varchar(100),
	PostalCode varchar
)

drop table GorskiM.Person

select		*
from		information_schema.schemata


SELECT SERVERPROPERTY('Collation')

EXEC sp_addextendedproperty 
	@name = N'Input Mask ', @value = '#',
	@level0type = N'Schema', @level0name = 'GorskiM',
	@level1type = N'Table', @level1name = 'Person', 
	@level2type = N'Column',@level2name = 'PostalCode';
GO



EXEC sp_updateextendedproperty 
	@name = N'Input Mask ', @value = '999',
	@level0type = N'Schema', @level0name = 'GorskiM',
	@level1type = N'Table', @level1name = 'Person', 
	@level2type = N'Column',@level2name = 'PostalCode';
GO

insert into GorskiM.Person (id, name, PostalCode)
values(3, 'Adam', 111)

select		*
from		GorskiM.Person

--------------------------------------------------------------------------------------------------------------------------------------

create table GorskiM.page (
  page_id int identity(1,1) not null,
  page_url varchar(50) not null,
  constraint PK_page primary key (page_id)
)

exec sp_addextendedproperty
	@name = N'Dev Comment', 
	@value = 'URL after first ''/'' and up to but not including ''?''',
	@level0type = N'schema', @level0name = GorskiM,
	@level1type = 'table', @level1name = page,
	@level2type = 'column', @level2name = page_url

exec sp_addextendedproperty
	@name = N'Dev Process', 
	@value = 'Each time a new page is added to the site, a new record needs inserted here.',
	@level0type = N'schema', @level0name = GorskiM,
	@level1type = 'table', @level1name = page
go
--------------------------------------------------------------------------------------------------------------------------------------


create table GorskiM.person (
  pers_id int identity(1,1) not null,
  pers_fname varchar(50) null,
  pers_lname varchar(50) null,
  pers_ssn varchar(11) not null, -- will store the mask in the data in this example
  constraint PK_pers primary key (pers_id)
)

EXEC sp_addextendedproperty 
@name = N'Val Label', 
@value = 'Social Security Number',
@level0type = N'Schema', @level0name = GorskiM,
@level1type = N'Table',  @level1name = person,
@level2type = N'Column', @level2name = pers_ssn;
GO
 
EXEC sp_addextendedproperty 
@name = N'Val Message', 
@value = 'Please use this format for Social Security number: ###-##-####',
@level0type = N'Schema', @level0name = GorskiM,
@level1type = N'Table',  @level1name = person,
@level2type = N'Column', @level2name = pers_ssn;
GO
EXEC sp_addextendedproperty 
@name = N'Dev Comment', @value = 'Is it keen to store the input mask in the value?',
@level0type = N'Schema', @level0name = GorskiM,
@level1type = N'Table',  @level1name = person,
@level2type = N'Column', @level2name = pers_ssn;
GO

select	sysobj.[name] as objname, 
		syscol.[name] as colname, 
		sysexp.[name] as propname, 
		sysexp.[value] as propval

from	sys.extended_properties sysexp

		join sys.objects sysobj 
			on sysobj.[object_id] = sysexp.major_id

		left join sys.columns syscol -- when expprop is on object, minor_id = 0
			on syscol.[object_id] = sysobj.[object_id] 
			and syscol.[column_id] = sysexp.minor_id

where	sysexp.class = 1 -- 1 = object or column
		and sysobj.[name]  = 'person'



insert into GorskiM.Person (pers_fname, pers_lname, pers_ssn)
values('Adam', 'Kamis', 111)


select		*
from		GorskiM.Person