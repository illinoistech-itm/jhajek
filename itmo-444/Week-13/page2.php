<?php
// page2.php

session_start();

echo 'Welcome to page #2<br />';

echo $_SESSION['favcolor']; // green
echo $_SESSION['animal'];   // cat
echo date('Y m d H:i:s', $_SESSION['time']);

// You may want to use SID here, like we did in page1.php
echo '<br /><a href="page1.php">page 1</a>';


?> 

<form method="post">
<fieldset>
        <legend>What is Your Favorite Pet?</legend>
                <input type="radio" name="animal" value="Cat" />Cats<br />
                <input type="radio" name="animal" value="Dog" />Dogs<br />
                <input type="radio" name="animal" value="Bird" />Birds<br />
                <input type="submit" value="Submit now" />
</fieldset>
</form>
