Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2043.outbound.protection.outlook.com [40.107.94.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D98A2E0B74
	for <linux-rt-devel@lists.linux.dev>; Tue,  8 Jul 2025 15:17:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.94.43
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751987865; cv=fail; b=sTge28HlKMzD6QSqj38t0KuOOK3fmgAUDWds02a5SLOlB/RD/pic2+fLwulD4X5IBQ5QFJnRCAsBrPuhZpXUT6DI0Hk5HauI+vXcjFzhT73LZNaRiZFdNAaJZ4LgOTYP82fBxtjYu8x0aYCsVRchYuKZ+LtEHRHgKKhcu5Gkqq8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751987865; c=relaxed/simple;
	bh=NJ8f+ews6xOgXjJqI4j+5NHyxaKFC6UwnNzIyx4nBw0=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=ZeZPyvDNmUDANzCQq7ltkJ/jV11o5MtQQ5JZwKODiQLHEZVx/HEBDD4FghYxQtLNBb23dwAkQ563eL1yygQ9jWzrJQA55X4aA+4qEXdiJWs/LTNTcP/99ihQpRKp4q0AoElW3zZEWnFBlQACLZUZKsDSw+byng9nya3Kwhi1yyQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=eaton.com; spf=pass smtp.mailfrom=eaton.com; dkim=pass (2048-bit key) header.d=eaton.com header.i=@eaton.com header.b=vrwkPrtx; arc=fail smtp.client-ip=40.107.94.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=eaton.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=eaton.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=eaton.com header.i=@eaton.com header.b="vrwkPrtx"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=A1llvrZX8K/hX7rIgSsep4/whW35hc/pybFZTueRhhYQM6ZDQBBAziTJ+7sXa2gn2jfA0255u67LY+nI1I1P9l7e/WbUTYYSxc9iSDd+TpIpNGKC6AG9hY8bwMXPBwMFyFEglFo8CXa3lMUXKVtGSvectqx841qxpbuXTDQgMdPi6IWobphdybCcmyUY+1fvsZ77h+7h2//+4FRSAi4zZEqOcWydcZXuntSzG2LdwjQll8gSVh/W0VPEA/5ehqVVdniPuWLxDIT//YGhJe8a+2KceK+e14QfdhosNUo1sEUFr+9cfNDAfjdfGN+yXPJytpMGbtPMpC/XMTyGVv2bNg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NJ8f+ews6xOgXjJqI4j+5NHyxaKFC6UwnNzIyx4nBw0=;
 b=KqR/+23QYAu9J04o0XplHtTsRWTqH8mjqW+YK9lSfrTwN8zMJuH/IGIMxtAz2J+c7dKElHCIvh/tHneAKJb+VXW2pdVMz/L3DntplShrN/gdUAj1nI2kK1e+WRmV57G7MhyIDFwp6Yw/yBN7pCRbwUHSFyhsbL/Hr+NRcs/tEEVMG2SOPEB6+HpqMGpubUq8SVxwgiOtkL+HzYpkNzikvS1AwZ/XuWU1IlD8w7ttgrNQSxUuJGEi03kzfK8teaWAxVLDpoT3Y/EwLzQk8M+9wRDmNttuetR9XUA57ESz7qMFm+8tS6mbY62h+CQOuTW4717hVsUN30FyExtuqGcXLg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=eaton.com; dmarc=pass action=none header.from=eaton.com;
 dkim=pass header.d=eaton.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=eaton.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NJ8f+ews6xOgXjJqI4j+5NHyxaKFC6UwnNzIyx4nBw0=;
 b=vrwkPrtxAekaY5MiW5OQYjkJd6cBZb+Lo81DR2z2uoAGpT+MaRAocgZIZA32P2T3QHUZ8+thUUMYTw0eKd8rduO2E3I7jOZAeup4DQ8s3AJTJ5ZjUaBzViLGTcfXl1sRn4Sys/814vvWKnzNnJQkQBe0FxG2BeqbgdepMdPZ9euxKKqwpDaYfU1mOdhWFXR0jH1JzWpBfNc3y42TxyvK+2T3j2rTtU0W1146oC/qlpKCaplJT1nVhQvsFTzSE26tBZ9qedFflwDDuXuFeyYHPShMBGAnnZf8M1xQvOCH8nigQYUu46gRWw5+PHb/MvkCBwDcALHZp/aNDjzto1xreg==
Received: from SJ0PR17MB5559.namprd17.prod.outlook.com (2603:10b6:a03:388::18)
 by DM6PR17MB4197.namprd17.prod.outlook.com (2603:10b6:5:2bc::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8901.27; Tue, 8 Jul
 2025 15:17:37 +0000
Received: from SJ0PR17MB5559.namprd17.prod.outlook.com
 ([fe80::669:b919:bceb:c275]) by SJ0PR17MB5559.namprd17.prod.outlook.com
 ([fe80::669:b919:bceb:c275%5]) with mapi id 15.20.8901.021; Tue, 8 Jul 2025
 15:17:37 +0000
From: =?iso-8859-2?B?qWluZGVs4fgsIEppbmT4aWNo?= <JindrichSindelar@eaton.com>
To: Ryo Takakura <ryotkkr98@gmail.com>, "rostedt@goodmis.org"
	<rostedt@goodmis.org>
CC: "bigeasy@linutronix.de" <bigeasy@linutronix.de>, "kprateek.nayak@amd.com"
	<kprateek.nayak@amd.com>, "linux-rt-devel@lists.linux.dev"
	<linux-rt-devel@lists.linux.dev>
Subject: Re: softirqs causing high IRQ jitter
Thread-Topic: softirqs causing high IRQ jitter
Thread-Index: AQHb7z/WV/f4z0P2vEGeXptD5Jq9m7QoS21wgAAMziA=
Date: Tue, 8 Jul 2025 15:17:37 +0000
Message-ID:
 <SJ0PR17MB5559C6B9A20520BE72CAE08BD74EA@SJ0PR17MB5559.namprd17.prod.outlook.com>
References: <20250702130909.0bc4702d@batman.local.home>
 <20250706120148.636285-1-ryotkkr98@gmail.com>
 <SJ0PR17MB5559DFA08F96F9A6E2E2E4DFD74FA@SJ0PR17MB5559.namprd17.prod.outlook.com>
 <SJ0PR17MB5559A9917E0B59AA6203C633D74EA@SJ0PR17MB5559.namprd17.prod.outlook.com>
In-Reply-To:
 <SJ0PR17MB5559A9917E0B59AA6203C633D74EA@SJ0PR17MB5559.namprd17.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
 MSIP_Label_ff418558-72e5-4d8e-958f-cfe0e73e210d_ActionId=b43ce4dd-939a-43a3-b779-feb5bfc44623;MSIP_Label_ff418558-72e5-4d8e-958f-cfe0e73e210d_ContentBits=0;MSIP_Label_ff418558-72e5-4d8e-958f-cfe0e73e210d_Enabled=true;MSIP_Label_ff418558-72e5-4d8e-958f-cfe0e73e210d_Method=Standard;MSIP_Label_ff418558-72e5-4d8e-958f-cfe0e73e210d_Name=Eaton
 Internal Only
 (IP2);MSIP_Label_ff418558-72e5-4d8e-958f-cfe0e73e210d_SetDate=2025-07-07T12:53:32Z;MSIP_Label_ff418558-72e5-4d8e-958f-cfe0e73e210d_SiteId=d6525c95-b906-431a-b926-e9b51ba43cc4;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=eaton.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SJ0PR17MB5559:EE_|DM6PR17MB4197:EE_
x-ms-office365-filtering-correlation-id: 4c65ac17-72a7-44c9-f3ef-08ddbe329269
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|1800799024|366016|42112799006|376014|38070700018|1580799027;
x-microsoft-antispam-message-info:
 =?iso-8859-2?Q?JEbakvL7tF+6yCRMTvnb0nJdBrVW0mQNV5OqLxU+u5zDMfJqxybWKVzpp7?=
 =?iso-8859-2?Q?w/pQ1mdeGoag6CgJLBGexqfb4zdzkb0liFS6URE2m7op5vvrG9WEVH5wdz?=
 =?iso-8859-2?Q?eW6XrVOyA74w9B9bnaGpgdGl/DvrGC+Hey9i0cshQCJrsB60LO4dmr2eh0?=
 =?iso-8859-2?Q?X2NUZk4/xUODPxMYWst6hoGC67nHJ+23DfvV8uNlus5ETBoBw2EaHyefOf?=
 =?iso-8859-2?Q?4GsRvTyio9cZw0/l09k7mXDprHqhXjXSkPe8aH3wdGYpz+ICYUXCz/qiKO?=
 =?iso-8859-2?Q?eMPzuWc0baDshJ5dsV6cyqp8TzQigfeRvv4WY8jgou+D5D2RaLqi24HTaF?=
 =?iso-8859-2?Q?3uYS+dJqw4JrGXGDu8752eNYRZD6uNjnsKOLQ9x3YwYgnMGeQRcTSrMS9w?=
 =?iso-8859-2?Q?Kp8s9ClUg0XCEWAm3yLi/iu+qY873zy1g3B7FAIqrL08VwjxLLEpoyzTDm?=
 =?iso-8859-2?Q?5qJ2+OiLACYdrhrIOeqlJlQuRZdL76WokrgUGX9BT/qaX5GU2dGjoZ6Swx?=
 =?iso-8859-2?Q?emlntnOO7Nri0OvL+Re4EGVj+9Zdhpe3pEtNqi1w9smzh7Ps4lVVnxh1Bl?=
 =?iso-8859-2?Q?ynKAx1MRRDXsw+ritl5DIrp+Ef6DKR7kN0L8E/jesBM3t+pIAblL5jPk5w?=
 =?iso-8859-2?Q?MFitrPCEqiO5OT3Ch1b63/8LlA5EsWjYkzh/Oan+f5V4sTtHLdaWglGV8/?=
 =?iso-8859-2?Q?h536DwQ6nH48+wZvjzq1FljqaBxsNspbuOJxru018QA8tFtbDRdI3md/Cu?=
 =?iso-8859-2?Q?DXUAzWTJrurwT8LC2g6yMeHCSoAdIaXB0BdwxNk9RZf4x7fZdhArO5Em+Z?=
 =?iso-8859-2?Q?RwB096EBIozoR7BIQkure+wHO0/xkBRj0Rv58UYg7KzEpMDiD9dW/ya9eW?=
 =?iso-8859-2?Q?8k45XLwnVG9qoLvhn6xpdeAk9sc7CeLAxNRTv1Tg9GkeysNLZpMsEnnCld?=
 =?iso-8859-2?Q?3rUy+vKzv363VBOjzxD+Wa56rsqj2maVhVVN+nLWcqD+2CXdbFBLpFJ38X?=
 =?iso-8859-2?Q?PKZEGc0Zz6lkqDHzmS3VBDRB6bSn36b1o0InM6x1z/r/9YAr3buSC6iUaR?=
 =?iso-8859-2?Q?AYp/OFE1JyU5gEuNlMfIwTSk8kLpjmVyVqgltM0CdTexpVRvjZyUbmbV5M?=
 =?iso-8859-2?Q?anZl/SMzmIwyJy8JCWXFXzdC7O9dOzqV3DlClDsxCSl8Z/YLAPSyaeUhER?=
 =?iso-8859-2?Q?BgtoYvpKD1DV7mEqg2DTc1sQ+3KZ14VMhYKheZUaIyQHP9hjsCb15e60m3?=
 =?iso-8859-2?Q?vPcNN8fv2R+Ac6L9KieoEXmJ1E5il9HnWB3pP3CqJdOV7uBxizeBft3KMv?=
 =?iso-8859-2?Q?UqnVewTxOps7d6by+l5HBifTck8ooujGlGHCiODj+Fw7iXpR0B2izBOf9H?=
 =?iso-8859-2?Q?04rCRpV14rgnCUIH+Ep6awZQ0OthNbP+rfAO8CpleWWfLdoDXpXBIZmv3Z?=
 =?iso-8859-2?Q?blq/ezKIEUeUjTpsZ4tVukX24pvXBLqFNc3rkNglzUqrlF2Y/mF6JtHcsG?=
 =?iso-8859-2?Q?Yv9NWWV2nqgNSIjPmL/LLZ/XvZ19Kr5A+braQpe8fmpHTmAN43mMwl/2p6?=
 =?iso-8859-2?Q?1YKBz+yh9cTti+FBWr3ejIkIoL2v?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR17MB5559.namprd17.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(42112799006)(376014)(38070700018)(1580799027);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?iso-8859-2?Q?gRs696FBv2v8WvvVxWT3ilEgAuRA4Vvs+PQgCIvGtX/MCMH4xVxHGCpnkK?=
 =?iso-8859-2?Q?DdyU8mY7yHYjX3620g/aZ+359MZeguMEB9zumN/0adcYjG6b03HaTxjyi5?=
 =?iso-8859-2?Q?utkI+8/YbG8JLm8jEP6MFaZwDR6mGVE6GtTETq/AjOBOaKMDv+Q6RhSeKp?=
 =?iso-8859-2?Q?v8fLMO9/SpurU7ZRsvm1A+UI9rrBwasnP2eXxzIYS01mk12yvF4mQsKd0I?=
 =?iso-8859-2?Q?LxKxKbA93GheEl4OkdXmUCa1Yjl8tMC83dBtl4BAj6TwlvdcIUKoQyeP+K?=
 =?iso-8859-2?Q?FS+0TkXO2BC/M0IOFttdU1I/Lq0jIKWkTlKO+Ynu9EiMKTJJXcduCNiuQi?=
 =?iso-8859-2?Q?OjAxywksqqrGvM+yTXmj1eXP3f6u5b3V1t0JXqzigtosRirNuE7nxOTYd1?=
 =?iso-8859-2?Q?REnkLfjh2mpFoypiO4gsDb8WdDVKOTQQc+K6/RPKzfRRckZDKk4oMeWQ+b?=
 =?iso-8859-2?Q?zqOAg8g5yVdu/l6BGZo8zojw1y0hxpTD2E1MTuXD4Xbhd5UcotBKnWwA10?=
 =?iso-8859-2?Q?k1FmkfXqR9V/nsne7lYwtBV7HhGFF9NvRBBCSc7YBC9jBICOB0aRcdbAFO?=
 =?iso-8859-2?Q?qoteU6XDB8mj88+OCHe3aNbEwOGsXWpDy7vaoANNqnSE7ma0k3vsx4JGQV?=
 =?iso-8859-2?Q?S7ux8i3If4i8YPizAE2j/lc0qPhMNmOzand+t0KS34Jh3F2QFLrW2Lh0U5?=
 =?iso-8859-2?Q?Q+ymXLc4UyqrKixORiLBdmESZIsFFNGpOqzeWtSm7SkCb8m1uOrdYhosZJ?=
 =?iso-8859-2?Q?UlxQFS3U3elNpFTLnZ500WAspBJUyMjYjBnlzH9ZuKpeu0v/XheaBmDOQZ?=
 =?iso-8859-2?Q?sAAUEyrZKTlnh/Km3XCYjGYsthg5yK2yi30IJv82ZqQUiXktDIV/8/OcSS?=
 =?iso-8859-2?Q?Dx5KnHArpaf07ar/AbhGXDETiRK03wX/JjaCDQqf9A4Z59w/ZRGRQed3Ni?=
 =?iso-8859-2?Q?s8npf1mYQx04j1bn/WP/1IOx+VGRWOV57z4DhfoyLSMFkEpcPqxNkZzsXZ?=
 =?iso-8859-2?Q?DExn/xKMaMasJSXs7DZrSzq8rfZ4c959lMFqzrPJ5n3wVvoE/eiLW6OuEI?=
 =?iso-8859-2?Q?FwtvzsWl0h6taGJTC+ERp5Lo6lUJiFY7dpP3gtGwigGNMHUY1JG3AFW2wT?=
 =?iso-8859-2?Q?NIiByeSn2LiRSjV/2gOMd5mz9RnHYi53jcU78OEqPbrmknen5OEOfeQlN6?=
 =?iso-8859-2?Q?BUM2PQyf8FgGYg9Tdu2GqDVGpl0IQru8lYLhKMthqMUNdvIQorUzSQ9FKM?=
 =?iso-8859-2?Q?MgnlliKtK9rN6BlGbarU847v2gXUlSGUZPWRIzA4lHldIxY4dcBulNf343?=
 =?iso-8859-2?Q?Svs65ALPBqGFUApDwqTViaFDPVcKsvrLxF9FXlc6VXVFL1PcCpfOs6rxDl?=
 =?iso-8859-2?Q?ltyX0KwoHfITQl3mxEhWSbz5kAJHOV8I2Wlw4r0HFvu68sWpuptku9IOzk?=
 =?iso-8859-2?Q?fbk6rJJr4bE7zAATjc6w5OspiJ7EiJeqXFXECWJUianAegLNEkrQkrudi7?=
 =?iso-8859-2?Q?iiGf7b50KTFIZRZjAMmWhm0P+t+Fy6TvEvK+1aQAuW2hKgt8xJ06b+lkek?=
 =?iso-8859-2?Q?gzqsrO2gbs5QshhKVPpVU1uwIvY64zQ04kBk1CJJI35ZEUT72U47yj37Tz?=
 =?iso-8859-2?Q?Ua8FQ11Zp8mb6mzvDWPfttNDkDdV0XIPV/?=
Content-Type: text/plain; charset="iso-8859-2"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-OriginatorOrg: eaton.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR17MB5559.namprd17.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4c65ac17-72a7-44c9-f3ef-08ddbe329269
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Jul 2025 15:17:37.0322
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: d6525c95-b906-431a-b926-e9b51ba43cc4
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 8dHzvVQAR4IYqp+O4wuIx2B9fVQ8nP82WbyUd2Yp9BybimGK0lXZSwsEZSlaBBKzFQ/1KEem5Azvig+GD0EIe/V29q0K+CWemUdOMqwiJN8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR17MB4197

> I think I'll focus on different ways how to reduce the number of
> softirqs occurring, maybe trying to use something like BH workqueues
> for some of them (NET_RX and NET_TX come to mind).

Correcting myself before someone else does: I meant threaded
workqueues, and now realize that touching the NET_RX and NET_TX would
be a bad idea. If anyone would have any suggestions on what I could
move from softirqs to a more manageable mechanism for deferred work, I
will be glad to read them :)

Best regards
Jindra

________________________________
Eaton Elektrotechnika s.r.o. ~ S=EDdlo spole=E8nosti, jak je zaps=E1no v re=
jst=F8=EDku: Kom=E1rovsk=E1 2406, Praha 9 - Horn=ED Po=E8ernice, 193 00, =
=C8esk=E1 Republika ~ Jm=E9no, m=EDsto, kde byla spole=E8nost zaregistrov=
=E1na: Praha ~ Identifika=E8n=ED =E8=EDslo (I=C8O): 498 11 894
________________________________
