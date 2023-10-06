{% macro union_event_tables(schema, database=target.database) %}
    {%- set event_relations = get_event_table_relation_list(schema=schema) -%}
    {# Prevent querying of db in parsing mode. This works because this macro does not create any new refs. -#}
	{%- if not execute -%}
        {{ return('') }}
    {%- endif -%}

    {%- set cols = adapter.get_columns_in_relation(source(schema, 'TRACKS')) -%}
    {%- set common_columns = {} -%}
    {%- for col in cols -%}
        {%- do common_columns.update({col.column: col}) -%}
    {% endfor %}
    
    {%- for relation in event_relations -%}
        {%- set cols = adapter.get_columns_in_relation(relation) -%}
        {%- set column_names = [] -%}
        {%- for col in cols -%}
            {%- do column_names.append(col.column) -%}
        {%- endfor %}
        {% do column_names.sort() %}
        {% set union_columns_set = set(column_names).union(common_columns.keys()) %}
        {% set union_columns = [] %}
        {%- for col in union_columns_set -%}
            {%- do union_columns.append(col) -%}
        {%- endfor -%}
        {%- do union_columns.sort() -%}
        {% set properties = [] %}
        SELECT  
        {% for column in union_columns -%}
            {%- if column in common_columns and column in column_names -%}
                {{column}} as {{column}},
            {%- elif column in common_columns and column not in column_names -%}
                null as {{column}},
            {%- else -%}
                {% do properties.append("'" + column + "'") %}
                {% do properties.append(column) %}
            {%- endif %} 
        {%- endfor %}
        object_construct(
        {%- for item in properties -%}
            {{ item }}
            {%- if not loop.last -%}, {%- endif %} 
        {%- endfor -%}
        ) as properties
        from {{relation}}
        {% if not loop.last -%}
            UNION ALL
        {%- endif -%}
    {%- endfor -%}
{%- endmacro -%}
