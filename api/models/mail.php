<?php
require_once('model.php');
class mail extends model{

	public function readSpecial(){
		//require_once('./config.php');
		//$data = Config;
		//return $data::$dbHost;
		$data = $this->request;
		return $data;
	}

	public function create()
	{
		
			//this method have to be implemented with special model
		return TRUE;
		
	}
	
	public function readSingle($foo)
	{
		
		return array("E-MailService is alive.");
		
	}

	public function postSpecial()
	{
		$data = $this->request;
		// loading user data
		switch ($this->request[3]) {
			
			case 'request': 
			
				$query = 'SELECT contact_mail FROM item WHERE id = '.$this->request[2];		
				$statement = $this->db->prepare($query);
				$statement->execute();
				$data = $statement->fetchAll(PDO::FETCH_ASSOC);
					
				return array("wanna send a mail to: ", $data);			
			break;
			default:
				return array("this method have to be implemented with special model", $data);			
			
		}
		

		
	}

	
}
?>
