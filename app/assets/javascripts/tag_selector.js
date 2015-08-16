$(document).on('page:load ready', function(){
    $('.tag_selector').select2({
        tags: true,
        tokenSeparators: [','],
        createSearchChoice: function (term) {
            return {
                id: $.trim(term),
                text: $.trim(term) + ' (new tag)'
            };
        },
        ajax: {
            url: '/tags',
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
                            id: val,
                            text: val 
                        }
                    })
                };
            },
        },
        initSelection: function (element, callback) {
            var data = [];

            function splitVal(string, separator) {
                var val, i, l;
                if (string === null || string.length < 1) return [];
                val = string.split(separator);
                for (i = 0, l = val.length; i < l; i = i + 1) val[i] = $.trim(val[i]);
                return val;
            }

            $(splitVal(element.val(), ",")).each(function () {
                data.push({
                    id: this,
                    text: this
                });
            });

            callback(data);
        }
    });
});