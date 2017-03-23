<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1">

    <!-- CSRF Token -->
    <meta name="csrf-token" content="{{ csrf_token() }}">

       <!-- Page title -->
    <title>Krece</title>


    {!!Html::style('/themes/krece/css/bootstrap.min.css')!!}
    {!!Html::style('/themes/krece/font-awesome/css/font-awesome.css')!!}
    {!!Html::style('/themes/krece/css/animate.css')!!}
    {!!Html::style('/themes/krece/css/style.css')!!}

    <!-- Scripts -->
    <script>
        window.Laravel = <?php echo json_encode([
            'csrfToken' => csrf_token(),
        ]); ?>
    </script>
</head>
   
<body class="gray-bg">


      <div class="row wrapper border-bottom white-bg page-heading">
                <div class="col-lg-10">
                    <img alt="image" src="/logo_green.png" style="width: 175px" height="85px" />
                    
                </div>
                <div class="col-lg-2">
                    <span>Necesitas ayuda?</span><br>
                    <a href="" class="btn btn-primary btn-sm "> 
                       &nbsp;!Contáctanos!
                    </a> 
                </div>
            </div>

<!-- Wrapper-->
<div class="loginColumns ">
    <!-- Main content-->
    <div class="row">
            <div class="col-md-6">
                @yield('leftcontent')
            </div>
            <div class="col-md-6">
                <div class="ibox-content">
                    @yield('content')
                </div>
            </div>
      </div>

    <!-- End main content-->

</div>

   <!-- Vendor scripts -->
{!!Html::script('/themes/krece/js/jquery-3.1.1.min.js')!!}
{!!Html::script('/themes/krece/js/bootstrap.min.js')!!} 




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
<div class="footer">
                <div class="pull-right">
                   Herramienta de facturación en la nube
                </div>
                <div>
                    <small>Diseñado y desarrollado por <a href='http://www.tinnsoft.com/'>Tinnsoft</a>.</small>
                </div>
            </div>
</html>
