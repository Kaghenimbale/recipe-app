$(document).on('change', '.toggle-public', function () {
  const checkbox = $(this);
  const recipeId = checkbox.val();
  const isPublic = checkbox.prop('checked');

  $.ajax({
    type: 'POST',
    url: '/recipes/' + recipeId + '/toggle',
    data: { public: isPublic },
    success: function () {
      checkbox.toggleClass('active', isPublic);
    }
  });
});