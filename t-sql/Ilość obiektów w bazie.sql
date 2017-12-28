

------------------------------------------------------------
-- Iloœæ obiektów w bazie
------------------------------------------------------------
select		s.name
			, o.type_desc
			--, o.name
			, type
			, count(*)		as NumOf
from		sys.objects o
			join sys.schemas s
				on o.schema_id = s.schema_id
where		1=1
			--and type = 'U'
			and s.name = 'dbo'
group by	s.name
			, o.type_desc
			, type

order by	NumOf desc

------------------------------------------------------------
-- Lista tabel w bazie
------------------------------------------------------------
select		t.[name]		as TableName
			, s.[name]		as SchemaName

from		sys.objects o
			join sys.schemas s
				on o.schema_id = s.schema_id

			join sys.tables t
				on o.object_id = t.object_id
where		1=1
			--and type = 'U'
			and s.name = 'dbo'

order by	t.[name]