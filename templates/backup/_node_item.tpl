<div class="span-10 success" id="node_{{id}}">
    <h3>{{ id.title }} - is Available</h3>
</div>
    {% with ["node_", id]|join, ["down_node_", id]|join as  node_id, down_node_id %}
        {% wire id=node_id action={postback postback={emit_signal node = node_id } delegate="metrics"} %}
    {% endwith %}

