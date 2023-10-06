{% macro get_event_tables(schema, database=target.database) %}
    
    select distinct
            table_schema as {{ adapter.quote('table_schema') }},
            table_name as {{ adapter.quote('table_name') }}
        from {{ database }}.information_schema.tables
        where table_schema ilike '{{ schema }}'
        AND table_name not in ('ALIASES', 'GROUPS', 'IDENTIFIES', 'PAGES', 'SCREENS', 'TRACKS', 'USERS')

{% endmacro %}  