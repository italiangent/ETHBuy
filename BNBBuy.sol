#uniswap router abi 
uniswapV2Router = web3.toChecksumAddress('0x7a250d5630B4cF539739dF2C5dAcb4c659F2488D') 
uniswapV2ABI = 'get it from etherscan'
uniswapRouterContract = web3.eth.contract(address=uniswapV2Router, abi=uniswapV2ABI)

WETH = web3.toChecksumAddress('0xc02aaa39b223fe8d0a0e5c4f27ead9083c756cc2')  
sender_address = web3.toChecksumAddress('0x1f144cF1a4A74ae178eb3605acdF0F4EA68c1B75') #the address which buys the token
privatekey_sender = privateKey
tokenToBuy = web3.toChecksumAddress('0x3c783c21a0383057d128bae431894a5c19f9cf06')  #address of token to buy

nonce = web3.eth.get_transaction_count(sender_address)

#for contracts with fee's use: swapExactETHForTokensSupportingFeeOnTransferTokens 

def buy():
    swapNativeForToken = uniswapV2RouterContract.functions.swapExactETHForTokens(
    0, # set to 0, or specify minimum amount of token you want to receive - consider decimals!!!- use factory contract for calculations
    [WETH,tokenToBuy],
    sender_address,
    (int(time.time()) + 10000)
    ).buildTransaction({
    'from': sender_address,
    'value': web3.toWei(0.0001,'ether'),#Amount of ETH you want to swap for token
    'gasPrice': web3.toWei('5','gwei'),
    'nonce': nonce,
    })

    signed_txn = web3.eth.account.sign_transaction(swapNativeForToken, private_key=privatekey_sender)
    tx_token = web3.eth.send_raw_transaction(signed_txn.rawTransaction)
    print("Swap was succesfull, bought: " + web3.toHex(tx_token))
buy()