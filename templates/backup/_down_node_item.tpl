<div class="span-10 error" id="down_node_{{id}}" style="display: none;">
    <h3>{{ id.title }} is Down</h3>
</div>

{% with ["down_node_",id]|join, ["node_", id]|join as down_node_id, node_id %}
    {% wire id=down_node_id action={fade_in target=node_id }
                            action={fade_out target=down_node_id} %}
{% endwith %}


