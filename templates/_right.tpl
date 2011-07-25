<div id="down_nodes" class="span-11">
<div><h2>Down Modalities</h2></div>
{% for id in m.search[{query cat="node" sort="pivot_title"}] %}
    {% with ["down_node_",id]|join as down_node_id %}
       {% wire action={connect signal={node down_node_id = down_node_id} action={postback postback={bring_up node=down_node_id} delegate="metrics" }}  %}
    {% endwith %}
    {% include "_down_node_item.tpl" id=id %}
{% endfor %}
</div>

