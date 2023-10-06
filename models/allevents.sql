{{ config(materialized='table') }}

with union_event_stream as (
    {{ union_event_tables(schema=var('segment_schema'))}}
)

SELECT 
    ANONYMOUS_ID as device_id,
    CONTEXT_PAGE_SEARCH,
    EVENT_TEXT as event_name,
    ORIGINAL_TIMESTAMP,
    USER_ID as user_id,
    UUID_TS,
    CONTEXT_LIBRARY_NAME,
    CONTEXT_LIBRARY_VERSION,
    RECEIVED_AT,
    CONTEXT_IP,
    CONTEXT_PAGE_PATH,
    CONTEXT_PAGE_TITLE,
    CONTEXT_PAGE_URL,
    EVENT,
    ID as event_id,
    TIMESTAMP as server_ts,
    CONTEXT_ACTIONS_AMPLITUDE_SESSION_ID,
    CONTEXT_LOCALE,
    CONTEXT_PAGE_REFERRER,
    CONTEXT_USER_AGENT,
    SENT_AT as device_ts,
    properties
from union_event_stream
