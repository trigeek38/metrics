<div class="span-10 error" id="down_node_{{id}}" {% ifequal "up" id.status %} style="display: none;" {% endifequal %}>
    <h3>{{ id.title }} is down</h3>
{% wire action={connect signal={chat session = id} action={postback postback={newchitchat id=id} delegate="mod_chitchat" }}  %}
{% button text="Chat" action={dialog_open title="Enter a nick and start chatting" template="_add_chat.tpl" id=id} %}

</div>

    {% with ["node_", id]|join, ["down_node_", id]|join as  node_id, down_node_id %}
        {% wire id=down_node_id action={postback postback={make_available node = down_node_id id = id} delegate="metrics"} %}
    {% endwith %}

