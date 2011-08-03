<div id="down_nodes" class="span-11">
<div><h2>Down Modalities</h2></div>
{% for id in m.search[{query cat="node" sort="pivot_title"}] %}
    {% include "_down_node_item.tpl" id=id %}
{% endfor %}
</div>

