<!-- Remove the container if you want to extend the Footer to full width. -->

<style>
  .zeria-footer {
    margin-top: 503px !important;
    }
  </style>
  <footer class="text-center text-lg-start zeria-footer" style="background-color: #808080;">
    <div class="container d-flex justify-content-center py-5">
      
    
      

    </div>
    
    <center><div class="text-center text-white p-3" style="background-color: rgba(0, 0, 0, 0.2);">
      We are probably good<center>

    <!-- Copyright -->
    <div class="text-center text-white p-3" >
      © <?php echo date("Y"); ?> Copyright:
      <a class="text-white" href="https://mulrbx.com">MULRBX</a><br>
      <?php $a=array("Designed by Apple in California","But hey, that's just a theory. a Game Theory! Thanks for watching!","asdfghjkl","Assembled in China","e","Our clients are made out of drywall", "You are currently in the year ".date("Y"));
        $random_keys=array_rand($a,4);
        echo $a[$random_keys[rand(0,4)]];
?>
    </div>
    <!-- Copyright -->
  </footer>
  
</div>
<!-- End of .container -->