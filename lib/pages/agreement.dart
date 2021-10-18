import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:flutterapp2/SharedPreferences/TokenStore.dart';
import 'package:flutterapp2/net/Address.dart';
import 'package:flutterapp2/net/HttpManager.dart';
import 'package:flutterapp2/net/ResultData.dart';
import 'package:flutterapp2/pages/IndexPage.dart';
import 'package:flutterapp2/pages/Mine.dart';
import 'package:flutterapp2/utils/JumpAnimation.dart';
import 'package:flutterapp2/utils/Rute.dart';
import 'package:flutterapp2/utils/Toast.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../main.dart';

class agreement extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return Login_();
  }
}

class Login_ extends State<agreement> {
  String old_pwd;
  String new_pwd;
  String re_pwd;
  bool check = false;
  FocusNode _commentFocus;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _commentFocus = FocusNode();
  }

  @override
  Widget build(BuildContext context) {
    ScreenUtil.instance = ScreenUtil(width: 417, height: 867)..init(context);

    // TODO: implement build
    return FlutterEasyLoading(
      child: Scaffold(
        appBar: AppBar(

          centerTitle: true,
          elevation: 0,
          iconTheme: IconThemeData(
            size: 25.0,
            color: Colors.white, //修改颜色
          ),
          backgroundColor: Color(0xfffa2020),
          title: Text("用户注册协议",style: TextStyle(fontSize: ScreenUtil().setSp(18)),),
        ),
        backgroundColor: Colors.white,
        body: ListView(
          children: <Widget>[
            Container(

              child: Center(
                child: Html(
                  data: """ <p style="margin-top:0;margin-right:0;margin-bottom:0;margin-left:0;text-indent:0"><span style=";font-family:Calibri;font-size:16pxfont-family:宋体">一、本站的服务内容</span></p><p style="margin-top:0;margin-right:0;margin-bottom:0;margin-left:0;text-indent:0"><span style=";font-family:Calibri;font-size:16pxfont-family:宋体">&nbsp; 本手机客户端彩票投注客户服务平台，依照本协议以下条款本平台登记注册的用户，并同意以下服务条款，方有资格享受本平台提供的账户管理、账户充值、彩票投注辅助等服务。</span></p><p style="margin-top:0;margin-right:0;margin-bottom:0;margin-left:0;text-indent:0"><span style=";font-family:Calibri;font-size:16pxfont-family:宋体"></span></p><p style="margin-top:0;margin-right:0;margin-bottom:0;margin-left:0;text-indent:0"><span style=";font-family:Calibri;font-size:16pxfont-family:宋体">二、服务协议的确定</span></p><p style="margin-top:0;margin-right:0;margin-bottom:0;margin-left:0;text-indent:0"><span style=";font-family:Calibri;font-size:16px"><span style="font-family:宋体">&nbsp; 根据相关法律、法规进行手机投注国家电脑型彩票业务，依照本协议以下条款本网站登记注册的高级用户（以下简称</span>&quot;<span style="font-family:宋体">用户</span><span style="font-family:Calibri">&quot;</span><span style="font-family:宋体">），并同意以下服务条款，方有资格享受本平台提供的电话投注辅助等服务，并受本协议条款的约束。三、用户信息的提供</span></span></p><p style="margin-top:0;margin-right:0;margin-bottom:0;margin-left:0;text-indent:0"><span style=";font-family:Calibri;font-size:16pxfont-family:宋体">为保障用户的合法权益，避免在中奖时因用户注册资料与真实情况不符而发生纠纷，请用户注册时务必按照真实、全面、准确的原则填写。对因用户自身原因而造成的不能兑奖、不能提款、不能注销等情况，由用户承担全部责任。如果用户提供的资料包含有不正确的信息，本平台保留结束该用户使用服务资格的权利。四、用户资料隐私本平台承诺对用户</span></p><p style="margin-top:0;margin-right:0;margin-bottom:0;margin-left:0;text-indent:0"><span style=";font-family:Calibri;font-size:16pxfont-family:宋体">注册之隐私信息绝对保密。未经用户授权或同意，不会将用户信息用于处理用户电话投注行为以外的其他活动，涉及相关法律事件除外。五、用户资料安全</span></p><p style="margin-top:0;margin-right:0;margin-bottom:0;margin-left:0;text-indent:0"><span style=";font-family:Calibri;font-size:16pxfont-family:宋体">&nbsp; 本平台对用户注册信息提供最大限度的安全保障。同时，用户务必对其用户密码、个人帐号等信息自行保密，免被盗用或窜改。用户如发现上述情况请立即与本平台联系。六、用户享有的权利</span></p><p style="margin-top:0;margin-right:0;margin-bottom:0;margin-left:0;text-indent:0"><span style=";font-family:Calibri;font-size:16px">&nbsp; 1<span style="font-family:宋体">、用户有权随时对个人登记资料进行查询、修改。为保护用户资金安全，所有注册用户名称不能更改。</span></span></p><p style="margin-top:0;margin-right:0;margin-bottom:0;margin-left:0;text-indent:0"><span style=";font-family:Calibri;font-size:16px">&nbsp; 2<span style="font-family:宋体">、用户可免费使用本平台所提供的电话投注服务，进行个人或集体彩票投注，或查询历史交易情况和帐户金额管理。</span><span style="font-family:Calibri">3</span><span style="font-family:宋体">、用户通过本平台委托代购彩票成功后两个月内，有权得到所购买的彩票原件，邮政快递费用由代购用户自理。合买用户不享有此项权利。</span></span></p><p style="margin-top:0;margin-right:0;margin-bottom:0;margin-left:0;text-indent:0"><span style=";font-family:Calibri;font-size:16px">&nbsp;4<span style="font-family:宋体">、用户通过本平台委托代购、合买彩票成功的，若彩票中奖，用户有权获得相应奖金。</span></span></p><p style="margin-top:0;margin-right:0;margin-bottom:0;margin-left:0;text-indent:0"><span style=";font-family:Calibri;font-size:16px">&nbsp;5<span style="font-family:宋体">、合买方案若中奖，该方案发起人将可按设定份额获得一定比例的税后奖金作为方案制作佣金。剩余的奖金在合买人之间分配，该佣金比例、奖金分配以及代购彩票等相关内容详见相关玩法细则。</span></span></p><p style="margin-top:0;margin-right:0;margin-bottom:0;margin-left:0;text-indent:0"><span style=";font-family:Calibri;font-size:16px">&nbsp;6<span style="font-family:宋体">、用户在任何时间都可对自己的预付款余额申请提款，本平台在核对用户资金来源正常的情况下，在收到提款请求</span><span style="font-family:Calibri">30</span><span style="font-family:宋体">个工作日内将用户预付款中需提取的款项转帐到用户注册的银行账户上。用户提款转帐所产生的银行费用由用户承担。</span></span></p><p style="margin-top:0;margin-right:0;margin-bottom:0;margin-left:0;text-indent:0"><span style=";font-family:Calibri;font-size:16px">&nbsp;7<span style="font-family:宋体">、用户可申请取消使用其注册的用户名，并注销其预付款账户。本平台在核对用户资料后，按用户要求将预付款余额返还给用户，并在</span><span style="font-family:Calibri">15</span><span style="font-family:宋体">个工作日内注销用户名和账户。七、用户应尽的义务</span></span></p><p style="margin-top:0;margin-right:0;margin-bottom:0;margin-left:0;text-indent:0"><span style=";font-family:Calibri;font-size:16px">&nbsp;1<span style="font-family:宋体">、用户不得利用本平台危害国家安全、泄露国家秘密，不得侵犯国家社会集体的和公民的合法权益，不得利用本平台制作、复制和传播下列信息</span><span style="font-family:Calibri">∶</span></span></p><p style="margin-top:0;margin-right:0;margin-bottom:0;margin-left:0;text-indent:0"><span style=";font-family:Calibri;font-size:16px"><span style="font-family:宋体">&nbsp; 一）煽动抗拒、破坏宪法和法律、行政法规实施的</span>;<span style="font-family:宋体">）</span></span></p><p style="margin-top:0;margin-right:0;margin-bottom:0;margin-left:0;text-indent:0"><span style=";font-family:Calibri;font-size:16px"><span style="font-family:宋体"><span style=";font-family:Calibri;font-size:16pxfont-family:宋体">&nbsp; 二）</span>煽动颠覆国家政权，推翻社会主义制度的</span><span style="font-family:Calibri">;</span><span style="font-family:宋体">）</span></span></p><p style="margin-top:0;margin-right:0;margin-bottom:0;margin-left:0;text-indent:0"><span style=";font-family:Calibri;font-size:16px"><span style="font-family:宋体">&nbsp; <span style=";font-family:Calibri;font-size:16pxfont-family:宋体"><span style=";font-family:Calibri;font-size:16pxfont-family:宋体">三）</span></span>煽动分裂国家、破坏国家统一的</span><span style="font-family:Calibri">;</span></span></p><p style="margin-top:0;margin-right:0;margin-bottom:0;margin-left:0;text-indent:0"><span style=";font-family:Calibri;font-size:16px"><span style="font-family:宋体">&nbsp; 四）煽动民族仇恨、民族歧视，破坏民族团结的</span>;<span style="font-family:宋体"><br/></span></span></p><p style="margin-top:0;margin-right:0;margin-bottom:0;margin-left:0;text-indent:0"><span style=";font-family:Calibri;font-size:16px"><span style="font-family:宋体">&nbsp; 五）捏造或者歪曲事实，散布谣言，扰乱社会秩序的</span><span style="font-family:Calibri">;</span><span style="font-family:宋体"><br/></span></span></p><p style="margin-top:0;margin-right:0;margin-bottom:0;margin-left:0;text-indent:0"><span style=";font-family:Calibri;font-size:16px"><span style="font-family:宋体">&nbsp;（六）宣扬封建迷信、淫秽、色情、赌博、暴力、凶杀、恐怖、教唆犯罪的</span><span style="font-family:Calibri">;</span></span></p><p style="margin-top:0;margin-right:0;margin-bottom:0;margin-left:0;text-indent:0"><span style=";font-family:Calibri;font-size:16px"><span style="font-family:宋体">&nbsp;（七）公然侮辱他人或者捏造事实诽谤他人的，或者进行其他恶意攻击的</span>;</span></p><p style="margin-top:0;margin-right:0;margin-bottom:0;margin-left:0;text-indent:0"><span style=";font-family:Calibri;font-size:16px"><span style="font-family:宋体">&nbsp;（八）损害国家机关信誉的</span>;</span></p><p style="margin-top:0;margin-right:0;margin-bottom:0;margin-left:0;text-indent:0"><span style=";font-family:Calibri;font-size:16px"><span style="font-family:宋体">&nbsp;（九）其他违反宪法和法律行政法规的</span>;<span style="font-family:宋体">（十）进行商业广告行为的。</span></span></p><p style="margin-top:0;margin-right:0;margin-bottom:0;margin-left:0;text-indent:0"><span style=";font-family:Calibri;font-size:16px"></span><br/></p><p style="margin-top:0;margin-right:0;margin-bottom:0;margin-left:0;text-indent:0"><span style=";font-family:Calibri;font-size:16px"><span style="font-family:宋体">&nbsp; 用户的的系统记录有可能作为用户违反法律的证据。</span>2<span style="font-family:宋体">、对应注册义务。一个用户名、一个身份证号、一个用户的真实姓名只能有效注册一次，且三者之间必须一一对应。严禁任何形式的重复注册及多次恶意注册，由此造成的一切后果由用户自行承担。</span></span></p><p style="margin-top:0;margin-right:0;margin-bottom:0;margin-left:0;text-indent:0"><span style=";font-family:Calibri;font-size:16pxfont-family:宋体">&nbsp; </span></p><p style="margin-top:0;margin-right:0;margin-bottom:0;margin-left:0;text-indent:0"><span style=";font-family:Calibri;font-size:16pxfont-family:宋体">&nbsp;同时，为保证用户操作预付款账户的安全性，用户应以一个银行卡帐号对应一个用户真实姓名名，因银行卡帐号与用户真实姓名不能一一对应而产生的不利后果，由用户自行承担。</span></p><p style="margin-top:0;margin-right:0;margin-bottom:0;margin-left:0;text-indent:0"><span style=";font-family:Calibri;font-size:16pxfont-family:宋体"></span></p><p style="margin-top:0;margin-right:0;margin-bottom:0;margin-left:0;text-indent:0"><span style=";font-family:Calibri;font-size:16px">3<span style="font-family:宋体">、保持用户名义务。为保护用户账户和预付款账户的安全性，用户名、用户真实姓名、身份证号码一经注册确认后，不得再行更改。</span></span></p><p style="margin-top:0;margin-right:0;margin-bottom:0;margin-left:0;text-indent:0"><span style=";font-family:Calibri;font-size:16px">4<span style="font-family:宋体">、预付款项义务。为避免因资金不能及时到帐导致延误购买彩票的情况，用户均必须设立预付款账户，并在账户中预先存入款项，方可提出代购请求。预付款账户设立和资金进出操作方式请查看相关网页细则。</span></span></p><p style="margin-top:0;margin-right:0;margin-bottom:0;margin-left:0;text-indent:0"><span style=";font-family:Calibri;font-size:16px">5<span style="font-family:宋体">、保护账户资料义务。用户账户资料包括用户密码、个人帐号以及用户帐号操作所需的资料。用户务必对其账户资料自行保密，以免帐号资料被盗用或篡改。用户因保护不周导致账户资料被盗用或篡改而造成的任何损失及法律责任由用户自行承担。</span></span></p><p style="margin-top:0;margin-right:0;margin-bottom:0;margin-left:0;text-indent:0"><span style=";font-family:Calibri;font-size:16px">6<span style="font-family:宋体">、承担银行费用的义务。在申请提取预付款或因合同终止返还预付款的情况下，款项从预付款账户转帐至用户银行卡的银行费用由用户承担。八、免责条款</span></span></p><p style="margin-top:0;margin-right:0;margin-bottom:0;margin-left:0;text-indent:0"><span style=";font-family:Calibri;font-size:16px"><span style="font-family:宋体">发生下列情况时，本平台不承担任何法律责任</span>∶</span></p><p style="margin-top:0;margin-right:0;margin-bottom:0;margin-left:0;text-indent:0"><span style=";font-family:Calibri;font-size:16px">1<span style="font-family:宋体">、用户资料泄露。由于用户将密码告知他人或与他人共享注册账户，或由于用户的疏忽，由此导致的任何个人资料泄露，以及由此产生的纠纷。无论何种原因导致的用户资料未授权使用、修改，用户密码、个人帐号或注册信息被未授权篡改、盗用而产生的一切后果，本平台不承担任何法律责任。</span></span></p><p style="margin-top:0;margin-right:0;margin-bottom:0;margin-left:0;text-indent:0"><span style=";font-family:Calibri;font-size:16px">2<span style="font-family:宋体">、不可抗力及不可预见的情势发生。不可抗力和不可预见情势包括</span><span style="font-family:Calibri">∶</span><span style="font-family:宋体">自然灾害、政府行为、罢工、战争等</span><span style="font-family:Calibri">;</span><span style="font-family:宋体">黑客攻击、计算机病毒侵入或发作、政府管制、彩票发行和销售机构的原因、彩票出票机或服务网络的故障、通信网络故障、国家政策变化、法律法规之变化等。因不可抗力和不可预见情势造成</span><span style="font-family:Calibri">∶</span><span style="font-family:宋体">网站暂时性关闭，用户资料或代购、合买委托指令泄露、丢失、被盗用、被篡改，委托代购、合买失败，本平台未能收到委托指令等，以及由此产生的纠纷，本平台不承担任何赔偿责任。因不可抗力和不可预见的情势造成本协议不能履行的，本平台不承担任何赔偿责任。</span></span></p><p style="margin-top:0;margin-right:0;margin-bottom:0;margin-left:0;text-indent:0"><span style=";font-family:Calibri;font-size:16px">3<span style="font-family:宋体">、用户原因或第三方原因造成损失。由于用户自身原因、或违反法律法规，以及第三方的原因，造成用户无法使用本平台服务或产生其他损失的，本平台不承担任何赔偿责任。</span><span style="font-family:Calibri">4</span><span style="font-family:宋体">、用户因代购、合买的彩票而产生的损失。用户根据本协议进行代购、合买委托投注而发生的直接、间接的损害，本平台不承担任何赔偿责任。</span></span></p><p style="margin-top:0;margin-right:0;margin-bottom:0;margin-left:0;text-indent:0"><span style=";font-family:Calibri;font-size:14px">5<span style="font-family:宋体">、用户使用链接或下载资料产生的损害。由于使用与本平台链接的其它网站，或者使用通过本平台下载或取得的资料，造成用户资料泄露、用户电脑系统损坏等情况及由此而导致的任何争议和后果，本平台不承担任何赔偿责任。</span><span style="font-family:Calibri">6</span><span style="font-family:宋体">、因网络故障、国家彩票机构限号、预付款金额不足等原因，本平台接受用户委托后，未能按用户委托完成代购出票的，无论用户预付款是否被冻结或划转，均视为本</span></span><span style=";font-family:Calibri;font-size:16pxfont-family:宋体">次代购或合买委托未完成，本平台对于上述原因造成的委托未完成不承担任何法律责任。用户预付款被冻结或划转的，本平台须在三个工作日内将冻结或划转的金额全额返还至用户预付款账户。</span></p><p style="margin-top:0;margin-right:0;margin-bottom:0;margin-left:0;text-indent:0"><span style=";font-family:Calibri;font-size:16pxfont-family:宋体">九、服务条款的修改和服务修订</span></p><p style="margin-top:0;margin-right:0;margin-bottom:0;margin-left:0;text-indent:0"><span style=";font-family:Calibri;font-size:16pxfont-family:宋体">本平台有权在必要时修改服务条款，服务条款一旦发生变动，将会在重要页面上提示修改内容。如果不同意所改动的内容，用户可以主动取消获得的服务。如果用户继续享用服务，则视为接受服务条款的变动。本平台保留随时修改或中断服务而不需知照用户的权利。</span></p><p><span style=";font-family:Calibri;font-size:14pxfont-family:宋体"></span><br/></p><p style="margin-top:0;margin-right:0;margin-bottom:0;margin-left:0;text-indent:0"><span style=";font-family:Calibri;font-size:16pxfont-family:宋体"></span><br/></p><p style="margin-top:0;margin-right:0;margin-bottom:0;margin-left:0;text-indent:0"><span style=";font-family:Calibri;font-size:16pxfont-family:宋体"></span>&nbsp;&nbsp;&nbsp;&nbsp; <br/></p><p><br/></p>  """,
                ),
              ),
            )

          ],
        ),
      ),
    );
  }
}
