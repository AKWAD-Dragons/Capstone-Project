## SERCL Capstone Project

<h3>Why This Project?</h3>

SERCL is a commercial platform that serves millions of customers in the german market. It has been built by AKWAD developers on two cross-platform mobile clients using <b>FLUTTER</b> and a multi technology server side including <b>PHP</b>, <b>Node JS</b>, ...etc.

In this Capstone Project we added a good portion of SERCL staging code to help our potential developers prove themselves on an up and running product instead of the classical interview questions that target the online tutorials plain knowledge. <b>It's a great opportunity to show an instant impact!</b>

<h3>What is this Project?</h3>
The capstone project consists of some modules and parts. Some you should build from scratch, Some you should detect and fix its bugs and some you should complete its missing pieces to work properly.

<h3>Task 0 : Setting up the project using Git</h3>

Before working on this project you need to have your own copy on your Github account. Hence, You should fork it to your account then clone it to your local machine. Once it's up and running you can start working on your local version, commiting and pushing to your remote version. Once you're totally done you will send us the link of your repository.

<u>Key notes about Git:</u>
 - Each module of the following should be worked out in a separate branch.
 - All branches should be started out of the <b>master</b> branch
 - Once a branch is done. It should be merged into the <b>master</b> branch
 - Project final evaluation will be on the final version of the <b>master</b> branch. The other branches are important to evaluate your Git skills but won't be pulled or evaluated.

If your Git knowledge needs a refresher. Here's a 15 mins article that would thrive your skills: https://www.atlassian.com/git

<h3>Task 1: Login Module</h3>

In this module you should see a screen like this:

<img src="https://i.imgur.com/BySXD76.png" style="width:300px; height:600px">

* In project files tree. Navigate to <u>lib/UI/LoginScreen.dart</u>

* [Scenario #1] We're mainly facing a navigation issue as the app doesn't go anywhere upon pressing the correspondant UI elements (e.i: Register Text should navigates to the Sign up screen on pressed) <span style="color:red">[BUG]</span>

*  [Scenario #2] If we clicked on the Register text we are navigated to a different screen than Sign up. We need to fix this behavior <span style="color:red">[BUG]</span>

* [Scenario #3] We expect to login into the App once pressing on Login button. This functionality is missing in this screen dart file, please complete it. <span style="color:blue">[MISSING]</span>

<h3>Task 2: Sign up Module</h3>

* In project files tree. Navigate to <u>lib/UI/SignupScreen.dart</u>

* Implement the full UI design of the sign up screen according to what is visible in this screenshot <span style="color:green">[IMPLEMENTATION]</span> :

<img src="https://i.imgur.com/kYesTJV.png" style="width:300px; height:600px">

* Consider running this design on different sizes of devices. So avoid defining exact width or height to the components.

* All clickable UI components should be compatible with its job. (e.i: Login text should navigate to Login screen & Create Account buttin should trigger the sign up process).

<h3>Task 3 : Bottom Navigation Bar</h3>

* In project files tree. Navigate to <u>lib/Widgets/BottomNavigationBar.dart</u>

* Implement the full UI design of the bottom navigation bar according to what is visible in this screenshot <span style="color:green">[IMPLEMENTATION]</span> :

<img src="https://i.imgur.com/t2XW4ZM.png" style="width:300px; height:600px">

* Bottom Navigation Bar should update the <i>_setScreen()</i> function located in <u>lib/UI/SP_ParentScreen.dart</u> with the correct selected screen.

* <span style="color:yellow">[+BONUS]</span> Use RxDart to setup the communication between the bottom navigation bar and <i>_setScreen()</i> function.

<br>
<br>

<h3>Task 4: JSON Serialization & Parsing</h3>

* In project files tree. Navigate to <u>lib/blocs/orders/orders_bloc.dart</u>

* Inside <i>_getOrders()</i> function we do query a certain Service Provider (SP) list of invitations. But the SP PODO doesn't contain a List of invitations field. Create the <i>Invitation</i> PODO class and generate its <i>Invitation.g</i> file then add it to the <i>SP</i> PODO class and regenerate the <i>SP.g</i> file. <span style="color:blue">[MISSING]</span>

* The <i>Invitation</i> PODO fields should follow the GraphQL Documentation here: https://dev.sercl.de/graphql-playground

* The <i>Invitation</i> class should implement the <i>Parser\<T></i> interface functions.

* After parsing the list of invitations is succeeded you should consider assigning this list to the correct <i>State</i> ending up with adding this <i>state</i> instance into the stream sink to send it to the listening subscribers screens. <span style="color:blue">[MISSING]</span>

<h3>Task 5: Invitation Details Module</h3>

* In project files tree. Navigate to <u>lib/UI/Orders/InvitationOrderDetails.dart</u>

* Implement the full UI design of the Invitation Details screen according to what is visible in this screenshot <span style="color:green">[IMPLEMENTATION]</span> :

<img src="https://i.imgur.com/VEwbQj3.png" style="width:300px; height:600px">

* Consider running this design on different sizes of devices. So avoid defining exact width or height to the components.

* All clickable UI components should be compatible with its job. (e.i.: Play audio button should play the audio file fetched with the invitation data).

* Clicking the image thumbnails should open any of them into full-screen mode.

* Contact & Reject buttons are not necessarily to be clickables

<h3>Task 6: OnBoarding Module</h3>

* In project files tree. Navigate to <u>lib/UI/OnBoarding</u> folder

* In the previous folder navigate to <i>Areas.dart</i> file.

* Implement the full UI design of the Areas screen according to what is visible in this screenshot <span style="color:green">[IMPLEMENTATION]</span> :

<img src="https://i.imgur.com/rIx8KIn.png" style="width:300px; height:600px">

* Consider running this design on different sizes of devices. So avoid defining exact width or height to the components.

* Consider add the proper validations to both <i>From</i> & <i>To</i> textfields as following:

 * Both fields should not be left empty.

 * Both fields should not contain any negative numeric values.

 * Both fields should not contain any non-numeric values.

 * <i>From</i> field numeric value cannot be larger than or equal <i>To</i> field numeric value.


 * In the OnBoarding folder navigate to <i>Services.dart</i> file.

 * Implement the full UI design of the Services screen according to what is visible in these screenshots <span style="color:green">[IMPLEMENTATION]</span> :

<img src="https://i.imgur.com/JfANaG9.png" style="width:300px; height:600px">

<img src="https://i.imgur.com/zvTwxJd.png" style="width:300px; height:600px">

* Consider running this design on different sizes of devices. So avoid defining exact width or height to the components.

* You should make use of the list of Categories and its Services which are fetched in the services bloc.

* Consider validating the user selection by checking at least one service selection.

* Consider setting the selected service chip color according its category.

* Consider the change occurs in width and height due to select/de-select

* <span style="color:yellow">[+BONUS]</span> Consider add a size based animation to each category container so that its size change run smoothly.
