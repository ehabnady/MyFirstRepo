<%@ Page Title="Bausch Credentials" Language="C#" MasterPageFile="~/Site1.Master" AutoEventWireup="true" CodeBehind="Bausch.aspx.cs" Inherits="AmounCRM4.Admins.Bausch" %>

<asp:Content ID="Content1" ContentPlaceHolderID="Head" runat="server">
    <title>Bausch Credentials</title>
    <style type="text/css">
        .auto-style3 {
            text-decoration: underline;
        }

        .auto-style4 {
            width: 624px;
            height: 204px;
        }

        .auto-style5 {
            direction: ltr;
        }

        .auto-style6 {
            color: #3366FF;
        }
    </style>
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="Body" runat="server">
    <asp:SqlDataSource runat="server" ID="sqlDS_Bausch"
        ConnectionString='<%$ ConnectionStrings:AmounCRM2ConnectionString10101423 %>'
        SelectCommand="SELECT [RecID], [EmployeeHRCode], [EmployeeUserName], [EmployeePassword], [Deleted], [EmployeeUN], [EmployeePWD] FROM [EmployeesBauschCredential] 
        WHERE ([EmployeeHRCode] = @EmployeeHRCode))">
        <SelectParameters>
            <asp:Parameter Name="EmployeeHRCode" Type="Int32"></asp:Parameter>
        </SelectParameters>
    </asp:SqlDataSource>

    <br />

    <div>
        <br />
        <br />
    </div>

    <telerik:RadPanelBar runat="server" ID="RadPanelBar1" Width="100%" Height="800px" ExpandMode="FullExpandedItem">
        <Items>
            <telerik:RadPanelItem Text="Emails" Expanded="true" Visible="true" Width="98%">
                <ContentTemplate>
                    <table style="text-align:center">
                        <tr style="visibility: hidden; text-align:left">
                            <td style="visibility: hidden; text-align:left; width: 10%">
                                <asp:Label ID="Label2" runat="server" Text="HR Code: " Font-Bold="True" Font-Size="X-Large"></asp:Label>
                            </td>
                            <td style="visibility: hidden; text-align:left; width: 90%">
                                <asp:Label ID="Label3" runat="server" Text='<%# Eval("EmployeeHRCode") %>'
                                    Font-Size="X-Large" Font-Bold="True" ForeColor="#0099FF"></asp:Label>
                            </td>
                        </tr>

                        <tr>
                            <td style="text-align:left; width: 10%">
                                <asp:Label ID="Label4" runat="server" Text="Email: " Font-Bold="True" Font-Size="X-Large"></asp:Label>
                            </td>
                            <td style="text-align:left; width: 90%">
                                <asp:Label ID="Label5" runat="server" Text='<%# Eval("EmployeeUN") %>' Font-Bold="True" Font-Size="X-Large" ForeColor="#0099FF"></asp:Label>
                            </td>
                        </tr>

                        <tr>
                            <td style="text-align:left; width: 10%">
                                <asp:Label ID="Label6" runat="server" Text="Password: " Font-Bold="True" Font-Size="X-Large"></asp:Label>
                            </td>
                            <td style="text-align:left; width: 90%">
                                <asp:Label ID="Label7" runat="server" Text='<%# Eval("EmployeePWD") %>' Font-Bold="True" Font-Size="X-Large" ForeColor="#0099FF"></asp:Label>
                            </td>
                        </tr>

                        <tr>
                            <td colspan="2" align="left" style="font-size: x-large">
                                <br />
                                <h3><u>How to use AmounEG Mail</u></h3>

                                From your web browser<br />
                                <ol>
                                    <li>Open your Browser and go to <a href="https://mail.amoun.eg:2096">https://mail.amoun.eg:2096</a> </li>
                                    <li>Type in your E-mail and password and press login as shown below.<br />
                                        <img src="../pic1.png" alt="Welcome" /></li>
                                    <li>Click on Roundcube<br />
                                        <img src="../pic2.png" alt="Roundcube" /></li>
                                    <li>Now you can open your mailbox, you will find the training invitation, open it and click on “Join Microsoft Teams Meeting”
                        <br />
                                        <img src="../Capture.png" alt="Capture" width="70%" />
                                    </li>
                                </ol>



                                <br />
                                <br />
                                Now you can access, enjoy dear
                            </td>
                        </tr>
                    </table>
                </ContentTemplate>
            </telerik:RadPanelItem>

            <telerik:RadPanelItem Text="HR Central" Expanded="true" Visible="true" Width="98%">
                <ContentTemplate>



                    <table style="-ms-word-wrap: break-word; word-wrap: break-word;">
                        <tr>
                            <td colspan="2" align="left" style="font-size: x-large">Hi
                                <asp:Label Text="" runat="server" ID="lblName" />, 
                <br />
                                <br />
                                Please open Chrome browser and paste the below link
                <br />
                                <a href="https://bauschhealth.service-now.com/hrcentral">https://bauschhealth.service-now.com/hrcentral</a><br />
                                <br />
                                The windows will request you to login, please use the below login details
                <br />
                                <br />
                            </td>
                        </tr>
                        <tr style="visibility: hidden">
                            <td align="right">
                                <asp:Label ID="lblHRCode" runat="server" Text="HR Code: " Font-Bold="True" Font-Size="X-Large"></asp:Label>
                            </td>
                            <td align="left">
                                <asp:Label ID="lblHRCode_Val" runat="server" Text='<%# Eval("EmployeeHRCode") %>'
                                    Font-Size="X-Large" Font-Bold="True" ForeColor="#0099FF"></asp:Label>
                            </td>
                        </tr>

                        <tr>
                            <td align="right">
                                <asp:Label ID="lblUserName" runat="server" Text="User Name: " Font-Bold="True" Font-Size="X-Large"></asp:Label>
                            </td>
                            <td align="left">
                                <asp:Label ID="lblUserName_Val" runat="server" Text='<%# Eval("EmployeeUserName") %>' Font-Bold="True" Font-Size="X-Large" ForeColor="#0099FF"></asp:Label>
                            </td>
                        </tr>

                        <tr>
                            <td align="right">
                                <asp:Label ID="lblPassword" runat="server" Text="Password: " Font-Bold="True" Font-Size="X-Large"></asp:Label>
                            </td>
                            <td align="left">
                                <asp:Label ID="lblPassword_Val" runat="server" Text='<%# Eval("EmployeePassword") %>' Font-Bold="True" Font-Size="X-Large" ForeColor="#0099FF"></asp:Label>
                            </td>
                        </tr>

                        <tr>
                            <td colspan="2" align="left" style="font-size: x-large">
                                <br />
                                To Enter the success factor directly copy and paste the below link
                                <br />
                                <a href="https://performancemanager.successfactors.eu/sf/home?company=Bausch&Loginmethod=SSO">https://performancemanager.successfactors.eu/sf/home?company=Bausch&Loginmethod=SSO</a>
                                <br />
                                <br />
                                Now you can access, enjoy dear</td>
                        </tr>
                    </table>

                    <table style="width: 90%; text-align: center; -ms-word-wrap: break-word; word-wrap: break-word;">
                        <tr>
                            <td align="left" class="auto-style5" style="font-size: x-large">
                                <br />
                                Please note that 
                <strong>if you have not already completed this training, the deadline has been extended to Feb. 14</strong>
                                All employees and contractors of Bausch Health Companies are required to report all medical device product complaints and adverse events related to any Bausch Health product.
 
                <br />
                                <br />
                                To provide this training, Bausch Health Global Device Complaints Management (GDCM)  has developed an online course available 24 hours a day, 7 days a week. 
                <br />
                                This mandatory training covers Bausch Health procedures for reporting  product complaints and adverse events.   
                <br />
                                The training will last approximately 20 minutes and includes an assessment which must be passed by answering at least 8 out of 10 questions correctly. 
 
                <br />
                                <br />
                                <span class="auto-style3"><strong>If you have a ComplianceWire account, you must take this training in ComplianceWire to receive credit for the training.</strong></span>
                                <br />
                                <br />
                                Please note that if you choose to view the training in a language other than English, you must click on your name in ComplianceWire, then choose “Language Settings”, choose your preferred language, then click save.
 
                <br />
                                <br />
                                <strong>***IF YOU ARE A COMPLIANCEWIRE USER, PLEASE TAKE THIS TRAINING THROUGH COMPLIANCEWIRE and DISREGARD THE REST OF THIS NOTIFICATION***
 
                                </strong>
                                <br />
                                <br />
                                For all Bausch Health colleagues who do <span class="auto-style3"><strong>not</strong></span> have a ComplianceWire account, please complete the mandatory Training through the online training course available in Brainshark by using the links below the instructions.<br />
                                <br />
                                <span class="auto-style3"><strong>Brainshark instructions </strong></span><em>(Only If you do not have a ComplianceWire account):  
                <br />
                                    <br />
                                </em><span class="auto-style3"><strong>To get started:
                <br />
                                    <br />
                                </strong></span>Click on the applicable link in the table below for your preferred language.<br />
                                <br />
                                <ul>
                                    <li>You will be asked to complete a guest book. The guest book must be filled out in order to receive credit for taking this course including your Last Name, First Name, Company, Country and Email Address.
                        <p style="width: 90%; text-align: center">
                            <img src="../BrainShark.JPG" alt="Bausch Health Promo" align="middle" />
                        </p>
                                    </li>
                                    <li>Please ensure that you spend enough time on each slide to read and comprehend the material. You must press play to advance to the next slide. <strong>Note that there is no audio or video for this presentation and you can only move forward once you start the presentation.</strong></li>
                                </ul>
                                <br />
                                <br />
                                <span class="auto-style3"><strong>Assessment and Meeting Criteria</strong></span>
                                <br />
                                <ul>
                                    <li>At the end of the presentation there will be a 10 question quiz which must be passed by answering at least 8 questions correctly.</li>
                                    <li>You must click the “submit” button on each question to advance to the next question.</li>
                                    <li>After you answer question 10 of the quiz, you will not be able to continue any further. The completion criteria for this training will be met once the User views all slides and answers at least 8 out of 10 questions correctly. Once completion criteria has been met, a green check mark and notification will appear on the left of the training window denoting that completion criteria has been met.  Please see screen shot below.</li>
                                </ul>
                                <p style="text-align: center">
                                    <img alt="Completion" class="auto-style4" src="../Completion.jpg" /><br />
                                </p>
                                <div class="auto-style5">
                                    <ul>
                                        <li>At that point, you have successfully completed the required training and you may download your certificate of completion by clicking on the download arrow or view your completion results by clicking on the eye button.</li>
                                    </ul>
                                    <br />

                                    <table border="1" style="border: thin solid #000000">
                                        <tr>
                                            <td>Language</td>
                                            <td>Link to Training - Brainshark</td>
                                        </tr>
                                        <tr>
                                            <td>Arabic</td>
                                            <td><a href="https://www.brainshark.com/corialabs/vu?pi=zHozxioM2zcKe9z0">https://www.brainshark.com/corialabs/vu?pi=zHozxioM2zcKe9z0</a></td>
                                        </tr>
                                        <tr>
                                            <td>Bulgarian</td>
                                            <td><a href="https://www.brainshark.com/corialabs/vu?pi=zHfz11RDUyzcKe9z0">https://www.brainshark.com/corialabs/vu?pi=zHfz11RDUyzcKe9z0</a></td>
                                        </tr>
                                        <tr>
                                            <td>English</td>
                                            <td><a href="https://www.brainshark.com/corialabs/vu?pi=zHyz9ZjhtzcKe9z0">https://www.brainshark.com/corialabs/vu?pi=zHyz9ZjhtzcKe9z0</a></td>
                                        </tr>
                                        <tr>
                                            <td>French</td>
                                            <td><a href="https://www.brainshark.com/corialabs/vu?pi=zFkzAD9NEzcKe9z0">https://www.brainshark.com/corialabs/vu?pi=zFkzAD9NEzcKe9z0</a></td>
                                        </tr>
                                        <tr>
                                            <td>German</td>
                                            <td><a href="https://www.brainshark.com/corialabs/vu?pi=zGxz3IOXxzcKe9z0">https://www.brainshark.com/corialabs/vu?pi=zGxz3IOXxzcKe9z0</a></td>
                                        </tr>
                                        <tr>
                                            <td>Italian</td>
                                            <td><a href="https://www.brainshark.com/corialabs/vu?pi=zGJz5sHP3zcKe9z0">https://www.brainshark.com/corialabs/vu?pi=zGJz5sHP3zcKe9z0</a></td>
                                        </tr>
                                        <tr>
                                            <td>Korean</td>
                                            <td><a href="https://www.brainshark.com/corialabs/vu?pi=zHpzlshW2zcKe9z0">https://www.brainshark.com/corialabs/vu?pi=zHpzlshW2zcKe9z0</a></td>
                                        </tr>
                                        <tr>
                                            <td>Polish</td>
                                            <td><a href="https://www.brainshark.com/corialabs/vu?pi=zHazapFDfzcKe9z0">https://www.brainshark.com/corialabs/vu?pi=zHazapFDfzcKe9z0</a></td>
                                        </tr>
                                        <tr>
                                            <td>Portuguese</td>
                                            <td><a href="https://www.brainshark.com/corialabs/vu?pi=zGczH6o6czcKe9z0">https://www.brainshark.com/corialabs/vu?pi=zGczH6o6czcKe9z0</a></td>
                                        </tr>
                                        <tr>
                                            <td>Serbian</td>
                                            <td><a href="https://www.brainshark.com/corialabs/vu?pi=zGUzZObszcKe9z0">https://www.brainshark.com/corialabs/vu?pi=zGUzZObszcKe9z0</a></td>
                                        </tr>
                                        <tr>
                                            <td>Spanish</td>
                                            <td><a href="https://www.brainshark.com/corialabs/vu?pi=zGszSSN4nzcKe9z0">https://www.brainshark.com/corialabs/vu?pi=zGszSSN4nzcKe9z0</a></td>
                                        </tr>
                                    </table>

                                    &nbsp;<br />
                                    If you have any questions, please email the Bausch Health Global Device Complaints Management Team at 
                    <a href="mailto:support@brainshark.com">globaldevicecomplaints@bauschhealth.com</a>globaldevicecomplaints@bauschhealth.com In the event that you experience any technical difficulties, while taking the training in Brainshark, you may also contact Brainshark support at 
                    <a href="mailto:support@brainshark.com">support@brainshark.com</a> or by calling 781-370-8222 between 8 a.m. to 9 p.m. EST, Monday – Friday.
                    <br />
                                    <br />
                                    <em><strong><span class="auto-style6">Please do not contact “Corporate Communications” or” Corporate Compliance” regarding this training as it is separate from the corporate compliance training. </span>
                                        <br class="auto-style6" />
                                    </strong></em>
                                    <br />
                                    We thank you for your attention to this correspondence and for completing this mandatory training.
                    <br />
                                    <br />
                                    Best Regards,
                    <br />
                                    <br />
                                    Bausch Health Global Device Complaints Management Team
                    <br />
                                </div>

                            </td>
                        </tr>
                    </table>



                </ContentTemplate>
            </telerik:RadPanelItem>

        </Items>
    </telerik:RadPanelBar>

</asp:Content>
