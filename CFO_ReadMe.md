# Looking for Suspicious Transactions

![Credit card fraudster](Images/credit_card_fraudster.jpg) 

*[Credit Card Fraudster by Richard Patterson](https://www.flickr.com/photos/136770128@N07/42252105582/) | [Creative Commons Licensed](https://creativecommons.org/licenses/by/2.0/)*

## Background

We have done all the requested analysis for you.  Instructons are and final analysis outcomes are included in this file. 

We have used SQL skills to analyze historical credit card transactions and consumption patterns in order to identify possible fraudulent transactions. The data used for this analysis based on the fraud_detection database.

There are two prt to this analysis. File query.sql has all the SQL data analysis components under section - Part 1. SQL statements realted to each of these questions are listed within this sections with question number as their heading. 

Direcdtory __*HM Files** has the following files__
  	QuickDBD.pdf	- QuickDBD diagram Documentation
	QuickDBD.png	- QuickDBD Table relationship
	create_db.sql	- Database create command
	query.sql	- Data Analysis SQL statmenets
	schema.sql	- Table creations and Table alter command
  

#### Part 1: Analysis Outcome
   ##### Plese refer to file ***query.sql in directory HM Files***  _See under section - Pat 1_

* Some fraudsters hack a credit card by making several small transactions (generally less than $2.00), which are typically ignored by cardholders. 

  * How can you isolate (or group) the transactions of each cardholder?

    - **ANSWER:** ***Under heading:- _Question 1_***

  * Count the transactions that are less than $2.00 per cardholder. 
   
    - **ANSWER:** ***Under heading:- _Question 2_***
  
  * Is there any evidence to suggest that a credit card has been hacked? Explain your rationale.

    - **ANSWER:**  ***YES***. There are evidence of several small transactions (less than $2) on 53 credit cards. 
	  Six credit cards recorded 10+ small transactions. This indicates these credit cards may have been hacked. 


* Take your investigation a step futher by considering the time period in which potentially fraudulent transactions are made. 

  * What are the top 100 highest transactions made between 7:00 am and 9:00 am?

    - **ANSWER:** ***Under heading:- _Question 4_*** 


  * Do you see any anomalous transactions that could be fraudulent?

    - **ANSWER:** ***Under heading:- _Question 5_*** 
    
	  Based on the result from Question 4, there are 9 transactions have transaction amount greater than $100. The result of 91 transaction out of 100 have transaction amount less than $100, in fact, they are between $23.13 and $11.65 with a low spread. However, the top 9 transactions would be considered suspicious. The transactions jumped from $100 to $748, then there are several transactions in the range of $1000, and then to the maximum of $1894.

  * Is there a higher number of fraudulent transactions made during this time frame versus the rest of the day?

    - **ANSWER:** ***Under heading:- _Question 6_*** 
    
	  Query 1 reveals that 30 potentially fraudulent transactions happened between 7am to 9am and averaging 15 transaction per hours block. Query 2 reveals that 320 potentially fraudulent transactions happened outside of 7am and 9am and averaging 14.54 transaction per hour block. Based on this data, we can see that the averages are very close. This tells us that there are potential fraudulent data occurring even outside of 7-9am.  But it is true that transactions are slightly higher during 7-9am windows
    

  * If you answered yes to the previous question, explain why you think there might be fraudulent transactions during this time frame.

    - **ANSWER:**  I think hackers may have picked this time of the day to make fraudulent transactions since customers are less likely to notice. The 7-9am usually a busy time  frame for people since its the start of the day. They generally busy getting ready for the day. During sleep time, it is awkward to see transactions like this since people are sleeping. So, 7-9am could be the best time for hackers.


* What are the top 5 merchants prone to being hacked using small transactions?
  
    - **ANSWER:** ***Under heading:- _Question 8_***
  
    The top 5 Merchants that are prone to be hacked:
      <table>
        <tr>
          <th>Name</th>
          <th>Count</th>
        </tr>
        <tr>
          <td>Wood-Ramirez</td>
          <td>7</td>
        </tr>
        <tr>
          <td>Hood-Phillips</td>
          <td>6</td>
        </tr>
        <tr>
          <td>Baker Inc</td>
          <td>6</td>
        </tr>
        <tr>
          <td>Mcdaniel, Hines and Mcfarland</td>
          <td>5</td>
        </tr>  
        <tr>
          <td>Hamilton-Mcfarland</td>
          <td>5</td>
        </tr>   
      </table>
   
  
    
* Create a view for each of your queries.

  - **ANSWER:** ***Under heading:- _Question 9_***  See section ***Part 1 - Creating VIEWS*** in query.sql


---
