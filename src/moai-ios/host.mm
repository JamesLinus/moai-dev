// Copyright (c) 2010-2011 Zipline Games, Inc. All Rights Reserved.
// http://getmoai.com

#import "pch.h"
#import "host.h"
#import "headers.h"

//================================================================//
// aku-util
//================================================================//

//----------------------------------------------------------------//
void AKUIosAppFinalize () {
}

//----------------------------------------------------------------//
void AKUIosAppInitialize () {

	loadMoaiLib_NSArray ();
	loadMoaiLib_NSData ();
	loadMoaiLib_NSDate ();
	loadMoaiLib_NSDictionary ();
	loadMoaiLib_NSError ();
	loadMoaiLib_NSNumber ();
	loadMoaiLib_NSObject ();
	loadMoaiLib_NSString ();
}

//----------------------------------------------------------------//
void AKUIosContextInitialize () {

	MOAIAppIOS::Affirm ();
			
	// MOAI
	REGISTER_LUA_CLASS ( MOAIAppIOS )
	REGISTER_LUA_CLASS ( MOAIDialogIOS )
	REGISTER_LUA_CLASS ( MOAIKeyboardIOS )
	REGISTER_LUA_CLASS ( MOAIBrowserIOS )
	REGISTER_LUA_CLASS ( MOAIWebViewIOS )
	REGISTER_LUA_CLASS ( MOAINotificationsIOS )

	// Device properties
	MOAIEnvironment& environment = MOAIEnvironment::Get ();
	
	environment.SetValue ( MOAI_ENV_appDisplayName,		[[[[ NSBundle mainBundle ] infoDictionary ] objectForKey:@"CFBundleDisplayName" ] UTF8String ]);
	environment.SetValue ( MOAI_ENV_appID,				[[[[ NSBundle mainBundle ] infoDictionary ] objectForKey:@"CFBundleIdentifier" ] UTF8String ]);
	environment.SetValue ( MOAI_ENV_appVersion,			[[[[ NSBundle mainBundle ] infoDictionary ] objectForKey:@"CFBundleShortVersionString" ] UTF8String ]);
	environment.SetValue ( MOAI_ENV_cacheDirectory,		[[ NSSearchPathForDirectoriesInDomains ( NSCachesDirectory, NSUserDomainMask, YES ) objectAtIndex:0 ] UTF8String ]);
	environment.SetValue ( MOAI_ENV_countryCode,		[[[ NSLocale currentLocale ] objectForKey: NSLocaleCountryCode ] UTF8String ]);
	environment.SetValue ( MOAI_ENV_devModel,			[[ UIDevice currentDevice ].model UTF8String ] );

	//environment.SetValue ( MOAI_ENV_devPlatform,		[[ UIDevice currentDevice ].platform UTF8String ]);
	environment.SetValue ( MOAI_ENV_documentDirectory,	[[ NSSearchPathForDirectoriesInDomains ( NSDocumentDirectory, NSUserDomainMask, YES ) objectAtIndex:0 ] UTF8String ]);
	environment.SetValue ( MOAI_ENV_iosRetinaDisplay,	[[ UIScreen mainScreen ] scale ] == 2.0 );

	environment.SetValue ( MOAI_ENV_documentDirectory,	[[ NSSearchPathForDirectoriesInDomains ( NSDocumentDirectory, NSUserDomainMask, YES ) objectAtIndex:0 ] UTF8String ]);
	environment.SetValue ( MOAI_ENV_iosRetinaDisplay,	[[ UIScreen mainScreen ] scale ] == 2.0 );	
	environment.SetValue ( MOAI_ENV_languageCode,		[[[ NSLocale currentLocale ] objectForKey: NSLocaleLanguageCode ] UTF8String ]);
	environment.SetValue ( MOAI_ENV_osBrand,			"iOS" );
	environment.SetValue ( MOAI_ENV_osVersion,			[[ UIDevice currentDevice ].systemVersion UTF8String ]);
	environment.SetValue ( MOAI_ENV_resourceDirectory,	[[[ NSBundle mainBundle ] resourcePath ] UTF8String ]);
	//environment.SetValue ( MOAI_ENV_openUdid,			[[ MOAIOpenUDID value] UTF8String ]);
	environment.SetValue ( MOAI_ENV_horizontalResolution, [[ UIScreen mainScreen ] bounds ].size.width * [[ UIScreen mainScreen ] scale ] );  
	environment.SetValue ( MOAI_ENV_verticalResolution, [[ UIScreen mainScreen ] bounds ].size.height * [[ UIScreen mainScreen ] scale ] );
	
	[ ReachabilityListener updateMoaiEnvironment ];
}

//----------------------------------------------------------------//
void AKUIosDidStartSession ( bool resumed ) {
	MOAIAppIOS::Get ().DidStartSession ( resumed );
}

//----------------------------------------------------------------//
void AKUIosNotifyLocalNotificationReceived ( UILocalNotification* notification ) {

	MOAINotificationsIOS::Get ().NotifyLocalNotificationReceived ( notification );
}

//----------------------------------------------------------------//
void AKUIosNotifyRemoteNotificationReceived ( NSDictionary* notification ) {

	MOAINotificationsIOS::Get ().NotifyRemoteNotificationReceived ( notification );
}

//----------------------------------------------------------------//
void AKUIosNotifyRemoteNotificationRegistrationComplete ( NSData* deviceToken ) {

	MOAINotificationsIOS::Get ().NotifyRemoteRegistrationComplete ( deviceToken );
}

//----------------------------------------------------------------//
void AKUIosOpenedFromURL ( NSURL* url ) {

	MOAIAppIOS::Get ().AppOpenedFromURL ( url );
}

//----------------------------------------------------------------//
void AKUIosSetFrameBuffer ( GLuint frameBuffer ) {

	MOAIGfxDevice::Get ().GetDefaultBuffer ()->SetGLFrameBufferID ( frameBuffer );
}

//----------------------------------------------------------------//
void AKUIosWillEndSession () {

	MOAIAppIOS::Get ().WillEndSession ();
}





