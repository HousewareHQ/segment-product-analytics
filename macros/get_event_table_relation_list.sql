{% macro get_event_table_relation_list(schema, database=target.database) %}

    {%- call statement('get_event_tables', fetch_result=True) %}
      {{ get_event_tables(schema, database)}}
    {%- endcall -%}

	{% set table_list = load_result('get_event_tables') -%}
    
    {%- if table_list and table_list['table'] -%}
        {%- set tbl_relations = [] -%}
        {%- for row in table_list['table'] -%}
            {%- set tbl_relation = api.Relation.create(
                database=database,
                schema=row.table_schema,
                identifier=row.table_name
            ) -%}
            {%- do tbl_relations.append(tbl_relation) -%}
        {%- endfor -%}

        {{ return(tbl_relations) }}
    {%- else -%}
        {{ return([]) }}
    {%- endif -%}

{% endmacro %}