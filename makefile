# include .env file and export its env vars
# (-include to ignore error if it does not exist)
-include .env

anvil: 
	anvil -f ${RPC_URL} -m ${MNEMONIC}

script: 
	forge script scripts/MyToken.s.sol --rpc-url ${LOCAL_RPC_URL}  --broadcast --private-key ${LOCAL_PRIVATE_KEY} -vvvv

script-mainnet:
	forge script scripts/MyToken.s.sol --rpc-url ${RPC_URL}  --broadcast --private-key ${PRIVATE_KEY} -vvvv

verify: 
	forge verify-contract --chain-id 4 --num-of-optimizations 200  --compiler-version v0.8.13+commit.abaa5c0e 0x48ae5f76a075078eb99815cf42a4b9d56e2dd955 src/MyToken.sol:MyToken ${ETHERSCAN_KEY}

verify-check: 
	forge verify-check --chain-id 4 uzrniwjwruhq9mkdhlhbrid8hiyfxkqjrcdjxiy4bk3dmyujqk ${ETHERSCAN_KEY}

abi: 
	cast abi-encode "constructor(uint64)" 2274

owner-local: 
	cast call --rpc-url ${LOCAL_RPC_URL} --private-key ${LOCAL_PRIVATE_KEY} 0x48ae5f76a075078eb99815cf42a4b9d56e2dd955 "owner()(address)"

owner-live: 
	cast call --rpc-url ${RPC_URL} --private-key ${PRIVATE_KEY} 0x48ae5f76a075078eb99815cf42a4b9d56e2dd955 "owner()(address)"

burn-local: 
	cast send --rpc-url ${LOCAL_RPC_URL} 0x48ae5f76a075078eb99815cf42a4b9d56e2dd955 "burn(address, uint256)" <address> <amount> --private-key ${LOCAL_PRIVATE_KEY}

burn-live: 
	cast send --rpc-url ${RPC_URL} 0x48ae5f76a075078eb99815cf42a4b9d56e2dd955 "burn(address, uint256)" <address> <amount> --private-key ${PRIVATE_KEY}

mint-local: 
	cast send --rpc-url ${LOCAL_RPC_URL} 0x48ae5f76a075078eb99815cf42a4b9d56e2dd955 "mint(address, uint256)" <address> <amount> --private-key ${LOCAL_PRIVATE_KEY}

mint-live: 
	cast send --rpc-url ${RPC_URL} 0x48ae5f76a075078eb99815cf42a4b9d56e2dd955 "mint(address, uint256)" <address> <amount> --private-key ${PRIVATE_KEY}