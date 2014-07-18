------------------------------------------------------------------------------------------------------------------

-- This is a basic Lua module for interacting with Stripe's API. The module has Corona SDK dependencies. 

-- Copyright (c) Will Summerlin 2014

--See Licence in README
------------------------------------------------------------------------------------------------------------------


-- Function to register a new customer 


-- All of the following values are set for testing ONLY. ---
description = "test"
email = "test@email.com"
api_key = "sk_test_4PRPv16aE7e9IgQ0qNIjxRL3"
cardNumber = "4242424242424242"
fullName = "Test Name"
expMonth = "07"
expYear = "2016"
cvc = "432"
------------------------------------------------------------

StripeNewRegister = function () 
    local json = require "json"
    print ("test")
    newCustomer = "email="..email.."&description="..description.."&card[number]="..cardNumber.."&card[exp_year]="..expYear.."&card[exp_month]="..expMonth.."&card[cvc]="..cvc--{["email"] = email, ["description"] = description}--, ["card"] = firstCard}
    
    
    print(newCustomer)
    
    local function networkListener( event )
        if ( event.isError ) then
            print( "Network error!" )
        else
            print( "RESPONSE: "..event.response )
            local data1 = event.response
            local resp1 = json.decode(data1)
            print(resp1)
            local error = resp1.error
            if error ~= nil then
                for i = 1, #resp1.error do
                    print(resp1.error[i].type)
                    print(resp1.error[i].message)
                end 
            end
            if error == nil then
                customerId = resp1.id
                print(customerId)
                customerCardId = resp1.cards.data[1].id
                print(customerCardId)
                customerCardLastFour = resp1.cards.data[1].last4
                print(customerCardLastFour)
                customerCardFingerprint = resp1.cards.data[1].fingerprint
                print(customerCardFingerprint)
                customerCardFunding = resp1.cards.data[1].funding
                print(customerCardFunding)
                customerCardBrand = resp1.cards.data[1].brand
                print(customerCardBrand)
                
            end  
        end
    end
    
    local key = {["Bearer"] = api_key}
    
    local headers = { 
        ["Authorization"] ="Bearer "..api_key,
        ["Content-Type"] = "application/x-www-form-urlencoded"
    }
    
    
    local params = {}
    params.headers = headers
    params.body =  newCustomer 
    
    print( "params.body: "..params.body )
    
    
    local naw = network.request("https://api.stripe.com/v1/customers", "POST", networkListener, params)
    
    print(naw)
    
end

--StripeNewRegister()


------------------------------------------------------------------------------------------------------------------

--Function to create a charge object

-- All of the following values are set for testing ONLY. ---
chargeDescription = "TestCharge"
customer = "cus_4QBO0CFOHJmJAe" -- Customer id is returned in the latter function as "customerId" - You NEED to save (mySQL?) this in order to make a charge
currency = "usd" -- 3 Letter ISO code
amount = "1041" -- In usd "1041" = $10.41
------------------------------------------------------------



StripeNewCharge = function () 
    local json = require "json"
    print ("test")
    newCharge = "amount="..amount.."&currency="..currency.."&customer="..customer.."&description="..description
    
    print(newCustomer)
    
    local function networkListener( event )
        if ( event.isError ) then
            print( "Network error!" )
        else
            print( "RESPONSE: "..event.response )
            local data1 = event.response
            local resp1 = json.decode(data1)
            print(resp1)
            local error = resp1.error
            if error ~= nil then
                for i = 1, #resp1.error do
                    print(resp1.error[i].type)
                    print(resp1.error[i].message)
                end 
            end
            if error == nil then
                chargeId = resp1.id
                chargedCard = resp1.card.id
                chargedCardLastFour = resp1.card.last4
                chargePaid = resp1.paid --true/false
                chargeFail = resp1.failure_message
                print(chargeFail)
                print(chargeId)
                print(chargedCard)
                print(chargedCardLastFour)
                print(chargePaid)
                
            end  
        end
    end
    
    local key = {["Bearer"] = api_key}
    
    local headers = { 
        ["Authorization"] ="Bearer "..api_key,
        ["Content-Type"] = "application/x-www-form-urlencoded"
    }
    
    
    local params = {}
    params.headers = headers
    params.body =  newCharge 
    
    print( "params.body: "..params.body )
    
    
    local naw = network.request("https://api.stripe.com/v1/charges", "POST", networkListener, params)
    
    print(naw)
    
end


--StripeNewCharge()



------------------------------------------------------------------------------------------------------------------
limit = "18" --A number between 1 and 100 (Optional - Default is 10)

chargedIdTable={}
chargedAmountTable = {}
chargedCardIdTable = {}
chargedCardLastFourTable = {}
chargedTimeTable = {} --Unix time stamps (date and time)


-- Return a list of all charges for a specific customer

StripeGetCharges = function () 
    local json = require "json"
    print ("test")
    getCharges = "customer="..customer.."&limit="..limit
    
    print(getCharges)
    
    local function networkListener( event )
        if ( event.isError ) then
            print( "Network error!" )
        else
            print( "RESPONSE: "..event.response )
            local data1 = event.response
            local resp1 = json.decode(data1)
            print(resp1)
            local error = resp1.error
            if error ~= nil then
                for i = 1, #resp1.error do
                    print(resp1.error[i].type)
                    print(resp1.error[i].message)
                end 
            end
            if error == nil then
                for j = 1, #resp1.data do
                    
                    table.insert(chargedIdTable, resp1.data[j].id)
                    print(resp1.data[j].id)
                    table.insert(chargedAmountTable, resp1.data[j].amount)
                    print(resp1.data[j].amount)
                    table.insert(chargedCardIdTable, resp1.data[j].card.id)
                    print(resp1.data[j].card.id)
                    table.insert(chargedCardLastFourTable, resp1.data[j].card.last4)
                    print(resp1.data[j].card.last4)
                    table.insert(chargedTimeTable, resp1.data[j].created)
                    print(resp1.data[j].created)
                end
                    
                
            end  
        end
    end
    
    local key = {["Bearer"] = api_key}
    
    local headers = { 
        ["Authorization"] ="Bearer "..api_key,
        ["Content-Type"] = "application/x-www-form-urlencoded"
    }
    
    
    local params = {}
    params.headers = headers
    params.body =  getCharges 
    
    print( "params.body: "..params.body )
    
    
    local naw = network.request("https://api.stripe.com/v1/charges", "GET", networkListener, params)
    
    print(naw)
    
end


--StripeGetCharges()

------------------------------------------------------------------------------------------------------------------ 

--Update specific params on a customer (i.e. "email", "Description")

--NOTE - You must set the global "customer" variable to the id of the customer being modified 
newEmail = "imnew@email.com"

StripeUpdateCustomer = function () 
    local json = require "json"
    print ("test")
    updateCustomer = "email="..newEmail--.."&description="..newDescription.."&(other params)"
    
    print(updateCustomer)
    
    local function networkListener( event )
        if ( event.isError ) then
            print( "Network error!" )
        else
            print( "RESPONSE: "..event.response )
            local data1 = event.response
            local resp1 = json.decode(data1)
            print(resp1)
            local error = resp1.error
            if error ~= nil then
                for i = 1, #resp1.error do
                    print(resp1.error[i].type)
                    print(resp1.error[i].message)
                end 
            end
            if error == nil then
                emailReturn = resp1.email
                print(emailReturn)

            end  
        end
    end
    
    local key = {["Bearer"] = api_key}
    
    local headers = { 
        ["Authorization"] ="Bearer "..api_key,
        ["Content-Type"] = "application/x-www-form-urlencoded"
    }
    
    
    local params = {}
    params.headers = headers
    params.body =  updateCustomer 
    
    print( "params.body: "..params.body )
    
    
    local naw = network.request("https://api.stripe.com/v1/customers/"..customer, "POST", networkListener, params)
    
    print(naw)
    
end

--StripeUpdateCustomer()



------------------------------------------------------------------------------------------------------------------ 

-- Return a customers information 

--NOTE - You must set the global "customer" variable to the id of the customer being requested 

StripeGetCustomer = function () 
    local json = require "json"
    print ("test")

    
    local function networkListener( event )
        if ( event.isError ) then
            print( "Network error!" )
        else
            print( "RESPONSE: "..event.response )
            local data1 = event.response
            local resp1 = json.decode(data1)
            print(resp1)
            local error = resp1.error
            if error ~= nil then
                for i = 1, #resp1.error do
                    print(resp1.error[i].type)
                    print(resp1.error[i].message)
                end 
            end
            if error == nil then
                emailReturn = resp1.email
                descriptionReturn = resp1.description
                defaultCard = resp1.default_card
                print(emailReturn)
                print(descriptionReturn)
                print(defaultCard)
                
                --Iterate through returned JSON here

            end  
        end
    end
    
    local key = {["Bearer"] = api_key}
    
    local headers = { 
        ["Authorization"] ="Bearer "..api_key,
        ["Content-Type"] = "application/x-www-form-urlencoded"
    }
    
    
    local params = {}
    params.headers = headers 
    
    
    local naw = network.request("https://api.stripe.com/v1/customers/"..customer, "GET", networkListener, params)
    
    print(naw)
    
end

--StripeGetCustomer()


------------------------------------------------------------------------------------------------------------------
 
 
 --Create a token for a one time charge
 
 
StripeNewToken = function () 
    local json = require "json"
    print ("test")
    newCardToken = "card[number]="..cardNumber.."&card[exp_year]="..expYear.."&card[exp_month]="..expMonth.."&card[cvc]="..cvc
    
    print(newCustomer)
    
    local function networkListener( event )
        if ( event.isError ) then
            print( "Network error!" )
        else
            print( "RESPONSE: "..event.response )
            local data1 = event.response
            local resp1 = json.decode(data1)
            print(resp1)
            local error = resp1.error
            if error ~= nil then
                for i = 1, #resp1.error do
                    print(resp1.error[i].type)
                    print(resp1.error[i].message)
                end 
            end
            if error == nil then
                tokenId = resp1.id
                print(tokenId)
                tokenCardId = resp1.card.id
                print(tokenCardId)
                tokenCardLastFour = resp1.card.last4
                print(tokenCardLastFour)
                tokenCardFingerprint = resp1.card.fingerprint
                print(tokenCardFingerprint)
                tokenCardFunding = resp1.card.funding
                print(tokenCardFunding)
                tokenCardBrand = resp1.card.brand
                print(tokenCardBrand)
                
            end  
        end
    end
    
    local key = {["Bearer"] = api_key}
    
    local headers = { 
        ["Authorization"] ="Bearer "..api_key,
        ["Content-Type"] = "application/x-www-form-urlencoded"
    }
    
    
    local params = {}
    params.headers = headers
    params.body =  newCardToken
    
    print( "params.body: "..params.body )
    
    
    local naw = network.request("https://api.stripe.com/v1/tokens", "POST", networkListener, params)
    
    print(naw)
    
end


--StripeNewToken()

------------------------------------------------------------------------------------------------------------------

--Charge a user with a token

--Below is an arbitrary and defunct token id (It will not work). The function above - "StripeNewToken()" - will generate a real single use token. 

tokenId = "tok_14HRJN4ZwoZsuAk4NbLdeGk5"


StripeTokenCharge = function () 
    local json = require "json"
    print ("test")
    newCharge = "amount="..amount.."&currency="..currency.."&card="..tokenId.."&description="..description
    
    print(newCustomer)
    
    local function networkListener( event )
        if ( event.isError ) then
            print( "Network error!" )
        else
            print( "RESPONSE: "..event.response )
            local data1 = event.response
            local resp1 = json.decode(data1)
            print(resp1)
            local error = resp1.error
            if error ~= nil then
                for i = 1, #resp1.error do
                    print(resp1.error[i].type)
                    print(resp1.error[i].message)
                end 
            end
            if error == nil then
                chargeId = resp1.id
                chargedCard = resp1.card.id
                chargedCardLastFour = resp1.card.last4
                chargePaid = resp1.paid --true/false
                chargeFail = resp1.failure_message
                print(chargeFail)
                print(chargeId)
                print(chargedCard)
                print(chargedCardLastFour)
                print(chargePaid)
                
            end  
        end
    end
    
    local key = {["Bearer"] = api_key}
    
    local headers = { 
        ["Authorization"] ="Bearer "..api_key,
        ["Content-Type"] = "application/x-www-form-urlencoded"
    }
    
    
    local params = {}
    params.headers = headers
    params.body =  newCharge 
    
    print( "params.body: "..params.body )
    
    
    local naw = network.request("https://api.stripe.com/v1/charges", "POST", networkListener, params)
    
    print(naw)
    
end


--StripeTokenCharge()



------------------------------------------------------------------------------------------------------------------
 
 
--Provide a refund
 
----Below is an arbitrary and defunct charge id (It will not work). You need to set "chargeId" to the id of the charge to be refunded 

chargeId = "ch_14HRca4ZwoZsuAk49Y0CMA65"

StripeRefundCharge = function () 
    local json = require "json"
    print ("test")
   
    
    local function networkListener( event )
        if ( event.isError ) then
            print( "Network error!" )
        else
            print( "RESPONSE: "..event.response )
            local data1 = event.response
            local resp1 = json.decode(data1)
            print(resp1)
            local error = resp1.error
            if error ~= nil then
                for i = 1, #resp1.error do
                    print(resp1.error[i].type)
                    print(resp1.error[i].message)
                end 
            end
            if error == nil then
                refundId = resp1.id
                refundAmount = resp1.amount
                refundTime = resp1.created
                print(refundAmount)
                print(refundId)
                print(refundTime)
                
            end  
        end
    end
    
    local key = {["Bearer"] = api_key}
    
    local headers = { 
        ["Authorization"] ="Bearer "..api_key,
        ["Content-Type"] = "application/x-www-form-urlencoded"
    }
    
    
    local params = {}
    params.headers = headers
    
    
    local naw = network.request("https://api.stripe.com/v1/charges/"..chargeId.."/refunds", "POST", networkListener, params)
    
    print(naw)
    
end


--StripeRefundCharge()

