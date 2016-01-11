# 


[![CocoaPods](https://img.shields.io/cocoapods/p/FayeCpp.svg?style=flat)](https://cocoapods.org/pods/FayeCpp)
[![CocoaPods](https://img.shields.io/cocoapods/v/FayeCpp.svg?style=flat)](https://cocoapods.org/pods/FayeCpp)

**FayeCpp** (C++) lightweight, cross-platform client library for desktop & mobile platforms, such as **Mac**, **Windows**, **Linux**, **iOS**, **Android**. 

Library created with "Pure C++" (features provided by Standard C++), without heavy **STL** and **C++11** features. For Mac and iOS there is also **Objective-C** client wrapper.


# Installation
--------------


### Getting the sources
```sh
git clone https://github.com/OlehKulykov/FayeCpp.git
cd FayeCpp
git submodule init
git submodule update
```
Or with few commands
```sh
git clone https://github.com/OlehKulykov/FayeCpp.git
cd FayeCpp
git submodule update --init --recursive
```

### Dependencies
 * [Libwebsockets] - "lightweight pure C library built to use minimal CPU and memory resources", or use **FayeCpp** with [Qt SDK][1] (see below).
 * [Jansson] - "C library for encoding, decoding and manipulating JSON data".


### Installation with [CocoaPods]
It's recommended to use client with latest [OpenSSL] library, cause of sequrity reasons. Plus to all, on mobile platforms connection is more stable via mobile network.
#### Podfile with [OpenSSL] support
```ruby
pod 'FayeCpp+OpenSSL', :inhibit_warnings => true
```
#### Podfile
```ruby
pod 'FayeCpp', :inhibit_warnings => true
```


### Patch
For Android build with [Libwebsockets] you need to apply patch:
```sh
cd libwebsockets
git apply < ../libwebsockets_h.patch
```


# Building
----------

> Use (install or update) latest [CMake] build system, need version 2.8 or later.
> Since version 0.1.11 static version of the library was added(read bellow section: Static linking).

### Build on Unix like platforms

```sh
cd FayeCpp
mkdir build
cd build
cmake -DCMAKE_BUILD_TYPE=Release ..
make
```

> During configuration phase, [Libwebsockets] and [Jansson] will be also configured, so, you can add cmake flags for this libs. Something like:
> ```sh
> cmake -DCMAKE_BUILD_TYPE=Release \
-DCMAKE_INSTALL_PREFIX:PATH=/usr \
-DJANSSON_BUILD_DOCS:BOOL=OFF \
-DLWS_WITHOUT_DEBUG:BOOL=ON ..
> ```
> For more options read [Libwebsockets], [Jansson] and [CMake] documentation.


### Build on Windows with Microsoft Visual Studio
 * Execute **Start** -> **Microsoft Visual Studio ....** -> **Visual Studio Tools** -> **... Tools Command Prompt** with administrative permissions (Context menu: **Run as administrator** ).
 * Do the same as on **Build on Unix like platforms**, with small changes, tell [CMake] **generate makefiles** and use **nmake** or generate **Microsoft Visual Studio** solution and projects and build them.

Build with **nmake**:
```sh
cmake -G"NMake Makefiles" -DCMAKE_BUILD_TYPE=Release ..
nmake
```
How to generate **Microsoft Visual Studio** solution (please replace version to yours if needed):
```sh
cmake -G"Visual Studio 11" -DCMAKE_BUILD_TYPE=Release ..
```
Example configuring **without** [OpenSSL] support for **Microsoft Visual Studio**:
> ```sh
> cmake -DCMAKE_INSTALL_PREFIX:PATH=c:\dev\FayeCpp\win-install \
-DLWS_WITH_SSL:BOOL=OFF \
-DLWS_SSL_CLIENT_USE_OS_CA_CERTS:BOOL=OFF \
-DLWS_USE_CYASSL:BOOL=OFF \
-DLWS_WITHOUT_SERVER:BOOL=ON \
-DLWS_WITHOUT_DAEMONIZE:BOOL=ON \
-DCMAKE_BUILD_TYPE=Release \
-G"Visual Studio 11" ..
> ```

* Or another option: especially for this case was added continuous integration for **Microsoft Windows** via [AppVeyor] service, so you could look to the **appveyor.yml** file, located a the root of the repository, and find out how to configure and build with minimun actions.


## Build on Windows with [MinGW]
If you are using FayeCpp with [Libwebsockets] support, you should generate **MinGW Makefile**, and ignore [Libwebsockets] shared library during configuration. Because, since Windows Vista, you will get linker error: ```undefined reference to 'inet_ntop'``` and building will be interrupted. So, for linking all together and workaround this issue there is an additional C source file: ```builds/windows-mingw/inet_ntop.c``` which compiles only in case of using [MinGW] compiler.

Successfully tested with **latest stable** [Mingw-builds project - native toolchains using trunk][3]:
```
MinGW64 version: 3.4
MinGW32 version: 3.11
The C compiler identification is GNU 4.9.2
The CXX compiler identification is GNU 4.9.2
```


### Build for Android with [Android NDK][2]
 * Apply patch, described above.
 * Download and install [Android NDK][2].
 * Navigate to installed [Android NDK][2] folder.
 * Execute **ndk-build** script with project path parameter:

```sh
cd <path_to_Android_NDK>
./ndk-build NDK_PROJECT_PATH=<path_to_FayeCpp>/builds/android
```

> Replace ```<path_to_Android_NDK>``` and ```<path_to_FayeCpp>``` with actual paths.


### Build iOS framework
For creating iOS framework was created script ```build_ios_framework.sh``` located in folder ```builds/ios/```.
So when you in root directory just execute next commands:
```sh
cd builds/ios/
./build_ios_framework.sh
```
So after finishing you will get ```FayeCpp.framework``` framework in folder ```builds/ios/``` which includes ```i386```, ```x86_64```, ```armv7```, ```armv7s``` and ```arm64``` architectures.


### Build iOS framework with sequre connection via [OpenSSL]
For building iOS framework with [OpenSSL] navigate to folder ```builds/ios-with-openssl/``` and do the same as described above.


# Static linking

If you want to use static version of the library generated with [CMake], you should add flag **FAYECPP_STATIC** to the compiller flags and link with other dependencies.


# Integration
-------------


### Integration with [Qt SDK][1] version 5.3 and up
> For older versions look at **Build on Unix like platforms** section

Started from [Qt SDK][1] version 5.3 [QtWebSockets] module and [QWebSocket] class was added. So, FayeCpp will use them ignoring [Libwebsockets] (library and licence).

As usual, you have Qt project file with extension ```*.pro```, so include ```fayecpp.pri``` to your project:
```sh
include(<path_to_FayeCpp>/fayecpp.pri)
```
> Of cource replace ```<path_to_FayeCpp>``` with actual path relatively to ```*.pro``` file location.


### Integrating with Xcode iOS project
For easy integration there is Xcode static iOS library project ```fayecpp.xcodeproj``` located in ```builds/ios/``` folder, full path is: ```builds/ios/fayecpp.xcodeproj```. So integration is the same as any other third party static library.
 * On you **main project** use context menu ```Add Files to"<main project>"...```, locate ```fayecpp.xcodeproj``` and add. Or drag ```fayecpp.xcodeproj``` to your **main project**.
 * On **main project** target locate ```Build Phases``` and expand ```Link Binary With Libraries``` group.
 * Click **plus button**, locate & select ```libfayecpp.a``` and press **Add**.
 * On the project/taget ```Build Settings``` locate ```Search Paths``` group.
 * Change option ```Always Search User Paths``` to **YES**.
 * Add to ```Header Search Paths```  folder where main header ```fayecpp.h``` located (root of the repository).

> Now you can include FayeCpp header as ```#include <fayecpp.h>```.
> When you including FayeCpp header to Objective-C code - don't forget change file extension from ```*.m``` to ```*.mm```.


### Using with Objective-C code
For **Mac** & **iOS** there is **Objective-C client wrapper** located in the folder ```contrib/objc/```. Just add ```FayeCppClient.h```, ```FayeCppClient.mm``` files to your project and use. This wrapper should be used **with** Automatic Reference Counting (ARC). 
Or use [CocoaPods].


# Working with the library in C++
--------------------------

### Include library
```cpp
// Add FayeCpp library to search headers folders.
// Include library header.
#include <fayecpp.h>

using namespace FayeCpp;
```


### Client delegate
```cpp
class FayeDelegate : public FayeCpp::Delegate
{
public:
    // override all FayeCpp::Delegate methods.
    virtual void onFayeTransportConnected(FayeCpp::Client * client)
	{
        // ....
	}
	
	virtual void onFayeClientReceivedMessageFromChannel(FayeCpp::Client * client, 
														const FayeCpp::REVariantMap & message, 
														const FayeCpp::REString & channel)
	{
	    
        // Print channel which received message
		RELog::log("Received message from channel: \"%s\"", channel.UTF8String());
		
		// Iterate all message (VariantMap) pairs
		REVariantMap::Iterator iterator = message.iterator();
		while (iterator.next()) 
		{
			iterator.key();   // get key
			iterator.value();   // get value for key
		}
		
		// .....
	}
	
    // overide other methods
	
    FayeDelegate() 
    {
        // .....
    }
    
	virtual ~FayeDelegate() 
	{
        // ......
	}
};
```


### Faye client 
```cpp
// define somewhere variable or field for client
FayeCpp::Client * _client = NULL;

// create & initialize client
_client = new FayeCpp::Client();
_client->setUrl("ws://your_faye_host:80/faye");
_client->setDelegate(_delegatePointerHere);
_client->connect();

// subscribing or adding channels to pending subscriptions
// From "The Bayeux Protocol Specification v1.0" section "Channels"
// http://docs.cometd.org/reference/bayeux_protocol_elements.html.
// The channel name consists of an initial "/" followed by an optional sequence of path segments separated by a single slash "/" character. Within a path segment, the character "/" is reserved. 
_client->subscribeToChannel("/faye_channel_1");
_client->subscribeToChannel("/something/faye_channel_2");
```

### Message objects

```cpp
// Variant object can hold basic types + list and maps
REVariant value;   // create null value, value.type() is REVariant::TypeNone;
value = REVariant();   // set null value, value.type() is REVariant::TypeNone;
value = "C string value";   // set C (const char *) string value, value.type() is REVariant::TypeString;
value = L"Строка";   // set wide (const wchar_t *) string value, value.type() is REVariant::TypeString;
value = 5;   // set integer value, value.type() is REVariant::TypeInteger;
value = 3.14f;   // set float value, value.type() is REVariant::TypeReal;
value = 3.14159265359;   // set double value, value.type() is REVariant::TypeReal;
value = true;   // set boolean value with true, value.type() is REVariant::TypeBool;
value = false;   // set boolean value with false, value.type() is REVariant::TypeBool;

// Map object (hash or dictionary), stores values by string keys
REVariantMap message;   // or FayeCpp::REVariantMap message; if namespace not used.
message["text"] = "Hello world";   // set C (const char *) string value
message[L"wide characters key"] = L"Hello world !!!";   // set wide (const wchar_t *) string value with wide string key.
message[L"Сообщение"] = L"Привет мир !!!";   // set wide (const wchar_t *) string value with wide string key.
message["integer key"] = 1;   // set integer value
message["float key"] = 3.14f;   // set float value
message["double key"] = 3.14159265359;   // set double value
message["is_use_something_1"] = true;   // set boolean value with true
message["is_use_something_2"] = false;   // set boolean value with false
message["null key"] = REVariant();   // set null value

value = message;   // set map value, value.type() is REVariant::TypeMap;

// List object
REVariantList parameters;   // or FayeCpp::REVariantList if namespace not used.
parameters += "Text value";   // add C (const char *) string value, or use 'parameters.add()' method.
parameters += L"Текстовое значение";   // add wide (const wchar_t *) string value with wide string key, or use 'parameters.add()' method.
parameters += 2;   // add integer value, or use 'parameters.add()' method.
parameters += 3.14f;   // add float value, or use 'parameters.add()' method.
parameters += 3.14159265359;   // add double value, or use 'parameters.add()' method.
parameters += true;   // add boolean value with true, or use 'parameters.add()' method.
parameters += false;   // add boolean value with false, or use 'parameters.add()' method.
parameters += REVariant();   // add null value, or use 'parameters.add()' method.

value = parameters;   // set list value, value.type() is REVariant::TypeList;

message["parameters"] = parameters;   // set list value for key
```


### Send message
```cpp
// Create dummy message
REVariantMap message;
message["text"] = "Hello world";
message[L"wide charectes key"] = L"Hello world !!!";
message["integer key"] = 1;
message["float key"] = 3.14f;
message["double key"] = 3.14159265359;

// Send message object to server with channel name
_client->sendMessageToChannel(message, "/faye_channel_1");
```

# Working with the library in Objective-C
--------------------------

### Include library and create client instance

```objective-c
// include Objective-C client wrapper
#import "FayeCppClient.h" 

// define strong property for the client
@property (nonatomic, strong) FayeCppClient * client;

// create client and strongly hold with property
self.client = [[FayeCppClient alloc] init];
```

### Client delegate

```objective-c
#pragma mark - FayeCpp client delegate
- (void) onFayeClientConnected:(FayeCppClient *) client
{
	NSLog(@"On faye client connected");
}

- (void) onFayeClient:(FayeCppClient *) client
	  receivedMessage:(NSDictionary *) message
		  fromChannel:(NSString *) channel
{
	NSLog(@"On faye client received message: \n%@ \nfrom channel: %@", message, channel);
}
// implement other delegate messages if needed ...
```

### Setup and connect

```objective-c
// set client delegate, all delegate methods are optional and called from main thread
[_client setDelegate:self];

// set faye url string
[_client setUrlString:@"ws://your_faye_host:80/faye"];

// connect and add channels to channels to pending subscriptions
[_client connect];
[_client subscribeToChannel:@"/faye_channel_1"];
[_client subscribeToChannel:@"/something/faye_channel_2"];
```

### Send message

```objective-c
[_client sendMessage:@{@"text" : @"Hello world", @"other_params" : @[]}
		   toChannel:@"/faye_channel_1"];
```


# License
---------

The MIT License (MIT)

Copyright (c) 2014 - 2016 Kulykov Oleh <info@resident.name>

Permission is hereby granted, free of charge, to any person obtaining a copy
of this software and associated documentation files (the "Software"), to deal
in the Software without restriction, including without limitation the rights
to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
copies of the Software, and to permit persons to whom the Software is
furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in
all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
THE SOFTWARE.




[Libwebsockets]:http://libwebsockets.org
[Jansson]:http://www.digip.org/jansson
[CMake]:http://www.cmake.org
[pthreads]:https://computing.llnl.gov/tutorials/pthreads
[Windows Threads]:http://msdn.microsoft.com/en-us/library/windows/desktop/ms686937
[1]:http://qt-project.org
[RECore]:https://github.com/OlehKulykov/recore
[2]:https://developer.android.com/tools/sdk/ndk/index.html
[QWebSocket]:http://qt-project.org/doc/qt-5/qwebsocket.html
[QtWebSockets]:http://qt-project.org/doc/qt-5/qtwebsockets-index.html
[Bayeux Protocol]:http://svn.cometd.com/trunk/bayeux/bayeux.html
[JSON]:http://www.json.org
[TODO_1]:https://github.com/davidgaleano/libwebsockets
[AppVeyor]:http://www.appveyor.com
[3]:http://mingw-w64.sourceforge.net/download.php
[MinGW]:http://mingw-w64.sourceforge.net/
[CocoaPods]:https://cocoapods.org/pods/FayeCpp
[OpenSSL]:https://www.openssl.org
