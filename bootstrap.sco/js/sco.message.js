/* ==========================================================
 * sco.message.js
 * http://github.com/terebentina/sco.js
 * ==========================================================
 * Copyright 2013 Dan Caragea.
 *
 * Licensed under the Apache License, Version 2.0 (the "License");
 * you may not use this file except in compliance with the License.
 * You may obtain a copy of the License at
 *
 * http://apache.org/licenses/LICENSE-2.0
 *
 * Unless required by applicable law or agreed to in writing, software
 * distributed under the License is distributed on an "AS IS" BASIS,
 * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 * See the License for the specific language governing permissions and
 * limitations under the License.
 * ========================================================== */

/*jshint laxcomma:true, sub:true, browser:true, jquery:true, eqeqeq: false */

;(function($, undefined) {
	"use strict";

	var pluginName = 'scojs_message';
	

	$[pluginName] = function(message, options) {
		var __opts;
		if(typeof options == "number"){
			__opts = $.extend({},$[pluginName].options,{"type":options});
		} else {
			__opts = $.extend({},$[pluginName].options,options);
		}
		
		var type = __opts.type;
		clearTimeout($[pluginName].timeout);
		var $selector = $('#' + __opts.id);
		if (!$selector.length) {
			$selector = $('<div/>', {id: __opts.id}).appendTo(__opts.appendTo);
		}
		if (__opts.animate) {
			$selector.addClass('page_mess_animate');
		} else {
			$selector.removeClass('page_mess_animate');
		}
		$selector.html(message);
		if (type === undefined || type == $[pluginName].TYPE_ERROR) {
			$selector.removeClass(__opts.okClass).addClass(__opts.errClass);
		} else if (type == $[pluginName].TYPE_OK) {
			$selector.removeClass(__opts.errClass).addClass(__opts.okClass);
		}
		$selector.slideDown('fast', function() {
			$[pluginName].timeout = setTimeout(function() { 
				$selector.slideUp('fast');
				if(__opts.onAfterHidden && (typeof __opts.onAfterHidden == "function")){
					__opts.onAfterHidden();
				}
			}, __opts.delay);
		});
	};


	$.extend($[pluginName], {
		options: {
			 id: 'page_message'
			,okClass: 'page_mess_ok'
			,errClass: 'page_mess_error'
			,animate: true
			,delay: 1000
			,appendTo: 'body'	// where should the modal be appended to (default to document.body). Added for unit tests, not really needed in real life.
		},

		TYPE_ERROR: 1,
		TYPE_OK: 2
	});
})(jQuery);
