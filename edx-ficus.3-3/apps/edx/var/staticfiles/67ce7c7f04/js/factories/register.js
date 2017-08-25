/*!
 * jQuery Cookie Plugin
 * https://github.com/carhartl/jquery-cookie
 *
 * Copyright 2011, Klaus Hartl
 * Dual licensed under the MIT or GPL Version 2 licenses.
 * http://www.opensource.org/licenses/mit-license.php
 * http://www.opensource.org/licenses/GPL-2.0
 */

!function(e){e.cookie=function(r,o,t){if(arguments.length>1&&(!/Object/.test(Object.prototype.toString.call(o))||null===o||void 0===o)){if(t=e.extend({},t),(null===o||void 0===o)&&(t.expires=-1),"number"==typeof t.expires){var n=t.expires,i=t.expires=new Date;i.setDate(i.getDate()+n)}return o=String(o),document.cookie=[encodeURIComponent(r),"=",t.raw?o:encodeURIComponent(o),t.expires?"; expires="+t.expires.toUTCString():"",t.path?"; path="+t.path:"",t.domain?"; domain="+t.domain:"",t.secure?"; secure":""].join("")}t=o||{};for(var s,u=t.raw?function(e){return e}:decodeURIComponent,c=document.cookie.split("; "),a=0;s=c[a]&&c[a].split("=");a++)if(u(s[0])===r)return u(s[1]||"");return null}}(jQuery),define("jquery.cookie",["jquery"],function(e){return function(){var r;return r||e.jQuery.fn.cookie}}(this)),define("js/factories/register",["jquery","jquery.cookie"],function(e){"use strict";return function(){e("form :input").focus(function(){e('label[for="'+this.id+'"]').addClass("is-focused")}).blur(function(){e("label").removeClass("is-focused")}),e("form#register_form").submit(function(r){r.preventDefault();var o=e("#register_form").serialize();e.ajax({url:"/create_account",type:"POST",dataType:"json",headers:{"X-CSRFToken":e.cookie("csrftoken")},notifyOnError:!1,data:o,success:function(e){location.href="/course/"},error:function(r,o,t){var n=e.parseJSON(r.responseText);e("#register_error").html(n.value).stop().addClass("is-shown")}})})}});