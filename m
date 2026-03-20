Received: from mx2.ferchau.com (smtp.ablegroup.de [212.211.156.0])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F3C7E32E6BD
	for <linux-rt-devel@lists.linux.dev>; Fri, 20 Mar 2026 19:24:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=212.211.156.0
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774034661; cv=fail; b=dKvc+RyKLw+Etxh1z8a43HQy/ZVmunFWXHeu2Ofa2XbpcJL5D9+g+j/7xVy1RopZJQV9uEUlisSfzJewebFMZWVVzpPhQbzfS3gOU1qaXcrQm/36TEFAQjzlRIBU0N3YXeiP7igO+W2K4fFr+jd8bnCCUyVALwjl8KTSmLGOwgA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774034661; c=relaxed/simple;
	bh=f4Ayng+5lAKpZMTxm5pLJHWMyIThxAHil4Sg9z1P+o8=;
	h=From:To:CC:Subject:Date:Message-ID:Content-Type:MIME-Version; b=N0L87hDnHvbBdnll1/jZ8Pi3Zy8Txk9+yKc7nFsIoZs6bP2L08wapHklrV8u6hh1fIFqObRQNx4FZ/mcogCBnh2uI8TbuCfVzT2iaGpAJ1RRw+rSKpHiTKP9n8XzqYV5rpA3nN2D4PxrprU8n6DNq4tV0jXFV1iQCG77ipAlHao=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ferchau.com; spf=pass smtp.mailfrom=ferchau.com; dkim=pass (2048-bit key) header.d=ferchau.com header.i=@ferchau.com header.b=qZ/J+mId; dkim=pass (1024-bit key) header.d=ablegroupde.onmicrosoft.com header.i=@ablegroupde.onmicrosoft.com header.b=JJhDPXT6; arc=fail smtp.client-ip=212.211.156.0
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ferchau.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ferchau.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ferchau.com header.i=@ferchau.com header.b="qZ/J+mId";
	dkim=pass (1024-bit key) header.d=ablegroupde.onmicrosoft.com header.i=@ablegroupde.onmicrosoft.com header.b="JJhDPXT6"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=ferchau.com; i=@ferchau.com; q=dns/txt; s=s2048;
  t=1774034657; x=1805570657;
  h=arc-seal:arc-message-signature:
   arc-authentication-results:dkim-signature:from:to:cc:
   subject:thread-topic:thread-index:date:message-id:
   accept-language:content-language:x-ms-has-attach:
   x-ms-tnef-correlator:msip_labels:authentication-results:
   x-ms-publictraffictype:x-ms-traffictypediagnostic:
   x-ms-office365-filtering-correlation-id:
   x-ms-exchange-senderadcheck:x-ms-exchange-antispam-relay:
   x-microsoft-antispam:x-microsoft-antispam-message-info:
   x-forefront-antispam-report:
   x-ms-exchange-antispam-messagedata-chunkcount:
   x-ms-exchange-antispam-messagedata-0:content-type:
   content-transfer-encoding:mime-version:
   x-exchange-routingpolicychecked:
   x-ms-exchange-crosstenant-authas:
   x-ms-exchange-crosstenant-authsource:
   x-ms-exchange-crosstenant-network-message-id:
   x-ms-exchange-crosstenant-originalarrivaltime:
   x-ms-exchange-crosstenant-fromentityheader:
   x-ms-exchange-crosstenant-id:
   x-ms-exchange-crosstenant-mailboxtype:
   x-ms-exchange-crosstenant-userprincipalname:
   x-ms-exchange-transport-crosstenantheadersstamped:
   x-cse-connectionguid:x-cse-msgguid:ironport-data:
   ironport-hdrordr:x-talos-cuid:x-talos-muid:x-ironport-av;
  bh=HJYD+kmAR16wSTxZwenwJIftk9htNyfKB9Yj2YKcBKE=;
  b=qZ/J+mId+JrN27xrF+fRVikvQmG5kjqaA1kn3wJl1AmyFUel8FUl2jhB
   8lUnSXA6NO5iZTtR4k3Lumfo7BTmngV+auBzUqZwElUc/8eY5Jn7jpznb
   GlJixwhgZTIdd6GCzAUM9xjza5AjMixrf7Zqva094mrDm+a7hRsgt9U/I
   rMsi56H21JEzaOWar/ZA6vBLObUgLUWLv367AuHHAkvb7+rpvl/IsOhVf
   frxp1QPBKTKRZyGcjwSU05omZQRAe55gC9eGnFbNG9Te2o7iPzIz3RkUg
   ipSZhS+JUmJOvww+x0DibN/Cj9u6RNSN7nIttIAr/ChaEL9KfJTbM0YRz
   Q==;
X-CSE-ConnectionGUID: T1CZZmXxTn2w/6JNbPQ10w==
X-CSE-MsgGUID: GGiDzt8zQ4+++Qd98y+dpA==
IronPort-Data: A9a23:I63FTalgZbfLGB2qjWcwfwno5gyzJ0RdPkR7XQ2eYbSJt1+Wr1Gzt
 xIZWmiCOvuJZGr0e9h1bI638x8HsZ+Hn99iSwBv+yhmFC4T+ZvOCOrCIxarNUt+DCFjoGGLT
 ik6QoOdRCzhZiaE/n9BCpC48z8kk/3OHuOiYAL9EngZbRd+Tys8gg5Ulec8g4p56fC0GArlV
 ena+qUzA3f7nWQvWo4ow/jb8k03566q4GpwUmEWPpingnePzxH5M7pCfcldH1OgKqFIE+izQ
 fr0zb3R1gvx4xc3B9q5pa3we0sMT6S6FVDmZq1+AvXKbrBq/0Te445jXBYuQR4/Zwahxrid/
 O5wWamYEm/FCEFsdNM1CHG0GwkmVUFPFSSuzXKX6aR/xGWeG5fgLmkH4Ojb8uT0984uaVyi+
 8D0JxgxNzuxteeG0I69EPYr2OYFJvHSZdsA7yQIITHxVZ7KQLjsZpfw1/JohG9pwO5DB/3eb
 tdfbT1kZRCojx9nYw9RUcpm2rr0wCCXnz5w8Tp5oYIS5HLS0B4387zkNd/Rd8aiS8hPlUaRu
 yTN+GGR7hQybYLPkmfYrBpAgMfgsiLXSp5CBoTktb0puVHCln1QBAU/AA7TTf6RzxTWt8hkA
 0YV9Scntrka8E2tU8XnWBu5sDiIs3Y0R9VUA8U55RuLx66S5ByWbkAcQyJMcs4Otck4XzUm2
 1aF2dTzClRHtLyTVGLY7KvRoT6sNCw9KW4ZeTRCSQoD/smlrIwt5jrLT9B+AOu2g8fzFDXY3
 T+Htm49iq8VgMpN0L+0lW0rmBqjo4rTXAMlvl2OGGyo9Ah5bZPjY4uj4FyzAet8Ebt1h2Kp5
 BAs8/VyJshXZX1RvERhmNkwIYw=
IronPort-HdrOrdr: A9a23:qM6ZTKgC42JMuWu45kdnA4SZtnBQX3513DAbv31ZSRFFG/FwyP
 rAoB1L73PJYWgqNU3IwerwQ5VpQRvnhPtICPoqTM2ftW7dySGVxeBZnMDfKljbdREWmdQtrJ
 uIH5IOa+EYbmIKwPoSgjPIa+rIqePvmMvD5IfjJh9WPEdXgspbnmNE43OgYytLrX59dP0E/f
 Snl6h6jgvlVWUcb8y9CHVAZO7eut3NmqvhZB4NFzQn5AONgT7A0s+3LzGomjMlFx9fy7Yr9m
 bI1ybj4L+4jv29whjAk0fO8pV/grLau5R+Lf3JrvJQBiTniw6uaogkcaaFpioJrOam70tvuM
 XQoi0nI9945xrqDy+ISFrWqkjdOQQVmjzfIGyj8DneSAvCNXcH4v969MJkm93img4dVZ9Hoe
 V2Nimixudq5Fv77VjADpHzJm9XfkbYmwtcrccDy3NYSocQc7lXsMgW+15UCo4JGGbg5JkgC/
 QGNrCr2B96SyLvU5nihBgZ/PW8GnAoWhuWSEkLvcKYlzBQgXBi1kMdgMgShG0J+p4xQ4RNo7
 2sCNUhqJheCssNKa5tDuYIRsW6TmTLXBLXKWqXZVDqDrsONX7Bo4P+pL81+OapcpoVy4Zaou
 WJbHpI8WopP07+A8yH25NGthjLXWWmRDzojtpT4pBo04eMMYYD8RfzOmzGv/HQ0Mn3WPerKs
 pbEKgmc8PeEQ==
X-Talos-CUID: 9a23:1S1HxW2PRhQ5seSrbUKTX7xfJpkOQE/Y/GfsJRWnTjhLbretcAbI5/Yx
X-Talos-MUID: =?us-ascii?q?9a23=3AA/YU0Q9/Le8gWQPsmY3flrWQf+hH4oi8FBAfqMl?=
 =?us-ascii?q?F+Iq9OX0gKnSRlB3iFw=3D=3D?=
X-IronPort-AV: E=Sophos;i="6.23,130,1770591600"; 
   d="scan'208";a="1683556"
Received: from gmzrzex001.ferchau.local ([10.100.54.1])
  by mx2.ferchau.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Mar 2026 20:23:06 +0100
Received: from GMZRZEX002.Ferchau.local (10.100.54.2) by
 GMZRZEX001.Ferchau.local (10.100.54.1) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.35; Fri, 20 Mar 2026 20:23:06 +0100
Received: from AM0PR07CU002.outbound.protection.outlook.com (40.93.65.69) by
 exchange.ferchau.com (172.16.19.112) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.35 via Frontend Transport; Fri, 20 Mar 2026 20:23:06 +0100
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=NGP7DiSvkL/fA/qPyph1hgvZb8xeCOaRpq0mY6D4sMfN/oT3LJxhAwpXkTK0XQmPBH2Gk+0wZBrJjC/2NCLrAJpfOg6bYhMRNN1ZNGFjEC5gPCfUFjCk/jnvrt/A39QPVfG0ow+dWMzWZF2kwwnFYG4nYJAPdlzg9PpZ/StsG0x5YJnmMOAyBoXc2roILcYoETtHpv8by+5oEREqdmrntsm+PrWNIWJX2eCMhpcU7yWSAkAqtaAs1JoIxmbbwFviyfFPAjASZx3k6YNQDg1TcRMuZ/L7XfjtPcepPdrYIVCXUFqTHeTOJwPLHPNgtRl9SYFsSYSatx/+/KhnIJMKzQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HJYD+kmAR16wSTxZwenwJIftk9htNyfKB9Yj2YKcBKE=;
 b=bC2MtTKyNPrnMVcwkMJmf2pRAO8VnmISKrKTL0e95litlNlXDcVPD36/uUDv2fsymOKCjAX43sWkkV9VQcd+ufyj28UCZ9MkAqom8ehOG+s8iqdjT1kb/vXtoUYrmrNb7fEFOmBPcJjNF1sQ1h52Zs7Gwf95qonjBfWps/gm/AIdDCXTXeWafoSe3121M3NuiR6Zt5rwjG/N7iBJkkCynW6fGIn27G8NSyy02AGkwLfGbVDvPvkTQul0SdYV07wxRyPM4H2fPhCsgK+55KSXxAWJwDjj/Q1oowtr5M8yzD54FPhK2l0Osbbby5KUC0pL2e+0/GAdRAR44wrb/auVhA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=ferchau.com; dmarc=pass action=none header.from=ferchau.com;
 dkim=pass header.d=ferchau.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ablegroupde.onmicrosoft.com; s=selector1-ablegroupde-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HJYD+kmAR16wSTxZwenwJIftk9htNyfKB9Yj2YKcBKE=;
 b=JJhDPXT6zOw8KirFz7D5b7WtxOawgnk5hS0yrb+jlX5wQEdCCUl9a/7zRqLFFp77BwpcbDRe0a3vMrVknFUyUa/thHqfVzdj1aNviIJP7m4WS0WhuKgJkFmwaNkNIbGkp9TBgt5oGbMlS2GbluhtqLofQbnR0nSyRZhI0d2xsz0=
Received: from VE1PR06MB6894.eurprd06.prod.outlook.com (2603:10a6:800:1aa::10)
 by PR3PR06MB6810.eurprd06.prod.outlook.com (2603:10a6:102:2e::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9723.19; Fri, 20 Mar
 2026 19:22:46 +0000
Received: from VE1PR06MB6894.eurprd06.prod.outlook.com
 ([fe80::284c:9a:e70f:8108]) by VE1PR06MB6894.eurprd06.prod.outlook.com
 ([fe80::284c:9a:e70f:8108%5]) with mapi id 15.20.9723.019; Fri, 20 Mar 2026
 19:23:01 +0000
From: "Moritz KLAMMLER (FERCHAU)" <Moritz.Klammler@ferchau.com>
To: Sebastian Andrzej Siewior <bigeasy@linutronix.de>, Thomas Gleixner
	<tglx@kernel.org>, Peter Zijlstra <peterz@infradead.org>
CC: "linux-rt-devel@lists.linux.dev" <linux-rt-devel@lists.linux.dev>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Possible PREEMPT_RT live-lock / priority-inversion between
 FUTEX_CMP_REQUEUE_PI and FUTEX_WAIT_REQUEUE_PI
Thread-Topic: Possible PREEMPT_RT live-lock / priority-inversion between
 FUTEX_CMP_REQUEUE_PI and FUTEX_WAIT_REQUEUE_PI
Thread-Index: AQHcuJ4tKJIXTbtBj06xHcNQzZlKbA==
Date: Fri, 20 Mar 2026 19:23:01 +0000
Message-ID: <VE1PR06MB6894BE61C173D802365BE19DFF4CA@VE1PR06MB6894.eurprd06.prod.outlook.com>
Accept-Language: de-DE, en-US
Content-Language: de-DE
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=ferchau.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: VE1PR06MB6894:EE_|PR3PR06MB6810:EE_
x-ms-office365-filtering-correlation-id: a3e785d7-8c00-4473-a650-08de86b61a4b
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|366016|1800799024|376014|38070700021|18002099003|56012099003;
x-microsoft-antispam-message-info: bi1YrTv8CWLLPVdJhtNlHRZTH2pRBd5I/ThxaASJDhnA9ZFmysI6qQsN6xcQxUFofTlMLpqcemD0dTDf+qrbbqvRWxZX4HWJc910DbsXS9d6fiD2XAVP2qvS/i7Z/voqIfOke4662m4/lW7mnWGSHhGnUkV/gdRY0UmExJv38PnqjrS9B9/XpSGvNkX4tpFq9EPMnORW1hsq7ITyuej1bVAMUFQKR3WvdC9KKcyOJZlfI0hrgnCsIwyiKe+B+M4NdUAKVakriv6ngHAEfxAEfo6OIERuZa2JsIecVbuDUKONEu4b/AoLBZaiAO1c3hPIuvUx2GjNEASnXBiAfNag38I3lZObauLQk76LGkDZbNxjo1Kmx8mvjImhec0BMC8aeCIBJlK1gZo2G+tOPybFG2KqXhTPagIBlpBz4VNhYkaoHY95qYadfOiSb182rNKdTTA7+4blaCcXpA24F11HrWU0iL01YTAAvSCRlh/l58Kyh5ik9WusDb8LUb0vwA9gKepzR/J7UKJOK+k8Ivv4knhHb1Oatpvvgp7FpYBLTpVzoI+51RUP3j1uaUxxq6aibsoEU5jQsemrcrEJWGGqyZl/rCC+M6DfJjBcWWCUXmOdIMgqOy07V63au/id6xu4ACZ8bqxl3IbB4JX1ZTsfG5w2RMpBmBNz86MnCd/XypNTCnM2YYWJ03NA0Hu4ifEk2Yx1JsQq1JV96YvISaE/hP9Siwa1bRkOLcsNDKFY3qlpbL847u6+fP1Hw9H6FFEM
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VE1PR06MB6894.eurprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(38070700021)(18002099003)(56012099003);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?koi8-r?Q?lm3sEitr27ipshuvsTkcO7ipUd11svph98bC3YgP8OLThGeyl/SzHn8Oax9JU0?=
 =?koi8-r?Q?VNubiliyGfkGbKNvcUYl6gOeceiy5fMPec/AtR3ZPh/hHsuBCxBr6ZE4tSowNi?=
 =?koi8-r?Q?t4CuaVS44MBqcoPYrG6jpMq/WgCREI20O3Waiain2/bTHSHai81YoLkmD9Orf1?=
 =?koi8-r?Q?D7UvUKlhG35FIitU10GbYAn4TwgHDC4UqSM31W6glUe2EJXVxJ9zIC3k7m+XTO?=
 =?koi8-r?Q?3rrUrIO3gHse2KW2Pbb76sI3Vn+4sIOpecBJpQeQ+KdSr+zgrzM/Ctwb60x4lz?=
 =?koi8-r?Q?CGow8HxKc4SZevdZ4EXmgE/Dsj2yAuHB2CA2fHt9tZEH+A68ITd6W7QzQKSyRQ?=
 =?koi8-r?Q?gdTozl1hRBw1gbDy4fUIWPls3MHDttNMBcnh3gp+kmRvGFRQvSLKtIRKAi2NIV?=
 =?koi8-r?Q?Bc3z8uJYKhefcnydcQMkHDCBcBSQfiV6eaYvU11w/v12UrTAWg3vxaKE08/EOo?=
 =?koi8-r?Q?I61ROmL68rOoEe1MIhZEmYRLeThdDaCyXyY+yq65CV9w5Fp8+ilZLc1icyApmy?=
 =?koi8-r?Q?m7fwB9KVyXec8X0776wLCM2UdCsvHdfu814r042q09T+IVVF4ue0Z4jNcccjDi?=
 =?koi8-r?Q?YHWiUJseItNYMHb9rxNmvUYdZfMN5d2+WU3taeQlPMhytfUIz9xpivVNQzxMI1?=
 =?koi8-r?Q?5W8JV9McEzFXzzvXlWYXQyl8FB8Dxoyb8GG5eTmzRPWsbZW1cbQslz1ohdr3HB?=
 =?koi8-r?Q?LHDjUmAX/31PhMXERFc/rTPmj4KDtdKV6b2urths3p3FCNvLs5hUgA6Y6jtjB1?=
 =?koi8-r?Q?VGLoMVjCmcVC8CyEnAnEOF5oQINAzp6rRXUNoOrL9uQRP4OGmevnOUZZqAeHpn?=
 =?koi8-r?Q?D/WYaXCa+WcCiipnzuKFxkL88R1a4conwm9GV1dlRqnSOYEVlw6cRKnfY41L1k?=
 =?koi8-r?Q?d84XYREw2kMavr2+uw4/M23iJGAGFQKg5j8G7bbudhACg/F0zOrazOK+asXo8T?=
 =?koi8-r?Q?jeJVujuVrZzL6iw/U92fpY1yBgU/V5M0N5hywOpqKlWzFTVDo7A+8K4BDlS+ao?=
 =?koi8-r?Q?IYJcgMrBAeiOiK8VTFM5HMuSDy5g/MsYgfnj5Zl2GxNqq77vQayUhG2+gOCgQr?=
 =?koi8-r?Q?+le1YvYu+7DeKp3BcSzXdeUUsj12QR9cxLxDHQt57PSDUTl8RAkUUlTnxB5MDj?=
 =?koi8-r?Q?N1zQJkBr4X+NF0MzC+6NgYxeWSzJ39ZMfvKGW0nqarqFM85n0V5Zlk74uHCyeC?=
 =?koi8-r?Q?qDHnDXH6rMGQ3h/1nKTYKEW6YW18dAwM/jc1SeX+rS/7JcHJa7Ja8jCN2kSF/6?=
 =?koi8-r?Q?lANwgr0VhTHS1LUZbb8d3Byx5D/5sPoQwxGWuu1IVVUJMby2tQ0N2Xum2PDCFd?=
 =?koi8-r?Q?dQrSNgDSomU01oV04XNiQhp5LH2qwFnt2eeWTMZSy8+7qJYxIOBVGdB1Fgfz9Q?=
 =?koi8-r?Q?7aGKXxtZuTBE6rnKelN8Z43TNrSeMIuvQbrIyef3y3Q4yjtYn8TpoEHRgkg4zg?=
 =?koi8-r?Q?plFdUkEMzEwKEfUNMtU+BjQ7lMAw+4yKWUXfBqDnmu+IXU6FEoZlEhZtCNbY33?=
 =?koi8-r?Q?lxUKOw5Vjo7WVYUoOnehcSAb9NVEOci799ebc8iI7VzMW1U9Y/rYNOjn4dE5TM?=
 =?koi8-r?Q?TQrfgOlsgOnnZtKxZr37Oare+bErqyZml/bN5hu4wequUEz3AeBdzunHRva96Z?=
 =?koi8-r?Q?+jRLRSMnxoEuV5J3dDdAViNG8QqWycas9ZUBv48EFlyDt5wAre3ZajZNwmcXnx?=
 =?koi8-r?Q?FX13oT8V3Egwgw=3D=3D?=
Content-Type: text/plain; charset="koi8-r"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: frcYHsaR91GP/UORb8yyzxOoseWRAxTY6bGnUXHaHrZ3ivfv6q3AFB4ucPoY+3eMmAUHKvzluyDDD4gZUzTL0U//OXA4V/Nd5OC0/l3JjH7Vni5fzujuUzqT7nj7pAlC6Kz/6QpaI4m9EqZhEHnkalzCxdsHoCIN8vfEHxYkElS8OjXEPWizw3TCYJco9tHvF1bkBCGZcP6+ALw38FVikPQ/1GCsU3AZElbvl68sTopD0/eO+gIJhsSAqLIHF79mbytz6HMGc6/NioZgbjAvUx5ArkfKt+LeU0YWaa0qsgP3vOcl2jbtDbI0AchzCPAgrb6qGS3ikmJPHcSFTmK9Wg==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: VE1PR06MB6894.eurprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a3e785d7-8c00-4473-a650-08de86b61a4b
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Mar 2026 19:23:01.6280
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 9a3c2f68-d5b5-4769-b2f8-8d6fe142b164
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: geihQyHFuhc6QnW+GNeROCmPtww5P412T+097K45qRpcHIql31hiBfM9/YvHaDnVFkQu/iF8z3pKriLOq0IJCbXWpZLHms/+loKUWsGNkBw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PR3PR06MB6810

Hello,=0A=
=0A=
we're running Linux 6.6 with PREEMPT_RT on a single-core armv7l machine=0A=
and observed our devices getting locked-up every few days.  We're using=0A=
RT/PI condition variables from librtpi [1] and determined that the RT=0A=
(SCHED_FIFO) thread making the FUTEX_CMP_REQUEUE_PI syscall from within=0A=
pi_cond_broadcast seems to occasionally live-lock inside the kernel.=0A=
=0A=
Thanks to a possibly less than ideal design decision in our system, the=0A=
"producer" thread calling pi_cond_broadcast (i.e. doing the=0A=
FUTEX_CMP_REQUEUE_PI) has a higher priority than the "consumer" threads=0A=
that are waiting on the condition variable (calling pi_cond_timedwait=0A=
which eventually makes a FUTEX_WAIT_REQUEUE_PI call).  While this might=0A=
not be ideal, I suppose that it still ought to be allowed; please=0A=
correct me if I should be mistaken on that point.=0A=
=0A=
What seems to happen next is that when the waiter exceeds its finite=0A=
timeout [2] and half an eye-blink later, the producer thread decides to=0A=
call FUTEX_CMP_REQUEUE_PI after all, the lower-priority consumer might=0A=
make it to the point where it sets the requeue state to=0A=
Q_REQUEUE_PI_DONE in futex_requeue_pi_wakeup_sync but then gets=0A=
preempted before it has a chance to remove itself from the waiters list.=0A=
Now, the higher-priority producer thread calls futex_requeue_pi_prepare=0A=
which will return false because it sees the Q_REQUEUE_PI_IGNORE.=0A=
Subsequently, futex_proxy_trylock_atomic will fail with -EAGAIN and=0A=
futex_requeue "goto retry".  Which effectively results in the=0A=
higher-priority RT thread busy-waiting on the lower-priority thread=0A=
forever.  It will call cond_resched before the "goto retry" but since it=0A=
is considered the most important task in the system, it doesn't seem to=0A=
be scheduled away anymore.=0A=
=0A=
We have experimentally added a "retry counter" in futex_requeue and, if=0A=
it exceeds a reasonable limit [3], attempted to take evasive action.=0A=
Both of these seem to resolve the live-lock, but neither of them feels=0A=
great to me:=0A=
=0A=
 - Decrement the current task prio before each subsequent retry until it=0A=
   eventually drops below the corresponding FUTEX_WAIT_REQUEUE_PI caller=0A=
   and restore it again before returning from the syscall.=0A=
=0A=
 - Do a usleep_range_state(1, 100, TASK_KILLABLE) before the=0A=
   cond_resched().  I'm clueless which numbers would be (and whether=0A=
   TASK_KILLABLE is) appropriate for this.  All I can say about the=0A=
   chosen ones is that they did seem to reliably resolve the situation=0A=
   in our use-case upon the first sleep.=0A=
=0A=
I think the nicest option might be to somehow prevent the=0A=
FUTEX_WAIT_REQUEUE_PI syscall from being preempted during the critical=0A=
section in the first place.  But I don't know whether, let alone how,=0A=
this could be accomplished.  The only (probably flawed) idea that comes=0A=
to my mind is temporarily escalating the task's priority to the maximum,=0A=
which might have all kinds of other undesirable consequences.=0A=
=0A=
The lock-up is reliably reproduced by having a higher-priority=0A=
"producer" thread doing=0A=
=0A=
    while (true) {=0A=
            pi_mutex_lock(mutex);=0A=
            ++global_counter;=0A=
            very_short_sleep();=0A=
            pi_cond_broadcast(condvar, mutex);=0A=
            pi_mutex_unlock(mutex);=0A=
            short_sleep();=0A=
    }=0A=
=0A=
and a lower-priorty "consumer" thread doing=0A=
=0A=
    while (true) {=0A=
        pi_mutex_lock(mutex);=0A=
        while (global_counter =3D=3D 0) {=0A=
            pi_cond_timedwait(condvar, mutex, super_short_timeout);=0A=
        }=0A=
        --global_counter;=0A=
        pi_mutex_unlock(mutex);=0A=
    }=0A=
=0A=
concurrently on a single-core machine.  The very_short_sleep() in the=0A=
producer thread gives the lower-priority consumer thread a chance to=0A=
enter its critical section only to be immediately preempted again before=0A=
completing it.=0A=
=0A=
I'm attaching an almost self-contained (only depending on librtpi)=0A=
example program [4] that implements the above pseudo-code, but it is=0A=
unfortunately a bit verbose.  You might have to tweak the numbers for=0A=
different CPU speeds.  On our device in question, it has never been=0A=
observed making it through 2^20 iterations on an unmodified kernel if=0A=
the producer's priority exceeds the consumer's.  With different=0A=
priorities or one of the workarounds mentioned above, it does 2^30=0A=
iterations without issues.=0A=
=0A=
Thanks for any insights on this topic.=0A=
=0A=
Moritz=0A=
=0A=
=0A=
[1] https://github.com/dvhart/librtpi=0A=
=0A=
[2] Exceeding the timeout is the only way by which I've been able to=0A=
    reliably provoke this situation.  I'm not sure if there would also=0A=
    be other ways to prematurely wake up the waiter.=0A=
=0A=
[3] I don't know what would be reasonable.  We've used a limit of 10=0A=
    before starting to take countermeasures in our experiments so far.=0A=
=0A=
[4] Alas, librtpi seems to be assuming 32 bit timestamps, so the example=0A=
    uses that, too.  We've been able to observe the symptom with both,=0A=
    32 and 64 bit syscalls.=0A=
=0A=
=0A=
=0A=
#undef _FILE_OFFSET_BITS=0A=
#undef _TIME_BITS=0A=
#define _GNU_SOURCE=0A=
=0A=
#include <assert.h>=0A=
#include <errno.h>=0A=
#include <limits.h>=0A=
#include <math.h>=0A=
#include <pthread.h>=0A=
#include <rtpi.h>=0A=
#include <stdatomic.h>=0A=
#include <stdbool.h>=0A=
#include <stdint.h>=0A=
#include <stdio.h>=0A=
#include <stdlib.h>=0A=
#include <string.h>=0A=
#include <sys/random.h>=0A=
#include <time.h>=0A=
#include <unistd.h>=0A=
=0A=
#define NANOS_PER_UNIT 1000000000LL=0A=
=0A=
#define ARRAY_SIZE(A) (sizeof(A) / sizeof((A)[0]))=0A=
#define CSV(...)      __VA_ARGS__=0A=
#define S(P)          ((const char *)(P))=0A=
=0A=
#define CONSOLE_PRINT(Format, ...)                                         =
                                            \=0A=
    do {                                                                   =
                                            \=0A=
        struct timespec _temp_ts;                                          =
                                            \=0A=
        if (0 !=3D clock_gettime(CLOCK_MONOTONIC, &_temp_ts)) {            =
                                              \=0A=
            _temp_ts.tv_sec =3D _temp_ts.tv_nsec =3D 0;                    =
                                                \=0A=
        }                                                                  =
                                            \=0A=
        const int _temp_id =3D gettid();                                   =
                                              \=0A=
        dprintf(STDERR_FILENO, "[%ld.%09lu][%d] %s:%d: " Format "\n", (long=
)_temp_ts.tv_sec,                           \=0A=
                (unsigned long)_temp_ts.tv_nsec, _temp_id, __FILE__, __LINE=
__, ##__VA_ARGS__);                         \=0A=
    } while (false)=0A=
=0A=
#define FATAL_ERROR(...)                                                   =
                                            \=0A=
    do {                                                                   =
                                            \=0A=
        CONSOLE_PRINT(__VA_ARGS__);                                        =
                                            \=0A=
        abort();                                                           =
                                            \=0A=
    } while (false)=0A=
=0A=
#define MUST_ZERO_PTHREAD(...)                                             =
                                            \=0A=
    do {                                                                   =
                                            \=0A=
        const int _temp_err =3D (__VA_ARGS__);                             =
                                              \=0A=
        if (_temp_err !=3D 0) {                                            =
                                              \=0A=
            FATAL_ERROR("%s =3D %d (%s)", #__VA_ARGS__, _temp_err, strerror=
(_temp_err));                                 \=0A=
        }                                                                  =
                                            \=0A=
    } while (false)=0A=
=0A=
#define MUST_ZERO_POSIX(...)                                               =
                                            \=0A=
    do {                                                                   =
                                            \=0A=
        const int _temp_ret =3D (__VA_ARGS__);                             =
                                              \=0A=
        if (_temp_ret !=3D 0) {                                            =
                                              \=0A=
            FATAL_ERROR("%s =3D %d (%s)", #__VA_ARGS__, _temp_ret, strerror=
(errno));                                     \=0A=
        }                                                                  =
                                            \=0A=
    } while (false)=0A=
=0A=
#define MUST_NOT_NULL(...)                                                 =
                                            \=0A=
    do {                                                                   =
                                            \=0A=
        const void *const _temp_ptr =3D (__VA_ARGS__);                     =
                                              \=0A=
        if (_temp_ptr =3D=3D NULL) {                                       =
                                                \=0A=
            FATAL_ERROR("%s =3D NULL (%s)\n", #__VA_ARGS__, strerror(errno)=
);                                            \=0A=
        }                                                                  =
                                            \=0A=
    } while (false)=0A=
=0A=
static pthread_barrier_t barrier;=0A=
static pi_mutex_t *mutex;=0A=
static pi_cond_t *condvar;=0A=
=0A=
static int64_t global_limit =3D 0;=0A=
static int64_t global_tally =3D 0;=0A=
=0A=
struct worker_thread_state {=0A=
    struct timespec t1;=0A=
    struct timespec t2;=0A=
    struct timespec last_update;=0A=
};=0A=
=0A=
static int64_t clamp(const int64_t floor, const int64_t value, const int64_=
t ceil) {=0A=
    if (value < floor) {=0A=
        return floor;=0A=
    }=0A=
    if (value > ceil) {=0A=
        return ceil;=0A=
    }=0A=
    return value;=0A=
}=0A=
=0A=
static int64_t nanoseconds(const struct timespec *const t1, const struct ti=
mespec *const t2) {=0A=
    return NANOS_PER_UNIT * (t2->tv_sec - t1->tv_sec) + (t2->tv_nsec - t1->=
tv_nsec);=0A=
}=0A=
=0A=
static int64_t little_sleepy(const useconds_t micmod) {=0A=
    struct timespec t1, t2;=0A=
    const useconds_t duration =3D random() % micmod;=0A=
    MUST_ZERO_POSIX(clock_gettime(CLOCK_MONOTONIC, &t1));=0A=
    MUST_ZERO_POSIX(usleep(duration));=0A=
    MUST_ZERO_POSIX(clock_gettime(CLOCK_MONOTONIC, &t2));=0A=
    return nanoseconds(&t1, &t2);=0A=
}=0A=
=0A=
static const char *policy_name(const int policy) {=0A=
    switch (policy) {=0A=
    case SCHED_OTHER:=0A=
        return "SCHED_OTHER";=0A=
    case SCHED_IDLE:=0A=
        return "SCHED_IDLE";=0A=
    case SCHED_BATCH:=0A=
        return "SCHED_BATCH";=0A=
    case SCHED_FIFO:=0A=
        return "SCHED_FIFO";=0A=
    case SCHED_RR:=0A=
        return "SCHED_RR";=0A=
    default:=0A=
        return "UNKNOWN";=0A=
    }=0A=
}=0A=
=0A=
static void overcome_barrier(const char *const who) {=0A=
    const int ret =3D pthread_barrier_wait(&barrier);=0A=
    if (ret =3D=3D 0) {=0A=
        CONSOLE_PRINT("The %s thread took the barrier as a follower", who);=
=0A=
    } else if (ret =3D=3D PTHREAD_BARRIER_SERIAL_THREAD) {=0A=
        CONSOLE_PRINT("The %s thread took the barrier as the leader", who);=
=0A=
    } else {=0A=
        FATAL_ERROR("The %s thread didn't take the barrier: %s", who, strer=
ror(ret));=0A=
    }=0A=
}=0A=
=0A=
static void worker_thread_enter(struct worker_thread_state *const state, co=
nst char *const who) {=0A=
    int policy;=0A=
    struct sched_param param;=0A=
    MUST_ZERO_PTHREAD(pthread_getschedparam(pthread_self(), &policy, &param=
));=0A=
    CONSOLE_PRINT("The %s thread runs with scheduling policy %s at priority=
 %d",=0A=
                  CSV(who, policy_name(policy), param.sched_priority));=0A=
    overcome_barrier(who);=0A=
    MUST_ZERO_POSIX(clock_gettime(CLOCK_MONOTONIC, &state->t1));=0A=
}=0A=
=0A=
static void worker_thread_progress(struct worker_thread_state *const state,=
 const int64_t iter, const char *const who) {=0A=
    struct timespec now;=0A=
    MUST_ZERO_POSIX(clock_gettime(CLOCK_MONOTONIC, &now));=0A=
    const int64_t since_start =3D nanoseconds(&state->t1, &now);=0A=
    const int64_t since_last =3D nanoseconds(&state->last_update, &now);=0A=
    const int64_t update_interval =3D clamp(10 * NANOS_PER_UNIT, since_star=
t / 10, 1000 * NANOS_PER_UNIT);=0A=
    if (iter >=3D 10 && since_last > update_interval) {=0A=
        CONSOLE_PRINT("The %s thread has already processed %lld items (%.2f=
 %%) in %.3f s (i.e. =97 %.1f Hz)",=0A=
                      CSV(who, iter, 100.0 * iter / global_limit, 1.0E-9 * =
since_start, 1.0E+9 * iter / since_start));=0A=
        state->last_update =3D now;=0A=
    }=0A=
}=0A=
=0A=
static int64_t worker_thread_completed(struct worker_thread_state *const st=
ate, const char *const who) {=0A=
    MUST_ZERO_POSIX(clock_gettime(CLOCK_MONOTONIC, &state->t2));=0A=
    const int64_t duration =3D nanoseconds(&state->t1, &state->t2);=0A=
    CONSOLE_PRINT("The %s thread is done processing all %lld items in %.3f =
s (i.e. =97 %.1f Hz)",=0A=
                  CSV(who, global_limit, 1.0E-9 * duration, 1.0E+9 * global=
_limit / duration));=0A=
    return duration;=0A=
}=0A=
=0A=
static void *worker_thread_exit(struct worker_thread_state *const state, co=
nst char *const who) {=0A=
    (void)state;=0A=
    CONSOLE_PRINT("The %s thread is about to exit", who);=0A=
    return NULL;=0A=
}=0A=
=0A=
static void *producer_function(void *const ident) {=0A=
    struct worker_thread_state state =3D {0};=0A=
    worker_thread_enter(&state, S(ident));=0A=
    int64_t sleep_locked =3D 0, sleep_unlocked =3D 0;=0A=
    for (int64_t i =3D 0; i < global_limit; ++i) {=0A=
        worker_thread_progress(&state, i, S(ident));=0A=
        MUST_ZERO_PTHREAD(pi_mutex_lock(mutex));=0A=
        const int64_t local_tally =3D ++global_tally;=0A=
        if (local_tally < 0) {=0A=
            FATAL_ERROR("Negative value observed by %s thread", S(ident));=
=0A=
        }=0A=
        sleep_locked +=3D little_sleepy(50);=0A=
        MUST_ZERO_PTHREAD(pi_cond_broadcast(condvar, mutex));=0A=
        MUST_ZERO_PTHREAD(pi_mutex_unlock(mutex));=0A=
        sleep_unlocked +=3D little_sleepy(100);=0A=
    }=0A=
    const int64_t loop_duration =3D worker_thread_completed(&state, S(ident=
));=0A=
    const int64_t sleep_total =3D sleep_locked + sleep_unlocked;=0A=
    CONSOLE_PRINT("The %s thread was sleeping for a total of %.3f seconds (=
%.2f %% of the time)",=0A=
                  CSV(S(ident), 1.0E-9 * sleep_total, 100.0 * sleep_total /=
 loop_duration));=0A=
    CONSOLE_PRINT("It was sleeping %.3f s (%.2f %%) with and %.3f s (%.2f %=
%) without holding the lock",=0A=
                  CSV(1.0E-9 * sleep_locked, 100.0 * sleep_locked / sleep_t=
otal),=0A=
                  CSV(1.0E-9 * sleep_unlocked, 100.0 * sleep_unlocked / sle=
ep_total));=0A=
    return worker_thread_exit(&state, S(ident));=0A=
}=0A=
=0A=
static void *consumer_function(void *const ident) {=0A=
    struct worker_thread_state state =3D {0};=0A=
    worker_thread_enter(&state, S(ident));=0A=
    int64_t wait_success =3D 0, wait_timeout =3D 0;=0A=
    for (int64_t i =3D 0; i < global_limit; ++i) {=0A=
        worker_thread_progress(&state, i, S(ident));=0A=
        MUST_ZERO_PTHREAD(pi_mutex_lock(mutex));=0A=
        for (uint64_t wait_nanos =3D 10; global_tally =3D=3D 0; wait_nanos =
+=3D wait_nanos / 2) {=0A=
            struct timespec timeout;=0A=
            MUST_ZERO_POSIX(clock_gettime(CLOCK_MONOTONIC, &timeout));=0A=
            uint64_t more_nanos =3D timeout.tv_nsec + wait_nanos;=0A=
            timeout.tv_sec +=3D more_nanos / NANOS_PER_UNIT;=0A=
            timeout.tv_nsec =3D more_nanos % NANOS_PER_UNIT;=0A=
            const int ret =3D pi_cond_timedwait(condvar, mutex, &timeout);=
=0A=
            if (ret =3D=3D 0) {=0A=
                wait_success +=3D 1;=0A=
            } else if (ret =3D=3D ETIMEDOUT) {=0A=
                wait_timeout +=3D 1;=0A=
            } else {=0A=
                FATAL_ERROR("pi_cond_timedwait with relative timeout of %ll=
d ns returned unexpected error code %d: %s",=0A=
                            CSV(wait_nanos, ret, strerror(ret)));=0A=
            }=0A=
        }=0A=
        const int64_t local_tally =3D --global_tally;=0A=
        if (local_tally < 0) {=0A=
            FATAL_ERROR("Negative value observed by %s thread", S(ident));=
=0A=
        }=0A=
        MUST_ZERO_PTHREAD(pi_mutex_unlock(mutex));=0A=
    }=0A=
    worker_thread_completed(&state, S(ident));=0A=
    const int64_t wait_total =3D wait_success + wait_timeout;=0A=
    if (wait_total > 0) {=0A=
        CONSOLE_PRINT("The %s thread encountered timeouts with %.2f %% of t=
he %lld pi_cond_timedwait calls",=0A=
                      CSV(S(ident), 100.0 * wait_timeout / wait_total, wait=
_total));=0A=
    } else {=0A=
        CONSOLE_PRINT("The %s thread didn't call pi_cond_timedwait at all!"=
, S(ident));=0A=
    }=0A=
    return worker_thread_exit(&state, S(ident));=0A=
}=0A=
=0A=
static int64_t great_power(const int n) {=0A=
    // Don't accept 2^0 because of atoi(3) deficiencies.=0A=
    return (0 < n && n < 60) ? (1LL << n) : -1LL;=0A=
}=0A=
=0A=
int main(int argc, char **argv) {=0A=
    typedef void *(*thread_function_t)(void *);=0A=
    struct {=0A=
        pthread_t thread;=0A=
        struct sched_param schedparams;=0A=
        thread_function_t function;=0A=
        char name[24];=0A=
    } threads[] =3D {=0A=
        {.function =3D producer_function, .name =3D "producer"},=0A=
        {.function =3D consumer_function, .name =3D "consumer"},=0A=
    };=0A=
    const int thread_count =3D ARRAY_SIZE(threads);=0A=
    if (argc < 4 || argc > 5) {=0A=
        CONSOLE_PRINT("Usage: %s N PRO CON", argv[0]);=0A=
        CONSOLE_PRINT("");=0A=
        CONSOLE_PRINT("Process 2^N items with producer and consumer thread =
running with FIFO scheduling");=0A=
        CONSOLE_PRINT("policy at priorities PRO and CON respectively.");=0A=
        return EXIT_FAILURE;=0A=
    } else if ((global_limit =3D great_power(atoi(argv[1]))) <=3D 0) {=0A=
        CONSOLE_PRINT("Please choose a sensible number of iterations.");=0A=
        return EXIT_FAILURE;=0A=
    } else if ((threads[0].schedparams.sched_priority =3D atoi(argv[2])) <=
=3D 0) {=0A=
        CONSOLE_PRINT("Please choose a positive real-time priority for the =
producer thread.");=0A=
        return EXIT_FAILURE;=0A=
    } else if ((threads[1].schedparams.sched_priority =3D atoi(argv[3])) <=
=3D 0) {=0A=
        CONSOLE_PRINT("Please choose a positive real-time priority for the =
consumer thread.");=0A=
        return EXIT_FAILURE;=0A=
    }=0A=
    {=0A=
        unsigned entropy;=0A=
        if (getrandom(&entropy, sizeof(entropy), 0) !=3D (ssize_t)sizeof(en=
tropy)) {=0A=
            FATAL_ERROR("Unable to obtain %zu bytes of system entropy (errn=
o =3D %d): %s",=0A=
                        CSV(sizeof(entropy), errno, strerror(errno)));=0A=
        }=0A=
        srandom(entropy);=0A=
    }=0A=
    if (threads[0].schedparams.sched_priority =3D=3D threads[1].schedparams=
.sched_priority) {=0A=
        CONSOLE_PRINT("About to process %lld items with the producer runnin=
g at %s priority %s the consumer",=0A=
                      CSV(global_limit, "the same", "as"));=0A=
    } else if (threads[0].schedparams.sched_priority > threads[1].schedpara=
ms.sched_priority) {=0A=
        CONSOLE_PRINT("About to process %lld items with the producer runnin=
g at %s priority %s the consumer",=0A=
                      CSV(global_limit, "higher", "than"));=0A=
    } else if (threads[0].schedparams.sched_priority < threads[1].schedpara=
ms.sched_priority) {=0A=
        CONSOLE_PRINT("About to process %lld items with the producer runnin=
g at %s priority %s the consumer",=0A=
                      CSV(global_limit, "lower", "than"));=0A=
    } else {=0A=
        FATAL_ERROR("The impossible has happened.");=0A=
    }=0A=
    CONSOLE_PRINT("Preparing synchronization primitives ...");=0A=
    MUST_ZERO_PTHREAD(pthread_barrier_init(&barrier, NULL, thread_count + 1=
));=0A=
    MUST_NOT_NULL(mutex =3D pi_mutex_alloc());=0A=
    MUST_NOT_NULL(condvar =3D pi_cond_alloc());=0A=
    MUST_ZERO_PTHREAD(pi_mutex_init(mutex, 0));=0A=
    MUST_ZERO_PTHREAD(pi_cond_init(condvar, 0));=0A=
    CONSOLE_PRINT("Starting %d threads ...", thread_count);=0A=
    for (int i =3D 0; i < thread_count; ++i) {=0A=
        pthread_attr_t attrs;=0A=
        MUST_ZERO_PTHREAD(pthread_attr_init(&attrs));=0A=
        MUST_ZERO_PTHREAD(pthread_attr_setschedpolicy(&attrs, SCHED_FIFO));=
=0A=
        MUST_ZERO_PTHREAD(pthread_attr_setschedparam(&attrs, &threads[i].sc=
hedparams));=0A=
        MUST_ZERO_PTHREAD(pthread_attr_setinheritsched(&attrs, PTHREAD_EXPL=
ICIT_SCHED));=0A=
        MUST_ZERO_PTHREAD(pthread_create(&threads[i].thread, &attrs, thread=
s[i].function, threads[i].name));=0A=
        MUST_ZERO_PTHREAD(pthread_attr_destroy(&attrs));=0A=
    }=0A=
    CONSOLE_PRINT("Releasing worker threads ...");=0A=
    overcome_barrier("main");=0A=
    struct timespec ts_before;=0A=
    MUST_ZERO_POSIX(clock_gettime(CLOCK_MONOTONIC, &ts_before));=0A=
    CONSOLE_PRINT("Joining %d threads ...", thread_count);=0A=
    for (int i =3D 0; i < thread_count; ++i) {=0A=
        MUST_ZERO_PTHREAD(pthread_join(threads[i].thread, NULL));=0A=
    }=0A=
    struct timespec ts_after;=0A=
    MUST_ZERO_POSIX(clock_gettime(CLOCK_MONOTONIC, &ts_after));=0A=
    if (global_tally !=3D 0) {=0A=
        FATAL_ERROR("Main thread observed non-zero tally %lld afterwards", =
global_tally);=0A=
    }=0A=
    CONSOLE_PRINT("Cleaning up synchronization primitives ...");=0A=
    MUST_ZERO_PTHREAD(pi_cond_destroy(condvar));=0A=
    MUST_ZERO_PTHREAD(pi_mutex_destroy(mutex));=0A=
    pi_cond_free(condvar);=0A=
    pi_mutex_free(mutex);=0A=
    MUST_ZERO_PTHREAD(pthread_barrier_destroy(&barrier));=0A=
    const int64_t elapsed_nanos =3D nanoseconds(&ts_before, &ts_after);=0A=
    CONSOLE_PRINT("Overall processing of %lld items took %.3f s (i.e. =97 %=
.1f Hz)",=0A=
                  CSV(global_limit, 1.0E-9 * elapsed_nanos, 1.0E+9 * global=
_limit / elapsed_nanos));=0A=
    return EXIT_SUCCESS;=0A=
}=0A=
