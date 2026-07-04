// SPDX-License-Identifier: MIT
pragma solidity ^0.8.19;

/*
    Smart Contract: Daftar Hak Voting Pemegang Saham
    Fungsi:
    - Tambah pemegang saham
    - Update jumlah saham
    - Hitung hak voting berdasarkan saham
    - Voting keputusan perusahaan
*/

contract HakVotingSaham {

    address public owner;

    constructor() {
        owner = msg.sender;
    }

    struct PemegangSaham {
        string nama;
        uint jumlahSaham;
        bool terdaftar;
    }

    mapping(address => PemegangSaham) public daftarSaham;

    struct Voting {
        string judul;
        uint setuju;
        uint tidakSetuju;
        bool aktif;
    }

    Voting public votingSaatIni;

    mapping(address => bool) public sudahVoting;

    modifier onlyOwner() {
        require(msg.sender == owner, "Hanya owner");
        _;
    }

    // Tambah pemegang saham
    function tambahPemegangSaham(
        address _alamat,
        string memory _nama,
        uint _jumlahSaham
    ) public onlyOwner {
        daftarSaham[_alamat] = PemegangSaham(
            _nama,
            _jumlahSaham,
            true
        );
    }

    // Lihat hak voting
    function lihatHakVoting(address _alamat)
        public
        view
        returns(uint)
    {
        require(
            daftarSaham[_alamat].terdaftar,
            "Belum terdaftar"
        );

        return daftarSaham[_alamat].jumlahSaham;
    }

    // Mulai voting baru
    function mulaiVoting(string memory _judul)
        public
        onlyOwner
    {
        votingSaatIni = Voting(
            _judul,
            0,
            0,
            true
        );
    }

    // Pemegang saham voting
    function voting(bool pilihan) public {
        require(
            daftarSaham[msg.sender].terdaftar,
            "Bukan pemegang saham"
        );

        require(
            !sudahVoting[msg.sender],
            "Sudah voting"
        );

        require(
            votingSaatIni.aktif,
            "Voting tidak aktif"
        );

        uint hakSuara =
            daftarSaham[msg.sender].jumlahSaham;

        if (pilihan) {
            votingSaatIni.setuju += hakSuara;
        } else {
            votingSaatIni.tidakSetuju += hakSuara;
        }

        sudahVoting[msg.sender] = true;
    }

    // Tutup voting
    function tutupVoting() public onlyOwner {
        votingSaatIni.aktif = false;
    }

    // Hasil voting
    function hasilVoting()
        public
        view
        returns(
            string memory,
            uint,
            uint,
            bool
        )
    {
        return (
            votingSaatIni.judul,
            votingSaatIni.setuju,
            votingSaatIni.tidakSetuju,
            votingSaatIni.aktif
        );
    }
}