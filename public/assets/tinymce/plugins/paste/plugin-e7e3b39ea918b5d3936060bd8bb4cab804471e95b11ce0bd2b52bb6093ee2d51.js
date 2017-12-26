!function(){var e={},t=function(t){for(var n=e[t],i=n.deps,o=n.defn,a=i.length,s=new Array(a),l=0;l<a;++l)s[l]=r(i[l]);var u=o.apply(null,s);if(void 0===u)throw"module ["+t+"] returned undefined";n.instance=u},n=function(t,n,r){if("string"!=typeof t)throw"module id must be a string";if(void 0===n)throw"no dependencies for "+t;if(void 0===r)throw"no definition function for "+t;e[t]={deps:n,defn:r,instance:void 0}},r=function(n){var r=e[n];if(void 0===r)throw"module ["+n+"] was undefined";return void 0===r.instance&&t(n),r.instance},i=function(e,t){for(var n=e.length,i=new Array(n),o=0;o<n;++o)i.push(r(e[o]));t.apply(null,t)};({}).bolt={module:{api:{define:n,require:i,demand:r}}};var o=n;(function(e,t){o(e,[],function(){return t})})("6",tinymce.util.Tools.resolve),o("1",["6"],function(e){return e("tinymce.PluginManager")}),o("7",["6"],function(e){return e("tinymce.dom.RangeUtils")}),o("8",["6"],function(e){return e("tinymce.Env")}),o("9",["6"],function(e){return e("tinymce.util.Delay")}),o("a",["6"],function(e){return e("tinymce.util.Tools")}),o("b",["6"],function(e){return e("tinymce.util.VK")}),o("c",[],function(){var e="x-tinymce/html",t="<!-- "+e+" -->";return{mark:function(e){return t+e},unmark:function(e){return e.replace(t,"")},isMarked:function(e){return-1!==e.indexOf(t)},internalHtmlMime:function(){return e}}}),o("g",["6"],function(e){return e("tinymce.html.DomParser")}),o("h",["6"],function(e){return e("tinymce.html.Schema")}),o("d",["a","g","h"],function(e,t,n){function r(t,n){return e.each(n,function(e){t=e.constructor==RegExp?t.replace(e,""):t.replace(e[0],e[1])}),t}function i(i){function o(e){var t=e.name,n=e;if("br"===t)return void(l+="\n");if(u[t]&&(l+=" "),c[t])return void(l+=" ");if(3==e.type&&(l+=e.value),!e.shortEnded&&(e=e.firstChild))do{o(e)}while(e=e.next);f[t]&&n.next&&(l+="\n","p"==t&&(l+="\n"))}var a=new n,s=new t({},a),l="",u=a.getShortEndedElements(),c=e.makeMap("script noscript style textarea video audio iframe object"," "),f=a.getBlockElements();return i=r(i,[/<!\[[^\]]+\]>/g]),o(s.parse(i)),l}function o(e){function t(e,t,n){return t||n?"\xa0":" "}return e=r(e,[/^[\s\S]*<body[^>]*>\s*|\s*<\/body[^>]*>[\s\S]*$/gi,/<!--StartFragment-->|<!--EndFragment-->/g,[/( ?)<span class="Apple-converted-space">\u00a0<\/span>( ?)/g,t],/<br class="Apple-interchange-newline">/g,/<br>$/i])}function a(e){var t=0;return function(){return e+t++}}return{filter:r,innerText:i,trimHtml:o,createIdGenerator:a,isMsEdge:function(){return-1!==navigator.userAgent.indexOf(" Edge/")}}}),o("3",["8","c","d"],function(e,t,n){var r=function(){},i=function(t){return!1===e.iOS&&void 0!==t&&"function"==typeof t.setData&&!0!==n.isMsEdge()},o=function(e,n,r){if(!i(e))return!1;try{return e.clearData(),e.setData("text/html",n),e.setData("text/plain",r),e.setData(t.internalHtmlMime(),n),!0}catch(e){return!1}},a=function(e,t,n,r){o(e.clipboardData,t.html,t.text)?(e.preventDefault(),r()):n(t.html,r)},s=function(e){return function(n,r){var i=t.mark(n),o=e.dom.create("div",{contenteditable:"false"}),a=e.dom.create("div",{contenteditable:"true"},i);e.dom.setStyles(o,{position:"fixed",left:"-3000px",width:"1000px",overflow:"hidden"}),o.appendChild(a),e.dom.add(e.getBody(),o);var s=e.selection.getRng();a.focus();var l=e.dom.createRng();l.selectNodeContents(a),e.selection.setRng(l),setTimeout(function(){o.parentNode.removeChild(o),e.selection.setRng(s),r()},0)}},l=function(e){return{html:e.selection.getContent(),text:e.selection.getContent({format:"text"})}},u=function(e){return function(t){!1===e.selection.isCollapsed()&&a(t,l(e),s(e),function(){e.execCommand("Delete")})}},c=function(e){return function(t){!1===e.selection.isCollapsed()&&a(t,l(e),s(e),r)}};return{register:function(e){e.on("cut",u(e)),e.on("copy",c(e))}}}),o("k",["6"],function(e){return e("tinymce.html.Entities")}),o("e",["k"],function(e){var t=function(e){return!/<(?:(?!\/?(?:div|p|br))[^>]*|(?:div|p|br)\s+\w[^>]+)>/.test(e)},n=function(e){return e.replace(/\r?\n/g,"<br>")},r=function(t,n){var r,i=[],o="<"+t;if("object"==typeof n){for(r in n)n.hasOwnProperty(r)&&i.push(r+'="'+e.encodeAllRaw(n[r])+'"');i.length&&(o+=" "+i.join(" "))}return o+">"},i=function(e,t,n){var i,o,a,s=e.split(/\r?\n/),l=0,u=s.length,c=[],f=[],d=r(t,n),p="</"+t+">";if(1===s.length)return e;for(;l<u;l++)i=l===u-1,o=!i&&!s[l+1],a=!s[l]&&!c.length,c.push(s[l]?s[l]:"&nbsp;"),(i||o||a)&&(f.push(c.join("<br>")),c=[]),o&&l++;return 1===f.length?f[0]:d+f.join(p+d)+p};return{isPlainText:t,convert:function(e,t,r){return t?i(e,t,r):n(e)},toBRs:n,toBlockElements:i}}),o("f",["a"],function(e){var t=function(e){return/^https?:\/\/[\w\?\-\/+=.&%@~#]+$/i.test(e)},n=function(e){return t(e)&&/.(gif|jpe?g|png)$/.test(e)},r=function(e,t,n){return e.undoManager.extra(function(){n(e,t)},function(){e.insertContent('<img src="'+t+'">')}),!0},i=function(e,t,n){return e.undoManager.extra(function(){n(e,t)},function(){e.execCommand("mceInsertLink",!1,t)}),!0},o=function(e,n,r){return!(!1!==e.selection.isCollapsed()||!t(n))&&i(e,n,r)},a=function(e,t,i){return!!n(t)&&r(e,t,i)},s=function(e,t){return e.insertContent(t,{merge:!1!==e.settings.paste_merge_formats,paste:!0}),!0},l=function(t,n){e.each([o,a,s],function(e){return!0!==e(t,n,s)})};return{isImageUrl:n,isAbsoluteUrl:t,insertContent:function(e,t){!1===e.settings.smart_paste?s(e,t):l(e,t)}}}),o("2",["7","8","9","a","b","3","c","e","f","d"],function(e,t,n,r,i,o,a,s,l,u){return function(o){function c(e,t){var n,r,i=o.dom;if(r=t||a.isMarked(e),e=a.unmark(e),n=o.fire("BeforePastePreProcess",{content:e,internal:r}),n=o.fire("PastePreProcess",n),e=n.content,!n.isDefaultPrevented()){if(o.hasEventListeners("PastePostProcess")&&!n.isDefaultPrevented()){var s=i.add(o.getBody(),"div",{style:"display:none"},e);n=o.fire("PastePostProcess",{node:s,internal:r}),i.remove(s),e=n.node.innerHTML}n.isDefaultPrevented()||l.insertContent(o,e)}}function f(e){e=o.dom.encode(e).replace(/\r\n/g,"\n"),e=s.convert(e,o.settings.forced_root_block,o.settings.forced_root_block_attrs),c(e,!1)}function d(){function e(e){var t,n,i,o=e.startContainer;if(t=e.getClientRects(),t.length)return t[0];if(e.collapsed&&1==o.nodeType){for(i=o.childNodes[R.startOffset];i&&3==i.nodeType&&!i.data.length;)i=i.nextSibling;if(i)return"BR"==i.tagName&&(n=r.doc.createTextNode("\ufeff"),i.parentNode.insertBefore(n,i),e=r.createRng(),e.setStartBefore(n),e.setEndAfter(n),t=e.getClientRects(),r.remove(n)),t.length?t[0]:void 0}}var n,r=o.dom,i=o.getBody(),a=o.dom.getViewPort(o.getWin()),s=a.y,l=20;if(R=o.selection.getRng(),o.inline&&(n=o.selection.getScrollContainer())&&n.scrollTop>0&&(s=n.scrollTop),R.getClientRects){var u=e(R);if(u)l=s+(u.top-r.getPos(i).y);else{l=s;var c=R.startContainer;c&&(3==c.nodeType&&c.parentNode!=i&&(c=c.parentNode),1==c.nodeType&&(l=r.getPos(c,n||i).y))}}T=r.add(o.getBody(),"div",{id:"mcepastebin",contentEditable:!0,"data-mce-bogus":"all",style:"position: absolute; top: "+l+"px;width: 10px; height: 10px; overflow: hidden; opacity: 0"},B),(t.ie||t.gecko)&&r.setStyle(T,"left","rtl"==r.getStyle(i,"direction",!0)?65535:-65535),r.bind(T,"beforedeactivate focusin focusout",function(e){e.stopPropagation()}),T.focus(),o.selection.select(T,!0)}function p(){if(T){for(var e;e=o.dom.get("mcepastebin");)o.dom.remove(e),o.dom.unbind(e);R&&o.selection.setRng(R)}T=R=null}function m(){var e,t,n,r,i="";for(e=o.dom.select("div[id=mcepastebin]"),t=0;t<e.length;t++)n=e[t],n.firstChild&&"mcepastebin"==n.firstChild.id&&(n=n.firstChild),r=n.innerHTML,i!=B&&(i+=r);return i}function g(e){var t={};if(e){if(e.getData){var n=e.getData("Text");n&&n.length>0&&-1==n.indexOf(A)&&(t["text/plain"]=n)}if(e.types)for(var r=0;r<e.types.length;r++){var i=e.types[r];t[i]=e.getData(i)}}return t}function v(e){var t=g(e.clipboardData||o.getDoc().dataTransfer);return u.isMsEdge()?r.extend(t,{"text/html":""}):t}function h(e){return C(e,"text/html")||C(e,"text/plain")}function b(e){var t;return t=e.indexOf(","),-1!==t?e.substr(t+1):null}function x(e,t){return!e.images_dataimg_filter||e.images_dataimg_filter(t)}function y(e,t,n){e&&(o.selection.setRng(e),e=null);var r=t.result,i=b(r),a=new Image;if(a.src=r,x(o.settings,a)){var s,l,u=o.editorUpload.blobCache;l=u.findFirst(function(e){return e.base64()===i}),l?s=l:(s=u.create(O(),n,i),u.add(s)),c('<img src="'+s.blobUri()+'">',!1)}else c('<img src="'+r+'">',!1)}function w(e,t){function n(n){var r,i,o,a=!1;if(n)for(r=0;r<n.length;r++)if(i=n[r],/^image\/(jpeg|png|gif|bmp)$/.test(i.type)){var s=i.getAsFile?i.getAsFile():i;o=new FileReader,o.onload=y.bind(null,t,o,s),o.readAsDataURL(s),e.preventDefault(),a=!0}return a}var r=e.clipboardData||e.dataTransfer;if(o.settings.paste_data_images&&r)return n(r.items)||n(r.files)}function P(e){var t=e.clipboardData;return-1!=navigator.userAgent.indexOf("Android")&&t&&t.items&&0===t.items.length}function _(t){return e.getCaretRangeFromPoint(t.clientX,t.clientY,o.getDoc())}function C(e,t){return t in e&&e[t].length>0}function k(e){return i.metaKeyPressed(e)&&86==e.keyCode||e.shiftKey&&45==e.keyCode}function D(){function e(e,t,n,r){var i,a;return C(e,"text/html")?i=e["text/html"]:(i=m())==B&&(n=!0),i=u.trimHtml(i),T&&T.firstChild&&"mcepastebin"===T.firstChild.id&&(n=!0),p(),a=!1===r&&s.isPlainText(i),i.length&&!a||(n=!0),n&&(i=C(e,"text/plain")&&a?e["text/plain"]:u.innerText(i)),i==B?void(t||o.windowManager.alert("Please use Ctrl+V/Cmd+V keyboard shortcuts to paste contents.")):void(n?f(i):c(i,r))}function r(e){var t=e["text/plain"];return!!t&&0===t.indexOf("file://")}o.on("keydown",function(e){function n(e){k(e)&&!e.isDefaultPrevented()&&p()}if(k(e)&&!e.isDefaultPrevented()){if((M=e.shiftKey&&86==e.keyCode)&&t.webkit&&-1!=navigator.userAgent.indexOf("Version/"))return;if(e.stopImmediatePropagation(),E=(new Date).getTime(),t.ie&&M)return e.preventDefault(),void o.fire("paste",{ieFake:!0});p(),d(),o.once("keyup",n),o.once("paste",function(){o.off("keyup",n)})}});var i=function(){return R||o.selection.getRng()};o.on("paste",function(r){var s=(new Date).getTime(),l=v(r),u=(new Date).getTime()-s,c=(new Date).getTime()-E-u<1e3,f="text"==F.pasteFormat||M,g=C(l,a.internalHtmlMime());return M=!1,r.isDefaultPrevented()||P(r)?void p():!h(l)&&w(r,i())?void p():(c||r.preventDefault(),!t.ie||c&&!r.ieFake||C(l,"text/html")||(d(),o.dom.bind(T,"paste",function(e){e.stopPropagation()}),o.getDoc().execCommand("Paste",!1,null),l["text/html"]=m()),void(C(l,"text/html")?(r.preventDefault(),e(l,c,f,g)):n.setEditorTimeout(o,function(){e(l,c,f,g)},0)))}),o.on("dragstart dragend",function(e){S="dragstart"==e.type}),o.on("drop",function(e){var t,i;if(i=_(e),!e.isDefaultPrevented()&&!S){t=g(e.dataTransfer);var s=C(t,a.internalHtmlMime());if((h(t)&&!r(t)||!w(e,i))&&i&&!1!==o.settings.paste_filter_drop){var l=t["mce-internal"]||t["text/html"]||t["text/plain"];l&&(e.preventDefault(),n.setEditorTimeout(o,function(){o.undoManager.transact(function(){t["mce-internal"]&&o.execCommand("Delete"),o.selection.setRng(i),l=u.trimHtml(l),t["text/html"]?c(l,s):f(l)})}))}}}),o.on("dragover dragend",function(e){o.settings.paste_data_images&&e.preventDefault()})}var T,R,M,F=this,E=0,S=!1,B="%MCEPASTEBIN%",A="data:text/mce-internal,",O=u.createIdGenerator("mceclip");F.pasteHtml=c,F.pasteText=f,F.pasteImageData=w,o.on("preInit",function(){D(),o.parser.addNodeFilter("img",function(e,n,r){function i(e){return e.data&&!0===e.data.paste}function a(e){e.attr("data-mce-object")||c===t.transparentSrc||e.remove()}function s(e){return 0===e.indexOf("webkit-fake-url")}function l(e){return 0===e.indexOf("data:")}if(!o.settings.paste_data_images&&i(r))for(var u=e.length;u--;){var c=e[u].attributes.map.src;c&&(s(c)?a(e[u]):!o.settings.allow_html_data_urls&&l(c)&&a(e[u]))}})})}}),o("i",["6"],function(e){return e("tinymce.html.Serializer")}),o("j",["6"],function(e){return e("tinymce.html.Node")}),o("5",["a","g","h","i","j","d"],function(e,t,n,r,i,o){function a(e){return/<font face="Times New Roman"|class="?Mso|style="[^"]*\bmso-|style='[^'']*\bmso-|w:WordDocument/i.test(e)||/class="OutlineElement/.test(e)||/id="?docs\-internal\-guid\-/.test(e)}function s(t){var n,r;return r=[/^[IVXLMCD]{1,2}\.[ \u00a0]/,/^[ivxlmcd]{1,2}\.[ \u00a0]/,/^[a-z]{1,2}[\.\)][ \u00a0]/,/^[A-Z]{1,2}[\.\)][ \u00a0]/,/^[0-9]+\.[ \u00a0]/,/^[\u3007\u4e00\u4e8c\u4e09\u56db\u4e94\u516d\u4e03\u516b\u4e5d]+\.[ \u00a0]/,/^[\u58f1\u5f10\u53c2\u56db\u4f0d\u516d\u4e03\u516b\u4e5d\u62fe]+\.[ \u00a0]/],t=t.replace(/^[\u00a0 ]+/,""),e.each(r,function(e){if(e.test(t))return n=!0,!1}),n}function l(e){return/^[\s\u00a0]*[\u2022\u00b7\u00a7\u25CF]\s*/.test(e)}function u(u){var c=u.settings;u.on("BeforePastePreProcess",function(f){function d(e){function t(e){var n="";if(3===e.type)return e.value;if(e=e.firstChild)do{n+=t(e)}while(e=e.next);return n}function n(e,t){if(3===e.type&&t.test(e.value))return e.value=e.value.replace(t,""),!1;if(e=e.firstChild)do{if(!n(e,t))return!1}while(e=e.next);return!0}function r(e){if(e._listIgnore)return void e.remove();if(e=e.firstChild)do{r(e)}while(e=e.next)}function o(e,t,o){var s=e._listLevel||c;s!=c&&(s<c?a&&(a=a.parent.parent):(u=a,a=null)),a&&a.name==t?a.append(e):(u=u||a,a=new i(t,1),o>1&&a.attr("start",""+o),e.wrap(a)),e.name="li",s>c&&u&&u.lastChild.append(a),c=s,r(e),n(e,/^\u00a0+/),n(e,/^\s*([\u2022\u00b7\u00a7\u25CF]|\w+\.)/),n(e,/^\u00a0+/)}for(var a,u,c=1,f=[],d=e.firstChild;void 0!==d&&null!==d;)if(f.push(d),null!==(d=d.walk()))for(;void 0!==d&&d.parent!==e;)d=d.walk();for(var p=0;p<f.length;p++)if(e=f[p],"p"==e.name&&e.firstChild){var m=t(e);if(l(m)){o(e,"ul");continue}if(s(m)){var g=/([0-9]+)\./.exec(m),v=1;g&&(v=parseInt(g[1],10)),o(e,"ol",v);continue}if(e._listLevel){o(e,"ul",1);continue}a=null}else u=a,a=null}function p(t,n){var r,o={},a=u.dom.parseStyle(n);return e.each(a,function(e,i){switch(i){case"mso-list":r=/\w+ \w+([0-9]+)/i.exec(n),r&&(t._listLevel=parseInt(r[1],10)),/Ignore/i.test(e)&&t.firstChild&&(t._listIgnore=!0,t.firstChild._listIgnore=!0);break;case"horiz-align":i="text-align";break;case"vert-align":i="vertical-align";break;case"font-color":case"mso-foreground":i="color";break;case"mso-background":case"mso-highlight":i="background";break;case"font-weight":case"font-style":return void("normal"!=e&&(o[i]=e));case"mso-element":if(/^(comment|comment-list)$/i.test(e))return void t.remove()}return 0===i.indexOf("mso-comment")?void t.remove():void(0!==i.indexOf("mso-")&&("all"==m||g&&g[i])&&(o[i]=e))}),/(bold)/i.test(o["font-weight"])&&(delete o["font-weight"],t.wrap(new i("b",1))),/(italic)/i.test(o["font-style"])&&(delete o["font-style"],t.wrap(new i("i",1))),(o=u.dom.serializeStyle(o,t.name))||null}var m,g,v=f.content;if(v=v.replace(/<b[^>]+id="?docs-internal-[^>]*>/gi,""),v=v.replace(/<br class="?Apple-interchange-newline"?>/gi,""),m=c.paste_retain_style_properties,m&&(g=e.makeMap(m.split(/[, ]/))),!1!==c.paste_enable_default_filters&&a(f.content)){f.wordContent=!0,v=o.filter(v,[/<!--[\s\S]+?-->/gi,/<(!|script[^>]*>.*?<\/script(?=[>\s])|\/?(\?xml(:\w+)?|img|meta|link|style|\w:\w+)(?=[\s\/>]))[^>]*>/gi,[/<(\/?)s>/gi,"<$1strike>"],[/&nbsp;/gi,"\xa0"],[/<span\s+style\s*=\s*"\s*mso-spacerun\s*:\s*yes\s*;?\s*"\s*>([\s\u00a0]*)<\/span>/gi,function(e,t){return t.length>0?t.replace(/./," ").slice(Math.floor(t.length/2)).split("").join("\xa0"):""}]]);var h=c.paste_word_valid_elements;h||(h="-strong/b,-em/i,-u,-span,-p,-ol,-ul,-li,-h1,-h2,-h3,-h4,-h5,-h6,-p/div,-a[href|name],sub,sup,strike,br,del,table[width],tr,td[colspan|rowspan|width],th[colspan|rowspan|width],thead,tfoot,tbody");var b=new n({valid_elements:h,valid_children:"-li[p]"});e.each(b.elements,function(e){e.attributes["class"]||(e.attributes["class"]={},e.attributesOrder.push("class")),e.attributes.style||(e.attributes.style={},e.attributesOrder.push("style"))});var x=new t({},b);x.addAttributeFilter("style",function(e){for(var t,n=e.length;n--;)t=e[n],t.attr("style",p(t,t.attr("style"))),"span"==t.name&&t.parent&&!t.attributes.length&&t.unwrap()}),x.addAttributeFilter("class",function(e){for(var t,n,r=e.length;r--;)t=e[r],n=t.attr("class"),/^(MsoCommentReference|MsoCommentText|msoDel)$/i.test(n)&&t.remove(),t.attr("class",null)}),x.addNodeFilter("del",function(e){for(var t=e.length;t--;)e[t].remove()}),x.addNodeFilter("a",function(e){for(var t,n,r,i=e.length;i--;)if(t=e[i],n=t.attr("href"),r=t.attr("name"),n&&-1!=n.indexOf("#_msocom_"))t.remove();else if(n&&0===n.indexOf("file://")&&(n=n.split("#")[1])&&(n="#"+n),n||r){if(r&&!/^_?(?:toc|edn|ftn)/i.test(r)){t.unwrap();continue}t.attr({href:n,name:r})}else t.unwrap()});var y=x.parse(v);!1!==c.paste_convert_word_fake_lists&&d(y),f.content=new r({validate:c.validate},b).serialize(y)}})}return u.isWordContent=a,u}),o("4",["8","a","5","d"],function(e,t,n,r){"use strict";return function(i){function o(e){i.on("BeforePastePreProcess",function(t){t.content=e(t.content)})}function a(e){i.on("PastePostProcess",function(t){e(t.node)})}function s(e){if(!n.isWordContent(e))return e;var o=[];t.each(i.schema.getBlockElements(),function(e,t){o.push(t)});var a=new RegExp("(?:<br>&nbsp;[\\s\\r\\n]+|<br>)*(<\\/?("+o.join("|")+")[^>]*>)(?:<br>&nbsp;[\\s\\r\\n]+|<br>)*","g");return e=r.filter(e,[[a,"$1"]]),e=r.filter(e,[[/<br><br>/g,"<BR><BR>"],[/<br>/g," "],[/<BR><BR>/g,"<br>"]])}function l(e){if(n.isWordContent(e))return e;var t=i.settings.paste_webkit_styles;if(!1===i.settings.paste_remove_styles_if_webkit||"all"==t)return e;if(t&&(t=t.split(/[, ]/)),t){var r=i.dom,o=i.selection.getNode();e=e.replace(/(<[^>]+) style="([^"]*)"([^>]*>)/gi,function(e,n,i,a){var s=r.parseStyle(r.decode(i),"span"),l={};if("none"===t)return n+a;for(var u=0;u<t.length;u++){var c=s[t[u]],f=r.getStyle(o,t[u],!0);/color/.test(t[u])&&(c=r.toHex(c),f=r.toHex(f)),f!=c&&(l[t[u]]=c)}return l=r.serializeStyle(l,"span"),l?n+' style="'+l+'"'+a:n+a})}else e=e.replace(/(<[^>]+) style="([^"]*)"([^>]*>)/gi,"$1$3");return e=e.replace(/(<[^>]+) data-mce-style="([^"]+)"([^>]*>)/gi,function(e,t,n,r){return t+' style="'+n+'"'+r})}function u(e){i.$("a",e).find("font,u").each(function(e,t){i.dom.remove(t,!0)})}e.webkit&&o(l),e.ie&&(o(s),a(u))}}),o("0",["1","2","3","4","5"],function(e,t,n,r,i){var o;return e.add("paste",function(a){function s(){return o||!1===a.settings.paste_plaintext_inform}function l(){if("text"==c.pasteFormat)c.pasteFormat="html",a.fire("PastePlainTextToggle",{state:!1});else if(c.pasteFormat="text",a.fire("PastePlainTextToggle",{state:!0}),!s()){var e=a.translate("Paste is now in plain text mode. Contents will now be pasted as plain text until you toggle this option off.");a.notificationManager.open({text:e,type:"info"}),o=!0}a.focus()}function u(){var e=this;e.active("text"===c.pasteFormat),a.on("PastePlainTextToggle",function(t){e.active(t.state)})}var c,f=this,d=a.settings;return/(^|[ ,])powerpaste([, ]|$)/.test(d.plugins)&&e.get("powerpaste")?void("undefined"!=typeof console&&console.log&&console.log("PowerPaste is incompatible with Paste plugin! Remove 'paste' from the 'plugins' option.")):(f.clipboard=c=new t(a),f.quirks=new r(a),f.wordFilter=new i(a),a.settings.paste_as_text&&(f.clipboard.pasteFormat="text"),d.paste_preprocess&&a.on("PastePreProcess",function(e){d.paste_preprocess.call(f,f,e)}),d.paste_postprocess&&a.on("PastePostProcess",function(e){d.paste_postprocess.call(f,f,e)}),a.addCommand("mceInsertClipboardContent",function(e,t){t.content&&f.clipboard.pasteHtml(t.content,t.internal),t.text&&f.clipboard.pasteText(t.text)}),a.settings.paste_block_drop&&a.on("dragend dragover draggesture dragdrop drop drag",function(e){e.preventDefault(),e.stopPropagation()}),a.settings.paste_data_images||a.on("drop",function(e){var t=e.dataTransfer;t&&t.files&&t.files.length>0&&e.preventDefault()}),a.addCommand("mceTogglePlainTextPaste",l),a.addButton("pastetext",{icon:"pastetext",tooltip:"Paste as text",onclick:l,onPostRender:u}),a.addMenuItem("pastetext",{text:"Paste as text",selectable:!0,active:c.pasteFormat,onclick:l,onPostRender:u}),void n.register(a))}),function(){}}),r("0")()}();