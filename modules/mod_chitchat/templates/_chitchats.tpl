<div class="zp-100" id="chat-box" style="height: 200px; width:300; overflow: auto;">
    <ul id="chitchat-list" class="chitchats-list">
        {% if m.chitchat.count[id] > 1 %}
        {% for chitchat in m.chitchat.rsc[id] %}
            {% include "_chitchats_chitchat.tpl" %}
        {% endfor %}
        {% else %}
            <div class="error"><p style="color: red;">No chat log for this resource</p></div>
        {% endif %}
    </ul>
</div>
