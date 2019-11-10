<%-- JIB KARIMI
    Project 02--%>



<%@ Page Title="Home Page" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="Default.aspx.cs" Inherits="WebApplication1._Default" %>

<asp:Content ID="BodyContent" ContentPlaceHolderID="MainContent" runat="server">
    <div class="container">
        <div class="jumbotron">
            <h1>Find your Favorit Artist</h1>
            <p class="lead">
                Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqu
            </p>
            <p><a href="Artist.aspx" class="btn btn-primary btn-lg">Learn more &raquo;</a></p>
        </div>

        <div class="text-center defaultBox">
            <div class="col-md-5 " id="LineAround">
                <h2>Our Disk Inventory</h2>
                <p>
                    NuGet is a free Visual Studio extension that makes it easy to add, remove, and update libraries and tools in Visual Studio projects.
                </p>
                <p>
                    <a class="btn btn-default" href="Disk.aspx">Learn more &raquo;</a>
                </p>
            </div>
            <div class="col-md-5" id="LineAround">
                <h2>Our Borrower Page</h2>
                <p>
                    You can easily find a web hosting company that offers the right mix of features and price for your applica. reprehenderit in voluptate.
                </p>
                <p>
                    <a class="btn btn-default" href="Borrower.aspx">Learn more &raquo;</a>
                </p>
            </div>
        </div>
    </div>

</asp:Content>
