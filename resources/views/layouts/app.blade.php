<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1">

    <!-- CSRF Token -->
    <meta name="csrf-token" content="{{ csrf_token() }}">

    <!-- <title>{{ config('app.name', 'Laravel') }}</title>-->

       <!-- Page title -->
    <title>Krece</title>

    <!-- Vendor styles -->
    <link rel="stylesheet" href="/themes/luna/vendor/fontawesome/css/font-awesome.css"/>
    <link rel="stylesheet" href="/themes/luna/vendor/animate/animate.css"/>
    <link rel="stylesheet" href="/themes/luna/vendor/bootstrap/css/bootstrap.css"/>

    <!-- App styles -->
    <link rel="stylesheet" href="/themes/luna/styles/pe-icons/pe-icon-7-stroke.css"/>
    <link rel="stylesheet" href="/themes/luna/styles/pe-icons/helper.css"/>
    <link rel="stylesheet" href="/themes/luna/styles/stroke-icons/style.css"/>
    <link rel="stylesheet" href="/themes/luna/styles/style.css">

    <!-- Scripts -->
    <script>
        window.Laravel = <?php echo json_encode([
            'csrfToken' => csrf_token(),
        ]); ?>
    </script>
</head>
   
<body class="blank">

<!-- Wrapper-->
<div class="wrapper">


    <!-- Main content-->
    <section class="content">
           <div class="container-center animated slideInDown">
           
              @yield('content')
        </div>
    </section>
    <!-- End main content-->

</div>

   <!-- Vendor scripts -->
<script src="/themes/luna/vendor/pacejs/pace.min.js"></script>
<script src="/themes/luna/vendor/jquery/dist/jquery.min.js"></script>
<script src="/themes/luna/vendor/bootstrap/js/bootstrap.min.js"></script>

<!-- App scripts -->
<script src="/themes/luna/scripts/luna.js"></script>

    <script src="/js/app.js">
      
    $(function()
    {
        var app={
            DOM: {},
            init: function(){
                if (window.location.pathname=='/register')
                {
                    this.DOM.form=$('form');
                    this.DOM.form.name=this.DOM.form.find('input[name="name"]');
                    this.DOM.form.email=this.DOM.form.find('input[name="email"]');
                    this.DOM.form.pwd=this.DOM.form.find('input[name="password"]');
                    this.DOM.form.pwdc=this.DOM.form.find('input[name="password_confirmation"]');

                    this.DOM.form.name.group=this.DOM.form.name.closest('.form-group');
                    this.DOM.form.email.group=this.DOM.form.email.closest('.form-group');
                    this.DOM.form.pwd.group=this.DOM.form.pwd.closest('.form-group');

                    this.DOM.submit(function(e)
                    {
                        e.preventDefault();
                        var self=this;
                        error={};

                        app.DOM.form.name.group.find('strong').text('');
                        app.DOM.form.email.group.find('strong').text('');
                        app.DOM.form.pwd.group.find('strong').text('');

                        app.DOM.form.name.group.removeClass('has-error');
                        app.DOM.form.email.group.removeClass('has-error');
                        app.DOM.form.pwd.group.removeClass('has-error');

                        var user={};
                        user.name=app.DOM.form.name.val();
                        user.email=app.DOM.form.email.val();
                        user.password=app.DOM.form.pwd.val();
                        user.password_confirmation=app.DOM.form.pwdc.val();

                        var request =$.ajax({
                                headers:{
                                    'X-CSRF-TOKEN':$('meta[name="csrf-token"]').attr(content)
                                },
                                url:'/validate/user',
                                type:'POST',
                                contentType:'application/json',
                                data: JSON.stringify(user)
                        });
                        request.done(function(data)
                        {
                            self.submit();
                        });
                        request.fail(function(jqXHR)
                        {
                            error=jqXHR.responseJSON;
                            if(error.name)
                            {
                                app.DOM.form.name.group.find('strong').text(error.name[0]);
                                app-DOM.form.name.group.addClass('has-error');
                            }
                            if(error.email)
                            {
                                app.DOM.form.email.group.find('strong').text(error.email[0]);
                                app-DOM.form.email.group.addClass('has-error');
                            }
                            if(error.password)
                            {
                                app.DOM.form.pwd.group.find('strong').text(error.password[0]);
                                app-DOM.form.pwd.group.addClass('has-error');
                            }
                        });
                    });
                }
            }
        }
        app.init();
    });

    </script>

</body>
</html>
