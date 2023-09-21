<?php
// Replace this section with your database query and setting user info
// For the purpose of the example, I'm manually setting some variables

include($_SERVER['DOCUMENT_ROOT'] . '/game/ProdRBX/Configuration.php');
include($_SERVER['DOCUMENT_ROOT'] . '/UserInfo.php');
include($_SERVER['DOCUMENT_ROOT'] . '/FuncTypes.php');


// Calculate "isAdmin" based on the value of $admin (1 for true, 0 for false)
$is_admin = ($admin === 1);

// Calculate "isBC" based on the value of $membership (1 for BC, 2 for TBC, 3 for OBC)
$isBC = ($membership === 1 || $membership === 2 || $membership === 3);

if ($RBXTICKET === null) {
    // Return a JSON-encoded message for "Sorry"
    $jsonData = json_encode(array("message" => "Sorry"));
} else {
$jsonData = '{
    "ChangeUsernameEnabled": true,
    "IsAdmin": ' . ($is_admin ? 'true' : 'false') . ',
    "UserId": '.$id.',
    "Name": "'.$name.'",
    "DisplayName": "'.$name.'",
    "IsEmailOnFile": true,
    "IsEmailVerified": true,
    "IsPhoneFeatureEnabled": true,
    "RobuxRemainingForUsernameChange": 0,
    "PreviousUserNames": "",
    "UseSuperSafePrivacyMode": false,
    "IsSuperSafeModeEnabledForPrivacySetting": false,
    "UseSuperSafeChat": false,
    "IsAppChatSettingEnabled": true,
    "IsGameChatSettingEnabled": true,
    "IsAccountPrivacySettingsV2Enabled": true,
    "IsSetPasswordNotificationEnabled": false,
    "ChangePasswordRequiresTwoStepVerification": false,
    "ChangeEmailRequiresTwoStepVerification": false,
    "UserEmail": "d****@dummy.com",
    "UserEmailMasked": true,
    "UserEmailVerified": true,
    "CanHideInventory": true,
    "CanTrade": false,
    "MissingParentEmail": false,
    "IsUpdateEmailSectionShown": true,
    "IsUnder13UpdateEmailMessageSectionShown": false,
    "IsUserConnectedToFacebook": false,
    "IsTwoStepToggleEnabled": false,
    "AgeBracket": 0,
    "UserAbove13": true,
    "ClientIpAddress": "123.123.123.123",
    "AccountAgeInDays": 0,
    "IsOBC": ' . ($membership === 3 ? 'true' : 'false') . ',
    "IsTBC": ' . ($membership === 2 ? 'true' : 'false') . ',
    "IsAnyBC": ' . ($isBC ? 'true' : 'false') . ',
    "IsPremium": false,
    "IsBcRenewalMembership": ' . ($isBC ? 'true' : 'false') . ',
    "BcExpireDate": "\/Date(-0)\/",
    "BcRenewalPeriod": null,
    "BcLevel": null,
    "HasCurrencyOperationError": false,
    "CurrencyOperationErrorMessage": null,
    "BlockedUsersModel": {
        "BlockedUserIds": [156],
        "BlockedUsers": [{
            "uid": 156,
            "Name": "builderman"
        }],
        "MaxBlockedUsers": 50,
        "Total": 1,
        "Page": 1
    },
    "Tab": null,
    "ChangePassword": false,
    "IsAccountPinEnabled": true,
    "IsAccountRestrictionsFeatureEnabled": true,
    "IsAccountRestrictionsSettingEnabled": false,
    "IsAccountSettingsSocialNetworksV2Enabled": false,
    "IsUiBootstrapModalV2Enabled": true,
    "IsI18nBirthdayPickerInAccountSettingsEnabled": true,
    "InApp": false,
    "MyAccountSecurityModel": {
        "IsEmailSet": true,
        "IsEmailVerified": true,
        "IsTwoStepEnabled": true,
        "ShowSignOutFromAllSessions": true,
        "TwoStepVerificationViewModel": {
            "UserId": 261,
            "IsEnabled": true,
            "CodeLength": 0,
            "ValidCodeCharacters": null
        }
    },
    "ApiProxyDomain": "https://api.roblox.com",
    "AccountSettingsApiDomain": "https://accountsettings.roblox.com",
    "AuthDomain": "https://auth.roblox.com",
    "IsDisconnectFbSocialSignOnEnabled": true,
    "IsDisconnectXboxEnabled": true,
    "NotificationSettingsDomain": "https://notifications.roblox.com",
    "AllowedNotificationSourceTypes": ["Test", "FriendRequestReceived", "FriendRequestAccepted", "PartyInviteReceived", "PartyMemberJoined", "ChatNewMessage", "PrivateMessageReceived", "UserAddedToPrivateServerWhiteList", "ConversationUniverseChanged", "TeamCreateInvite", "GameUpdate", "DeveloperMetricsAvailable"],
    "AllowedReceiverDestinationTypes": ["DesktopPush", "NotificationStream"],
    "BlacklistedNotificationSourceTypesForMobilePush": [],
    "MinimumChromeVersionForPushNotifications": 50,
    "PushNotificationsEnabledOnFirefox": true,
    "LocaleApiDomain": "https://locale.roblox.com",
    "HasValidPasswordSet": true,
    "IsUpdateEmailApiEndpointEnabled": true,
    "FastTrackMember": null,
    "IsFastTrackAccessible": false,
    "HasFreeNameChange": false,
    "IsAgeDownEnabled": ' . ($isBC ? 'true' : 'false') . ',
    "IsSendVerifyEmailApiEndpointEnabled": true,
    "IsPromotionChannelsEndpointEnabled": true,
    "ReceiveNewsletter": false,
    "SocialNetworksVisibilityPrivacy": 6,
    "SocialNetworksVisibilityPrivacyValue": "AllUsers",
    "Facebook": null,
    "Twitter": "@Shedletsky",
    "YouTube": null,
    "Twitch": null
}';
}

// Display the updated JSON data
echo $jsonData;
?>
