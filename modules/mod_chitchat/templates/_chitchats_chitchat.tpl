<li {% if hidden %}style="display: none"{% endif %} id="chitchat-{{ chitchat.id }}">
	{{ chitchat.name }} - <b>{{ chitchat.message }}</b> {{ chitchat.created|timesince }}
</li>
