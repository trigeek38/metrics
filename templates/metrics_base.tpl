<!DOCTYPE html>
<html lang="en">
<head>
	<meta http-equiv="Content-type" content="text/html; charset=utf-8" />
	<title>{% block title %}{{ m.rsc[id].seo_title | default: m.rsc[id].title }}{% endblock %} &mdash; Metrics</title>

	<link rel="icon" href="/lib/images/favicon.ico" type="image/x-icon" />
	<link rel="shortcut icon" href="/favicon.ico" type="image/x-icon" />
	
      	<link rel="stylesheet" href="/lib/css/metrics.css" type="text/css" media="screen, projection" />
        <!-- Framework CSS -->
      	<link rel="stylesheet" href="/lib/css/blueprint/screen.css" type="text/css" media="screen, projection" />
      	<link rel="stylesheet" href="/lib/css/blueprint/print.css" type="text/css" media="print" />
        <!--[if IE]><link rel="stylesheet" href="blueprint/ie.css" type="text/css" media="screen, projection" /><![endif]-->

      	<!-- Import fancy-type plugin. -->
      	<link rel="stylesheet" href="/lib/css/blueprint/plugins/fancy-type/screen.css" type="text/css" media="screen, projection" />
	<meta name="author" content="Jeff Bell" />

	{% all include "_html_head.tpl" %}

	{% lib
		"css/jquery.loadmask.css" 
		"css/zp-dialog.css" 
	%}

	<!--[if IE]>

	<![endif]-->
	
	<!-- Make ie understand html5 -->
	{% lib "js/apps/modernizr.js" %}
{% include "_js_include_jquery.tpl" %}

{% lib
        "js/apps/zotonic-1.0.js"
        "js/apps/z.widgetmanager.js"
        "js/modules/z.notice.js"
        "js/modules/z.imageviewer.js"
        "js/modules/z.dialog.js"
        "js/modules/livevalidation-1.3.js"
        "js/modules/z.inputoverlay.js"
        "js/modules/jquery.loadmask.js"
%}

{% block _js_include_extra %}{% endblock %}

<script type="text/javascript">
        $(function()
        {
            $.widgetManager();
        });
</script>


	{% block html_head_extra %}{% endblock %}
</head>

<body class="{% block page_class %}{% endblock %}">
    <div class="container grid">
    <div class="span-24">
        {% include "_header.tpl" %}
    </div>
	{% block content %}
        {% endblock %}
    <div class="span-24">
        {% include "_footer.tpl" %}
    </div>


        {% stream %}
	{% script %}

</body>
</html>
