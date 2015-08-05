/*$(document).on('page:update', function(){
    $('.searchbox').not('.has_select2').select2({
        minimumInputLength: 2,
        ajax: {
            url: '/docs',
            dataType: 'json',
            quietMillis: 500,
            data: function(term, page) {
                return {
                    q: term
                };
            },
            results: function(data, page) {
                return {
                    results: $.map(data, function (val, i) {
                        return { 
                            id: 'foobz',
                            text: val.name
                        }
                    })
                };
            },
        },
    });

    $('.searchbox').not('.has_select2').addClass('has_select2');
});*/