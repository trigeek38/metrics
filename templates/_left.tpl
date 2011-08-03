<div class="span-11 last" id="up_nodes">
<div><h2>Available Modalities</h2></div>
{% for id in m.search[{query cat="node" sort="pivot_title"}] %}
    {% include "_node_item.tpl" id=id %}
{% endfor %}
</div>
