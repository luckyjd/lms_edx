/*
** Checkboxes TreeView- jQuery
** https://github.com/aexmachina/jquery-qubit
**
** Copyright (c) 2014 Simon Wade
** The MIT License (MIT)
** https://github.com/aexmachina/jquery-qubit/blob/master/LICENSE.txt
**
*/

(function(t){"use strict";RequireJS.define("js/groups/models/cohort",["backbone"],function(t){var e=t.Model.extend({idAttribute:"id",defaults:{name:"",user_count:0,assignment_type:"",user_partition_id:null,group_id:null}});return e})}).call(this,define||RequireJS.define),function(t){"use strict";RequireJS.define("js/groups/models/verified_track_settings",["backbone"],function(t){var e=t.Model.extend({defaults:{enabled:!1,verified_cohort_name:""}});return e})}.call(this,define||RequireJS.define),function(t){var e=t.Model.extend({defaults:{type:"confirmation",title:"",message:"",details:[],actionText:null,actionClass:"",actionIconClass:"",actionCallback:null}});this.NotificationModel=e}.call(this,Backbone),RequireJS.define("js/models/notification",function(){}),function(t,e,i){var o=t.View.extend({events:{"click .action-primary":"triggerCallback"},initialize:function(){this.template=i.template(e("#notification-tpl").text())},render:function(){return this.$el.html(this.template({type:this.model.get("type"),title:this.model.get("title"),message:this.model.get("message"),details:this.model.get("details"),actionText:this.model.get("actionText"),actionClass:this.model.get("actionClass"),actionIconClass:this.model.get("actionIconClass")})),this.$(".message").focus(),this},triggerCallback:function(t){t.preventDefault();var e=this.model.get("actionCallback");e&&e(this)}});this.NotificationView=o}.call(this,Backbone,$,_),RequireJS.define("js/views/notification",function(){}),function(t){"use strict";RequireJS.define("js/groups/views/cohort_form",["jquery","underscore","backbone","gettext","edx-ui-toolkit/js/utils/html-utils","js/models/notification","js/views/notification"],function(t,e,i,o,n){var s=i.View.extend({events:{"change .cohort-management-details-association-course input":"onRadioButtonChange"},initialize:function(e){this.template=n.template(t("#cohort-form-tpl").text()),this.contentGroups=e.contentGroups,this.context=e.context},showNotification:function(t,e){var i=new NotificationModel(t);this.removeNotification(),this.notification=new NotificationView({model:i}),e.before(this.notification.$el),this.notification.render()},removeNotification:function(){this.notification&&this.notification.remove()},render:function(){return n.setHtml(this.$el,this.template({cohort:this.model,isDefaultCohort:this.isDefault(this.model.get("name")),contentGroups:this.contentGroups,studioGroupConfigurationsUrl:this.context.studioGroupConfigurationsUrl,isCcxEnabled:this.context.isCcxEnabled})),this},isDefault:function(t){var i=this.model.collection;if(e.isUndefined(i))return!1;var o=i.where({assignment_type:"random"});return 1===o.length&&o[0].get("name")===t},onRadioButtonChange:function(e){var i=t(e.currentTarget),o="yes"===i.val();o||this.$(".input-cohort-group-association").val(null),this.$(".input-cohort-group-association").prop("disabled",!o)},hasAssociatedContentGroup:function(){return this.$(".radio-yes").prop("checked")},getSelectedContentGroup:function(){var t,i,o,n,s,r=this.$(".input-cohort-group-association").val();if(!this.hasAssociatedContentGroup()||e.isNull(r))return null;for(t=r.split(":"),i=parseInt(t[0]),o=parseInt(t[1]),n=0;n<this.contentGroups.length;n++)if(s=this.contentGroups[n],s.get("id")===i&&s.get("user_partition_id")===o)return s;return null},getUpdatedCohortName:function(){var t=this.$(".cohort-name").val();return t?t.trim():""},getAssignmentType:function(){return this.$('input[name="cohort-assignment-type"]:checked').val()},showMessage:function(t,e,i){this.showNotification({type:e||"confirmation",title:t,details:i},this.$(".form-fields"))},validate:function(t){var i;return i=[],t.name||i.push(o("You must specify a name for the cohort")),this.hasAssociatedContentGroup()&&null===t.group_id&&(e.isNull(this.$(".input-cohort-group-association").val())?i.push(o("You did not select a content group")):i.push(o("The selected content group does not exist"))),i},saveForm:function(){var i,n,s,r,c,a=this,h=this.model,d=t.Deferred(),u=!e.isUndefined(this.model.id);return c=function(t,e){a.showMessage(t,"error",e)},this.removeNotification(),n=this.getSelectedContentGroup(),s=this.getAssignmentType(),i={name:this.getUpdatedCohortName(),group_id:n?n.id:null,user_partition_id:n?n.get("user_partition_id"):null,assignment_type:s},r=this.validate(i),r.length>0?(c(o(u?"The cohort cannot be saved":"The cohort cannot be added"),r),d.reject()):h.save(i,{patch:u,wait:!0}).done(function(t){h.id=t.id,a.render(),d.resolve()}).fail(function(t){var e=null;try{var i=JSON.parse(t.responseText);e=i.error}catch(n){}e||(e=o("We've encountered an error. Refresh your browser and then try again.")),c(e),d.reject()}),d.promise()}});return s})}.call(this,define||RequireJS.define),function(t){var e=function(e,i,o,n){var s=1===o?e:i;return t.template(s,{interpolate:/\{(.+?)\}/g})(n)};this.interpolate_ntext=e;var i=function(e,i){return t.template(e,{interpolate:/\{(.+?)\}/g})(i)};this.interpolate_text=i}.call(this,_),RequireJS.define("string_utils",["underscore"],function(t){return function(){var e;return e||t.interpolate_text}}(this)),function(t){"use strict";RequireJS.define("js/groups/views/cohort_editor",["backbone","underscore","jquery","gettext","js/groups/views/cohort_form","string_utils","js/models/notification","js/views/notification"],function(t,e,i,o,n){var s=t.View.extend({events:{"click .wrapper-tabs .tab":"selectTab","click .tab-content-settings .action-save":"saveSettings","click .tab-content-settings .action-cancel":"cancelSettings","submit .cohort-management-group-add-form":"addStudents"},initialize:function(t){this.template=e.template(i("#cohort-editor-tpl").text()),this.groupHeaderTemplate=e.template(i("#cohort-group-header-tpl").text()),this.cohorts=t.cohorts,this.contentGroups=t.contentGroups,this.context=t.context},errorNotifications:null,confirmationNotifications:null,render:function(){return this.$el.html(this.template({cohort:this.model})),this.renderGroupHeader(),this.cohortFormView=new n({model:this.model,contentGroups:this.contentGroups,context:this.context}),this.cohortFormView.render(),this.$(".tab-content-settings").append(this.cohortFormView.$el),this},renderGroupHeader:function(){this.$(".cohort-management-group-header").html(this.groupHeaderTemplate({cohort:this.model}))},selectTab:function(t){var e=i(t.currentTarget),n=e.data("tab");t.preventDefault(),this.$(".wrapper-tabs .tab").removeClass("is-selected"),this.$(".wrapper-tabs .tab").find("span.sr").remove(),e.addClass("is-selected"),e.find("a").prepend('<span class="sr">'+o("Selected tab")+" </span>"),this.$(".tab-content").addClass("is-hidden"),this.$(".tab-content-"+n).removeClass("is-hidden").focus()},saveSettings:function(t){var e=this.cohortFormView,i=this;t.preventDefault(),e.saveForm().done(function(){i.renderGroupHeader(),e.showMessage(o("Saved cohort"))})},cancelSettings:function(t){t.preventDefault(),this.render()},setCohort:function(t){this.model=t,this.render()},addStudents:function(t){t.preventDefault();var e=this,n=this.cohorts,s=this.$(".cohort-management-group-add-students"),r=this.model.url()+"/add",c=s.val().trim(),a=this.model.id;c.length>0?i.post(r,{users:c}).done(function(t){e.refreshCohorts().done(function(){var i=n.get(a);e.setCohort(i),e.addNotifications(t),t.unknown.length>0&&e.$(".cohort-management-group-add-students").val(c)})}).fail(function(){e.showErrorMessage(o("Error adding students."),!0)}):(e.showErrorMessage(o("Enter a username or email."),!0),s.val(""))},refreshCohorts:function(){return this.cohorts.fetch()},undelegateViewEvents:function(t){t&&t.undelegateEvents()},showErrorMessage:function(t,e,i){e&&this.confirmationNotifications&&(this.undelegateViewEvents(this.confirmationNotifications),this.confirmationNotifications.$el.html(""),this.confirmationNotifications=null),void 0===i&&(i=new NotificationModel),i.set("type","error"),i.set("title",t),this.undelegateViewEvents(this.errorNotifications),this.errorNotifications=new NotificationView({el:this.$(".cohort-errors"),model:i}),this.errorNotifications.render()},addNotifications:function(t){var i,n,s,r,c,a,h,d,u,l=5;if(this.undelegateViewEvents(this.confirmationNotifications),c=t.added.length+t.changed.length,r=t.present.length,c>0||r>0){n=interpolate_text(ngettext("{numUsersAdded} student has been added to this cohort","{numUsersAdded} students have been added to this cohort",c),{numUsersAdded:c});var f={};e.each(t.changed,function(t){i=t.previous_cohort,i in f?f[i]=f[i]+1:f[i]=1}),s=[];for(i in f)s.push(interpolate_text(ngettext("{numMoved} student was removed from {oldCohort}","{numMoved} students were removed from {oldCohort}",f[i]),{numMoved:f[i],oldCohort:i}));r>0&&s.push(interpolate_text(ngettext("{numPresent} student was already in the cohort","{numPresent} students were already in the cohort",r),{numPresent:r})),this.confirmationNotifications=new NotificationView({el:this.$(".cohort-confirmations"),model:new NotificationModel({type:"confirmation",title:n,details:s})}),this.confirmationNotifications.render()}else this.confirmationNotifications&&(this.confirmationNotifications.$el.html(""),this.confirmationNotifications=null);this.undelegateViewEvents(this.errorNotifications),a=t.unknown.length,a>0?(h=function(t,e){for(var i=t.length,n=[],s=0;s<(e?i:Math.min(l,i));s++)n.push(interpolate_text(o("Unknown user: {user}"),{user:t[s]}));return n},n=interpolate_text(ngettext("There was an error when trying to add students:","There were {numErrors} errors when trying to add students:",a),{numErrors:a}),s=h(t.unknown,!1),d=function(e){e.model.set("actionText",null),e.model.set("details",h(t.unknown,!0)),e.render()},u=new NotificationModel({details:s,actionText:a>l?o("View all errors"):null,actionCallback:d,actionClass:"action-expand"}),this.showErrorMessage(n,!1,u)):this.errorNotifications&&(this.errorNotifications.$el.html(""),this.errorNotifications=null)}});return s})}.call(this,define||RequireJS.define),function(t){"use strict";RequireJS.define("js/groups/views/course_cohort_settings_notification",["jquery","underscore","backbone","gettext"],function(t,e,i,o){var n=i.View.extend({initialize:function(i){this.template=e.template(t("#cohort-state-tpl").text()),this.cohortEnabled=i.cohortEnabled},render:function(){return this.$el.html(this.template({})),this.showCohortStateMessage(),this},showCohortStateMessage:function(){var t=this.$(".action-toggle-message");AnimationUtil.triggerAnimation(t),this.cohortEnabled?t.text(o("Cohorts Enabled")):t.text(o("Cohorts Disabled"))}});return n})}.call(this,define||RequireJS.define),function(t){"use strict";RequireJS.define("js/groups/views/cohort_discussions",["jquery","underscore","backbone","gettext","js/models/notification","js/views/notification"],function(t,e,i){var o=i.View.extend({setDisabled:function(t,e){t.prop("disabled",e?"disabled":!1)},getCohortedDiscussions:function(i){var o=this,n=[];return e.each(o.$(i),function(e){n.push(t(e).data("id"))}),n},saveForm:function(e,i){var o,n=this,s=this.cohortSettings,r=t.Deferred();return o=function(t,e){n.showMessage(t,e,"error")},this.removeNotification(),s.save(i,{patch:!0,wait:!0}).done(function(){r.resolve()}).fail(function(t){var i=null;try{var n=JSON.parse(t.responseText);i=n.error}catch(s){}i||(i=gettext("We've encountered an error. Refresh your browser and then try again.")),o(i,e),r.reject()}),r.promise()},showMessage:function(t,e,i){var o=new NotificationModel({type:i||"confirmation",title:t});this.removeNotification(),this.notification=new NotificationView({model:o}),e.before(this.notification.$el),this.notification.render()},removeNotification:function(){this.notification&&this.notification.remove()}});return o})}.call(this,define||RequireJS.define),function(t){t.fn.qubit=function(t){return this.each(function(){new e(this,t)})};var e=function(e){var i=this;this.scope=t(e),this.scope.on("change","input[type=checkbox]",function(t){i.suspendListeners||i.process(t.target)}),this.scope.find("input[type=checkbox]:checked").each(function(){i.process(this)})};e.prototype={itemSelector:"li",process:function(e){var e=t(e),i=e.parentsUntil(this.scope,this.itemSelector);try{this.suspendListeners=!0,i.eq(0).find("input[type=checkbox]").filter(e.prop("checked")?":not(:checked)":":checked").each(function(){t(this).parent().hasClass("hidden")||t(this).prop("checked",e.prop("checked"))}).trigger("change"),this.processParents(e)}finally{this.suspendListeners=!1}},processParents:function(){var e=this,i=!1;this.scope.find("input[type=checkbox]").each(function(){var o=t(this),n=o.closest(e.itemSelector),s=n.find("input[type=checkbox]").not(o),r=s.filter(function(){return t(this).prop("checked")||t(this).prop("indeterminate")}).length;s.length?0==r?e.setChecked(o,!1)&&(i=!0):r==s.length?e.setChecked(o,!0)&&(i=!0):e.setIndeterminate(o,!0)&&(i=!0):e.setIndeterminate(o,!1)&&(i=!0)}),i&&this.processParents()},setChecked:function(t,e,i){var o=!1;return t.prop("indeterminate")&&(t.prop("indeterminate",!1),o=!0),t.prop("checked")!=e&&(t.prop("checked",e).trigger("change"),o=!0),o},setIndeterminate:function(t,e){return e&&t.prop("checked",!1),t.prop("indeterminate")!=e?(t.prop("indeterminate",e),!0):void 0}}}(jQuery),RequireJS.define("js/vendor/jquery.qubit",function(){}),function(t){"use strict";RequireJS.define("js/groups/views/cohort_discussions_inline",["jquery","underscore","backbone","gettext","js/groups/views/cohort_discussions","edx-ui-toolkit/js/utils/html-utils","js/vendor/jquery.qubit"],function(t,e,i,o,n,s){var r=n.extend({events:{"change .check-discussion-category":"setSaveButton","change .check-discussion-subcategory-inline":"setSaveButton","click .cohort-inline-discussions-form .action-save":"saveInlineDiscussionsForm","change .check-all-inline-discussions":"setAllInlineDiscussions","change .check-cohort-inline-discussions":"setSomeInlineDiscussions"},initialize:function(e){this.template=s.template(t("#cohort-discussions-inline-tpl").text()),this.cohortSettings=e.cohortSettings},render:function(){var t=this.cohortSettings.get("always_cohort_inline_discussions"),e=this.model.get("inline_discussions");s.setHtml(this.$(".cohort-inline-discussions-nav"),this.template({inlineDiscussionTopicsHtml:this.getInlineDiscussionsHtml(e),alwaysCohortInlineDiscussions:t})),this.$("ul.inline-topics").qubit(),this.setElementsEnabled(t,!0)},getInlineDiscussionsHtml:function(i){var o=s.template(t("#cohort-discussions-category-tpl").html()),n=s.template(t("#cohort-discussions-subcategory-tpl").html()),r=!1,c=i.children,a=i.entries,h=i.subcategories;return s.joinHtml.apply(this,e.map(c,function(t){var i,s="",c=t[0],d=t[1];return a&&e.has(a,c)&&"entry"===d?(i=a[c],s=n({name:c,id:i.id,is_cohorted:i.is_cohorted,type:"inline"})):s=o({name:c,entriesHtml:this.getInlineDiscussionsHtml(h[c]),isCategoryCohorted:r}),s},this))},setAllInlineDiscussions:function(e){e.preventDefault(),this.setElementsEnabled(t(e.currentTarget).prop("checked"),!1)},setSomeInlineDiscussions:function(e){e.preventDefault(),this.setElementsEnabled(!t(e.currentTarget).prop("checked"),!1)},setElementsEnabled:function(t,e){this.setDisabled(this.$(".check-discussion-category"),t),this.setDisabled(this.$(".check-discussion-subcategory-inline"),t),this.setDisabled(this.$(".cohort-inline-discussions-form .action-save"),e)},setSaveButton:function(t){this.setDisabled(this.$(".cohort-inline-discussions-form .action-save"),!1)},saveInlineDiscussionsForm:function(t){t.preventDefault();var e=this,i=e.getCohortedDiscussions(".check-discussion-subcategory-inline:checked"),n={cohorted_inline_discussions:i,always_cohort_inline_discussions:e.$(".check-all-inline-discussions").prop("checked")};e.saveForm(e.$(".inline-discussion-topics"),n).done(function(){e.model.fetch().done(function(){e.render(),e.showMessage(o("Your changes have been saved."),e.$(".inline-discussion-topics"))}).fail(function(){var t=o("We've encountered an error. Refresh your browser and then try again.");e.showMessage(t,e.$(".inline-discussion-topics"),"error")})})}});return r})}.call(this,define||RequireJS.define),function(t){"use strict";RequireJS.define("js/groups/views/cohort_discussions_course_wide",["jquery","underscore","backbone","gettext","js/groups/views/cohort_discussions","edx-ui-toolkit/js/utils/html-utils"],function(t,e,i,o,n,s){var r=n.extend({events:{"change .check-discussion-subcategory-course-wide":"discussionCategoryStateChanged","click .cohort-course-wide-discussions-form .action-save":"saveCourseWideDiscussionsForm"},initialize:function(e){this.template=s.template(t("#cohort-discussions-course-wide-tpl").text()),this.cohortSettings=e.cohortSettings},render:function(){s.setHtml(this.$(".cohort-course-wide-discussions-nav"),this.template({courseWideTopicsHtml:this.getCourseWideDiscussionsHtml(this.model.get("course_wide_discussions"))})),this.setDisabled(this.$(".cohort-course-wide-discussions-form .action-save"),!0)},getCourseWideDiscussionsHtml:function(i){var o=s.template(t("#cohort-discussions-subcategory-tpl").html()),n=i.entries,r=i.children;return s.joinHtml.apply(this,e.map(r,function(t){var e=t[0],i=n[e];return o({name:e,id:i.id,is_cohorted:i.is_cohorted,type:"course-wide"})}))},discussionCategoryStateChanged:function(t){t.preventDefault(),this.setDisabled(this.$(".cohort-course-wide-discussions-form .action-save"),!1)},saveCourseWideDiscussionsForm:function(t){t.preventDefault();var e=this,i=e.getCohortedDiscussions(".check-discussion-subcategory-course-wide:checked"),n={cohorted_course_wide_discussions:i};e.saveForm(e.$(".course-wide-discussion-topics"),n).done(function(){e.model.fetch().done(function(){e.render(),e.showMessage(o("Your changes have been saved."),e.$(".course-wide-discussion-topics"))}).fail(function(){var t=o("We've encountered an error. Refresh your browser and then try again.");e.showMessage(t,e.$(".course-wide-discussion-topics"),"error")})})}});return r})}.call(this,define||RequireJS.define),function(t){"use strict";RequireJS.define("js/groups/views/verified_track_settings_notification",["jquery","underscore","backbone","gettext","edx-ui-toolkit/js/utils/string-utils","js/models/notification","js/views/notification"],function(t,e,i,o,n){var s=i.View.extend({render:function(){return this},validateSettings:function(e,i,s){if(this.model.get("enabled")){var r=this.model.get("verified_cohort_name");if(e){var c=!1;t.each(i,function(t,e){"manual"===e.get("assignment_type")&&e.get("name")===r?(c=!0,e.disableEditingName=!0):e.disableEditingName=!1}),c?this.showNotification({type:"confirmation",title:n.interpolate(o("This course uses automatic cohorting for verified track learners. You cannot disable cohorts, and you cannot rename the manual cohort named '{verifiedCohortName}'. To change the configuration for verified track cohorts, contact your edX partner manager."),{verifiedCohortName:r})}):this.showNotification({type:"error",title:n.interpolate(o("This course has automatic cohorting enabled for verified track learners, but the required cohort does not exist. You must create a manually-assigned cohort named '{verifiedCohortName}' for the feature to work."),{verifiedCohortName:r})}),s.prop("disabled",!0)}else this.showNotification({type:"error",title:o("This course has automatic cohorting enabled for verified track learners, but cohorts are disabled. You must enable cohorts for the feature to work.")}),s.prop("disabled",!1)}},showNotification:function(e){this.notification&&this.notification.remove(),this.notification=new NotificationView({model:new NotificationModel(e)}),t(".cohort-management").before(this.notification.$el),this.notification.render()}});return s})}.call(this,define||RequireJS.define),function(t,e,i,o,n,s,r){var c=t.View.extend({initialize:function(t){this.template=i.template(e("#file-upload-tpl").text()),this.options=t},render:function(){var t,e,i=this.options,n=function(t,e){var o=i[t];return o?o:e};return this.$el.html(this.template({title:n("title",""),inputLabel:n("inputLabel",""),inputTip:n("inputTip",""),extensions:n("extensions",""),submitButtonText:n("submitButtonText",o("Upload File")),url:n("url","")})),t=this.$el.find(".submit-file-button"),e=this.$el.find(".result"),this.$el.find("#file-upload-form").fileupload({dataType:"json",type:"POST",done:this.successHandler.bind(this),fail:this.errorHandler.bind(this),autoUpload:!1,replaceFileInput:!1,add:function(i,o){o.files[0];t.removeClass("is-disabled").attr("aria-disabled",!1),t.unbind("click"),t.click(function(t){t.preventDefault(),o.submit()}),e.html("")}}),this},successHandler:function(t,e){var i,c=e.files[0].name;i=this.options.successNotification?this.options.successNotification(c,t,e):new s({type:"confirmation",title:n(o("Your upload of '{file}' succeeded."),{file:c})});var a=new r({el:this.$(".result"),model:i});a.render()},errorHandler:function(t,e){var i,c=e.files[0].name,a=null,h=e.response().jqXHR;if(this.options.errorNotification)i=this.options.errorNotification(c,t,e);else{if(h.responseText)try{a=JSON.parse(h.responseText).error}catch(d){}a||(a=n(o("Your upload of '{file}' failed."),{file:c})),i=new s({type:"error",title:a})}var u=new r({el:this.$(".result"),model:i});u.render()}});this.FileUploaderView=c}.call(this,Backbone,$,_,gettext,interpolate_text,NotificationModel,NotificationView),RequireJS.define("js/views/file_uploader",function(){}),function(t){"use strict";RequireJS.define("js/groups/views/cohorts",["jquery","underscore","backbone","gettext","js/groups/models/cohort","js/groups/models/verified_track_settings","js/groups/views/cohort_editor","js/groups/views/cohort_form","js/groups/views/course_cohort_settings_notification","js/groups/views/cohort_discussions_inline","js/groups/views/cohort_discussions_course_wide","js/groups/views/verified_track_settings_notification","edx-ui-toolkit/js/utils/html-utils","js/views/file_uploader","js/models/notification","js/views/notification","string_utils"],function(t,e,i,o,n,s,r,c,a,h,d,u,l){var f="is-hidden",p="is-disabled",m=".cohorts-state",g=i.View.extend({events:{"change .cohort-select":"onCohortSelected","change .cohorts-state":"onCohortsEnabledChanged","click .action-create":"showAddCohortForm","click .cohort-management-add-form .action-save":"saveAddCohortForm","click .cohort-management-add-form .action-cancel":"cancelAddCohortForm","click .link-cross-reference":"showSection","click .toggle-cohort-management-secondary":"showCsvUpload","click .toggle-cohort-management-discussions":"showDiscussionTopics"},initialize:function(e){var i=this.model;this.template=l.template(t("#cohorts-tpl").text()),this.selectorTemplate=l.template(t("#cohort-selector-tpl").text()),this.context=e.context,this.contentGroups=e.contentGroups,this.cohortSettings=e.cohortSettings,i.on("sync",this.onSync,this),t(this.getSectionCss("cohort_management")).click(function(){i.fetch()})},render:function(){if(l.setHtml(this.$el,this.template({cohorts:this.model.models,cohortsEnabled:this.cohortSettings.get("is_cohorted")})),this.onSync(),!this.verifiedTrackSettingsNotificationView){var t=new s;t.url=this.context.verifiedTrackCohortingUrl,t.fetch({success:e.bind(this.renderVerifiedTrackSettingsNotificationView,this)}),this.verifiedTrackSettingsNotificationView=new u({model:t})}return this},renderSelector:function(t){l.setHtml(this.$(".cohort-select"),this.selectorTemplate({cohorts:this.model.models,selectedCohort:t}))},renderCourseCohortSettingsNotificationView:function(){var e=new a({el:t(".cohort-state-message"),cohortEnabled:this.getCohortsEnabled()});e.render()},renderVerifiedTrackSettingsNotificationView:function(){this.verifiedTrackSettingsNotificationView&&this.verifiedTrackSettingsNotificationView.validateSettings(this.getCohortsEnabled(),this.model.models,this.$(m))},onSync:function(t,e,i){var n,s=this.lastSelectedCohortId&&this.model.get(this.lastSelectedCohortId),r=this.model.length>0,c=this.$(".cohort-management-nav"),a=this.$(".wrapper-cohort-supplemental");n=function(){return i&&i.patch&&e.hasOwnProperty("user_partition_id")},this.hideAddCohortForm(),n()?this.renderSelector(s):r?(c.removeClass(f),a.removeClass(f),this.renderSelector(s),s&&this.showCohortEditor(s)):(c.addClass(f),a.addClass(f),this.showNotification({type:"warning",title:o("You currently have no cohorts configured"),actionText:o("Add Cohort"),actionClass:"action-create",actionIconClass:"fa-plus"})),this.renderVerifiedTrackSettingsNotificationView()},getSelectedCohort:function(){var t=this.$(".cohort-select").val();return t&&this.model.get(parseInt(t))},onCohortSelected:function(t){t.preventDefault();var e=this.getSelectedCohort();this.lastSelectedCohortId=e.get("id"),this.showCohortEditor(e)},onCohortsEnabledChanged:function(t){t.preventDefault(),this.saveCohortSettings()},saveCohortSettings:function(){var t,e=this,i={is_cohorted:this.getCohortsEnabled()};t=this.cohortSettings,t.save(i,{patch:!0,wait:!0}).done(function(){e.render(),e.renderCourseCohortSettingsNotificationView()}).fail(function(t){e.showNotification({type:"error",title:o("We've encountered an error. Refresh your browser and then try again.")},e.$(".cohorts-state-section"))})},getCohortsEnabled:function(){return this.$(m).prop("checked")},showCohortEditor:function(e){this.removeNotification(),this.editor?(this.editor.setCohort(e),t(".cohort-management-group .group-header-title").focus()):(this.editor=new r({el:this.$(".cohort-management-group"),model:e,cohorts:this.model,contentGroups:this.contentGroups,context:this.context}),this.editor.render(),t(".cohort-management-group .group-header-title").focus())},showNotification:function(t,e){var i=new NotificationModel(t);this.removeNotification(),this.notification=new NotificationView({model:i}),e||(e=this.$(".cohort-management-group")),e.before(this.notification.$el),this.notification.render()},removeNotification:function(){this.notification&&this.notification.remove(),this.cohortFormView&&this.cohortFormView.removeNotification()},showAddCohortForm:function(t){var e;t.preventDefault(),this.removeNotification(),e=new n,e.url=this.model.url,this.cohortFormView=new c({model:e,contentGroups:this.contentGroups,context:this.context}),this.cohortFormView.render(),this.$(".cohort-management-add-form").append(this.cohortFormView.$el),this.cohortFormView.$(".cohort-name").focus(),this.setCohortEditorVisibility(!1)},hideAddCohortForm:function(){this.setCohortEditorVisibility(!0),this.cohortFormView&&(this.cohortFormView.remove(),this.cohortFormView=null)},setCohortEditorVisibility:function(t){t?(this.$(".cohorts-state-section").removeClass(p).attr("aria-disabled",!1),this.$(".cohort-management-group").removeClass(f),this.$(".cohort-management-nav").removeClass(p).attr("aria-disabled",!1)):(this.$(".cohorts-state-section").addClass(p).attr("aria-disabled",!0),this.$(".cohort-management-group").addClass(f),this.$(".cohort-management-nav").addClass(p).attr("aria-disabled",!0))},saveAddCohortForm:function(t){var e=this,i=this.cohortFormView.model;t.preventDefault(),this.removeNotification(),this.cohortFormView.saveForm().done(function(){e.lastSelectedCohortId=i.id,e.model.fetch().done(function(){e.showNotification({type:"confirmation",title:interpolate_text(o("The {cohortGroupName} cohort has been created. You can manually add students to this cohort below."),{cohortGroupName:i.get("name")})})})})},cancelAddCohortForm:function(t){t.preventDefault(),this.removeNotification(),this.onSync()},showSection:function(e){e.preventDefault();var i=t(e.currentTarget).data("section");t(this.getSectionCss(i)).click(),t(window).scrollTop(0)},showCsvUpload:function(e){e.preventDefault(),t(e.currentTarget).addClass(f);var i=this.$(".csv-upload").removeClass(f);this.fileUploaderView||(this.fileUploaderView=new FileUploaderView({el:i,title:o("Assign students to cohorts by uploading a CSV file."),inputLabel:o("Choose a .csv file"),inputTip:o("Only properly formatted .csv files will be accepted."),submitButtonText:o("Upload File and Assign Students"),extensions:".csv",url:this.context.uploadCohortsCsvUrl,successNotification:function(t,e,i){var n=interpolate_text(o("Your file '{file}' has been uploaded. Allow a few minutes for processing."),{file:t});return new NotificationModel({type:"confirmation",title:n})}}).render())},showDiscussionTopics:function(e){e.preventDefault(),t(e.currentTarget).addClass(f);var i=this.$(".cohort-discussions-nav").removeClass(f);this.CourseWideDiscussionsView||(this.CourseWideDiscussionsView=new d({el:i,model:this.context.discussionTopicsSettingsModel,cohortSettings:this.cohortSettings}).render()),this.InlineDiscussionsView||(this.InlineDiscussionsView=new h({el:i,model:this.context.discussionTopicsSettingsModel,cohortSettings:this.cohortSettings}).render())},getSectionCss:function(t){return".instructor-nav .nav-item [data-section='"+t+"']"}});return g})}.call(this,define||RequireJS.define),function(t){"use strict";RequireJS.define("js/groups/collections/cohort",["backbone","js/groups/models/cohort"],function(t,e){var i=t.Collection.extend({model:e,comparator:"name",parse:function(t){return t.cohorts}});return i})}.call(this,define||RequireJS.define),function(t){"use strict";RequireJS.define("js/groups/models/course_cohort_settings",["backbone"],function(t){var e=t.Model.extend({idAttribute:"id",defaults:{is_cohorted:!1,cohorted_inline_discussions:[],cohorted_course_wide_discussions:[],always_cohort_inline_discussions:!0}});return e})}.call(this,define||RequireJS.define),function(t){"use strict";RequireJS.define("js/groups/models/cohort_discussions",["backbone"],function(t){var e=t.Model.extend({defaults:{course_wide_discussions:{},inline_discussions:{}}});return e})}.call(this,define||RequireJS.define),function(t){"use strict";RequireJS.define("js/groups/models/content_group",["backbone"],function(t){var e=t.Model.extend({idAttribute:"id",defaults:{name:"",user_partition_id:null}});return e})}.call(this,define||RequireJS.define),function(t,e){"use strict";RequireJS.define("js/groups/views/cohorts_dashboard_factory",["jquery","js/groups/views/cohorts","js/groups/collections/cohort","js/groups/models/course_cohort_settings","js/groups/models/cohort_discussions","js/groups/models/content_group"],function(t,e,i,o,n,s){return function(r,c){var a=t.map(r,function(t){return new s({id:t.id,name:t.name,user_partition_id:t.user_partition_id})}),h=new i,d=new o,u=new n,l=t(".cohort-management");h.url=l.data("cohorts_url"),d.url=l.data("course_cohort_settings_url"),u.url=l.data("discussion-topics-url");var f=new e({el:l,model:h,contentGroups:a,cohortSettings:d,context:{discussionTopicsSettingsModel:u,uploadCohortsCsvUrl:l.data("upload_cohorts_csv_url"),verifiedTrackCohortingUrl:l.data("verified_track_cohorting_url"),studioGroupConfigurationsUrl:c,isCcxEnabled:l.data("is_ccx_enabled")}});h.fetch().done(function(){d.fetch().done(function(){u.fetch().done(function(){f.render()})})})}})}.call(this,define||RequireJS.define);