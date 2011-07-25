<div class="span-10 success" id="node_{{id}}" {% ifequal "down" id.status %} style="display: none;" {% endifequal %}>
    <h3>{{ id.title }} is up </h3>
</div>
    {% with ["node_", id]|join, ["down_node_", id]|join as  node_id, down_node_id %}
        {% wire id=node_id action={postback postback={make_unavailable node = node_id id = id} delegate="metrics"} %}
    {% endwith %}

