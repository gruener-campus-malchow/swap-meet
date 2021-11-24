<?php
class Api {
	private $db;
	private $json;
	private $debug;
	private $debugMessages;
	
    public function __construct(){
		$this->debug = FALSE;
		if($this->debug){
			$this->debugMessages = array();
		}
        header('Content-Type: application/json');
             
        $this->createTest();
        $this->testDB();
        
        if($this->debug){
			$this->json = json_encode($this->debugMessages);
		}
	}
    private function dbConnect(){
		# TODO: Config FILE with git-ignore
        $this->db = new PDO('mysql:host=localhost;dbname=strike_swap-meet', 'strike_swapmeet', '420');
        if ($this->debug){
			$this->debugMessages = array_merge(array(
				'errorcode' => $this->db->errorCode(),
				'errorinfo' => $this->db->errorInfo()
			), $this->debugMessages);
		}
        $this->json = json_encode($data);
    }
    private function executeSELECT($query){
		$statement = $this->db->prepare($query);
        $statement->execute();
        $data = $statement->fetchAll(PDO::FETCH_ASSOC);
        
	  if ($this->debug){
			$this->debugMessages = array_merge(array(
				'errorcode' => $this->db->errorCode(),
				'errorinfo' => $this->db->errorInfo()
			), $this->debugMessages);
		}
        
        return $data;
	}
	public function getJson()
	{
		return $this->json;
	}
	private function createTest(){
		$data = array(
			"foo" => "bar",
			"bar" => "foo",
		);
		$this->json = json_encode($data);
	}
	private function testDB(){
		$this->dbConnect();
		$data = $this->executeSELECT('SELECT * FROM item');
		$this->json = json_encode($data);
	}
	
}

$api = new Api();
echo $api->getJson();


?>
