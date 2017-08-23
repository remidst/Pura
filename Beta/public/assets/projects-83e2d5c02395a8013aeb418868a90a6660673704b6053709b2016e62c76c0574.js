(function() {
  $(document).ready(function() {
    $('#project_user_tokens').tokenInput('/users.json');
    return {
      theme: 'facebook'
    };
  });

}).call(this);
