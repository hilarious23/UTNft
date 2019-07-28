// solidityのバージョン宣言
pragma solidity ^0.5.2;
// ライブラリの読み込み
import "github.com/OpenZeppelin/openzeppelin-contracts/contracts/token/ERC721/ERC721Full.sol";
import "github.com/OpenZeppelin/openzeppelin-contracts/contracts/token/ERC721/ERC721Mintable.sol";
import "github.com/OpenZeppelin/openzeppelin-contracts/contracts/token/ERC721/ERC721Pausable.sol";
// ライブラリ継承
contract ItemAssetAnswer is ERC721Full, ERC721Mintable, ERC721Pausable {
    // tokenIdからItemAssetTypeを割り出せるようにオフセットを宣言
    uint16 public constant ITEM_TYPE_OFFSET = 10000;
    // metadata用(今回は不要)
    string public tokenURIPrefix = "https://www.utcrypto.net/metadata/item/";
    // Type毎の最大発行数の管理用
    // 他コントラクトからアクセスできないようにするため、privateに
    mapping(uint16 => uint16) private itemTypeToSupplyLimit;
    // コントラクトデプロイ時の処理。nameとsymbolの設定
    constructor() public ERC721Full("UtCrypto:Item", "UTCI") {
    }
    // 実運用用
    function isAlreadyMinted(uint256 _tokenId) public view returns (bool) {
        return _exists(_tokenId);
    }
    // 発行数上限の設定(_itemType,_supplyLimit)
    // 上限を0にしたり、一度セットしたものから増やすことはできない。
    // 上限を減らすことはできる
        // 発行数上限を誤って0にしないようにバリデート
        // まだ上限が設定されていないもしくは、一度セットされている上限より低い上限を設定しようとしているか確認
        // 発行数上限の設定
    }
    
    // metadata用(今回は不要)
    function setTokenURIPrefix(string calldata _tokenURIPrefix) external onlyMinter {
        tokenURIPrefix = _tokenURIPrefix;
    }
    // 発行数上限のgetter
    // トークン発行(_ownerに対して_tokenIdをmint)
    // _tokenIdは0001から順番に発行しているものとする
        // 該当itemTypeの発行数上限を超えていないか確認したうえでmint
    }
    
    // metadata用(今回は不要)
    function tokenURI(uint256 tokenId) public view returns (string memory) {
        bytes32 tokenIdBytes;
        if (tokenId == 0) {
            tokenIdBytes = "0";
        } else {
            uint256 value = tokenId;
            while (value > 0) {
                tokenIdBytes = bytes32(uint256(tokenIdBytes) / (2 ** 8));
                tokenIdBytes |= bytes32(((value % 10) + 48) * 2 ** (8 * 31));
                value /= 10;
            }
        }
        bytes memory prefixBytes = bytes(tokenURIPrefix);
        bytes memory tokenURIBytes = new bytes(prefixBytes.length + tokenIdBytes.length);
        uint8 i;
        uint8 index = 0;
        
        for (i = 0; i < prefixBytes.length; i++) {
            tokenURIBytes[index] = prefixBytes[i];
            index++;
        }
        
        for (i = 0; i < tokenIdBytes.length; i++) {
            tokenURIBytes[index] = tokenIdBytes[i];
            index++;
        }
        
        return string(tokenURIBytes);
    }
}