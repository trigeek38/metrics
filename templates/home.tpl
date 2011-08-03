{% extends "metrics_base.tpl" %}
{% block content %}
    {% block left%}
        <div class="span-12" id="nodes-left">
        {% include "_left.tpl" %}
        </div>
    {% endblock %}
    {% block right%}
        <div class="span-11 last" id="nodes-right">
        {% include "_right.tpl" %}
        </div>
    {% endblock %}

    {# whenever a node status changes, refresh both templates. #}
    {% wire action={connect signal={node_status_changed}
        action={update target="nodes-left" template="_left.tpl"}
        action={update target="nodes-right" template="_right.tpl"} }
    %}

{% endblock %}

