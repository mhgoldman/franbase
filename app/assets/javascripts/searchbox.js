function format(obj) {
    text = obj.text;

    if (obj.kind == 'tag') {
        text = "<i class='glyphicon glyphicon-tag'></i>&nbsp;" + obj.text;
    } else if (obj.kind == 'doc') {
        text = "<i class='glyphicon glyphicon-file'></i>&nbsp;" + obj.text;
    }

    container = document.createElement('div');

    if (obj.kind == 'header') {        
        container.className = 'searchbox-collection-header';        
        collname = document.createElement('span');
        collname.innerHTML = text;        
        collname.className = 'searchbox-collection-name';
        collname.title = (collname.textContent || collname.innerText).trim();
        container.appendChild(collname);
        link = document.createElement('span');
        link.className = 'searchbox-collection-more';

        if (obj.num_more > 0) {
            link.innerHTML = "+" + obj.num_more + " more";
        }

        container.appendChild(link);
    } else {
        container.className = 'searchbox-item';
        container.innerHTML = text;        
        container.title = (container.textContent || container.innerText).trim();
    }

    return container;
}

$(document).on('page:load ready', function(){
    MAX_RESULTS = 5;

    $('.searchbox').select2({
        formatResult: format,
        formatSelection: format,
        formatInputTooShort: false,
        minimumInputLength: 2,
        ajax: {
            url: '/search',
            dataType: 'json',
            quietMillis: 500,
            data: function(term, page) {
                return {
                    q: term
                };
            },
            results: function(data, page) {
                q = data.q;

                results = Array();

                // Add tags to result list
                num_tags = data.tags.length;

                if (num_tags > 0) {
                    tags = $.map(data.tags.slice(0,MAX_RESULTS), function (val, i) {
                        return {
                            id: val,
                            text: val,
                            kind: 'tag',
                            url: '/docs?tag=' + val
                        }
                    });

                    results.push(
                        {
                            id: 'tags-header',
                            kind: 'header',
                            text: "Tags",
                            num_more: Math.max(num_tags - MAX_RESULTS, 0),
                            url: encodeURI('/tags?q=' + q),
                            children: tags
                        }
                    );
                }

                // Add docs to result list
                num_docs = data.docs.length;

                if (num_docs > 0) {
                    docs = $.map(data.docs.slice(0,MAX_RESULTS), function (val, i) {
                        return {
                            id: val.name,
                            text: val.name,
                            kind: 'doc',
                            url: '/docs/' + val._id.$oid
                        }
                    });

                    results.push(
                        {
                            id: 'docs-header',
                            kind: 'header',
                            text: "Docs",
                            num_more: Math.max(num_docs - MAX_RESULTS, 0),
                            url: encodeURI('/docs?q=' + q),
                            children: docs
                        }
                    );
                }

                return {
                    results: results
                };
            },
        },
    });

    $('.searchbox').on('select2-selecting', function(e) {
        if (e && e.choice && e.choice.url) {
            location.href = e.choice.url;
        }
    });
});