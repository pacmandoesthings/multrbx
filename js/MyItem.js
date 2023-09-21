;// bundle: page___0f32db6c6ed1acfc038e53b963b85bff_m
;// files: jquery.filter_input.js, My/myitem.js, pageStyleNotifications.js, utilities/dialog.js, utilities/popover.js, TosModalCheck.js, YouTube/RobloxYouTube.js, common/deviceMeta.js

;// jquery.filter_input.js
(function(n){n.fn.extend({filter_input:function(t){function i(t){var i=t.charCode?t.charCode:t.keyCode?t.keyCode:0,r;return(i==8||i==9||i==13||i==35||i==36||i==37||i==39||i==46)&&n.browser.mozilla&&t.charCode==0&&t.keyCode==i?!0:(r=String.fromCharCode(i),u.test(r))?!0:!1}var r={regex:".*",live:!1},t=n.extend(r,t),u=new RegExp(t.regex);if(t.live)n(this).live("keypress",i);else return this.each(function(){var t=n(this);t.unbind("keypress").keypress(i)})}})})(jQuery);

; // My/myitem.js
var MyItemPage = new function() {
    function y() {
        var r, u, o = e,
            f;
        return u = n != t ? $(".PricingField_Robux [type=text]").val() : n, f = Math.round(u * v), r = f > o ? f : o
    }

    function nt(i) {
        var r;
        return r = n != t ? $(".PricingField_Robux [type=text]").val() : n, r - y(i)
    }

    function o(n) {
        n ? ($("#PlayerLimitDefault").hide(), $("#PlayerLimitOptions").show("clip", "slow")) : ($("#PlayerLimitOptions").hide(), $("#PlayerLimitDefault").show("clip", "slow"))
    }

    function p(n, t, i) {
        var r = $(n).val();
        $("#PricingError").hide(), $("#PricingErrorMax").hide(), isNaN(r) ? ($(n).val(r.replace(/\D/g, "")), $("#PricingError").show()) : r < t ? ($(n).val(t), $("#PricingError").show()) : i != null && r > i && ($(n).val(i), $("#PricingErrorMax").show())
    }

    function f() {
        n != t && ($('.PricingField_Robux [type="text"]').prop("disabled", !1), p('.PricingField_Robux [type="text"]', Math.max(e, n), t)), $(".MarketplaceFeeInRobuxLabel").html(y("Robux")), $(".UserProfitInRobuxLabel").html(nt("Robux"))
    }

    function u() {
        if (!$(".PricingField_Robux [type=checkbox]").attr("checked")) {
            var t = $('.PricingField_Robux [type="text"]'),
                i = t.val();
            r || (r = i ? i : n), t.val(""), t.prop("disabled", !0), $(".MarketplaceFeeInRobuxLabel").text("0"), $(".UserProfitInRobuxLabel").text("0")
        }
    }

    function w() {
        k(".PricingField_Robux")
    }

    function b() {
        d(".PricingField_Robux")
    }

    function k(n) {
        $("input", n).prop("disabled") || $("input", n).prop("disabled", !0)
    }

    function d(n) {
        $("input", n).prop("disabled") && $("input", n).prop("disabled", !1)
    }

    function g() {
        c || $(".PricingField_Robux input").prop("readonly", !0)
    }

    function s() {
        Roblox.GenericConfirmation.open({
            titleText: Roblox.MyItem.strings.PriceChangingThrottledTitleText,
            bodyContent: Roblox.MyItem.strings.PriceChangingThrottledBodyContent,
            acceptText: Roblox.MyItem.strings.OKText,
            declineColor: Roblox.GenericConfirmation.none,
            imageUrl: Roblox.MyItem.AlertImageUrl
        })
    }

    function h(n) {
        $.ajax({
            url: n,
            method: "POST",
            contentType: "application/json; charset=utf-8",
            dataType: "json"
        }).done(function() {
            location.reload()
        }).fail(function() {
            location.reload()
        })
    }
    var e, n, v, t, a, l, i, c, r;
    ResizeFieldSet = function(n, t) {
        var i = {
            to: {
                height: t
            }
        };
        $("#PlaceAccessOptionsField").css({
            height: t,
            display: "block"
        })
    }, this.SelectPlaceType_Public = function(n, t, i, r, u) {
        setTimeout(function() {
            o(!0)
        }, 1), $(n).hide(), $(t).show("clip", "fast"), $("#" + u).hide(), $(i).attr("checked") === !1 && $(r).attr("checked") === !1 && $(i).attr("checked", !0), $("#SellThisItem").show()
    }, this.SelectPlaceType_Personal = function(n, t, i, r) {
        return n ? (setTimeout(function() {
            o(!1)
        }, 1), $(i).hide("slow", function() {
            $(t).show("fast")
        }), $("#" + r).show(), $("#SellThisItem").hide(), !0) : (showBCOnlyModal("BCOnlyModalPersonalServer"), !1)
    }, this.Initialize = function(o, y, p, k, d, nt, tt, it) {
        var ot, st;
        e = o, n = p, v = y, t = k, a = d, l = nt, i = tt, c = it;
		console.log("If this isn't the item page something's wrong...");
		// o/e  == 1
		// y/v  == 0.9
		// p/n  == 2
		// k/t  == 999999999
		// d/a  == false
		// nt/l == false
		// tt/i == isPlaceAsset
		// it/c == true
        var et = $(".SellThisItemRow").children('[type="checkbox"]'),
            ft = $(".PricingPanel"),
            rt = $(".PricingField_Robux [type=checkbox]"),
            ut = $(".PricingField_Robux [type=text]"),
            ct = $(".MarketplaceFeeInRobuxLabel"),
            lt = $(".UserProfitInRobuxLabel"),
            ht = $("#PayToPlayFAQ");
        r = ut.val() ? ut.val() : n, et.attr("checked") ? (ft.show(), rt.attr("checked") ? f() : u(), i && ($(".PlaceTypeOptions").hide(), $("#PlaceAccess").hide(), $("#PlaceOptions").hide(), $("#PlaceCopyProtection").hide(), $("#Comments").hide(), $(".BCOptions").hide())) : (ft.hide(), ut.attr("checked", !1), i && ($(".PlaceTypeOptions").show(), $("#PlaceAccess").show(), $("#PlaceOptions").show(), $("#PlaceCopyProtection").show(), $("#Comments").show(), $(".BCOptions").show())), g(), ot = !1, $(".PersonalServerAccessCtrls input,select").change(function() {
            ot = !0
        }), $(".papListRemoveUserIcon").click(function() {
            ot = !0
        }), $(".SaveButton").click(function() {
            window.onbeforeunload = null
        }), window.onbeforeunload = function() {
            if (ot) return "Your changes have not been saved."
        }, rt.change(function() {
            if ($(this).prop("readonly")) return s(), !1;
            $(this).attr("checked") ? (ut.val(r), f()) : (r = ut.val(), u())
        }), ut.change(function() {
            f()
			//What's the point of this? The text is hidden when the for sale button is unchecked. Couldn't Roblox's site either exclude the price in the update or just update the price along with the fact that it's not for sale?
        }), ut.click(function() {
            if ($(this).prop("readonly")) return s(), !1
        }), $('.PublicDomainRow [type="checkbox"]').click(function() {
            $(this).attr("checked") ? (et.attr("checked", !1), rt.attr("checked", !1), ft.hide(), u()) : et.attr("checked") && ft.show()
        }), et.click(function() {
            if (!a) return showBCOnlyModal("BCOnlyModalSelling"), !1;
            if ($(this).attr("checked")) {
                if (l) return Roblox.GenericConfirmation.open({
                    titleText: Roblox.MyItem.strings.SellingSuspendedTitleText,
                    bodyContent: Roblox.MyItem.strings.SellingSuspendedBodyContent,
                    acceptText: Roblox.MyItem.strings.OKText,
                    declineColor: Roblox.GenericConfirmation.none,
                    imageUrl: Roblox.MyItem.AlertImageUrl
                }), !1;
                $('.PublicDomainRow [type="checkbox"]').attr("checked", !1), ft.show(), b(), rt.prop("readonly") || u(), f(), i && ($(".PlaceTypeOptions").hide(), $("#PlaceAccess").hide(), $("#PlaceOptions").hide(), $("#PlaceCopyProtection").hide(), $("#Comments").hide(), $(".BCOptions").hide()), rt.prop("readonly") || $(".PricingField_Robux").css("display") !== "none" || rt.attr("checked", !0).change()
            } else w(), rt.prop("readonly") || rt.attr("checked", !1).change(), ft.hide(), i && ($(".PlaceTypeOptions").show(), $("#PlaceAccess").show(), $("#PlaceOptions").show(), $("#PlaceCopyProtection").show(), $("#Comments").show(), $(".BCOptions").show())
        }), ht.click(function() {
            return window.open(this.href, "PayToPlayFAQ", "left=100,top=100,width=500,height=500,toolbar=0,resizable=0,scrollbars=1"), !1
        }), st = $("#archive-url").attr("data-url"), $(".button-archive-restore").click(function() {
            h(st)
        }), $(".button-archive-archive").click(function() {
            h(st)
        })
    }
};

;// pageStyleNotifications.js
$(function(){$(".pagification .pagification-showall, .pagification .pagification-collapse").click(function(){$(this).parents(".pagification-body").toggleClass("collapsed")})});

;// utilities/dialog.js
typeof Roblox=="undefined"&&(Roblox={}),typeof Roblox.Dialog=="undefined"&&(Roblox.Dialog=function(){function g(f){var k,c,v,w,o,b;n.isOpen=!0,k={titleText:"",bodyContent:"",footerText:"",acceptText:Roblox.Lang.ControlsResources["Action.Yes"]||a.Yes,declineText:Roblox.Lang.ControlsResources["Action.No"]||a.No,acceptColor:h,declineColor:s,xToCancel:!1,onAccept:function(){return!1},onDecline:function(){return!1},onCancel:function(){return!1},imageUrl:null,showAccept:!0,showDecline:!0,allowHtmlContentInBody:!1,allowHtmlContentInFooter:!1,dismissable:!0,fieldValidationRequired:!1,onOpenCallback:function(){},onCloseCallback:t,cssClass:null,checkboxAgreementText:Roblox.Lang.ControlsResources["Action.Agree"]||a.Agree,checkboxAgreementRequired:!1},f=$.extend({},k,f),i.overlayClose=f.dismissable,i.escClose=f.dismissable,f.onCloseCallback&&(i.onClose=function(){f.onCloseCallback(),t()}),c=$(u),c.html(f.acceptText),c.attr("class",f.acceptColor),c.unbind(),c.bind("click",function(){return p(c)?!1:(f.fieldValidationRequired?nt(f.onAccept):l(f.onAccept),!1)}),v=$(e),v.html(f.declineText),v.attr("class",f.declineColor),v.unbind(),v.bind("click",function(){return p(v)?!1:(l(f.onDecline),!1)}),w=$(tt),w.unbind(),w.bind("change",function(){w.is(":checked")?y(c):r(c)}),o=$('[data-modal-type="confirmation"]'),o.find(".modal-title").text(f.titleText),f.imageUrl==null?o.addClass("noImage"):(o.find("img.modal-thumb").attr("src",f.imageUrl),o.removeClass("noImage")),n.extraClass&&(o.removeClass(n.extraClass),n.extraClass=!1),f.cssClass!=null&&(o.addClass(f.cssClass),n.extraClass=f.cssClass),f.allowHtmlContentInBody?o.find(".modal-message").html(f.bodyContent):o.find(".modal-message").text(f.bodyContent),f.checkboxAgreementRequired?(r(c),o.find(".modal-checkbox.checkbox > input").prop("checked",!1),o.find(".modal-checkbox.checkbox > label").text(f.checkboxAgreementText),o.find(".modal-checkbox.checkbox").show()):(o.find(".modal-checkbox.checkbox > input").prop("checked",!0),o.find(".modal-checkbox.checkbox").hide()),$.trim(f.footerText)==""?o.find(".modal-footer").hide():o.find(".modal-footer").show(),f.allowHtmlContentInFooter?o.find(".modal-footer").html(f.footerText):o.find(".modal-footer").text(f.footerText),o.modal(i),b=$(d+" .modal-header .close"),b.unbind(),b.bind("click",function(){return l(f.onCancel),!1}),f.xToCancel||b.hide(),f.showAccept||c.hide(),f.showDecline||v.hide(),$("#rbx-body").addClass("modal-mask"),f.onOpenCallback()}function r(n){n.hasClass(s)?n.addClass(f):n.hasClass(v)?n.addClass(o):n.hasClass(h)&&n.addClass(c)}function p(n){return n.hasClass(c)||n.hasClass(f)||n.hasClass(o)?!0:!1}function rt(){var n=$(u),t=$(e);r(n),r(t)}function y(n){n.hasClass(f)?(n.removeClass(f),n.addClass(s)):n.hasClass(o)?(n.removeClass(o),n.addClass(v)):n.hasClass(c)&&(n.removeClass(c),n.addClass(h))}function w(){var n=$(u),t=$(e);y(n),y(t)}function k(){if(n.isOpen){var t=$(u);t.click()}}function b(){var n=$(e);n.click()}function t(t){n.isOpen=!1,typeof t!="undefined"?$.modal.close(t):$.modal.close(),$("#rbx-body").removeClass("modal-mask")}function l(n){t(),typeof n=="function"&&n()}function nt(n){if(typeof n=="function"){var i=n();if(i!=="undefined"&&i==!1)return!1}t()}function ut(n,t){var i=$(".modal-body");n?(i.find(".modal-btns").hide(),i.find(".modal-processing").show()):(i.find(".modal-btns").show(),i.find(".modal-processing").hide()),typeof t!="undefined"&&t!==""&&$.modal.close("."+t)}var d=".simplemodal-container",v="btn-primary-md",h="btn-secondary-md",s="btn-control-md",o="btn-primary-md disabled",c="btn-secondary-md disabled",f="btn-control-md disabled",it="btn-none",u=".modal-btns #confirm-btn",e=".modal-btns #decline-btn",tt="#modal-checkbox-input",n={isOpen:!1},i={overlayClose:!0,escClose:!0,opacity:80,zIndex:1040,overlayCss:{backgroundColor:"#000"},onClose:t,focus:!1},a={Yes:"Yes",No:"No",Agree:"Agree"};return{open:g,close:t,disableButtons:rt,enableButtons:w,clickYes:k,clickNo:b,status:n,toggleProcessing:ut,green:v,blue:h,white:s,none:it}}()),$(document).keypress(function(n){Roblox.Dialog.isOpen&&n.which===13&&Roblox.Dialog.clickYes()});

;// utilities/popover.js
var Roblox=Roblox||{};Roblox.Popover=function(){"use strict";function u(n,i){var u=$(n),f=$(i),e=$(t),h=e.outerWidth(),c=u.find(r).outerWidth(),l=e.offset().left,o=0,s;(u.hasClass("bottom")||u.hasClass("top"))&&(s=$("body").outerWidth()-parseInt(f.width()+f.offset().left),o=$("body").outerWidth()-l-s-h/2-c/2,u.find(r).css("right",o))}function f(t){return t.data("hiddenClassName")&&(n=t.data("hiddenClassName")),n}function s(){$(t).on("click",function(t){var s=$(this).data("bind"),h=s?"#"+s:i,r=$(h),c=$(this).data("container"),l=c?"#"+c:o,e;n=f(r),r.hasClass("manual")||r.toggleClass(n),e=!r.hasClass(n),$(document).triggerHandler("Roblox.Popover.Status",{isOpen:e,eventType:t.type}),e||u(h,l)})}function h(){$("body").on("click",function(r){$(t).each(function(){var u=$(this).data("bind"),t=u?$("#"+u):$(i),o="roblox-popover-open-always",e="roblox-popover-close";if(n=f(t),$(t).hasClass(o)&&!$(r.target).hasClass(e))return!1;!$(r.target).hasClass(e)&&($(this).is(r.target)||$(this).has(r.target).length!==0||t.has(r.target).length!==0||t.hasClass(n)||r.type!=="click")||(t.addClass(n),$(document).triggerHandler("Roblox.Popover.Status",{isHidden:!0,eventType:r.type}))})})}function e(){s(),h()}var t=".roblox-popover",i=".roblox-popover-content",o=".roblox-popover-container",r=".arrow",n="hidden";return $(function(){e()}),{init:e,setUpTrianglePosition:u}}();

;// YouTube/RobloxYouTube.js
function RobloxYouTubeVideo(n,t){var i=this;this.RobloxVideoPlayerID=n,this.OnPlayerStateChangeCallback=function(r){t(r,n,i)},this.YouTubeVideoID=null,this.Chromeless=!1,this.Autoplay=!1,this.Muted=!1,this.Player=function(){return document.getElementById(this.RobloxVideoPlayerID)},this.Init=function(n,t,r,u,f,e){function s(n){if(!o){i.Muted&&n.target.mute();var t=navigator.userAgent.match(/iPad/i)!=null;i.Autoplay&&!t&&n.target.playVideo()}}this.YouTubeVideoID=n,this.Chromeless=t,this.Autoplay=e,this.Muted=e;var o=u<=120;RobloxYouTubeVideoManager.CallWhenReady(function(){var t=new YT.Player(r,{width:u,height:f,playerVars:{showinfo:0,showsearch:0,rel:0,fs:0,version:3,autohide:1,enablejsapi:1,iv_load_policy:3,playerapiid:n,controls:1,wmode:"opaque"},videoId:n,events:{onReady:s}});t.A&&(t.A.id=i.RobloxVideoPlayerID)})},this.SeekToTime=function(n){this.Player().seekTo(n,!0)},this.PauseVideo=function(){this.Player().pauseVideo()}}var RobloxYouTube=RobloxYouTube||{Events:{States:{Unstarted:-1,Ended:0,Playing:1,Paused:2,Buffering:3,VideoCued:5},Errors:{InvalidParameters:2,VideoNotFound:100,NotEmbeddable:101,NotEmbeddable2:150}}},RobloxYouTubeVideoManager=function(){function e(i){t?i():n.push(i)}function f(){t=!0;for(var i=0;i<n.length;i++)n[i]()}function o(n){return r[n.RobloxVideoPlayerID]=n,n}function s(n){return r[n]}var r=[],n=[],t=!1,u=document.createElement("script"),i;return u.src="https://www.youtube.com/iframe_api",i=document.getElementsByTagName("script")[0],i.parentNode.insertBefore(u,i),$(function(){t||typeof YT=="undefined"||(YT.loaded===1?f():onYouTubeIframeAPIReady=robloxOnYoutubeIframeAPIReady)}),{AddVideo:o,GetVideo:s,OnYouTubeApiReady:f,CallWhenReady:e}}(),robloxOnYoutubeIframeAPIReady=function(){RobloxYouTubeVideoManager.OnYouTubeApiReady()};onYoutubeIframeAPIReady=robloxOnYoutubeIframeAPIReady;