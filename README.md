# Amusement Park Pass Generator (part 2)

## iOS Techdegree Project 5

You will now take the foundation you created in Project 4 (Amusement Park Generator (I)) and add the User Interface for the app, along with a short list of new features and entrant types handling. You might need to refactor some code in order to accommodate these changes.

The app can take user input and create personalized entrant passes for all the entrant types. When the passes are being swiped at different locations in the park, business rules such as whether the entrant is allowed to access an area, whether the entrant can get a discount, will be tested.

### Required Tasks

1. Construct an iPad user-interface as per the screenshots in the project mockup. As mentioned in the Onward and Upward Instruction Video, the UI elements such as entry boxes and labels need to be enabled/disabled (or made visible/hidden) depending on the entrant type the user selects.

2. Utilize the code created in Project 4 as the business logic foundation for the user interface. You may need to refactor, enhance or rewrite some of the code from Project 4 in order to satisfy the expanded requirements for this project, which are detailed in the Business Rules Matrix and the Entrant Access Rules documents.

3. Make sure your app can perform all of the following tasks:
  - Create entry passes for the all the entrant types listed for Project 4 (Classic, VIP, Free Child, Manager, Hourly Employee:Food, Hourly Employee Maintenance)

  - Create entry passes for the four additional entrant types listed for Project 5 (Season Pass Guest, Senior Guest, Contract Employee, Vendor)

  - Ensure that all necessary information is present before issuing a particular type of pass, otherwise, display an appropriate alert message
  
4. Provide a set of correct values for the selected entrant type when the user clicks the “Populate Data” button.

5. In the next pass testing, when the user clicks on the test buttons (such as Area Access, Ride Access, Discount Access), messages such as “Access all rides”, “Kitchen area: access allowed”, “10% discount for food” should be displayed in the Test Results area.
Passes need to be tested for rules such as:
  - Entries to various areas (Amusement, Ride, Kitchen, Maintenance, Office, etc.)
  - Access to rides
  - Privileges for skipping lines
  - Discounts for food and merchandise

### Extra Credit

* Add additional input validation to ensure that phone numbers and zip codes are all numerical, birthday is of the correct format (MM/DD/YYYY) and that all text entries are of “reasonable” length. You can decide what you deem reasonable, and put it in the relevant comment in the code. You will only be graded on the implementation. An alert needs to be generated to notify the user that there is an invalid input.

* Add a feature to the swipe method(s), so that a “ding” sound is played when an entrant is granted access and a “buzz” sound is played when an entrant is denied access.

### Personal Enhancements

* Adaptive UI for both portrait and landscape mode
