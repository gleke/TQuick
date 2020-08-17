function openFile(fileUrl,callback){
    var doc = new XMLHttpRequest();
    doc.onreadystatechange = function() {
        if (doc.readyState === XMLHttpRequest.DONE) {
            callback(doc.responseText);
        }
    }
    doc.open("GET", fileUrl);
    doc.send();
}


function parser(lrc_data){
    if(!lrc_data || lrc_data.length === 0){
        return;
    }

    var list = [];
    var lrcs = lrc_data.split('\n');
    for(var i in lrcs) {
        lrcs[i] = lrcs[i].replace(/(^\s*)|(\s*$)/g, ""); 
        var t = lrcs[i].substring(lrcs[i].indexOf("[") + 1, lrcs[i].indexOf("]"));
        var s = t.split(":");
        if(isNaN(parseInt(s[0]))) {
//            var obj = {};
        }else {
            var arr = lrcs[i].match(/\[(\d+:.+?)\]/g);
            var start = 0;
            for(var k in arr){
                start += arr[k].length; 
            }
            var content = lrcs[i].substring(start);
            for (var k in arr){
                var t = arr[k].substring(1, arr[k].length-1);
                var s = t.split(":");

                var itemobj = {};
                itemobj.tag = "item";
                itemobj.value = content
                itemobj.time = (parseFloat(s[0])*60+parseFloat(s[1])).toFixed(3);

                list.push(itemobj);
            }
        }
    }

    return list;
}
