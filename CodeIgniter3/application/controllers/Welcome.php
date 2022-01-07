<?php
defined('BASEPATH') OR exit('No direct script access allowed');

class Welcome extends CI_Controller {
	function __construct(){
		parent::__construct();
		$this->load->model("data");
	}

	function genNota($n,$kode){
		$has = "";
		$lbr = strlen($n);
		for($i = 1; $i <= 4 - $lbr; $i++){
			$has = $has."0";
		}
		return date("Y").date("m").date("d")."/".$has.$n.$kode;
	}

	function rp($rp){
		$a = $rp;
		$b = explode(".",$a);
		$rp = $b[0];
		if (count($b)>1) {
			$koma=$b[1];
		}else{
			$koma="";
		}
		$rupiah="";
		$p = strlen($rp);
		while($p>3){
			$rupiah = ".".substr($rp,-3).$rupiah;
			$l = strlen($rp)-3;
			$rp = substr($rp, 0,$l);
			$p = strlen($rp);
		}
		if($koma==""||$koma==0||$koma==00){
			$rupiah=$rp.$rupiah;
		}else{
			$rupiah=$rp.$rupiah.",".$koma;
		}

		if($rupiah==0||$rupiah=="0,00"){ $rupiah="";}
		return $rupiah;
	}

	public function index()
	{
		$this->load->view('welcome_message');
	}

	public function pages($judul=''){
		if($judul == "kategoribyproduk"){
			$sData = array();
			$data = $this->data->kategoribyproduk();
			foreach($data as $rs){
				$arr_row = array();
				$arr_row['id'] = (int)$rs->idkategori;
				$arr_row['nama'] = $rs->kategori."";
				$sData[] = $arr_row;
			}
			header('Content-Type: application/json');
			echo json_encode($sData, JSON_PRETTY_PRINT);
		}else if($judul == "subkategoribyproduk"){
			$sData = array();
			$data = $this->data->subkategoribyproduk($this->input->get('id'));
			foreach($data as $rs){
				$arr_row = array();
				$arr_row['id'] = (int)$rs->idsubkategori;
				$arr_row['nama'] = $rs->subkategori."";
				$sData[] = $arr_row;
			}
			header('Content-Type: application/json');
			echo json_encode($sData, JSON_PRETTY_PRINT);
		}
		else if($judul == "produkbykategori"){
			$sData = array();
			$data = $this->data->produkbykategori($this->input->get('idkategori'),$this->input->get('idsubkategori'));
			foreach($data as $rs){
				$arr_row = array();
				$arr_row['id'] = (int)$rs->id;
				$arr_row['idkategori'] = (int)$rs->idkategori;
				$arr_row['judul'] = $rs->judul."";
				$arr_row['harga'] = "Rp. ".$this->rp($rs->harga)."";
				$arr_row['hargax'] = (int)$rs->harga."";
				$arr_row['thumbnail'] = $rs->thumbnail."";
				$arr_row['deskripsi'] = $rs->deskripsi."";
				$sData[] = $arr_row;
			}
			header('Content-Type: application/json');
			echo json_encode($sData, JSON_PRETTY_PRINT);
		}else if($judul == "cabang"){
			$sData = array();
			$data = $this->data->cabang($this->input->get('userid'));
			foreach($data as $rs){
				$arr_row = array();
				$arr_row['id'] = (int)$rs->id;
				$arr_row['nama'] = $rs->nama."";
				$arr_row['alamat'] = $rs->alamat."";
				$arr_row['kota'] = $rs->kota."";
				$arr_row['provinsi'] = $rs->provinsi."";
				$arr_row['kodepos'] = $rs->kodepos."";
				$arr_row['telp'] = $rs->telp."";
				$arr_row['email'] = $rs->email."";
				$sData[] = $arr_row;
			}
			header('Content-Type: application/json');
			echo json_encode($sData, JSON_PRETTY_PRINT);
		}else if($judul == "cekprodukbycabang"){
			$data = $this->db->query("select*from stokcabang where idproduk='".$this->input->get('idproduk')."' and idcabang='".$this->input->get('idcabang')."'")->result();
			if($data){
				echo "OK";
			}else{
				echo "KOSONG";
			}
		}else if($judul=="login"){
			$sData = array();
			$status = "OK";
			$sData = array(
				"response_status"=>$status,
				"response_message"=>"",
				"data"=>array()
			);
			$user = $this->input->get('username');
			$pass = $this->input->get('password');
			$data = $this->data->login($user,$pass);
			if($data){
				foreach($data as $rs){
					$arr_row=array();
					$arr_row['username'] = $rs->userid;
					$arr_row['nama'] = $rs->nama;
					$arr_row['email'] = $rs->email."";
					$arr_row['level'] = $rs->level."";
					$arr_row['foto'] = $rs->foto."";
					if($rs->level=="2"){
						$datax = $this->data->cabangbyuserid($user);
						if($datax){
							foreach($datax as $rsx){
								$arr_row['alamat'] = $rsx->alamat."";
								$arr_row['kota'] = $rsx->kota."";
								$arr_row['telp'] = $rsx->telp."";
							}
						}
					}else if($rs->level=="3"){
						$datax = $this->data->pelangganbyuserid($user);
						if($datax){
							foreach($datax as $rsx){
								$arr_row['alamat'] = $rsx->alamat."";
								$arr_row['kota'] = $rsx->kota."";
								$arr_row['telp'] = $rsx->telp."";
							}
						}
					}
					$sData['data'][] = $arr_row;
				}
			}else{
				$sData['response_status'] = "Error";
				$sData['response_message'] = "Password Salah";
			}
			header('Content-Type: application/json');
			echo json_encode($sData, JSON_PRETTY_PRINT);
		}else if($judul == "klikbayar"){
			$query = $this->db->query("select jual from conter");
			$row = $query->result();
			$nota = $this->genNota($row[0]->jual,"J");
			$query = $this->db->query("update conter set jual=jual+1");

			$total = 0;
			$keterangan = "";
			$userid = "";
			$idcabang = "";
			$token = "";
			$email = "";
			$nama = "";

			$listkeranjang = json_decode($this->input->post('listkeranjang'));
			foreach ($listkeranjang as $key => $rs){
				//echo $rs->idproduk." ".$rs->judul." ".$rs->harga." ".$rs->hargax." ".$rs->jumlah." ".$rs->thumbnail." ".$rs->userid." ".$rs->idcabang;
				$this->db->query("insert into penjualan(nota,tanggal,idproduk,judul,harga,jumlah,thumbnail,userid,idcabang,st) values(
					'".$nota."',
					'".date("Y-m-d H:i:s")."',
					'".$rs->idproduk."',
					'".$rs->judul."',
					'".$rs->hargax."',
					'".$rs->jumlah."',
					'".$rs->thumbnail."',
					'".$rs->userid."',
					'".$rs->idcabang."',
					'1'
					
				)");
				// $total += $rs->hargax*$rs->jumlah;
				// $keterangan=$rs->judul." @".$this->rp($rs->hargax)." x ".$this->rp($rs->jumlah)." Rp.".$this->rp($rs->hargax);
				// $userid = $rs->userid;
				// $idcabang = $rs->idcabang;
			}
			echo "OK";
		}else if($judul == "produkbyfavorite"){
			$sData = array();
			$data = $this->data->produkbyfavorite($this->input->get('id'));
			foreach($data as $rs){
				$arr_row = array();
				$arr_row['id'] = (int)$rs->id;
				$arr_row['idkategori'] = (int)$rs->idkategori;
				$arr_row['judul'] = $rs->judul."";
				$arr_row['harga'] = "Rp. ".$this->rp($rs->harga)."";
				$arr_row['hargax'] = (int)$rs->harga."";
				$arr_row['thumbnail'] = $rs->thumbnail."";
				$arr_row['deskripsi'] = $rs->deskripsi."";
				$sData[] = $arr_row;
			}
			header('Content-Type: application/json');
			echo json_encode($sData, JSON_PRETTY_PRINT);
		}else if($judul == "cekprodukbyfavorite"){
			$data = $this->db->query("select*from favorite where idproduk='".$this->input->get('idproduk')."' and userid='".$this->input->get('userid')."'")->result();
			if($data){
				echo "OK";
			}else{
				echo "KOSONG";
			}
		}else if($judul == "savefavorite"){
			$data = array(
				'idproduk' => $this->input->post('idproduk'),
				'userid' => $this->input->post('userid'));
			$insert = $this->db->insert('favorite', $data);
			if ($insert) {
				echo "OK";
			}
		}else if($judul == "deletefavorite"){
			$data = array(
				'idproduk' => $this->input->post('idproduk'),
				'userid' => $this->input->post('userid'));
			$delete = $this->data->hapus_data($data,'favorite');
			echo "OK";
		}else if($judul == "transaksibynota"){
			$sData = array();
			$data = $this->data->transaksibynota($this->input->get('nota'));
			foreach($data as $rs){
				$arr_row = array();
				$arr_row['id'] = (int)$rs->id;
				$arr_row['nota'] = $rs->nota."";
				$arr_row['tanggal'] = $rs->tanggal."";
				$arr_row['idproduk'] = (int)$rs->idproduk;
				$arr_row['judul'] = $rs->judul."";
				$arr_row['harga'] = "Rp. ".$this->rp($rs->harga)."";
				$arr_row['hargax'] = (int)$rs->harga."";
				$arr_row['thumbnail'] = $rs->thumbnail."";
				$arr_row['jumlah'] = (int)$rs->jumlah;
				$arr_row['userid'] = $rs->userid."";
				$arr_row['idcabang'] = (int)$rs->idcabang;
				$arr_row['flag'] = $rs->flag."";
				$arr_row['st'] = $rs->st."";
				$sData[] = $arr_row;
			}
			header('Content-Type: application/json');
			echo json_encode($sData, JSON_PRETTY_PRINT);
		}else if($judul == "transaksibypelanggan"){
			$sData = array();
			$data = $this->data->transaksibypelanggan($this->input->get('id'));
			foreach($data as $rs){
				$arr_row = array();
				$arr_row['nota'] = $rs->nota."";
				$arr_row['tanggal'] = $rs->tanggal."";
				$arr_row['st'] = $rs->st."";
				$sData[] = $arr_row;
			}
			header('Content-Type: application/json');
			echo json_encode($sData, JSON_PRETTY_PRINT);
		}else if($judul == "pelanggan"){
			$sData = array();
			$data = $this->data->pelanggan($this->input->get('userid'));
			foreach($data as $rs){
				$arr_row = array();
				$arr_row['id'] = (int)$rs->id;
				$arr_row['nama'] = $rs->nama."";
				$arr_row['alamat'] = $rs->alamat."";
				$arr_row['kota'] = $rs->kota."";
				$arr_row['provinsi'] = $rs->provinsi."";
				$arr_row['kodepos'] = $rs->kodepos."";
				$arr_row['telp'] = $rs->telp."";
				$arr_row['email'] = $rs->email."";
				$arr_row['foto'] = $rs->foto."";
				$sData[] = $arr_row;
			}
			header('Content-Type: application/json');
			echo json_encode($sData, JSON_PRETTY_PRINT);
		}else if($judul == "register"){
			$data = array(
				'userid' => $this->input->post('userid'),
				'alamat' => $this->input->post('alamat'),
				'telp' => $this->input->post('telp'),
				'email' => $this->input->post('email'),
				'kota' => $this->input->post('kota'),
				'pass' => $this->input->post('pass'),
			);
			$insert = $this->db->query("insert into pelanggan(userid,nama,alamat,kota,telp,email) values('".$data['userid']."',
			'".$data['userid']."',
			'".$data['alamat']."',
			'".$data['kota']."',
			'".$data['telp']."',
			'".$data['email']."'
			)");

			$insert1 = $this->db->query("insert into signin(userid,pass,nama,level,email) values('".$data['userid']."',
			'".$data['pass']."',
			'".$data['userid']."',
			'3',
			'".$data['email']."'
			)");

			if ($insert && $insert1) {
				echo "OK";
			}
		}
	}
}
