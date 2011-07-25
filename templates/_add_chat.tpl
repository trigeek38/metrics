<div class="zp-100">
{% include "_chitchats.tpl" id=id %}
</div>
<div class="clearfix"></div>
<div class="zp-100">
{% include "_chitchats_form.tpl" id=id %}
{% button text="Close Chat" action={dialog_close} action={reload}%}
</div>

