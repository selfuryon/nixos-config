/* override recipe: enable session restore ***/
user_pref("browser.startup.page", 3); // 0102
user_pref("browser.sessionstore.privacy_level", 0); // 1003 [to restore cookies/formdata if not sanitized]
user_pref("privacy.clearOnShutdown.history", false); // 2811
user_pref("privacy.cpd.history", false); // 2812 to match when you use Ctrl-Shift-Del

/* override: enable ipv6 ***/
user_pref("network.dns.disableIPv6", false);

/* override: disable letterboxing ***/
user_pref("privacy.resistFingerprinting.letterboxing", false); // [HIDDEN PREF]
