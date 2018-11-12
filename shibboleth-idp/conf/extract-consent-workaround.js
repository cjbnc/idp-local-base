// Create a logger and log message prefix.
var logger = Java.type("org.slf4j.LoggerFactory").getLogger("net.shibboleth.idp.script");
var logPrefix = "ExtractConsentWorkaround :";

// Get the consent context from the profile request context.
var consentContext = profileContext.getSubcontext("net.shibboleth.idp.consent.context.ConsentContext")
logger.debug("{} consent context '{}'", logPrefix, consentContext);

if (consentContext != null) {
    // Get the Map<String,Consent> of consent objects obtained from the user.
    var currentConsents = consentContext.getCurrentConsents();
    logger.debug("{} current consents '{}'", logPrefix, currentConsents);

    // For each consent object representing an attribute ...
    for each (var consent in currentConsents.values()) {
        if (!consent.isApproved()) {
            // ... if consent is not approved, then approve and log.
            logger.info("{} approving attribute '{}'", logPrefix, consent.getId());
            consent.setApproved(true);
        } else {
            // ... if consent is approved, great, just log.
            logger.debug("{} attribute '{}' is approved", logPrefix, consent.getId());
        }
    }
}

