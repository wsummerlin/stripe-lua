Stripe-lua
==========

V1.0


A simple lua module to interact with Stripe's payment API.

It’s a work in progress, but what is commited should work pretty well.

To use stripe-lua simply:

1. Go to https://dashboard.stripe.com/register and create an account.
2. Set the api_key variable to your stripe api_key
3. Add the file to your lua project and require “stripe.lua”
4. Set the required variables (see comments in the code) 
5. Call the function initiating your request (See below)
6. Use the returned data (stored as variables and tables, respectively) as needed.

Functions and their “function” -

  StripeNewRegister() : Register a new customer 

  StripeNewCharge() : Charge a customer 

  StripeGetCharges() : Get a list of a customers charge history (With you only)

  StripeUpdateCustomer() : Update a customer's information (email, etc)

  StripeGetCustomer() : Get a customer’s information 

  StripeNewToken() : Create a single use card token 

  StripeTokenCharge() : Charge someone using a card token
  
  StripeRefundCharge() : Provide a refund 


Tips: 

  All pertinent variables (i.e. cardNumber) are global - so you can set them anywhere in your project. 

  Store a customers id, charge ids, and everything else...you will thank me for this one

  All functions are global - so they can be called from anywhere in your project. 


Contact me (Will Summerlin) for help or with any suggestions: techpulsesoftware@gmail.com

Also, check out my blog: http://cooldevelopments.blogspot.com/


Licence: 

Copyright © 2015 Will Summerlin

Permission is hereby granted, free of charge, to any person obtaining a copy of this software and associated documentation files (the "Software"), to deal in the Software without restriction, including without limitation the rights to use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of the Software, and to permit persons to whom the Software is furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.

