# Final-Projecct
Instacart dashboard


LOGO_IMAGE = "anima5.gif"

    st.markdown(
        """
        <style>
        .container {
            display: flex;
        }
        .logo-text {
            
            font-weight:525 !important;
            font-size:45px !important;
            color: #3298e6 !important;
            padding-top: 115px !important;
            
        }
        .logo-img {
            width: 400px;
            height: 350px;
            padding-top: -2rem;
        }
        </style>
        """,
        unsafe_allow_html=True
    )

    st.markdown(
        f"""<div class="container">
            <img class="logo-img" src="data:image/gif;base64,{base64.b64encode(open(LOGO_IMAGE, "rb").read()).decode()}">
            <p class="logo-text">Radiology Information Extraction Toolkit</p>
            </div>
        """,
        unsafe_allow_html=True
    )































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

Once again you have two options, 
First, go to the above link for the train dataset and run it through DataWrangling.Rmd, to make necesserary transformation for shiny part
and save it as insta_ready.csv.

Or, you can download the already transformed data insta_ready.csv from the link below. As github has limited storage offering, I was not able to store the big dataset here. Then you can easliy access that file and download it to your PC and run the shiny app from the reproductible code provided
[link for insta_ready.csv](https://drive.google.com/file/d/1_VDO8gex_QHaup5eeoiwgIjWtkXsR5Gn/view?usp=sharing)
