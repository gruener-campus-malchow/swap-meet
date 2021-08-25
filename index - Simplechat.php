<?php
//$_SESSION['login'] = FALSE;
session_start();
class Website
{
    private $head;
    private $body;
    private $foot;

    public function __construct($title) //Konstruktor für Klasse wird eingeführt; wird aufgerufen, sobald ein Objekt der Klasse erstellt wird(siehe l. 56)
    {

        $this->head = '
        <!DOCTYPE html>
            <html lang="de">
                <head>
                    <meta charset="utf-8">
                    <meta name="viewport"content="width=device-        width,          initial-scale=1.0">
                    <title>' . $title . '</title>
                </head>
                <body>';

        $this->foot = "
                </body>
            </html>";

        $this->body = "";
    }

    public function getHtml()
    {
        return $this->head . $this->body . $this->foot; // gibt die html-Struktur des Dokumentes wieder
    }

    public function uebertragen()
    {
        $dbh = new PDO('mysql:host=localhost;dbname=strike_db', 'strike_ddb', 'j6RTu87twd4B95QE');
        if(isset($_GET['username'])){
            $_SESSION['name'] = $_GET['username'];
        }
            $usernameforid = $_SESSION['name'];
            $id_ergebnis = $dbh->query("SELECT id FROM users WHERE username = '$usernameforid'");
            $id_ergebnis = $id_ergebnis->fetch();
            $_SESSION['uid'] = $id_ergebnis['id'];
            $userid = $_SESSION['uid'];


        if(isset($_GET['username'])){
            $statement = $dbh->prepare('SELECT secret FROM users WHERE username = ?');


            $statement = $dbh->prepare('SELECT COUNT(username) FROM users WHERE username = :bp_username AND secret = :bp_password');
            $statement->bindParam(':bp_username',$_GET['username']);
            $statement->bindParam(':bp_password',$_GET['password']);

            $ergebnis = $statement->execute();
            if ($statement->fetchColumn() == 1){
                $this->body .= 'zugangsdaten in DB gefunden';
                $_SESSION['login'] = TRUE;
            }
            else{
                $this->body .= 'Keine richtigen Login Daten eingegeben';
            }
        }
            if($_SESSION['login'] === TRUE){ //start of monster if-clause
                //
                $this->body .=  '<form method="GET">
                                 <label>Chats:
                                 <select name="select" onchange="this.form.submit()">
                                 <option>Bitte Auswählen</option>';

                $chatanzahl = $dbh->query('SELECT id FROM chats');
                $count = $chatanzahl->rowCount();
                $test42 = 0;
                while($count > $test42){
                    $chat = $dbh->query("SELECT chat FROM chats WHERE id = '$test42'");
                    $chat = $chat->fetch();
                    $auswahl = $chat["chat"];
                    $this->body .= '<option value="'.$auswahl.'">'.$chat["chat"].'</option>';
                    $test42++;
                }

                $this->body .= '
                                    </select>
                                </label>
                    </form>';

                    if($_GET['select'] == "computer"){
                    $chat_id = 1;
                    $ergebnis = $dbh->query("SELECT * FROM chatverlauf WHERE chat_id = '$chat_id'");

                    while ($zeile = $ergebnis->fetch()) {
                        $usernameid = $zeile['user'];
                        $ergebnisname = $dbh->query("SELECT username FROM users WHERE id = '$usernameid'");
                        $ergebnisname = $ergebnisname->fetch();
                        $content  = '<div>' . $zeile['timecode'] . ' ' .  $ergebnisname['username'] . ': ' . $zeile['message'] . '</div>';
                        $this->body .= $content;
                        }

                        $vorbereitung = $dbh->prepare("INSERT INTO chatverlauf (id, timecode, message, user, chat_id) VALUES (NULL, CURRENT_TIMESTAMP, ?, '$userid', '$chat_id')"); // user id wird später noch zu euner Variable geändert
                    $vorbereitung->execute(array(htmlentities($_GET['field'])));

                        $this->body .= "<form method='GET'>
                        <input name='field' placeholder ='Nachricht'>
                        <br>
                        <input type='submit' value='Nachricht Absenden'>
                        <input type=hidden name=select value='" . htmlspecialchars($_GET['select']) . "'>
                        </form>";

                }
                if($_GET['select'] == "food"){
                    $chat_id = 0;
                    $ergebnis = $dbh->query("SELECT * FROM chatverlauf WHERE chat_id = '$chat_id'");
                    while ($zeile = $ergebnis->fetch()) {
                        $usernameid = $zeile['user'];
                        $ergebnisname = $dbh->query("SELECT username FROM users WHERE id = '$usernameid'");
                        $ergebnisname = $ergebnisname->fetch();
                        $content  = '<form method="GET"><div>' . $zeile['timecode'] . ' ' . $ergebnisname['username'] . ': ' . $zeile['message'] .  '</div>
                        <input type="submit" name=" ' . $zeile["id"] . ' " value="edit"> 
                        <input type="hidden" name= "chat_id" value= "'.$chat_id.'"> 
                         <input type="hidden" name= "message_id" value= "'.$zeile['id'].'"> 
                        </form>';

                        $this->body .= $content;
                    }
                    $vorbereitung = $dbh->prepare("INSERT INTO chatverlauf (id, timecode, message, user, chat_id) VALUES (NULL, CURRENT_TIMESTAMP, ?, '$userid', '$chat_id')");
                    $vorbereitung->execute(array(htmlentities($_GET['field'])));

                    $this->body .= "<form method='GET'>
                        <input name='field' placeholder ='Nachricht'>
                        <br>
                        <input type='submit' value='Nachricht Absenden'>
                    <input type=hidden name=select value='" . htmlspecialchars($_GET['select']) . "'></form>";


                } else if(isset($_GET["chat_id"])) {

                    //$dbh->beginTransaction();
                    $query = $dbh->prepare("SELECT message FROM chatverlauf WHERE user = ? AND id = ?");
                    $query->bindParam(1, $userid);
                    $query->bindParam(2, $_GET['message_id']);
                    $query->execute();
                    $result = $query->fetch();

                    $this->body .= '<form>


                            <textarea method = "GET" rows="4" cols="50" name = "updated_message"> ' . $result[0]   . '</textarea>
                            <br>
                             <input type="submit" value="speichern" name="speichern">
                             <input type="hidden" name= "message_id" value = " ' . $_GET["message_id"] . ' " >
                       </form>';
                    //$_SESSION['db-object']=$dbh;
               }
               else if($_GET['speichern'] == 'speichern')
               {
                   $update = $dbh->prepare("UPDATE chatverlauf SET message = ? WHERE user = ? AND id = ?");
                   $update->bindParam(1, $_GET['updated_message']);
                   $update->bindParam(2, $userid);
                   $update->bindParam(3, $_GET['message_id']);
                   $update->execute();
                   if ($update) { print("did something good!");       }
                   //$dbh->commit();
               }


            }//end of monster if-clause
        else{
            $this->body .= "<form method='GET'>
                        <input name='username' placeholder ='Benutzername'>
                        <br>
                        <input name='password' placeholder ='Passwort' type='password'>
                        <br>
                        <input type='submit' value='login'>
                        </form>";
        }
        }
}
$mySite = new Website("SimpleChat");
$mySite->uebertragen();
echo $mySite->getHtml();
?>
