//KIP7 Minable
interface IKIP7Minable {
    function mint(address _to, uint256 _amount) external returns (bool);
    function isMinter(address _account) external view returns (bool);
    function addMinter(address _account) external;
    function renounceMinter() external;
}
