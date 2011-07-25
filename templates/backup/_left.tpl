<div class="span-11 last" id="up_nodes">
<div><h2>Available Modalities</h2></div>
{% for id in m.search[{query cat="node" sort="pivot_title"}] %}
    {% with ["node_",id]|join as node_id %}
       {% wire action={connect signal={node node_id = node_id} action={postback postback={take_down node=node_id} delegate="metrics" }}  %}
    {% endwith %}
    {% include "_node_item.tpl" id=id %}
{% endfor %}
</div>
