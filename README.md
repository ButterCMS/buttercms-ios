# ButterCMSSDK sample application
ButterCMS is a headless CMS which provides content through REST APIs. The [Swift ButterCMSSDK](https://github.com/ButterCMS/buttercms-swift) simplifies interaction with those REST APIs. 

The sample application is implemented for iOS 14 or higher. It is connected to a sample ButterCMS instance. It demonstrates usage of the following main object available in ButterCMS:

* Pages
* Blog posts
* Collections

ButterCMSSDK automatically deserializes json data received from REST APIs. Where Blog posts have a fixed data model the Pages and Collections have to be fine-tuned by generics. There are two models of pages:

* [HomePage](ButterCMSSample/Model/HomePageFields.swift) 
* [CaseStudyPage](ButterCMSSample/Model/CaseStudyPageFields.swift) 

and one model for Collection:
    
* [Faq](ButterCMSSample/Model/FaqCollectionItem.swift)
    
The configuration of the ButterCMSSDK and calls of individal APIs can be found in [ButterCMSManager.swift]((ButterCMSSample/Managers/ButterCMSManager.swift).

 

