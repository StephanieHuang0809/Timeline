<%@ Page Title="" Language="C#" MasterPageFile="~/Root.Master" AutoEventWireup="true" CodeBehind="register.aspx.cs" Inherits="Timeline.register" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <script type="text/javascript" src="js/jquery.min2.js"></script>
    <script type="text/javascript" src="js/jquery.lavalamp-1.3.5.js"></script>

    <style type="text/css"">
         .compactlabel-wrapper {
			display: inline-block;
			position: relative;
		}
		
		.compactlabel-wrapper-on {
			z-index: 5;
		}
		
		.compactlabel-wrapper label {
			position: absolute;
			z-index: 4;
		}
		
		.compactlabel-wrapper label.compactlabel-hide {
			z-index: 2;
		}
		
		.compactlabel-wrapper input {
			position: relative;
			z-index: 3;
		}
		
		.compactlabel-label-backing {
			position: absolute;
			z-index: 1;
		}
		/* personalized styles */
		.compactlabel-label-backing {
			padding: 2px 3px 4px 3px;
			border-style: solid;
			border-width: 0px 0px 0 0px;
			-moz-border-radius-topleft: 3px;
			-moz-border-radius-topright: 3px;
			background-color: #e0e0e0;
			-webkit-transition: 1s background-color;
			
		}
		.compactlabel-wrapper label {
			font-family: "Lucida Sans Unicode", "Lucida Sans", "Lucida Grande", Arial, sans-serif;
			color: #555;
			padding: 4px;
			
			font-size: 14px;
		}
		
		.compactlabel-wrapper-on,
		.compactlabel-wrapper-on .compactlabel-label-backing {
			-moz-box-shadow: SkyBlue 0 0 5px;
			-webkit-box-shadow: SkyBlue 0 0 5px;
			box-shadow: SkyBlue 0 0 5px;
		}

        input[type="submit"], input[type="reset"]
        {
           display:inline;   
           float:none;
           height:30px;
           width:90px;
         }

		input[type=radio]{
        padding: 3px;
			margin: 0;
			border: solid #ddd 2px;
			background-color: #e0e0e0;
			font-family: "Lucida Sans Unicode", "Lucida Sans", "Lucida Grande", Arial, sans-serif;
			
			font-size: 12px;
        -moz-border-radius: 1px;
			-webkit-border-radius: 1px;
			border-radius: 1px;
			background-image: -moz-linear-gradient( 270deg, rgba(255,255,255,0), rgba(100,100,100,.15)  );
			-webkit-transition: 1s background-color, 1s border-color;

        }
		input[type=text] {
			padding: 3px;
			margin: 0;
			border: solid #ddd 2px;
			background-color: #e0e0e0;
			font-family: "Lucida Sans Unicode", "Lucida Sans", "Lucida Grande", Arial, sans-serif;
			font-size: 12px;
			-moz-border-radius: 1px;
			-webkit-border-radius: 1px;
			border-radius: 1px;
			background-image: -moz-linear-gradient( 270deg, rgba(255,255,255,0), rgba(100,100,100,.15)  );
			-webkit-transition: 1s background-color, 1s border-color;
		}
        input[type=text] {
			background-image: -webkit-gradient(linear, left bottom, left top, to(rgba(255,255,255,0)), from(rgba(100,100,100,.15)));
			outline: none;
		}

        input[type=text]:hover,
		input[type=text]:focus,
		.compactlabel-wrapper-on input,
		.compactlabel-wrapper-on .compactlabel-label-backing {
			background-color: #fff;
			border-color: #fff;
		}
		 #app_form {
			position: absolute;
			margin-left:115px;
			top: 110px;
			bottom: 120px;
			width: 570px;
            height:420px;			
		    padding: 60px 20px;
		    background-color:#E6E6E6;
			
			/*-moz-box-shadow: 0 0 50px #252525;
			-webkit-box-shadow: 0 0 5px rgba( 0, 0, 0, .5 );
			box-shadow: 0 0 5px rgba( 0, 0, 0, .5 );*/
			border: inset 2px rgba( 99, 99, 99, .02 );
		}
       
       #app_form {
			background: -webkit-gradient(linear, left top, left bottom, from(rgba( 55, 55, 55, 0 )), from(rgba( 55, 55, 55, .1 )));
		}
      
		
		#name,#ic{
			width: 150px;
		}
		
		#email,#street{
        
        width:314px;
        }
        #phone,#postal-code {
			width: 200px;
		}
		
		#city,
		#state
		{
			width: 150px;
		}
		
		p {
			margin: 0px;
            color:#585858;
            font-size:17px;
		}

</style>

    <script type="text/javascript">
    jQuery(document).ready(function () {

        // For all the inputs that are text inputs
        jQuery('input:text').each(function () {
            var $this = jQuery(this);

            // get the label
            var label = jQuery('label[for=' + this.id + ']');

            // If no label, then return to avoid errors
            if (label.size() == 0) {
                return;
            }

            // create wrapper element
            var wrapper = jQuery('<div class="compactlabel-wrapper"></div>');
            $this.wrap(wrapper);

            // move the label to before the the input
            $this.before(label);

            // create label backing
            var backing = jQuery('<div class="compactlabel-label-backing"></div>')
				.insertBefore($this)
				.height(label.height())
				.width(label.width());

            // basic style information
            var labelOffset = label.position(), inputOffset = $this.position(), labelHeight = label.outerHeight();

            // flag for if on or off
            var isHover = false, isFocus = false;

            // a jQuery object of the backing and label to animate both together
            var animatedElements = jQuery(backing.get()).add(label.get());


            // common functionality for hover on and focus on
            var on = function (event) {
                $this.parent().addClass('compactlabel-wrapper-on');
                animatedElements.stop().animate({ "top": '-' + (labelHeight - inputOffset.top) + 'px' });

            };

            // common functionality for hover off and focus off
            var off = function (event) {
                if (isHover || isFocus) {
                    return;
                }
                if (inputEmpty) {
                    label.removeClass('compactlabel-hide');
                } else {
                    label.addClass('compactlabel-hide');
                }

                if (!inputEmptyChange) {
                    animatedElements.stop();
                }

                animatedElements.animate(
					{ "top": labelOffset.top + 'px' },
					function () {
					    $this.parent().removeClass('compactlabel-wrapper-on')
					});
            };

            var onHover = function (event) {
                isHover = true;
                on(event);
            };

            var offHover = function (event) {
                isHover = false;
                off(event);
            };

            var onFocus = function (event) {
                isFocus = true;
                on(event);
            };

            var offFocus = function (event) {
                isFocus = false;
                off(event);
            };

            // The pieces for keeping track if the value of the input is empty
            var inputEmpty = false, inputEmptyStart = false, inputEmptyChange = false;
            var checkInputEmpty = function () {
                inputEmpty = $this.val() == '';
            };
            checkInputEmpty();
            // ID for setTimeout for checkInputEmpty
            var checkInputEmptyFnID = null;



            if (!inputEmpty) {
                label.addClass('compactlabel-hide');
            }

            // add the events
            // events to track if the value changed empty state	
            $this.focus(function () {
                inputEmptyStart = inputEmpty;
                inputEmptyChange = false;
                checkInputEmptyFnID = setInterval(checkInputEmpty, 50);
            });

            $this.blur(function () {
                clearInterval(checkInputEmptyFnID);
                checkInputEmpty();
                inputEmptyChange = inputEmptyStart != inputEmpty;
            });

            // animation events
            $this.focus(onFocus);
            $this.blur(offFocus);
            $this.hover(onHover, offHover);
            label.hover(onHover, offHover);

        });
    });
	
	</script>
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <div class="form">
    <form id="app_form"   name="application" action=""  onClick="validate">
    <p style="font-family: 'Comic Sans MS'; font-size: xx-large; font-weight: 900; color: #FFFFFF">
    Welcome to T:meLine</p>
    <p style="font-family: 'Comic Sans MS'; font-size: xx-large; font-weight: 900; color: #FFFFFF">
        <asp:LinkButton ID="LinkButton1" runat="server">Personal</asp:LinkButton>
&nbsp;<asp:LinkButton ID="LinkButton2" runat="server">Corporate</asp:LinkButton>
    </p>
    <p style="font-family: 'Comic Sans MS'; font-size: medium; font-weight: normal; color: #FFFFFF">
        &nbsp;</p>
    <p style="font-family: 'Comic Sans MS'; font-size: medium; font-weight: normal; color: #FFFFFF">
        <label for="fName">First Name</label>
        <asp:TextBox ID="firstName" runat="server" ></asp:TextBox>
    </p>
        </form>
        </div>
</asp:Content>
