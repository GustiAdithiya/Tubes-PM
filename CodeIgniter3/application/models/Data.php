<?php
class Data extends CI_Model{
	public function kategoribyproduk(){
		$data=$this->db->query("select distinct idkategori,kategori from produk where st='1' and thumbnail <>''");
		$this->db->close();
		return $data->result();
	}
	public function subkategoribyproduk($id){
		$data=$this->db->query("select distinct idsubkategori,subkategori from produk where st='1' and idkategori='".$id."' and thumbnail <>''");
		$this->db->close();
		return $data->result();
	}
	public function produkbykategori($idk,$ids){
		$data=$this->db->query("select*from produk where idkategori='".$idk."' and idsubkategori like '%".$ids."%' and thumbnail <>'' and st='1' ");
		$this->db->close();
		return $data->result();
	}
	public function cabang($id){
		$data=$this->db->query("select*from cabang where userid like '%".$id."%'");
		$this->db->close();
		return $data->result();
	}
	public function pelanggan($id){
		$data=$this->db->query("select*from pelanggan p join signin s on p.userid=s.userid where p.userid like '%".$id."%'");
		$this->db->close();
		return $data->result();
	}
	public function login($user,$pass){
		$data=$this->db->query("select*from signin where userid='".$user."' and pass='".$pass."'");
		$this->db->close();
		return $data->result();
	}
	public function cabangbyuserid($id){
		$data=$this->db->query("select*from cabang where userid='".$id."'");
		$this->db->close();
		return $data->result();
	}
	public function pelangganbyuserid($id){
		$data=$this->db->query("select*from pelanggan where userid='".$id."'");
		$this->db->close();
		return $data->result();
	}
	public function produkbyfavorite($id){
		$data=$this->db->query("select f.userid,f.idproduk,p.* from favorite f join produk p on f.idproduk=p.id where userid='".$id."'");
		$this->db->close();
		return $data->result();
	}
	public function hapus_data($where,$table){
		$this->db->where($where);
		$this->db->delete($table);
	}
	public function transaksibypelanggan($id){
		$data=$this->db->query("select distinct nota, tanggal, st from penjualan where userid='".$id."'");
		$this->db->close();
		return $data->result();
	}
}
?>