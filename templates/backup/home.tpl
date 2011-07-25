{% extends "metrics_base.tpl" %}
{% block content %}
    {% block left%}
        <div class="span-12">
        {% include "_left.tpl" %}
        </div>
    {% endblock %}
    {% block right%}
        <div class="span-11 last">
        {% include "_right.tpl" %}
        </div>
    {% endblock %}
{% endblock %}

