	{% wire id="chitchats-form" type="submit" postback={newchitchat id=id} delegate="mod_chitchat" %}
	<form id="chitchats-form" method="post" action="postback">
					<input type="text" name="name" id="name" />
					{% validate id="name"  type={presence} %}
                                        <input type="text" name="message" id="message">
					{% validate id="message" type={presence} %}
					<button type="submit">{_ Send _}</button>
	</form>
