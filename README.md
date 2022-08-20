#  Brian Weissberg Square Project

## Build tools & versions used

- I used all native iOS components in my app without any third party libraries.

## Steps to run the app

- This app is ready to build and run out of the box

## What areas of the app did you focus on?

- I spent a lot of focus on how I parsed and handled data for this app. I did my best to split up responsibility of the different classes and methods within those classes.
- I focused on unit testing a little bit with using expectations for async tasks. It took the JSON responses and created `.json` files for each of the three URL's. I was able to really build the app around the idea that a user can easily test each of the three URL's. 
- Within the app, I wanted to make a real time way to test behaviour of each of the JSON files quickly. This is why I created the `Test` button at the top that allows a user to see each of the three scenarios quickly and easily. 
- I focused on making the app friendly for user data. I only loaded the images when they were queued by `cellForRowAt`. Once the images where loaded, I cached the images in memory using the URL. If the caching were to take place on device such as using `CoreData`, then I would have focusing more on clearing the cache but since it in memory, I just focused on adding items to the cache. I would have preferred to use the `uuid` for the cache but in real life, I would want assurances that the `uuid` would always be the same for the lifetime of a user, thus decided to use the image url. 
- Completely removed the `main.storyboard` and actually launch the app from the scene delegate using a coordinator. This allows for the coordinator to be the source of truth for navigation and for views to be decoupled if more are to be added in the future. All view logic will go through the coordinator so that each view will not know/care about any other view such as using `segues` etc. At my current employer, use of a storyboard is not allowed and I have really come to appreciate making a view all in code. The UI for the tableview cell is basic but very reusable since I used a stack view. This would allow a future developer to very easily add/remove elements of the stack without having to redo constraints. 

## What was the reason for your focus? What problems were you trying to solve?
- My focus in building this app was to create a plaform that could *easily* be expanded upon and *tested*. Each class only does a specific task so that it is easy to resuse and is also easier to test. This came in very handy when making my unit test. Instead of making a real network call using my real `NetworkManager`, I was able to create a mock network manager class that would examine the string value of the URL and then use my local json files in bundle to mock loading the json from network. 

## How long did you spend on this project?

- I decided to use my full 8 hours to build this project.

## Did you make any trade-offs for this project? What would you have done differently with more time?

- Yes. Here are a few things I would change. 
	- I don't like the idea of hardcoding a URL into any part of the my code. In real life, the contract for a URL should be given upfront and be somehow passed in while creating the view. I didn't want my coordinator know about hardcoded URL's so just decided to bake in my `UrlState` into my network manager.
	- I would write more unit tests with more edge cases. I wanted to write tests where I actually tested the main view controller but just ran out of time. I was satisfied with my code coverage but could have definately done better. 
	- I would make it easier to test without pushing/popping views from a nav controller. It isn't very elegant but it does the job.
	- Error handling: Because it is very easy to create an alert, I would have done more than show a banner.
	- Pagination. If I had more time, I would have created logic to load images for the first 10 employees into the tableview. Then when user starts scrolling, I would do something like load the next 10 and so on so that user never see's a placeholder image. The tableview does not scroll very smooth until all images are cached. 
## What do you think is the weakest part of your project?
- Documentation. While I personally like the organization of the code, I always appreciate descriptive comments to guide me. This especially goes for the unit tests, when reviewing code for the first time, I like to review the unit tests for that code. 

## Did you copy any code or dependencies? Please make sure to attribute them here!
- Refresh control, just copied and pasted that in
- Alert view controller, mostly copied and pasted. 

## Is there any other information you’d like us to know?

- Thank you for taking time to review this code. 