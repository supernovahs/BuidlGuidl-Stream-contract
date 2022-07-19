# BuidlGuidl-Stream-contract
Optimized Version of BuidlGuidl Stream contract


## Run forge tests

```
forge test --fork-url <RPC URL>  --gas-report

```

This contract saves a lot of gas that will directly benefit the builders . 

 ## Gas Report 
 
 ###  [Gas Snapshot](https://github.com/supernovahs/BuidlGuidl-Stream-contract/blob/master/.gas-snapshot)
 
 
  Deployment cost | Avg Gas cost
  ----------------| --------------
  contract deploy |     385392     |
  FunctionName    |                |
    cap           |  301           | 
    frequency     |  418           |
    last          |  329           |
    streamBalance |  2733          |
    streamDeposit |  2733          |
    streamWithdraw|  6960          |
    toAddress     |  256           |
    


## Beware 
```
The contract is not audited, use at your own risk. Supernovahs will not be responsible for any theft or loss of funds. 
DYOR.
```

## Contribute

Feel Free to make a [Pull request](https://github.com/supernovahs/BuidlGuidl-Stream-contract/pulls)
