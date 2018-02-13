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
//= require jquery-fileupload/basic
//= require autosize
//= require turbolinks
//= require jquery.tokeninput
//= require bootstrap-sprockets
//= require cable
//= require_tree .


$(document).on('turbolinks:load', function(){
	$.ajaxSetup({
	  headers: {
	    'X-CSRF-Token': $('meta[name="csrf-token"]').attr('content')
	  }
	});

	
	$("#project_user_tokens").tokenInput("/users.json",
	{
		queryParam: 'q',
		minChars: 1,
		propertyToSearch: "username",
		hintText: "ユーザー名から検索する",
		noResultsText: "このユーザーは見つかりませんでした。",
		searchingText: "検索中...",
		theme: "facebook",
		preventDuplicates: true,
		resultsFormatter: function(item){ return "<li>" + item.username + " " + item.company + "</li>" },
	});

	$("#contact_user_token").tokenInput("/users/company_lookup.json",
	{
		queryParam: 'q',
		minChars: 1,
		propertyToSearch: "username",
		hintText: "ユーザー名から検索する",
		noResultsText: "このユーザーは見つかりませんでした。",
		searchingText: "検索中...",
		theme: "facebook",
		tokenLimit: 1,
		preventDuplicates: true,
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

	autosize($("textarea"));

	$('#publication_publication_attachments_attributes_0_attachment').change(function(){
		var names = [];
		for (var i = 0; i < $(this).get(0).files.length; ++i) {
			names.push($(this).get(0).files[i].name);
		}
		$("#file-display").text(names);
	});

	$('#upload-btn').click(function(){
		$('#publication_publication_attachments_attributes_0_attachment').click();
	});


	$("#reporting_reporting_attachments_attributes_0_attachment").change(function(){
		var names = [];
		for (var j = 0 ; j < $(this).get(0).files.length; ++j) {
			names.push($(this).get(0).files[j].name);
		}
		$("#reporting-file-display").text(names);
	});

	$('a#reporting-file-upload-btn').click(function(){
		$("#reporting_reporting_attachments_attributes_0_attachment").click();
	});

	$("#reporting_attachment_attachment").change(function(){
		$("#add-file-display").show().text("アップロード中です . . .").css('color', 'black');
	});

	$("#reporting-add-file-btn").click(function(){
		$("#reporting_attachment_attachment").click();
	});

	$("#publication_attachment_attachment").change(function(){
		$("#add-attachment-display").show().text("アップロード中です . . .").css('color', 'black');
	});

	$("#publication-add-file-btn").click(function(){
		$("#publication_attachment_attachment").click();
	});



	$(".publication-views").click(function(){
		$(this).find(".publication-views-list").toggleClass("hide");
	});

	$(".publication-comment-readmarks").click(function(){
		$(this).find(".publication_comment_views_list").toggleClass("hide");
	});

	$("#well-document").hide();
	$("#well-specs").hide();

	$("#nav-file").click(function(){
		$(".nav-show").removeClass("nav-selected");
		$(this).addClass("nav-selected");
		$("#well-document").show();
		$("#well-msg").hide();
		$("#well-specs").hide();
	});

	$("#nav-msg").click(function(){
		$(".nav-show").removeClass("nav-selected");
		$(this).addClass("nav-selected");
		$("#well-msg").show();
		$("#well-specs").hide();
		$("#well-document").hide();
	});

	$("#nav-specs").click(function(){
		$(".nav-show").removeClass("nav-selected");
		$(this).addClass("nav-selected");
		$("#well-document").hide();
		$("#well-msg").hide();
		$("#well-specs").show();
	});

	$(".btn-toggle-read").click(function(){
		$this = $(this)
		$this.toggleClass("btn-toggle-read-activated");
		$this.text(($this.text() == "仕事が完了しました") ? "仕事を続ける" : "仕事が完了しました");
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

	$("#copy-background").hide();

	$(".conversation-messages").on("click", ".message-content", function(e){
		$this = $(this)
		$("#copy").css({'top':e.pageY-30, 'left':e.pageX});
		$("#copy-background").show();
		$("#copy").on('click', function(e){
			e.stopPropagation();
			var content = $this.text();
			copyToClipboard($this);
			$("#copy-background").hide();
		});
	});

	$("#copy-background").on('click', function(){
		$(this).hide();
	});

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

function copyToClipboard(element) {
    var $temp = $("<input>");
    $("body").append($temp);
    $temp.val($.trim($(element).text())).select();
    document.execCommand("copy");
    $temp.remove();
}





