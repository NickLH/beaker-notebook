Feature: Subscriptions
  As a researcher
  I want to see my subscriptions
  So that I can use them quickly and easily.

  Background:
    Given I'm signed in as a researcher
    And I'm subscribed to the following market items:
      | title               | remoteFile | description  |
      | Crime Rates, Canada | CRIME.xml  | pretty bad   |
      | Population, Canada  | POP.xml    | somewhat low |

  Scenario: Seeing subscribed datasets
    When I view My Datasets
    Then I should see the following datasets:
      | title               | remoteFile | description  |
      | Crime Rates, Canada | CRIME.xml  | pretty bad   |
      | Population, Canada  | POP.xml    | somewhat low |

  Scenario: Viewing dataset details
    When I view My Datasets
    And I view the "Crime Rates, Canada" dataset
    Then I should see the "Crime Rates, Canada" dataset in the marketplace

  Scenario: Seeing subscription date
    Given I have the following market items:
      | title            | remoteFile |
      | Employment Rates | MONEYS.csv |
    When I view the market search
    And I view the "Employment Rates" market item
    And I subscribe to the market item
    And I view My Datasets
    Then I should see the current date for subscription date for "Employment Rates" market item

  Scenario: Searching datasets
    When I view My Datasets
    And I search my subscriptions for "Crime Rates"
    Then I should see the following datasets:
      | title               | remoteFile | description  |
      | Crime Rates, Canada | CRIME.xml  | pretty bad   |