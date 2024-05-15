// SPDX-License-Identifier: MIT
pragma solidity 0.8.25;

contract TVLOracle {
    address public tvlAggregator;
    address public owner;
    mapping(string => uint256) public tvl;

    event TVLUpdated(string name, uint256 _currentTvl);

    constructor(address _tvlAggregator) {
        owner = msg.sender;
        require(_tvlAggregator != address(0), "No zero addresses");
        tvlAggregator = _tvlAggregator;
    }

    /// @notice Sets TVL by aggregator
    /// @param _name Subset of TVL
    /// @param _newTvl New TVL calculated by aggregator
    function setTvl(string memory _name, uint256 _newTvl) public {
        require(
            msg.sender == tvlAggregator,
            "Only TVL Aggregator can call this message"
        );
        tvl[string(_name)] = _newTvl;
        emit TVLUpdated(_name, _newTvl);
    }

    /// @notice Sets the address of the TVL aggregator
    /// @param _tvlAggregator Address of new aggregator
    function setTVLAggregator(address _tvlAggregator) public {
        require(_tvlAggregator != address(0) && msg.sender == owner, "No zero addresses");
        tvlAggregator = _tvlAggregator;
    }
}
