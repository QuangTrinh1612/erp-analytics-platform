{% macro quote_column(column) %}
    {% if 'quote' in column %}
        {% if column.quote %}
            {% if target.type in ('bigquery', 'spark', 'databricks') %}            
                `{{ column.name | upper }}`
            {% elif target.type == 'snowflake' %}
                "{{ column.name | upper }}"
            {% else %}
                "{{ column.name }}"
            {% endif %}
        {% else %}
            {{ column.name }}
        {% endif %}
    {% else %}
        {{ column.name }}
    {% endif %}
{% endmacro %}