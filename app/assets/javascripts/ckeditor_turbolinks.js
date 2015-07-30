// https://github.com/tsechingho/ckeditor-rails/issues/28

  $(document).on('page:update', function(){
    try {
      if ($('.ckeditor')[0]) {
          CKEDITOR.replace($('.ckeditor').attr('id'));
      }
    }
    catch(e) { }
  });
  