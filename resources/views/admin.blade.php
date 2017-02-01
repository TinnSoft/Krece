

@extends('home')

 <div class="wrapper wrapper-content">
        <div class="row">
            <div class="col-lg-3">
                <div class="ibox float-e-margins">
                    <div class="ibox-content mailbox-content">
                        <div class="file-manager">
                           
                            <div class="space-25"></div>
                            <h5>Impuestos</h5>
                            <ul class="folder-list m-b-md" style="padding: 0">
                                <li><a href="mailbox.html"> <i class="fa fa-inbox "></i> Impuestos </a></li>
                                <li><a href="mailbox.html"> <i class="fa fa-envelope-o"></i> Retenciones</a></li>
                            </ul>
                           
                            <div class="clearfix"></div>
                        </div>
                    </div>
                </div>
            </div>
            <div class="col-lg-9 animated fadeInRight">
                 @yield('content')  
               
            </div>
        </div>
        </div>
    </div>
</div>
