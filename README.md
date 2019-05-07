# Final-Projecct
Instacart dashboard


Please for the Report of this project click [here](http://rpubs.com/isdikov/493840)
For the original source of the train dataset used for this project click [here](https://p8105.com/dataset_instacart.html)
To see the shinydashboard [click here](https://ibrokhim-sadikov.shinyapps.io/Final/)

Data description
The original data is quite extensive, and the data linked to at the top of this page for use in the class represents a cleaned and limited version of the data. The dataset contains 1,384,617 observations of 131,209 unique users, where each row in the dataset is a product from an order. There is a single order per user in this dataset.

There are 15 variables in this dataset:

order_id: order identifier
product_id: product identifier
add_to_cart_order: order in which each product was added to cart
reordered: 1 if this prodcut has been ordered by this user in the past, 0 otherwise
user_id: customer identifier
eval_set: which evaluation set this order belongs in (Note that the data for use in this class is exclusively from the “train”  eval_set)
order_number: the order sequence number for this user (1=first, n=nth)
order_dow: the day of the week on which the order was placed
order_hour_of_day: the hour of the day on which the order was placed
days_since_prior_order: days since the last order, capped at 30, NA if order_number=1
product_name: name of the product
aisle_id: aisle identifier
department_id: department identifier
aisle: the name of the aisle
department: the name of the department
