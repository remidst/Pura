// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, or any plugin's
// vendor/assets/javascripts directory can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// compiled file. JavaScript code in this file should be added after the last require_* statement.
//
// Read Sprockets README (https://github.com/rails/sprockets#sprockets-directives) for details
// about supported directives.
//
//= require jquery3
//= require jquery_ujs
//= require jquery.tokeninput
//= require_tree .


$(document).ready(function(){
	$("#project_user_tokens").tokenInput("/users.json",
	{
		queryParam: 'q',
		minChars: 2,
		propertyToSearch: "username",
		hintText: "ユーザー名から検索する",
		noResultsText: "このユーザーは見つかりませんでした。",
		searchingText: "検索中...",
		theme: "facebook",
		preventDuplicates: true,
		prePopulate: $('#project_user_tokens').data('load'),
		resultsFormatter: function(item){ return "<li>" + item.username + " " + item.company + "</li>" },
	});

	$("#flash").delay(4000).animate({height: 'toggle'}, 'slow');

	$("table > tbody > tr[data-link]").not('thead').click(function(){
		window.location = this.dataset.link
	});

	$("#nav-file").click(function(){
		$(".nav-show").removeClass("nav-selected");
		$(this).addClass("nav-selected");
		$(".project-well").removeClass("well-hide");
		$("#well-msg").addClass("well-hide");
	});

	$("#nav-msg").click(function(){
		$(".nav-show").removeClass("nav-selected");
		$(this).addClass("nav-selected");
		$(".project-well").removeClass("well-hide");
		$("#well-document").addClass("well-hide");
	});

	$("conversation-messages").hide();
	$(".conversation-form").hide();


	$("li.conversation-list").first().addClass("conversation-selected");
	$(".conversation-messages").first().show();
	$(".conversation-form").first().show();

	$("li.conversation-list").click(function(){
		$("li.conversation-list").removeClass("conversation-selected");
		$(this).addClass("conversation-selected");
		$(".conversation-messages").hide();
		$(".conversation-form").hide();
		var id_var=$(this).attr('id');
		alert(id_var);
		$(".conversation-messages#messages" + id_var).show();
		$(".conversation-form#form-" + id_var).show();
	});
});

