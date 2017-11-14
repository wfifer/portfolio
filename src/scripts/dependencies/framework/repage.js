/* repage.js - https://github.com/rstacruz/repage.js
 * includes page.js - https://github.com/visionmedia/page.js
 * @license MIT */
!function(e){if("object"==typeof exports&&"undefined"!=typeof module)module.exports=e();else if("function"==typeof define&&define.amd)define([],e);else{var t;"undefined"!=typeof window?t=window:"undefined"!=typeof global?t=global:"undefined"!=typeof self&&(t=self),t.page=e()}}(function(){var e,t,n;return function i(e,t,n){function r(o,s){if(!t[o]){if(!e[o]){var f=typeof require=="function"&&require;if(!s&&f)return f(o,!0);if(a)return a(o,!0);var u=new Error("Cannot find module '"+o+"'");throw u.code="MODULE_NOT_FOUND",u}var c=t[o]={exports:{}};e[o][0].call(c.exports,function(t){var n=e[o][1][t];return r(n?n:t)},c,c.exports,i,e,t,n)}return t[o].exports}var a=typeof require=="function"&&require;for(var o=0;o<n.length;o++)r(n[o]);return r}({1:[function(e,t,n){var i=e("page");var r=this.setImmediate?this.setImmediate:function(e){window.setTimeout(e,0)};function a(e,t){if("function"==typeof e){return a("*",e)}if("function"==typeof t){i(e,t)}else if("string"===typeof e){a.show(e,t)}else{a.start(e)}}a.start=i.start;a.stop=i.stop;a.dispatch=i.dispatch;a.base=i.base;a.sameOrigin=i.sameOrigin;a.show=function(e,t,n){var r=a.uri(e,t);i.show(r,{},n)};a.replace=function(e,t,n,r){var o=a.uri(e,t);i.replace(o,{},n,r)};a.len=0;a.uri=function(e,t){var n=e;if(t){n=e.replace(/:([A-Za-z_]+)/g,function(e,n){var i=t[n];delete t[n];return i})}if(t&&Object.keys(t).length>0){n+="?"+a.querystring(t)}return n};a.querystring=function(e,t){var n=[],i;if(Array.isArray(e)){for(var r=0,o=e.length;r<o;r++){i=e[r];n.push(a.querystring({"":i},t))}}else if(typeof e==="object"){for(var s in e){if(!e.hasOwnProperty(s))continue;i=e[s];if(typeof i==="undefined")continue;if(t)s=t+"["+s+"]";if(i===null){n.push(s+"=")}else if(typeof i==="object"){n.push(a.querystring(i,s))}else{n.push([s,encodeURIComponent(i)].join("="))}}}return n.join("&")};a.back=function(e,t){if(a.len>0){history.back()}else if(e){a(e,t)}};a.redirect=function(e,t){r(function(){a.replace(e,t)})};a.teardown=function(){a.stop();a.len=0;i.callbacks=[]};var o=i.Context.prototype.pushState;i.Context.prototype.pushState=function(){a.len++;o.apply(this,arguments)};a.page=i;t.exports=a},{page:2}],2:[function(e,t,n){(function(){var e=true;var n="";var i;function r(e,t){if("function"==typeof e){return r("*",e)}if("function"==typeof t){var n=new s(e);for(var i=1;i<arguments.length;++i){r.callbacks.push(n.middleware(arguments[i]))}}else if("string"==typeof e){r.show(e,t)}else{r.start(e)}}r.callbacks=[];r.base=function(e){if(0==arguments.length)return n;n=e};r.start=function(t){t=t||{};if(i)return;i=true;if(false===t.dispatch)e=false;if(false!==t.popstate)window.addEventListener("popstate",u,false);if(false!==t.click)window.addEventListener("click",c,false);if(!e)return;var n=location.pathname+location.search+location.hash;r.replace(n,null,true,e)};r.stop=function(){i=false;removeEventListener("click",c,false);removeEventListener("popstate",u,false)};r.show=function(e,t,n){var i=new o(e,t);if(false!==n)r.dispatch(i);if(!i.unhandled)i.pushState();return i};r.replace=function(e,t,n,i){var a=new o(e,t);a.init=n;if(null==i)i=true;if(i)r.dispatch(a);a.save();return a};r.dispatch=function(e){var t=0;function n(){var i=r.callbacks[t++];if(!i)return a(e);i(e,n)}n()};function a(e){var t=window.location.pathname+window.location.search;if(t==e.canonicalPath)return;r.stop();e.unhandled=true;window.location=e.canonicalPath}function o(e,t){if("/"==e[0]&&0!=e.indexOf(n))e=n+e;var i=e.indexOf("?");this.canonicalPath=e;this.path=e.replace(n,"")||"/";this.title=document.title;this.state=t||{};this.state.path=e;this.querystring=~i?e.slice(i+1):"";this.pathname=~i?e.slice(0,i):e;this.params=[];this.hash="";if(!~this.path.indexOf("#"))return;var r=this.path.split("#");this.path=r[0];this.hash=r[1]||"";this.querystring=this.querystring.split("#")[0]}r.Context=o;o.prototype.pushState=function(){history.pushState(this.state,this.title,this.canonicalPath)};o.prototype.save=function(){history.replaceState(this.state,this.title,this.canonicalPath)};function s(e,t){t=t||{};this.path=e;this.method="GET";this.regexp=f(e,this.keys=[],t.sensitive,t.strict)}r.Route=s;s.prototype.middleware=function(e){var t=this;return function(n,i){if(t.match(n.path,n.params))return e(n,i);i()}};s.prototype.match=function(e,t){var n=this.keys,i=e.indexOf("?"),r=~i?e.slice(0,i):e,a=this.regexp.exec(r);if(!a)return false;for(var o=1,s=a.length;o<s;++o){var f=n[o-1];var u="string"==typeof a[o]?decodeURIComponent(a[o]):a[o];if(f){t[f.name]=undefined!==t[f.name]?t[f.name]:u}else{t.push(u)}}return true};function f(e,t,n,i){if(e instanceof RegExp)return e;if(e instanceof Array)e="("+e.join("|")+")";e=e.concat(i?"":"/?").replace(/\/\(/g,"(?:/").replace(/(\/)?(\.)?:(\w+)(?:(\(.*?\)))?(\?)?/g,function(e,n,i,r,a,o){t.push({name:r,optional:!!o});n=n||"";return""+(o?"":n)+"(?:"+(o?n:"")+(i||"")+(a||(i&&"([^/.]+?)"||"([^/]+?)"))+")"+(o||"")}).replace(/([\/.])/g,"\\$1").replace(/\*/g,"(.*)");return new RegExp("^"+e+"$",n?"":"i")}function u(e){if(e.state){var t=e.state.path;r.replace(t,e.state)}}function c(e){if(1!=p(e))return;if(e.metaKey||e.ctrlKey||e.shiftKey)return;if(e.defaultPrevented)return;var t=e.target;while(t&&"A"!=t.nodeName)t=t.parentNode;if(!t||"A"!=t.nodeName)return;var i=t.getAttribute("href");if(t.pathname==location.pathname&&(t.hash||"#"==i))return;if(t.target)return;if(!h(t.href))return;var a=t.pathname+t.search+(t.hash||"");var o=a+t.hash;a=a.replace(n,"");if(n&&o==a)return;e.preventDefault();r.show(o)}function p(e){e=e||window.event;return null==e.which?e.button:e.which}function h(e){var t=location.protocol+"//"+location.hostname;if(location.port)t+=":"+location.port;return 0==e.indexOf(t)}if("undefined"==typeof t){window.page=r}else{t.exports=r}})()},{}]},{},[1])(1)});