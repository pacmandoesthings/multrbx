<!DOCTYPE html>
<!--[if IE 8]><html class="ie8" ng-app="robloxApp"><![endif]-->
<!--[if gt IE 8]><!-->
<html>
<!--<![endif]-->
<head data-machine-id="WEB997">
    <!-- MachineID: WEB997 -->
    <title>Roblox</title>
<meta http-equiv="X-UA-Compatible" content="IE=edge,requiresActiveX=true" />
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<meta name="author" content="Roblox Corporation" />
<meta name="description" content="Roblox is a global platform that brings people together through play." />
<meta name="keywords" content="free games, online games, building games, virtual worlds, free mmo, gaming cloud, physics engine" />
<meta name="apple-itunes-app" content="app-id=431946152" />
<meta name="google-site-verification" content="KjufnQUaDv5nXJogvDMey4G-Kb7ceUVxTdzcMaP9pCY" />


<script type="application/ld+json">
    {
    "@context" : "http://schema.org",
    "@type" : "Organization",
    "name" : "Roblox",
    "url" : "https://www.roblox.com/",
    "logo": "https://images.rbxcdn.com/c69b74f49e785df33b732273fad9dbe0.png",
    "sameAs" : [
    "https://www.facebook.com/ROBLOX/",
    "https://twitter.com/roblox",
    "https://www.linkedin.com/company/147977",
    "https://www.instagram.com/roblox/",
    "https://www.youtube.com/user/roblox",
    "https://plus.google.com/+roblox",
    "https://www.twitch.tv/roblox"
    ]
    }
</script>    <meta property="og:site_name" content="ROBLOX" />
    <meta property="og:title" content="Roblox" />
    <meta property="og:type" content="website"/>
        <meta property="og:url" content="https://www.roblox.com/" />
    <meta property="og:description" content="Roblox is ushering in the next generation of entertainment. Imagine, create, and play together with millions of players across an infinite variety of immersive, user-generated 3D worlds."/>
            <meta property="og:image" content="https://images.rbxcdn.com/6c27cb9db1779888868bf7d87e6d3709.jpg" />
    <meta property="fb:app_id" content="190191627665278">
    <meta name="twitter:card" content="summary_large_image">
    <meta name="twitter:site" content="@ROBLOX">
    <meta name="twitter:title" content="Roblox">
    <meta name="twitter:description" content="Roblox is ushering in the next generation of entertainment. Imagine, create, and play together with millions of players across an infinite variety of immersive, user-generated 3D worlds.">
    <meta name="twitter:creator">
            <meta name=twitter:image1 content="https://images.rbxcdn.com/6c27cb9db1779888868bf7d87e6d3709.jpg" />
    <meta name="twitter:app:country" content="US">
    <meta name="twitter:app:name:iphone" content="ROBLOX Mobile">
    <meta name="twitter:app:id:iphone" content="431946152">
    <meta name="twitter:app:url:iphone">
    <meta name="twitter:app:name:ipad" content="ROBLOX Mobile">
    <meta name="twitter:app:id:ipad" content="431946152">
    <meta name="twitter:app:url:ipad">
    <meta name="twitter:app:name:googleplay" content="ROBLOX">
    <meta name="twitter:app:id:googleplay" content="com.roblox.client">
    <meta name="twitter:app:url:googleplay"/>

<meta name="locale-data" 
      data-language-code="en_us" 
      data-language-name="English" 
      data-locale-api-url="https://locale.roblox.com" /><meta name="device-meta"
      data-device-type="computer"
      data-is-in-app="false"
      data-is-desktop="true"
      data-is-phone="false"
      data-is-tablet="false"
      data-is-console="false"
      data-is-android-app="false"
      data-is-ios-app="false"
      data-is-uwp-app="false"
      data-is-xbox-app="false"
      data-is-amazon-app="false"
      data-is-studio="false"
      data-app-type="unknown"
/>

<meta name="page-meta" data-internal-page-name="Landing" />
    

<script type="text/javascript">
    var Roblox = Roblox || {};

    Roblox.BundleVerifierConstants = {
        isMetricsApiEnabled: true,
        eventStreamUrl: "//ecsv2.roblox.com/pe?t=diagnostic",
        deviceType: "Computer",
        cdnLoggingEnabled: JSON.parse("true")
    };
</script>        <script type="text/javascript">
            var Roblox = Roblox || {};

Roblox.BundleDetector = (function () {
    var isMetricsApiEnabled = Roblox.BundleVerifierConstants && Roblox.BundleVerifierConstants.isMetricsApiEnabled;

    var loadStates = {
        loadSuccess: "loadSuccess",
        loadFailure: "loadFailure",
        executionFailure: "executionFailure"
    };

    var bundleContentTypes = {
        javascript: "javascript",
        css: "css"
    };

    var ephemeralCounterNames = {
        cdnPrefix: "CDNBundleError_",
        unknown: "CDNBundleError_unknown",
        cssError: "CssBundleError",
        jsError: "JavascriptBundleError",
        jsFileError: "JsFileExecutionError",
        resourceError: "ResourcePerformance_Error",
        resourceLoaded: "ResourcePerformance_Loaded"
    };

    return {
        jsBundlesLoaded: {},
        bundlesReported: {},

        counterNames: ephemeralCounterNames,
        loadStates: loadStates,
        bundleContentTypes: bundleContentTypes,

        timing: undefined,

        setTiming: function (windowTiming) {
            this.timing = windowTiming;
        },

        getLoadTime: function () {
            if (this.timing && this.timing.domComplete) {
                return this.getCurrentTime() - this.timing.domComplete;
            }
        },

        getCurrentTime: function () {
            return new Date().getTime();
        },

        getCdnProviderName: function (bundleUrl, callBack) {
            if (Roblox.BundleVerifierConstants.cdnLoggingEnabled) {
                var xhr = new XMLHttpRequest();
                xhr.open('GET', bundleUrl, true);

                xhr.onreadystatechange = function () {
                    if (xhr.readyState === xhr.HEADERS_RECEIVED) {
                        try {
                            var headerValue = xhr.getResponseHeader("rbx-cdn-provider");
                            if (headerValue) {
                                callBack(headerValue);
                            } else {
                                callBack();
                            }
                        } catch (e) {
                            callBack();
                        }
                    }
                };

                xhr.onerror = function () {
                    callBack();
                };

                xhr.send();
            } else {
                callBack();
            }
        },

        getCdnProviderAndReportMetrics: function (bundleUrl, bundleName, loadState, bundleContentType) {
            this.getCdnProviderName(bundleUrl, function (cdnProviderName) {
                Roblox.BundleDetector.reportMetrics(bundleUrl, bundleName, loadState, bundleContentType, cdnProviderName);
            });
        },

        reportMetrics: function (bundleUrl, bundleName, loadState, bundleContentType, cdnProviderName) {
            if (!isMetricsApiEnabled
                || !bundleUrl
                || !loadState
                || !loadStates.hasOwnProperty(loadState)
                || !bundleContentType
                || !bundleContentTypes.hasOwnProperty(bundleContentType)) {
                return;
            }

            var xhr = new XMLHttpRequest();
            var metricsApiUrl = (Roblox.EnvironmentUrls && Roblox.EnvironmentUrls.metricsApi) || "https://metrics.roblox.com";

            xhr.open("POST", metricsApiUrl + "/v1/bundle-metrics/report", true);
            xhr.setRequestHeader("Content-Type", "application/json");
            xhr.withCredentials = true;
            xhr.send(JSON.stringify({
                bundleUrl: bundleUrl,
                bundleName: bundleName || "",
                bundleContentType: bundleContentType,
                loadState: loadState,
                cdnProviderName: cdnProviderName,
                loadTimeInMilliseconds: this.getLoadTime() || 0
            }));
        },

        logToEphemeralStatistics: function (sequenceName, value) {
            var deviceType = Roblox.BundleVerifierConstants.deviceType;
            sequenceName += "_" + deviceType;

            var xhr = new XMLHttpRequest();
            xhr.open('POST', '/game/report-stats?name=' + sequenceName + "&value=" + value, true);
            xhr.withCredentials = true;
            xhr.send();
        },

        logToEphemeralCounter: function (ephemeralCounterName) {
            var deviceType = Roblox.BundleVerifierConstants.deviceType;
            ephemeralCounterName += "_" + deviceType;
            //log to ephemeral counters - taken from eventTracker.js
            var xhr = new XMLHttpRequest();
            xhr.open('POST', '/game/report-event?name=' + ephemeralCounterName, true);
            xhr.withCredentials = true;
            xhr.send();
        },

        logToEventStream: function (failedBundle, ctx, cdnProvider, status) {
            var esUrl = Roblox.BundleVerifierConstants.eventStreamUrl,
                currentPageUrl = encodeURIComponent(window.location.href);

            var deviceType = Roblox.BundleVerifierConstants.deviceType;
            ctx += "_" + deviceType;
            //try and grab performance data.
            //Note that this is the performance of the xmlhttprequest rather than the original resource load.
            var duration = 0;
            if (window.performance) {
                var perfTiming = window.performance.getEntriesByName(failedBundle);
                if (perfTiming.length > 0) {
                    var data = perfTiming[0];
                    duration = data.duration || 0;
                }
            }
            //log to event stream (diagnostic)
            var params = "&evt=webBundleError&url=" + currentPageUrl +
                "&ctx=" + ctx + "&fileSourceUrl=" + encodeURIComponent(failedBundle) +
                "&cdnName=" + (cdnProvider || "unknown") +
                "&statusCode=" + (status || "unknown") +
                "&loadDuration=" + Math.floor(duration);
            var img = new Image();
            img.src = esUrl + params;
        },

        getCdnInfo: function (failedBundle, ctx, fileType) {
            if (Roblox.BundleVerifierConstants.cdnLoggingEnabled) {
                var xhr = new XMLHttpRequest();
                var counter = this.counterNames;
                xhr.open('GET', failedBundle, true);
                var cdnProvider;

                //succesful request
                xhr.onreadystatechange = function () {
                    if (xhr.readyState === xhr.HEADERS_RECEIVED) {
                        cdnProvider = xhr.getResponseHeader("rbx-cdn-provider");
                        if (cdnProvider && cdnProvider.length > 0) {
                            Roblox.BundleDetector.logToEphemeralCounter(counter.cdnPrefix + cdnProvider + "_" + fileType);
                        }
                        else {
                            Roblox.BundleDetector.logToEphemeralCounter(counter.unknown + "_" + fileType);
                        }
                    }
                    else if (xhr.readyState === xhr.DONE) {
                        // append status to cdn provider so we know its not related to network error. 
                        Roblox.BundleDetector.logToEventStream(failedBundle, ctx, cdnProvider, xhr.status);
                    }
                };

                //attach to possible things that can go wrong with the request.
                //additionally a network error will trigger this callback
                xhr.onerror = function () {
                    Roblox.BundleDetector.logToEphemeralCounter(counter.unknown + "_" + fileType);
                    Roblox.BundleDetector.logToEventStream(failedBundle, ctx, counter.unknown);
                };

                xhr.send();
            }
            else {
                this.logToEventStream(failedBundle, ctx);
            }
        },

        reportResourceError: function (resourceName) {
            var ephemeralCounterName = this.counterNames.resourceError + "_" + resourceName;
            this.logToEphemeralCounter(ephemeralCounterName);
        },

        reportResourceLoaded: function (resourceName) {
            var loadTimeInMs = this.getLoadTime();
            if (loadTimeInMs) {
                var sequenceName = this.counterNames.resourceLoaded + "_" + resourceName;
                this.logToEphemeralStatistics(sequenceName, loadTimeInMs);
            }
        },

        reportBundleError: function (bundleTag) {
            var ephemeralCounterName, failedBundle, ctx, contentType;
            if (bundleTag.rel && bundleTag.rel === "stylesheet") {
                ephemeralCounterName = this.counterNames.cssError;
                failedBundle = bundleTag.href;
                ctx = "css";
                contentType = bundleContentTypes.css;
            } else {
                ephemeralCounterName = this.counterNames.jsError;
                failedBundle = bundleTag.src;
                ctx = "js";
                contentType = bundleContentTypes.javascript;
            }

            //mark that we logged this bundle
            this.bundlesReported[failedBundle] = true;

            //e.g. javascriptBundleError_Computer
            this.logToEphemeralCounter(ephemeralCounterName);
            //this will also log to event stream
            this.getCdnInfo(failedBundle, ctx, ctx);

            var bundleName;
            if (bundleTag.dataset) {
                bundleName = bundleTag.dataset.bundlename;
            }
            else {
                bundleName = bundleTag.getAttribute('data-bundlename');
            }

            this.getCdnProviderAndReportMetrics(failedBundle, bundleName, loadStates.loadFailure, contentType);
        },

        bundleDetected: function (bundleName) {
            this.jsBundlesLoaded[bundleName] = true;
        },

        verifyBundles: function (document) {
            var ephemeralCounterName = this.counterNames.jsFileError,
                eventContext = ephemeralCounterName;
            //grab all roblox script tags in the page. 
            var scripts = (document && document.scripts) || window.document.scripts;
            var errorsList = [];
            var bundleName;
            var monitor;
            for (var i = 0; i < scripts.length; i++) {
                var item = scripts[i];

                if (item.dataset) {
                    bundleName = item.dataset.bundlename;
                    monitor = item.dataset.monitor;
                }
                else {
                    bundleName = item.getAttribute('data-bundlename');
                    monitor = item.getAttribute('data-monitor');
                }

                if (item.src && monitor && bundleName) {
                    if (!Roblox.BundleDetector.jsBundlesLoaded.hasOwnProperty(bundleName)) {
                        errorsList.push(item);
                    }
                }
            }
            if (errorsList.length > 0) {
                for (var j = 0; j < errorsList.length; j++) {
                    var script = errorsList[j];
                    if (!this.bundlesReported[script.src]) {
                        //log the counter only if the file is actually corrupted, not just due to failure to load
                        //e.g. JsFileExecutionError_Computer
                        this.logToEphemeralCounter(ephemeralCounterName);
                        this.getCdnInfo(script.src, eventContext, 'js');

                        if (script.dataset) {
                            bundleName = script.dataset.bundlename;
                        }
                        else {
                            bundleName = script.getAttribute('data-bundlename');
                        }

                        this.getCdnProviderAndReportMetrics(script.src, bundleName, loadStates.executionFailure, bundleContentTypes.javascript);
                    }
                }
            }
        }
    };
})();

window.addEventListener("load", function (evt) {
    Roblox.BundleDetector.verifyBundles();
});

Roblox.BundleDetector.setTiming(window.performance.timing);
            //# sourceURL=somename.js
        </script>
    
    <link href="https://images.rbxcdn.com/3b43a5c16ec359053fef735551716fc5.ico" rel="icon" />


    <link onerror='Roblox.BundleDetector && Roblox.BundleDetector.reportBundleError(this)' rel='stylesheet' data-bundlename='StyleGuide' href='https://static.rbxcdn.com/css/a0a81d2e84e563372eb6c6f974833031c42f61eb6094150eb288b9d9ff6c3e35.css/fetch' />



    <link rel="canonical" href="https://www.roblox.com/" />
    

    
<link onerror='Roblox.BundleDetector && Roblox.BundleDetector.reportBundleError(this)' rel='stylesheet'  href='https://static.rbxcdn.com/css/page___b9da2650977861b9ecd198f068f842c2_m.css/fetch' />


<link onerror='Roblox.BundleDetector && Roblox.BundleDetector.reportBundleError(this)' rel='stylesheet'  href='https://authsite.roblox.com/landing/266e3fa9-fbe0-44c7-b8d4-27fe06a4a556/get-css-bundle' />

<link onerror='Roblox.BundleDetector && Roblox.BundleDetector.reportBundleError(this)' rel='stylesheet' data-bundlename='Captcha' href='https://static.rbxcdn.com/css/1b4a454048320339d1a8e7459370f628af99f171c07767bf505492f5650c3b4d.css/fetch' />


        





<script type="text/javascript">
    var Roblox = Roblox || {};
    Roblox.EnvironmentUrls = Roblox.EnvironmentUrls || {};
    // please keep the list in alphabetical order
    Roblox.EnvironmentUrls = {
        abtestingApiSite: "https://abtesting.roblox.com",
        accountInformationApi: "https://accountinformation.roblox.com",
        accountSettingsApi: "https://accountsettings.roblox.com",
        amazonStoreLink: "http://amzn.com/B00NUF4YOA",
        apiGatewayUrl: "https://apis.roblox.com",
        apiProxyUrl: "https://api.roblox.com",
        appProtocolUrl: "robloxmobile://",
        appStoreLink: "https://itunes.apple.com/us/app/roblox-mobile/id431946152",
        authApi: "https://auth.roblox.com",
        authAppSite: "https://authsite.roblox.com",
        avatarApi: "https://avatar.roblox.com",
        avatarAppSite: "https://avatarsite.roblox.com",
        badgesApi: "https://badges.roblox.com",
        billingApi: "https://billing.roblox.com",
        captchaApi: "https://captcha.roblox.com",
        catalogApi: "https://catalog.roblox.com",
        chatApi: "https://chat.roblox.com",
        contactsApi: "https://contacts.roblox.com",
        developApi: "https://develop.roblox.com",
        domain: "roblox.com",
        economyApi: "https://economy.roblox.com",
        followingsApi: "https://followings.roblox.com",
        friendsApi: "https://friends.roblox.com",
        friendsAppSite: "https://friendsite.roblox.com",
        gamesApi: "https://games.roblox.com",
        gamesAppSite: "https://gamesite.roblox.com",
        gameInternationalizationApi: "https://gameinternationalization.roblox.com",
        googlePlayStoreLink: "https://play.google.com/store/apps/details?id=com.roblox.client&hl=en",
        groupsApi: "https://groups.roblox.com",
        inventoryApi: "https://inventory.roblox.com",
        iosAppStoreLink: "https://itunes.apple.com/us/app/roblox-mobile/id431946152",
        localeApi: "https://locale.roblox.com",
        localizationTablesApi: "https://localizationtables.roblox.com",
        metricsApi: "https://metrics.roblox.com",
        midasApi: "https://midas.roblox.com",
        notificationApi: "https://notifications.roblox.com",
        notificationAppSite: "https://notificationsite.roblox.com",
        premiumFeaturesApi: "https://premiumfeatures.roblox.com",
        presenceApi: "https://presence.roblox.com",
        publishApi: "https://publish.roblox.com",
        surveysAppSite: "https://surveyssite.roblox.com",
        thumbnailsApi: "https://thumbnails.roblox.com",
        translationRolesApi: "https://translationroles.roblox.com",
        voiceApi: "https://voice.roblox.com",
        websiteUrl: "https://www.roblox.com",
        windowsStoreLink: "https://www.microsoft.com/en-us/store/games/roblox/9nblgggzm6wm",
        xboxStoreLink: "https://www.microsoft.com/en-us/p/roblox/bq1tn1t79v9k"
    }
</script>



<script type="text/javascript">
    var Roblox = Roblox || {};
    Roblox.GaEventSettings = {
        gaDFPPreRollEnabled: "false" === "true",
        gaLaunchAttemptAndLaunchSuccessEnabled: "false" === "true",
        gaPerformanceEventEnabled: "false" === "true"
    };
</script>


    
    <script onerror='Roblox.BundleDetector && Roblox.BundleDetector.reportBundleError(this)' data-monitor='true' data-bundlename='headerinit' type='text/javascript' src='https://js.rbxcdn.com/2cf45f2e73c1c0f46b9fdb40828e3299.js'></script>


    

    
    <!--[if lt IE 9]>
        <script src="//oss.maxcdn.com/html5shiv/3.7.2/html5shiv.min.js"></script>
        <script src="//oss.maxcdn.com/respond/1.4.2/respond.min.js"></script>
    <![endif]-->

<script>
    //Set if it browser's do not track flag is enabled
    var Roblox = Roblox || {};
    (function() {
        var dnt = navigator.doNotTrack || window.doNotTrack || navigator.msDoNotTrack;
        if (typeof window.external !== "undefined" &&
            typeof window.external.msTrackingProtectionEnabled !== "undefined") {
            dnt = dnt || window.external.msTrackingProtectionEnabled();
        }
        Roblox.browserDoNotTrack = dnt == "1" || dnt == "yes" || dnt === true;
    })();
</script>


    <script type="text/javascript">

        var _gaq = _gaq || [];

                window.GoogleAnalyticsDisableRoblox2 = true;
        _gaq.push(['b._setAccount', 'UA-486632-1']);
            _gaq.push(['b._setSampleRate', '10']);
        _gaq.push(['b._setCampSourceKey', 'rbx_source']);
        _gaq.push(['b._setCampMediumKey', 'rbx_medium']);
        _gaq.push(['b._setCampContentKey', 'rbx_campaign']);

            _gaq.push(['b._setDomainName', 'roblox.com']);

            _gaq.push(['b._setCustomVar', 1, 'Visitor', 'Anonymous', 2]);
                _gaq.push(['b._setPageGroup', 1, 'Landing']);
            _gaq.push(['b._trackPageview']);

        _gaq.push(['c._setAccount', 'UA-26810151-2']);
            _gaq.push(['c._setSampleRate', '1']);
                    _gaq.push(['c._setDomainName', 'roblox.com']);
                    _gaq.push(['c._setPageGroup', 1, 'Landing']);

        (function () {
            if (!Roblox.browserDoNotTrack) {
                var ga = document.createElement('script');
                ga.type = 'text/javascript';
                ga.async = true;
                ga.src = ('https:' == document.location.protocol ? 'https://ssl' : 'http://www') + '.google-analytics.com/ga.js';
                var s = document.getElementsByTagName('script')[0];
                s.parentNode.insertBefore(ga, s);
            }
        })();
    </script>
    
            <script type="text/javascript">
            if (Roblox && Roblox.EventStream) {
                Roblox.EventStream.Init("//ecsv2.roblox.com/www/e.png",
                    "//ecsv2.roblox.com/www/e.png",
                    "//ecsv2.roblox.com/pe?t=studio",
                    "//ecsv2.roblox.com/pe?t=diagnostic");
            }
        </script>



<script type="text/javascript">
    if (Roblox && Roblox.PageHeartbeatEvent) {
        Roblox.PageHeartbeatEvent.Init([2,8,20,60]);
    }
</script>        <script type="text/javascript">
if (typeof(Roblox) === "undefined") { Roblox = {}; }
Roblox.Endpoints = Roblox.Endpoints || {};
Roblox.Endpoints.Urls = Roblox.Endpoints.Urls || {};
Roblox.Endpoints.Urls['/api/item.ashx'] = 'https://www.roblox.com/api/item.ashx';
Roblox.Endpoints.Urls['/asset/'] = 'https://assetgame.roblox.com/asset/';
Roblox.Endpoints.Urls['/client-status/set'] = 'https://www.roblox.com/client-status/set';
Roblox.Endpoints.Urls['/client-status'] = 'https://www.roblox.com/client-status';
Roblox.Endpoints.Urls['/game/'] = 'https://assetgame.roblox.com/game/';
Roblox.Endpoints.Urls['/game-auth/getauthticket'] = 'https://www.roblox.com/game-auth/getauthticket';
Roblox.Endpoints.Urls['/game/edit.ashx'] = 'https://assetgame.roblox.com/game/edit.ashx';
Roblox.Endpoints.Urls['/game/getauthticket'] = 'https://assetgame.roblox.com/game/getauthticket';
Roblox.Endpoints.Urls['/game/get-hash'] = 'https://assetgame.roblox.com/game/get-hash';
Roblox.Endpoints.Urls['/game/placelauncher.ashx'] = 'https://assetgame.roblox.com/game/placelauncher.ashx';
Roblox.Endpoints.Urls['/game/preloader'] = 'https://assetgame.roblox.com/game/preloader';
Roblox.Endpoints.Urls['/game/report-stats'] = 'https://assetgame.roblox.com/game/report-stats';
Roblox.Endpoints.Urls['/game/report-event'] = 'https://assetgame.roblox.com/game/report-event';
Roblox.Endpoints.Urls['/game/updateprerollcount'] = 'https://assetgame.roblox.com/game/updateprerollcount';
Roblox.Endpoints.Urls['/login/default.aspx'] = 'https://www.roblox.com/login/default.aspx';
Roblox.Endpoints.Urls['/my/avatar'] = 'https://www.roblox.com/my/avatar';
Roblox.Endpoints.Urls['/my/money.aspx'] = 'https://www.roblox.com/my/money.aspx';
Roblox.Endpoints.Urls['/navigation/userdata'] = 'https://www.roblox.com/navigation/userdata';
Roblox.Endpoints.Urls['/chat/chat'] = 'https://www.roblox.com/chat/chat';
Roblox.Endpoints.Urls['/chat/data'] = 'https://www.roblox.com/chat/data';
Roblox.Endpoints.Urls['/presence/users'] = 'https://www.roblox.com/presence/users';
Roblox.Endpoints.Urls['/presence/user'] = 'https://www.roblox.com/presence/user';
Roblox.Endpoints.Urls['/friends/list'] = 'https://www.roblox.com/friends/list';
Roblox.Endpoints.Urls['/navigation/getcount'] = 'https://www.roblox.com/navigation/getCount';
Roblox.Endpoints.Urls['/regex/email'] = 'https://www.roblox.com/regex/email';
Roblox.Endpoints.Urls['/catalog/browse.aspx'] = 'https://www.roblox.com/catalog/browse.aspx';
Roblox.Endpoints.Urls['/catalog/html'] = 'https://search.roblox.com/catalog/html';
Roblox.Endpoints.Urls['/catalog/json'] = 'https://search.roblox.com/catalog/json';
Roblox.Endpoints.Urls['/catalog/contents'] = 'https://search.roblox.com/catalog/contents';
Roblox.Endpoints.Urls['/catalog/lists.aspx'] = 'https://search.roblox.com/catalog/lists.aspx';
Roblox.Endpoints.Urls['/catalog/items'] = 'https://search.roblox.com/catalog/items';
Roblox.Endpoints.Urls['/asset-hash-thumbnail/image'] = 'https://assetgame.roblox.com/asset-hash-thumbnail/image';
Roblox.Endpoints.Urls['/asset-hash-thumbnail/json'] = 'https://assetgame.roblox.com/asset-hash-thumbnail/json';
Roblox.Endpoints.Urls['/asset-thumbnail-3d/json'] = 'https://assetgame.roblox.com/asset-thumbnail-3d/json';
Roblox.Endpoints.Urls['/asset-thumbnail/image'] = 'https://assetgame.roblox.com/asset-thumbnail/image';
Roblox.Endpoints.Urls['/asset-thumbnail/json'] = 'https://assetgame.roblox.com/asset-thumbnail/json';
Roblox.Endpoints.Urls['/asset-thumbnail/url'] = 'https://assetgame.roblox.com/asset-thumbnail/url';
Roblox.Endpoints.Urls['/asset/request-thumbnail-fix'] = 'https://assetgame.roblox.com/asset/request-thumbnail-fix';
Roblox.Endpoints.Urls['/avatar-thumbnail-3d/json'] = 'https://www.roblox.com/avatar-thumbnail-3d/json';
Roblox.Endpoints.Urls['/avatar-thumbnail/image'] = 'https://www.roblox.com/avatar-thumbnail/image';
Roblox.Endpoints.Urls['/avatar-thumbnail/json'] = 'https://www.roblox.com/avatar-thumbnail/json';
Roblox.Endpoints.Urls['/avatar-thumbnails'] = 'https://www.roblox.com/avatar-thumbnails';
Roblox.Endpoints.Urls['/avatar/request-thumbnail-fix'] = 'https://www.roblox.com/avatar/request-thumbnail-fix';
Roblox.Endpoints.Urls['/bust-thumbnail/json'] = 'https://www.roblox.com/bust-thumbnail/json';
Roblox.Endpoints.Urls['/group-thumbnails'] = 'https://www.roblox.com/group-thumbnails';
Roblox.Endpoints.Urls['/groups/getprimarygroupinfo.ashx'] = 'https://www.roblox.com/groups/getprimarygroupinfo.ashx';
Roblox.Endpoints.Urls['/headshot-thumbnail/json'] = 'https://www.roblox.com/headshot-thumbnail/json';
Roblox.Endpoints.Urls['/item-thumbnails'] = 'https://www.roblox.com/item-thumbnails';
Roblox.Endpoints.Urls['/outfit-thumbnail/json'] = 'https://www.roblox.com/outfit-thumbnail/json';
Roblox.Endpoints.Urls['/place-thumbnails'] = 'https://www.roblox.com/place-thumbnails';
Roblox.Endpoints.Urls['/thumbnail/asset/'] = 'https://www.roblox.com/thumbnail/asset/';
Roblox.Endpoints.Urls['/thumbnail/avatar-headshot'] = 'https://www.roblox.com/thumbnail/avatar-headshot';
Roblox.Endpoints.Urls['/thumbnail/avatar-headshots'] = 'https://www.roblox.com/thumbnail/avatar-headshots';
Roblox.Endpoints.Urls['/thumbnail/user-avatar'] = 'https://www.roblox.com/thumbnail/user-avatar';
Roblox.Endpoints.Urls['/thumbnail/resolve-hash'] = 'https://www.roblox.com/thumbnail/resolve-hash';
Roblox.Endpoints.Urls['/thumbnail/place'] = 'https://www.roblox.com/thumbnail/place';
Roblox.Endpoints.Urls['/thumbnail/get-asset-media'] = 'https://www.roblox.com/thumbnail/get-asset-media';
Roblox.Endpoints.Urls['/thumbnail/remove-asset-media'] = 'https://www.roblox.com/thumbnail/remove-asset-media';
Roblox.Endpoints.Urls['/thumbnail/set-asset-media-sort-order'] = 'https://www.roblox.com/thumbnail/set-asset-media-sort-order';
Roblox.Endpoints.Urls['/thumbnail/place-thumbnails'] = 'https://www.roblox.com/thumbnail/place-thumbnails';
Roblox.Endpoints.Urls['/thumbnail/place-thumbnails-partial'] = 'https://www.roblox.com/thumbnail/place-thumbnails-partial';
Roblox.Endpoints.Urls['/thumbnail_holder/g'] = 'https://www.roblox.com/thumbnail_holder/g';
Roblox.Endpoints.Urls['/users/{id}/profile'] = 'https://www.roblox.com/users/{id}/profile';
Roblox.Endpoints.Urls['/service-workers/push-notifications'] = 'https://www.roblox.com/service-workers/push-notifications';
Roblox.Endpoints.Urls['/notification-stream/notification-stream-data'] = 'https://www.roblox.com/notification-stream/notification-stream-data';
Roblox.Endpoints.Urls['/api/friends/acceptfriendrequest'] = 'https://www.roblox.com/api/friends/acceptfriendrequest';
Roblox.Endpoints.Urls['/api/friends/declinefriendrequest'] = 'https://www.roblox.com/api/friends/declinefriendrequest';
Roblox.Endpoints.Urls['/authentication/is-logged-in'] = 'https://www.roblox.com/authentication/is-logged-in';
Roblox.Endpoints.addCrossDomainOptionsToAllRequests = true;
</script>

    <script type="text/javascript">
if (typeof(Roblox) === "undefined") { Roblox = {}; }
Roblox.Endpoints = Roblox.Endpoints || {};
Roblox.Endpoints.Urls = Roblox.Endpoints.Urls || {};
</script>

    <script>
    Roblox = Roblox || {};
    Roblox.AbuseReportPVMeta = {
        desktopEnabled: false,
        phoneEnabled: false,
        inAppEnabled: false
    };
</script>

</head>
<body id="rbx-body"
      class="rbx-body    gotham-font"
      data-performance-relative-value="0.005"
      data-internal-page-name="Landing"
      data-send-event-percentage="0">
    <div id="roblox-linkify" data-enabled="true" data-regex="(https?\:\/\/)?(?:www\.)?([a-z0-9-]{2,}\.)*(((m|de|www|web|api|blog|wiki|corp|polls|bloxcon|developer|devforum|forum)\.roblox\.com|robloxlabs\.com)|(www\.shoproblox\.com)|help\.roblox\.com(?![A-Za-z0-9\/.]*\/attachments\/))(?!\/[A-Za-z0-9-+&@#\/=~_|!:,.;]*%)((\/[A-Za-z0-9-+&@#\/%?=~_|!:,.;]*)|(?=\s|\b))" data-regex-flags="gm" data-as-http-regex="(([^.]help|polls)\.roblox\.com)"></div>

<div id="image-retry-data"
     data-image-retry-max-times="10"
     data-image-retry-timer="1500"
     data-ga-logging-percent="10">
</div>
<div id="http-retry-data"
     data-http-retry-max-timeout="0"
     data-http-retry-base-timeout="0"
     data-http-retry-max-times="1">
</div>
    
    
        <script src="https://roblox-api.arkoselabs.com/fc/api/?onload=reportFunCaptchaLoaded" async onerror="Roblox.BundleDetector && Roblox.BundleDetector.reportResourceError('funcaptcha')"></script>
<script type="text/javascript">
    var Roblox = Roblox || {};
    $(function () {
        var captcha = Roblox.Captcha;
        //set captcha values
        captcha.setInvisibleMode("true" === "true" ? true : false);
        captcha.setSiteKey("6LcpwSQUAAAAAPN5nICO6tHekrkrSIYvsl9jAPW4");
        var types = ["Login"];
        captcha.setMultipleEndpoints(types, "https://api.roblox.com/captcha/validate/login");
        //for truly invisible
        var trulyInvisibleEnabled = "false" === "true";
        if (trulyInvisibleEnabled) {
            var trulyInvisibleCaptchaContainer = "truly-invisible-captcha";
            var elem = $("#" + trulyInvisibleCaptchaContainer);
            if (elem.length) {
                Roblox.Captcha.renderTrulyInvisible(trulyInvisibleCaptchaContainer, types[0]);
            }
        }
    });
</script>
<script type="text/javascript">
    var Roblox = Roblox || {};
    $(function () {
        var funCaptcha = Roblox.FunCaptcha;
        if (funCaptcha) {
            var captchaTypes = [{"Type":"Signup","PublicKey":"A2A14B1D-1AF3-C791-9BBC-EE33CC7A0A6F","ApiUrl":"https://captcha.roblox.com/v1/funcaptcha/signup"},{"Type":"Login","PublicKey":"9F35E182-C93C-EBCC-A31D-CF8ED317B996","ApiUrl":"https://captcha.roblox.com/v1/funcaptcha/login/web"}];
            funCaptcha.addCaptchaTypes(captchaTypes, true);
            funCaptcha.setMaxRetriesOnTokenValidationFailure(1);
            funCaptcha.setPerAppTypeLoggingEnabled(false);
            funCaptcha.setRetryIntervalRange(500, 1500);
        }
    });

    // Necessary because of how FunCaptcha js executes callback
    // i.e. window["{function name}"]
    function reportFunCaptchaLoaded()
    {
        if (Roblox.BundleDetector)
        {
            Roblox.BundleDetector.reportResourceLoaded("funcaptcha");
        }
    }
</script>
<script>
    var Roblox = Roblox || {};
    Roblox.SignupMeta = {
        isSinglePasswordFieldEnabled: true,
        isNewUserLandingAbTestingEnabled: true,
        newUserLandingPageAbTestName: "NewUser.LandingPage.HomePage",
        timeoutOnAbtestingEnrollEndpoint: "30000",
        isFbSignUpEnabled: false
    };
</script>

<div id="landing-container" class="landing-container">
    <div landing-base class="landing-base"
         is-login-fun-captcha-enabled="true"
         is-always-captcha-login-enabled="false"
         is-always-captcha-sign-up-enabled="false"
         is-captcha-v2-component-for-sign-up-enabled="true"
         is-captcha-v2-component-for-login-enabled="true">
    </div>
</div>

    <footer class="container-footer">
        <div class="footer">
            <ul class="row footer-links">
                    <li class="footer-link">
                        <a href="https://www.roblox.com/info/about-us?locale=en_us" class="text-footer-nav roblox-interstitial" target="_blank">
                            About Us
                        </a>
                    </li>
                    <li class="footer-link">
                        <a href="https://www.roblox.com/info/jobs?locale=en_us" class="text-footer-nav roblox-interstitial" target="_blank">
                            Jobs
                        </a>
                    </li>
                <li class=" footer-link">
                    <a href="https://www.roblox.com/info/blog?locale=en_us" class="text-footer-nav" target="_blank">
                        Blog
                    </a>
                </li>
                <li class=" footer-link">
                    <a href="https://www.roblox.com/info/parents?locale=en_us" class="text-footer-nav roblox-interstitial" target="_blank">
                        Parents
                    </a>
                </li>
                <li class=" footer-link">
                    <a href="https://www.roblox.com/info/help?locale=en_us" class="text-footer-nav roblox-interstitial" target="_blank">
                        Help
                    </a>
                </li>
                <li class=" footer-link">
                    <a href="https://www.roblox.com/info/terms?locale=en_us" class="text-footer-nav" target="_blank">
                        Terms
                    </a>
                </li>
                <li class=" footer-link">
                    <a href="https://www.roblox.com/info/privacy?locale=en_us" class="text-footer-nav privacy" target="_blank">
                        Privacy
                    </a>
                </li>
            </ul>
                <div class="row copyright-wrapper">
                    <div class="col-sm-6 col-md-3">
                        <!-- Native Select to Support Mobile -->
                        <div class="rbx-select-group icon-dropdown">
                            <select class="rbx-select language-select" id="language-switcher">
                                        <option value="de_de"
                                                data-is-supported="true"
                                                >
                                            Deutsch
                                        </option>
                                        <option value="en_us"
                                                data-is-supported="true"
                                                selected>
                                            English
                                        </option>
                                        <option value="es_es"
                                                data-is-supported="true"
                                                >
                                            Espa&#241;ol
                                        </option>
                                        <option value="fr_fr"
                                                data-is-supported="true"
                                                >
                                            Fran&#231;ais
                                        </option>
                                        <option value="pt_br"
                                                data-is-supported="true"
                                                >
                                            Portugu&#234;s (Brasil)
                                        </option>
                                        <option value="ko_kr"
                                                data-is-supported="true"
                                                >
                                            ???
                                        </option>
                                        <option value="zh_cn"
                                                data-is-supported="true"
                                                >
                                            ??(??)
                                        </option>
                                        <option value="zh_tw"
                                                data-is-supported="true"
                                                >
                                            ??(??)
                                        </option>
                                        <option value="id_id"
                                                data-is-supported="false"
                                                >
                                            Bahasa Indonesia*
                                        </option>
                                        <option value="ms_my"
                                                data-is-supported="false"
                                                >
                                            bahasa Melayu*
                                        </option>
                                        <option value="nb_no"
                                                data-is-supported="false"
                                                >
                                            bokm&#229;l*
                                        </option>
                                        <option value="cs_cz"
                                                data-is-supported="false"
                                                >
                                            ceština*
                                        </option>
                                        <option value="da_dk"
                                                data-is-supported="false"
                                                >
                                            dansk*
                                        </option>
                                        <option value="et_ee"
                                                data-is-supported="false"
                                                >
                                            eesti*
                                        </option>
                                        <option value="fil_ph"
                                                data-is-supported="false"
                                                >
                                            Filipino*
                                        </option>
                                        <option value="hr_hr"
                                                data-is-supported="false"
                                                >
                                            hrvatski*
                                        </option>
                                        <option value="it_it"
                                                data-is-supported="false"
                                                >
                                            Italiano*
                                        </option>
                                        <option value="lv_lv"
                                                data-is-supported="false"
                                                >
                                            latviešu*
                                        </option>
                                        <option value="lt_lt"
                                                data-is-supported="false"
                                                >
                                            lietuviu*
                                        </option>
                                        <option value="hu_hu"
                                                data-is-supported="false"
                                                >
                                            magyar*
                                        </option>
                                        <option value="nl_nl"
                                                data-is-supported="false"
                                                >
                                            Nederlands*
                                        </option>
                                        <option value="pl_pl"
                                                data-is-supported="false"
                                                >
                                            polski*
                                        </option>
                                        <option value="ro_ro"
                                                data-is-supported="false"
                                                >
                                            rom&#226;na*
                                        </option>
                                        <option value="sq_al"
                                                data-is-supported="false"
                                                >
                                            shqipe*
                                        </option>
                                        <option value="sk_sk"
                                                data-is-supported="false"
                                                >
                                            slovencina*
                                        </option>
                                        <option value="sl_sl"
                                                data-is-supported="false"
                                                >
                                            slovenski*
                                        </option>
                                        <option value="fi_fi"
                                                data-is-supported="false"
                                                >
                                            suomi*
                                        </option>
                                        <option value="sv_se"
                                                data-is-supported="false"
                                                >
                                            svenska*
                                        </option>
                                        <option value="vi_vn"
                                                data-is-supported="false"
                                                >
                                            Ti?ng Vi?t Nam*
                                        </option>
                                        <option value="tr_tr"
                                                data-is-supported="false"
                                                >
                                            T&#252;rk&#231;e*
                                        </option>
                                        <option value="el_gr"
                                                data-is-supported="false"
                                                >
                                            e???????*
                                        </option>
                                        <option value="bs_ba"
                                                data-is-supported="false"
                                                >
                                            ????????*
                                        </option>
                                        <option value="bg_bg"
                                                data-is-supported="false"
                                                >
                                            ?????????*
                                        </option>
                                        <option value="kk_kz"
                                                data-is-supported="false"
                                                >
                                            ????? ????*
                                        </option>
                                        <option value="ru_ru"
                                                data-is-supported="false"
                                                >
                                            ???????*
                                        </option>
                                        <option value="sr_rs"
                                                data-is-supported="false"
                                                >
                                            ??????*
                                        </option>
                                        <option value="uk_ua"
                                                data-is-supported="false"
                                                >
                                            ??????????*
                                        </option>
                                        <option value="ka_ge"
                                                data-is-supported="false"
                                                >
                                            ???????*
                                        </option>
                                        <option value="hi_in"
                                                data-is-supported="false"
                                                >
                                            ??????*
                                        </option>
                                        <option value="bn_bd"
                                                data-is-supported="false"
                                                >
                                            ?????*
                                        </option>
                                        <option value="si_lk"
                                                data-is-supported="false"
                                                >
                                            ?????*
                                        </option>
                                        <option value="th_th"
                                                data-is-supported="false"
                                                >
                                            ???????*
                                        </option>
                                        <option value="my_mm"
                                                data-is-supported="false"
                                                >
                                            ?????*
                                        </option>
                                        <option value="km_kh"
                                                data-is-supported="false"
                                                >
                                            ?????????*
                                        </option>
                                        <option value="ja_jp"
                                                data-is-supported="false"
                                                >
                                            ???*
                                        </option>

                            </select>
                            <span class="icon-arrow icon-down-16x16"></span>
                        </div>

                        <!-- Regular UI for Desktop -->
                        <div class="input-group-btn">
                            <button type="button" class="input-dropdown-btn" data-toggle="dropdown">
                                <span class="icon-globe"></span>
                                <span class="rbx-selection-label" data-bind="label">
English                                </span>
                                <span class="icon-down-16x16"></span>
                            </button>
                            <ul data-toggle="dropdown-menu" class="dropdown-menu" role="menu">
                                        <li>
                                            <a href="#"
                                               class="locale-option"
                                               data-locale="de_de"
                                               data-is-supported="true">
                                                Deutsch
                                            </a>
                                        </li>
                                        <li>
                                            <a href="#"
                                               class="locale-option"
                                               data-locale="en_us"
                                               data-is-supported="true">
                                                English
                                            </a>
                                        </li>
                                        <li>
                                            <a href="#"
                                               class="locale-option"
                                               data-locale="es_es"
                                               data-is-supported="true">
                                                Espa&#241;ol
                                            </a>
                                        </li>
                                        <li>
                                            <a href="#"
                                               class="locale-option"
                                               data-locale="fr_fr"
                                               data-is-supported="true">
                                                Fran&#231;ais
                                            </a>
                                        </li>
                                        <li>
                                            <a href="#"
                                               class="locale-option"
                                               data-locale="pt_br"
                                               data-is-supported="true">
                                                Portugu&#234;s (Brasil)
                                            </a>
                                        </li>
                                        <li>
                                            <a href="#"
                                               class="locale-option"
                                               data-locale="ko_kr"
                                               data-is-supported="true">
                                                ???
                                            </a>
                                        </li>
                                        <li>
                                            <a href="#"
                                               class="locale-option"
                                               data-locale="zh_cn"
                                               data-is-supported="true">
                                                ??(??)
                                            </a>
                                        </li>
                                        <li>
                                            <a href="#"
                                               class="locale-option"
                                               data-locale="zh_tw"
                                               data-is-supported="true">
                                                ??(??)
                                            </a>
                                        </li>
                                        <li>
                                            <a href="#"
                                               class="locale-option"
                                               data-locale="id_id"
                                               data-is-supported="false">
                                                Bahasa Indonesia*
                                            </a>
                                        </li>
                                        <li>
                                            <a href="#"
                                               class="locale-option"
                                               data-locale="ms_my"
                                               data-is-supported="false">
                                                bahasa Melayu*
                                            </a>
                                        </li>
                                        <li>
                                            <a href="#"
                                               class="locale-option"
                                               data-locale="nb_no"
                                               data-is-supported="false">
                                                bokm&#229;l*
                                            </a>
                                        </li>
                                        <li>
                                            <a href="#"
                                               class="locale-option"
                                               data-locale="cs_cz"
                                               data-is-supported="false">
                                                ceština*
                                            </a>
                                        </li>
                                        <li>
                                            <a href="#"
                                               class="locale-option"
                                               data-locale="da_dk"
                                               data-is-supported="false">
                                                dansk*
                                            </a>
                                        </li>
                                        <li>
                                            <a href="#"
                                               class="locale-option"
                                               data-locale="et_ee"
                                               data-is-supported="false">
                                                eesti*
                                            </a>
                                        </li>
                                        <li>
                                            <a href="#"
                                               class="locale-option"
                                               data-locale="fil_ph"
                                               data-is-supported="false">
                                                Filipino*
                                            </a>
                                        </li>
                                        <li>
                                            <a href="#"
                                               class="locale-option"
                                               data-locale="hr_hr"
                                               data-is-supported="false">
                                                hrvatski*
                                            </a>
                                        </li>
                                        <li>
                                            <a href="#"
                                               class="locale-option"
                                               data-locale="it_it"
                                               data-is-supported="false">
                                                Italiano*
                                            </a>
                                        </li>
                                        <li>
                                            <a href="#"
                                               class="locale-option"
                                               data-locale="lv_lv"
                                               data-is-supported="false">
                                                latviešu*
                                            </a>
                                        </li>
                                        <li>
                                            <a href="#"
                                               class="locale-option"
                                               data-locale="lt_lt"
                                               data-is-supported="false">
                                                lietuviu*
                                            </a>
                                        </li>
                                        <li>
                                            <a href="#"
                                               class="locale-option"
                                               data-locale="hu_hu"
                                               data-is-supported="false">
                                                magyar*
                                            </a>
                                        </li>
                                        <li>
                                            <a href="#"
                                               class="locale-option"
                                               data-locale="nl_nl"
                                               data-is-supported="false">
                                                Nederlands*
                                            </a>
                                        </li>
                                        <li>
                                            <a href="#"
                                               class="locale-option"
                                               data-locale="pl_pl"
                                               data-is-supported="false">
                                                polski*
                                            </a>
                                        </li>
                                        <li>
                                            <a href="#"
                                               class="locale-option"
                                               data-locale="ro_ro"
                                               data-is-supported="false">
                                                rom&#226;na*
                                            </a>
                                        </li>
                                        <li>
                                            <a href="#"
                                               class="locale-option"
                                               data-locale="sq_al"
                                               data-is-supported="false">
                                                shqipe*
                                            </a>
                                        </li>
                                        <li>
                                            <a href="#"
                                               class="locale-option"
                                               data-locale="sk_sk"
                                               data-is-supported="false">
                                                slovencina*
                                            </a>
                                        </li>
                                        <li>
                                            <a href="#"
                                               class="locale-option"
                                               data-locale="sl_sl"
                                               data-is-supported="false">
                                                slovenski*
                                            </a>
                                        </li>
                                        <li>
                                            <a href="#"
                                               class="locale-option"
                                               data-locale="fi_fi"
                                               data-is-supported="false">
                                                suomi*
                                            </a>
                                        </li>
                                        <li>
                                            <a href="#"
                                               class="locale-option"
                                               data-locale="sv_se"
                                               data-is-supported="false">
                                                svenska*
                                            </a>
                                        </li>
                                        <li>
                                            <a href="#"
                                               class="locale-option"
                                               data-locale="vi_vn"
                                               data-is-supported="false">
                                                Ti?ng Vi?t Nam*
                                            </a>
                                        </li>
                                        <li>
                                            <a href="#"
                                               class="locale-option"
                                               data-locale="tr_tr"
                                               data-is-supported="false">
                                                T&#252;rk&#231;e*
                                            </a>
                                        </li>
                                        <li>
                                            <a href="#"
                                               class="locale-option"
                                               data-locale="el_gr"
                                               data-is-supported="false">
                                                e???????*
                                            </a>
                                        </li>
                                        <li>
                                            <a href="#"
                                               class="locale-option"
                                               data-locale="bs_ba"
                                               data-is-supported="false">
                                                ????????*
                                            </a>
                                        </li>
                                        <li>
                                            <a href="#"
                                               class="locale-option"
                                               data-locale="bg_bg"
                                               data-is-supported="false">
                                                ?????????*
                                            </a>
                                        </li>
                                        <li>
                                            <a href="#"
                                               class="locale-option"
                                               data-locale="kk_kz"
                                               data-is-supported="false">
                                                ????? ????*
                                            </a>
                                        </li>
                                        <li>
                                            <a href="#"
                                               class="locale-option"
                                               data-locale="ru_ru"
                                               data-is-supported="false">
                                                ???????*
                                            </a>
                                        </li>
                                        <li>
                                            <a href="#"
                                               class="locale-option"
                                               data-locale="sr_rs"
                                               data-is-supported="false">
                                                ??????*
                                            </a>
                                        </li>
                                        <li>
                                            <a href="#"
                                               class="locale-option"
                                               data-locale="uk_ua"
                                               data-is-supported="false">
                                                ??????????*
                                            </a>
                                        </li>
                                        <li>
                                            <a href="#"
                                               class="locale-option"
                                               data-locale="ka_ge"
                                               data-is-supported="false">
                                                ???????*
                                            </a>
                                        </li>
                                        <li>
                                            <a href="#"
                                               class="locale-option"
                                               data-locale="hi_in"
                                               data-is-supported="false">
                                                ??????*
                                            </a>
                                        </li>
                                        <li>
                                            <a href="#"
                                               class="locale-option"
                                               data-locale="bn_bd"
                                               data-is-supported="false">
                                                ?????*
                                            </a>
                                        </li>
                                        <li>
                                            <a href="#"
                                               class="locale-option"
                                               data-locale="si_lk"
                                               data-is-supported="false">
                                                ?????*
                                            </a>
                                        </li>
                                        <li>
                                            <a href="#"
                                               class="locale-option"
                                               data-locale="th_th"
                                               data-is-supported="false">
                                                ???????*
                                            </a>
                                        </li>
                                        <li>
                                            <a href="#"
                                               class="locale-option"
                                               data-locale="my_mm"
                                               data-is-supported="false">
                                                ?????*
                                            </a>
                                        </li>
                                        <li>
                                            <a href="#"
                                               class="locale-option"
                                               data-locale="km_kh"
                                               data-is-supported="false">
                                                ?????????*
                                            </a>
                                        </li>
                                        <li>
                                            <a href="#"
                                               class="locale-option"
                                               data-locale="ja_jp"
                                               data-is-supported="false">
                                                ???*
                                            </a>
                                        </li>


                            </ul>
                        </div>
                    </div>
                    <div class="col-sm-6 col-md-9">
                        <!-- NOTE: "Roblox Corporation" is a healthcheck; be careful when updating! -->
                        <p class="text-footer footer-note">
                            &#169;2019 Roblox Corporation. Roblox, the Roblox logo and Powering Imagination are among our registered and unregistered trademarks in the U.S. and other countries.
                        </p>
                    </div>
                </div>
        </div>
    </footer>



 

<img src="/timg/rbx" style="position: absolute"/>


<script type="application/ld+json">
    {
    "@context" : "http://schema.org",
    "@type" : "Organization",
    "name" : "Roblox",
    "url" : "https://www.roblox.com/",
    "logo": "https://images.rbxcdn.com/c69b74f49e785df33b732273fad9dbe0.png",
    "sameAs" : [
    "https://www.facebook.com/ROBLOX/",
    "https://twitter.com/roblox",
    "https://www.linkedin.com/company/147977",
    "https://www.instagram.com/roblox/",
    "https://www.youtube.com/user/roblox",
    "https://plus.google.com/+roblox",
    "https://www.twitch.tv/roblox"
    ]
    }
</script>



    
<script onerror='Roblox.BundleDetector && Roblox.BundleDetector.reportBundleError(this)' data-monitor='true' data-bundlename='intl-polyfill' type='text/javascript' src='https://js.rbxcdn.com/d44520f7da5ec476cfb1704d91bab327.js'></script>
<script onerror='Roblox.BundleDetector && Roblox.BundleDetector.reportBundleError(this)' data-monitor='true' data-bundlename='InternationalCore' type='text/javascript' src='https://js.rbxcdn.com/b7765265afdb7c76d94552b635c3d3b9003e39e810227f3d25432466a817b0f1.js'></script>

<script onerror='Roblox.BundleDetector && Roblox.BundleDetector.reportBundleError(this)' data-monitor='true' data-bundlename='TranslationResources' type='text/javascript' src='https://js.rbxcdn.com/79cebbe6c213cf1e125bca7c80e12e034a5a99e0e580174e652d1b030e9b2c08.js'></script>


    <script onerror='Roblox.BundleDetector && Roblox.BundleDetector.reportBundleError(this)' data-monitor='true' data-bundlename='leanbase' type='text/javascript' src='https://js.rbxcdn.com/b633ae58598a91ee67648c10e82c4cf3.js'></script>


    
    <script onerror='Roblox.BundleDetector && Roblox.BundleDetector.reportBundleError(this)' data-monitor='true' data-bundlename='angular' type='text/javascript' src='https://js.rbxcdn.com/d2ebf030e9277bd03b7893b9be1f767a.js'></script>

    <div ng-modules="baseTemplateApp">
        <script type="text/javascript" src="https://js.rbxcdn.com/5a2d7b762bad6ebbee9153f472c60659.js"></script>
    </div>

    <div ng-modules="pageTemplateApp">
        <script type="text/javascript" src="https://js.rbxcdn.com/3e544c8e724dcdc296258b0ca69401a9.js"></script>
    </div>

    

    
    <script type='text/javascript'>Roblox.config.externalResources = [];Roblox.config.paths['Pages.Catalog'] = 'https://js.rbxcdn.com/cafca5e807a6864149a01d3e510763d3.js';Roblox.config.paths['Pages.CatalogShared'] = 'https://js.rbxcdn.com/e0610c5d06c6d6a98d4bef38711e7cdb.js';Roblox.config.paths['Widgets.AvatarImage'] = 'https://js.rbxcdn.com/7d49ac94271bd506077acc9d0130eebb.js';Roblox.config.paths['Widgets.DropdownMenu'] = 'https://js.rbxcdn.com/da553e6b77b3d79bec37441b5fb317e7.js';Roblox.config.paths['Widgets.GroupImage'] = 'https://js.rbxcdn.com/8ad41e45c4ac81f7d8c44ec542a2da0a.js';Roblox.config.paths['Widgets.HierarchicalDropdown'] = 'https://js.rbxcdn.com/4a0af9989732810851e9e12809aeb8ad.js';Roblox.config.paths['Widgets.ItemImage'] = 'https://js.rbxcdn.com/61a0490ba23afa17f9ecca2a079a6a57.js';Roblox.config.paths['Widgets.PlaceImage'] = 'https://js.rbxcdn.com/a6df74a754523e097cab747621643c98.js';</script>

    
    <script>
        Roblox.XsrfToken.setToken('c/DHyzfzavM7');
    </script>

        <script>
            $(function () {
                Roblox.DeveloperConsoleWarning.showWarning();
            });
        </script>
        <script type="text/javascript">
        $(function () {
            Roblox.JSErrorTracker.initialize({ 'suppressConsoleError': true});
        });
    </script>


<script type="text/javascript">
    $(function(){
        function trackReturns() {
            function dayDiff(d1, d2) {
                return Math.floor((d1-d2)/86400000);
            }
            if (!localStorage) {
                return false;
            }

            var cookieName = 'RBXReturn';
            var cookieOptions = {expires:9001};
            var cookieStr = localStorage.getItem(cookieName) || "";
            var cookie = {};

            try {
                cookie = JSON.parse(cookieStr);
            } catch (ex) {
                // busted cookie string from old previous version of the code
            }

            try {
                if (typeof cookie.ts === "undefined" || isNaN(new Date(cookie.ts))) {
                    localStorage.setItem(cookieName, JSON.stringify({ ts: new Date().toDateString() }));
                    return false;
                }
            } catch (ex) {
                return false;
            }

            var daysSinceFirstVisit = dayDiff(new Date(), new Date(cookie.ts));
            if (daysSinceFirstVisit == 1 && typeof cookie.odr === "undefined") {
                RobloxEventManager.triggerEvent('rbx_evt_odr', {});
                cookie.odr = 1;
            }
            if (daysSinceFirstVisit >= 1 && daysSinceFirstVisit <= 7 && typeof cookie.sdr === "undefined") {
                RobloxEventManager.triggerEvent('rbx_evt_sdr', {});
                cookie.sdr = 1;
            }
            try {
                localStorage.setItem(cookieName, JSON.stringify(cookie));
            } catch (ex) {
                return false;
            }
        }

        GoogleListener.init();


    
        RobloxEventManager.initialize(true);
        RobloxEventManager.triggerEvent('rbx_evt_pageview');
        trackReturns();
        

    
        RobloxEventManager._idleInterval = 450000;
        RobloxEventManager.registerCookieStoreEvent('rbx_evt_initial_install_start');
        RobloxEventManager.registerCookieStoreEvent('rbx_evt_ftp');
        RobloxEventManager.registerCookieStoreEvent('rbx_evt_initial_install_success');
        RobloxEventManager.registerCookieStoreEvent('rbx_evt_fmp');
        RobloxEventManager.startMonitor();
        

    });

</script>


    
    

<script type="text/javascript">
    var Roblox = Roblox || {};
    Roblox.UpsellAdModal = Roblox.UpsellAdModal || {};

    Roblox.UpsellAdModal.Resources = {
        //<sl:translate>
        title: "Remove Ads Like This",
        body: "Builders Club members do not see external ads like these.",
        accept: "Upgrade Now",
        decline: "No, thanks"
        //</sl:translate>
    };
</script>

    
    <script onerror='Roblox.BundleDetector && Roblox.BundleDetector.reportBundleError(this)' data-monitor='true' data-bundlename='page' type='text/javascript' src='https://js.rbxcdn.com/a5160517444fe1693d4ea8133da402b9.js'></script>


<script onerror='Roblox.BundleDetector && Roblox.BundleDetector.reportBundleError(this)'   type='text/javascript' src='https://authsite.roblox.com/landing/266e3fa9-fbe0-44c7-b8d4-27fe06a4a556/get-html-bundle'></script>
<script onerror='Roblox.BundleDetector && Roblox.BundleDetector.reportBundleError(this)'   type='text/javascript' src='https://authsite.roblox.com/landing/266e3fa9-fbe0-44c7-b8d4-27fe06a4a556/get-javascript-bundle'></script>
<script onerror='Roblox.BundleDetector && Roblox.BundleDetector.reportBundleError(this)'   type='text/javascript' src='https://authsite.roblox.com/landing/266e3fa9-fbe0-44c7-b8d4-27fe06a4a556/en_us/get-language-resources-bundle'></script>

    <script onerror='Roblox.BundleDetector && Roblox.BundleDetector.reportBundleError(this)' data-monitor='true' data-bundlename='StyleGuide' type='text/javascript' src='https://js.rbxcdn.com/6cb1233c96a5fe784f04e532fa9daa8f57f799d687ebeefe4b1fc83100eaa4f2.js'></script>



<script onerror='Roblox.BundleDetector && Roblox.BundleDetector.reportBundleError(this)' data-monitor='true' data-bundlename='Captcha' type='text/javascript' src='https://js.rbxcdn.com/51ad6cf0e375c1d0c0e379793d72171f6c9ab7bff5d93e278fe44a0dd491a82a.js'></script>





    
        <script>
        var _comscore = _comscore || [];
        _comscore.push({ c1: "2", c2: "6035605", c3: "", c4: "", c15: "" });

        (function() {
            var s = document.createElement("script"), el = document.getElementsByTagName("script")[0];
            s.async = true;
            s.src = (document.location.protocol == "https:" ? "https://sb" : "http://b") + ".scorecardresearch.com/beacon.js";
            el.parentNode.insertBefore(s, el);
        })();
    </script>
    <noscript>
        <img src="http://b.scorecardresearch.com/p?c1=2&c2=&c3=&c4=&c5=&c6=&c15=&cv=2.0&cj=1"/>
    </noscript>
        
    


    
</body>
</html>