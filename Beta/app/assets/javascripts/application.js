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
//= require turbolinks
//= require jquery.tokeninput
//= require bootstrap
//= require cable
//= require_tree .


$(document).on('turbolinks:load', function(){
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

	$("a.btn.btn-info.scroll-home").click(function(){
		$('body,html').animate({
			scrollTop: 0
		}, 1000);
		return false;
	});

	$("#flash").delay(4000).animate({height: 'toggle'}, 'slow');

	$("table > tbody > tr[data-link]").not('thead').click(function(){
		window.location = this.dataset.link
	});

	notificationCount();

	$("#notification-button").click(function(){
		var pos = $(this).position();
		$("#notification-container").css({
			position: "absolute",
			top: pos.bottom + "px",
			right: pos.left + "px",
		});
		$("#notification-container").toggleClass("notification-hidden");
		$("#notification-button").toggleClass("notification-button-selected")
	});

	$(".notifications").click(function(){
		var id_notification = $(this).attr('id');
		var url = $(this).data('notification');
		var content = $(this).text();

		if (content.indexOf("ファイル") >= 0) {
			window.location = url + "?v=" + id_notification + "&to=documents";
		} else {
			window.location = url + "?v=" + id_notification ;
		}
	});



	$(".readmark-count").click(function(){
		$(this).find(".readmark-list").toggleClass("hide");
	});

	$("#well-document").hide();

	$("#nav-file").click(function(){
		$(".nav-show").removeClass("nav-selected");
		$(this).addClass("nav-selected");
		$("#well-document").show();
		$("#well-msg").hide();
	});

	$("#nav-msg").click(function(){
		$(".nav-show").removeClass("nav-selected");
		$(this).addClass("nav-selected");
		$("#well-msg").show();
		$("#well-document").hide();
	});

	$(".conversation-messages").hide();
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
		$(".conversation-messages#messages-" + id_var).show();
		$(".conversation-form.id-" + id_var).show();

	});

	getUrlVars();
	var to = getUrlVars()["to"];
	if (to.indexOf("documents") >= 0) {
		$("#well-msg").hide();
		$("#well-document").show();
		$(".nav-show").removeClass("nav-selected");
		$("#nav-file").addClass("nav-selected");
	}

	$("#file-form").hide();
	$("#file-button").click(function(){
		$(this).hide();
		$("#file-form").show();
	});
	$(".close, .modal").click(function(){
		$("#file-form").hide();
		$("#file-button").show();
	});
	$(".modal-content").click(function(e){
		e.stopPropagation();
	});

	layout();


});


function layout(){
	$(".message-container").each(function() {
		var $this;
		$this = $(this);
		if ($this.data('sender') === current_user_id) {
		  $this.find(".message-username").addClass("self");
		  $this.find(".messages").addClass("message-sent");
		  $this.find(".message-content").addClass("sent");
		  $this.find(".message-info").addClass("self-info");
		  return true;
		}
	});
};

function notificationCount(){
	var pos = $("#notification-button").position();
	$("#notification-count-container").css({
		position: "absolute",
		top: pos.top + "px",
		right: pos.left +  "px",
	})
}

function getUrlVars()
{
    var vars = [], hash;
    var hashes = window.location.href.slice(window.location.href.indexOf('?') + 1).split('&');
    for(var i = 0; i < hashes.length; i++)
    {
        hash = hashes[i].split('=');
        vars.push(hash[0]);
        vars[hash[0]] = hash[1];
    }
    return vars;
}


