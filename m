Received: from CH5PR02CU005.outbound.protection.outlook.com (mail-northcentralusazon11012037.outbound.protection.outlook.com [40.107.200.37])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 648A5208D0
	for <linux-rt-devel@lists.linux.dev>; Mon, 27 Apr 2026 09:23:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.200.37
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777281823; cv=fail; b=Q05wmcQzRpmQB9JweXWUR9ZtQsrdKAjoCkkiY4fnxSTJ5RYRD4sck5GI2swH0d+H9Hygo7pIWESgYwbPdZ5+bnQJzHbFBmmZ1m3q2TYJ9qbGlK7pf5Sag2ric/vP6jY6f1L0dgt8De4+zlHYCRuadWH4Sqn055rIRGGbafYRjKk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777281823; c=relaxed/simple;
	bh=xPz+UF7hxLsDRthFAMlm/CrJ4ivUaulTVx24h2nvkx4=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=oA69vnt5OA6KNNoxwM5AWJJMZSGEkWn8qq7gcZrDtsEWdWak64py8spkpY9ScAGWUZolmqtii3DkRd3GfS9ViILc0npOd/DYcyZQvnGR4IWXkaEUmj8V/14hub4YEI91LKdtSgjSdkbnsowYzxFrL4dc37zAOQ7IkoV7WaqOjnc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=IDvs47VW; arc=fail smtp.client-ip=40.107.200.37
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="IDvs47VW"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=yDdCwhm2I3iqih1Dm1wenGjMQO94nHvxwN0OiZkuzbYizTdrAJjsNvmdJo0fLuWPCI6MXj/lDPUYbYX9NBfflphKFyPqpBtnsCgfnBEnQFYZFPFxWdvJvAc3/aiCDdGqMPzTJmtEEsGGbfKe7fqW6LQgikTVfnUghiV+kEqkxcybnpAM/uqfTwKtNc8nOqMK2AtSH48tog8q792TbzGIhxMg33JKOURLqUY1HDXkPmzR5phENUUGL9Py3a02r/2Jq6LDXJs6gHKCM79FKPFr6mo9w5QE9RZR9eSB9U/RaHkwND9CkT1P7s27P4yavmhkWwXnWmpyJYzSCdxiPLbqoQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xPz+UF7hxLsDRthFAMlm/CrJ4ivUaulTVx24h2nvkx4=;
 b=LAm86CtJ/DGTIGCa8fgtusPWjk651YpV1BsIez5E7z2JEQ+HZ5OQyrYzUhL7VleGPuqu2XLWPxPJ8QBz3Q13xlkbw7p/j3vRP1sGT60bTLbwGIO4++DKAkj6mg2rhiEpir3AcpTPzDODRvVhlJNdsJOygVNOmeH2WHe1Vq2d2ws4DcYc74pWc/YM6ZMQxTNB/OQFFEVdgOjFW/ceR1pU2lQftaoIT50/fo+8XZJAtvVIbpkYqvOhvgbj5B3w1c7OfBu8q8/F7WCgrbxkPIe5DNIBXoevo/KqUl8Qp8c4e+S7kPJQy4oqS7lHej/4mp1oHbBDbpcPRHYLxU0UjAHXrQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xPz+UF7hxLsDRthFAMlm/CrJ4ivUaulTVx24h2nvkx4=;
 b=IDvs47VWbyEgElmU5nZXZur9+ulOJSfPE32n+ZMa6oMZLeGSokFjyGM8Ony4+8BcChN6Dxy/WEtVOSJ8QsD6/lJFMMcaot41lwrmreU8sQbxMPR47VsXz43LdnMVH0/Yi1mgTSCBmNaVBq+QaPY0O834uR4WEhAlnjG2/mRNTFs=
Received: from IA1PR12MB6307.namprd12.prod.outlook.com (2603:10b6:208:3e5::22)
 by DS0PR12MB7780.namprd12.prod.outlook.com (2603:10b6:8:152::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9870.15; Mon, 27 Apr
 2026 09:23:38 +0000
Received: from IA1PR12MB6307.namprd12.prod.outlook.com
 ([fe80::4739:b181:8a2b:89b2]) by IA1PR12MB6307.namprd12.prod.outlook.com
 ([fe80::4739:b181:8a2b:89b2%3]) with mapi id 15.20.9870.013; Mon, 27 Apr 2026
 09:23:33 +0000
From: "Ostrowski, Rafal" <Rafal.Ostrowski@amd.com>
To: Bert Karwatzki <spasswolf@web.de>
CC: "Varone, Dillon" <Dillon.Varone@amd.com>, "Hung, Alex"
	<Alex.Hung@amd.com>, "Deucher, Alexander" <Alexander.Deucher@amd.com>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>, Thomas Gleixner
	<tglx@linutronix.de>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "linux-next@vger.kernel.org"
	<linux-next@vger.kernel.org>, "linux-rt-devel@lists.linux.dev"
	<linux-rt-devel@lists.linux.dev>, "amd-gfx@lists.freedesktop.org"
	<amd-gfx@lists.freedesktop.org>
Subject: Re: kernel panic when resuming from hibernate in next-20260406 with
 PREEMPT_RT
Thread-Topic: kernel panic when resuming from hibernate in next-20260406 with
 PREEMPT_RT
Thread-Index:
 AQHcyCLT+fim4XOC0kmlAbF0I1GUirXWuPGTgAAB0YCAAF84wIABLwbTgBjULYCAAaF9CA==
Date: Mon, 27 Apr 2026 09:23:32 +0000
Message-ID:
 <IA1PR12MB630726FFADF30847A8496012F8362@IA1PR12MB6307.namprd12.prod.outlook.com>
References: <20260409131411.10598-1-spasswolf@web.de>
		 <IA1PR12MB6307858BAECC7CC3AE8AA958F8582@IA1PR12MB6307.namprd12.prod.outlook.com>
	 <a67b9159f69e8788a598fb459d8e6d99d1776f2f.camel@web.de>
	 <IA1PR12MB6307AC51F4C6E4A77BCB5EDDF8582@IA1PR12MB6307.namprd12.prod.outlook.com>
	 <IA1PR12MB630789B32C2104D1FAC2B761F8592@IA1PR12MB6307.namprd12.prod.outlook.com>
 <a1c86a3b83e26d86f95068e8005ce4b2efdca23a.camel@web.de>
In-Reply-To: <a1c86a3b83e26d86f95068e8005ce4b2efdca23a.camel@web.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_Enabled=True;MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_SetDate=2026-04-27T09:23:32.645Z;MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_Name=AMD
 General;MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_ContentBits=1;MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_Method=Standard;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: IA1PR12MB6307:EE_|DS0PR12MB7780:EE_
x-ms-office365-filtering-correlation-id: a17b4bac-f66d-42b1-499d-08dea43ea6fb
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|1800799024|376014|366016|38070700021|56012099003|22082099003|18002099003;
x-microsoft-antispam-message-info:
 GCLtmb/9GobH6oxxrr/g9wQEEW7ON8a1gE2n7mWaxJ2AECIOzkC332a6fUEYaKEu3N3ozNy8zkinPDpIzSC6EFLDm1k2+WtKN0AyImZJFyhF5pKQc3gNJRJh8ZzOGhpXwMwc/rWV+lln2NmlmFCySRdoDZl69cspdRmk+MNcYBhKn5MLMGruXIZrcs+V7dI6FQyE5j2AWJAhi/buQwpZg4zecy4hXZWaCfOsHuS2vdaPEJWBtp1YYZRzBinumuaNmCH5UGv7L+ey06NoTu+mYu4vFcouMedPVB7EHRHjIpUgJd22eaTreFL08ZSWaeLGPGEuIEMNOd+vNwS8DY3WXtbQeADccOeznKR5lB/PNc1QRDsbiwKSxJMCJwrWsZiPSWqEA5tFLtXWeckj3NcTHcl7iBVTdL+tX4LKKBIQz2HqQ6FPRu5d/tlhDilq6HGDdbd9txpd0iYY3J4/Zd9ParhUe86zhNO9VTygoplaM66qClFmuPjvNet/NW+gVUS3ndty0Ior8QxjfNlk7WFM9fLPX+1kt5pdxtYmcAt0Ls7GT4Y7XbAPai3RYK4Y/+Vg1sPU0vMhaZuPg+UhsZmZjLJdir+rSAua1PE9L9bTVZBRFCsLLOxoj/iKXD+KT41DAOBy6ul47iUCL2XMLIgjXlc/sQExhq9QLJvHdke2kUEtncxNB0Ez6sN/lQ8dAHI3hkm2oPtkvacA0g7qBeEzq5RyjflhJNVNWH2zVHKPYEjXpCYEQOsRT6gpujIOTNWN+SP5mTqsxD3BTZet7h7/IJAj3PpRnqZCFpaqVM+PXnc=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA1PR12MB6307.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016)(38070700021)(56012099003)(22082099003)(18002099003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?iso-8859-1?Q?OiMhnR00wbXuGhbSrS/uE50HgTSnZnvgezWqz5HCFWaV8+nrGhfpJpSKDs?=
 =?iso-8859-1?Q?earahL2exJTtAh5Wg31FLjiJkx72T/c1rr427M4+W89QR6JElzTkC2xUR1?=
 =?iso-8859-1?Q?6HgOKVI7DtQbiWK8xKK/rMIwRHfAkJ56OJm49uWELC0Y3p9Io+QEtUaIK/?=
 =?iso-8859-1?Q?KEtLYfexMRiULFuY7DLMUUqNtpC6pBzb2BYw24Y+cua3SI+kMOKt1HEocz?=
 =?iso-8859-1?Q?uAOl30/I65btpkrNConE004s+2iUMgrIABYx+gauvFq6fFWm0EVso/wPIb?=
 =?iso-8859-1?Q?wwwPRJQn/fZXfhQdJF8TTzo9QYr5ICgp+nzj6sATVyFtHSLlhXab/I1fMn?=
 =?iso-8859-1?Q?lNDnOXMlne/pdGhDjFThbLk9wbm/DhSlnLAsCqRsvZFJkM3+pfxeZ4SU2d?=
 =?iso-8859-1?Q?TpLz1MrB+jbRX8FcBV93cotLR9VDv81PQKxuHLgJ/Tx4cZK0/h9aXn10yG?=
 =?iso-8859-1?Q?9c2AsVJQ4IP+3QP/bqEG/dIVDl+BUfkM5p872/GZRYIKRbAvd2NIJngaIW?=
 =?iso-8859-1?Q?BMvpYnm+KrcWPe8gxEOTzOEUs9P4wKlPVQu/1m2L2GS4FtrfSxPQeITjoI?=
 =?iso-8859-1?Q?Ln0eHJnprfyM5YRNY/e2/A0u1xSTwTbtZp0hzsCbkn+GzMnrZIIl+fcLfD?=
 =?iso-8859-1?Q?pCAtyJrRPvL74LMJqjXhSBkOWsR5z8lafaWMBShCf1cgAaEwwLsKIW03jp?=
 =?iso-8859-1?Q?lf8bMT1xjOGzRQdqcUlmMGRAW3D3gH+1S8zQ6RrrbO4t51n0DFY9Z/xY+0?=
 =?iso-8859-1?Q?xsbOoc6WXrObpCws8pEya5bTv/+kMaXJnwqsTucaW8X9S8dCK1GkiS8GO8?=
 =?iso-8859-1?Q?bT1gMdXUo1wizHgNMtmeLyvxRuqX+vv1b4hEpwgc2EfdLQVkLvnr+nQ1Nk?=
 =?iso-8859-1?Q?CTq3RbhAJX5b+5mwcjzIqRwJVZbrFG8Sx0WDn0UaJMPbtF0+X2krRfR6A4?=
 =?iso-8859-1?Q?dK3pfli7iZrR7no1CU9j4+PKLJ0qFqmi5fiPrmsi43By5uAPumYwb6j8Os?=
 =?iso-8859-1?Q?iSpMoas+OKIHYMNkTFbrgPr7I5/oJZKq+3+s5qKNAEPa1sD+aee9z0uDoN?=
 =?iso-8859-1?Q?SwNPTwXXDZNxWWwMnBLoliMgx/bghZhvnCdlRGHaOt8R6Kx9tX+J+EI1Aq?=
 =?iso-8859-1?Q?oGM5tIQZolctz+Mt3LXQUEbBrJ6HhqbQiGE500dILlnu21x2lK7b+mxqGK?=
 =?iso-8859-1?Q?i0NS0uwXfl1NDB8umKUwygTQy+19++YuiSvU6uBc0HNghN6Mbq9QnZttOO?=
 =?iso-8859-1?Q?hD8vUYU9GaVqW8LIEZNLUflk7ZhYjN66+U6TXquxYC2caial5fXLCc68Ky?=
 =?iso-8859-1?Q?W7nixhvmJ8t87EFTIYlBzLwjcoowxfO4Fm8IswTy+MAdupyiqWyaBT5GeK?=
 =?iso-8859-1?Q?p7swdDWZ17dYIaJFWuRsA6bdmoJ2eQyzmb1xTAEoHUpsxMVsfGrXMzgEHA?=
 =?iso-8859-1?Q?Q/sgk7ZGt9h3lBGTVCAMuEMmUCIUMsjw8DugK7DmMsoXIaxlxd1ywAHfPq?=
 =?iso-8859-1?Q?XX995cuDFPkw/zWFXv/WsD5W5XpyYmyBAMt1GrBa7iTS2Ts4U0bGm9Esvn?=
 =?iso-8859-1?Q?lEhxXG4sZxJfC0vJLu6nRxJ4oAdOHdfXO4ZTlQOtkVFm2d1/xr/QFTLlDB?=
 =?iso-8859-1?Q?nmQKeKSeFT46/1idZHrTpuRSy3HrkCKB35EfmLqFQttDpnNvVzvkYDjp6d?=
 =?iso-8859-1?Q?tu5RG9/VTBRKWPiKPHUMbSe1MbF5wvn//KQk4QqBgYUGbrWRRA0Jc6EXlF?=
 =?iso-8859-1?Q?tASnGBQZacViMITZWOCWLF588Hz0mPTw9p1qexGD8RgHZT?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: IA1PR12MB6307.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a17b4bac-f66d-42b1-499d-08dea43ea6fb
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 Apr 2026 09:23:32.9216
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: xQ6Vg0JDCQlX1Mj2JmvO9vwga/OKUiFBhWpHjHj6YE6opBIb0TdRLxy3hpbIIC/tubxo7rMFcfAbSmuG8mWUbQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB7780

27.04.2026, Bert Karwatzki wrote:=0A=
> So it seems that commit=0A=
> 8bf0cb97edb6 ("drm/amd/display: Move dml2_destroy to non-FPU compilation =
unit")=0A=
> is the commit that fixes the issue, but is missing the appropriate tags:=
=0A=
> =0A=
> Reported-By: Bert Karwatzki <spasswolf@web.de>=0A=
> Fixes: 3539437f354b ("drm/amd/display: Move FPU Guards From DML To DC - P=
art 3")=0A=
> =0A=
> Please fix this.=0A=
> =0A=
> Bert Karwatzki=0A=
=0A=
Hi Bert,=0A=
=0A=
I am glad to hear that mentioned patch fixed your issue.=0A=
Small clarification - amdgpu is not designed to support=0A=
PREEMPT_RT flag, but it was still worth to fix as obvious regression.=0A=
Sorry for missing tags. Unfortunately change is already merged.=0A=
I will keep that in mind to add these tags for future changes.=0A=
=0A=
Kind Regards,=0A=
Rafal Ostrowski=
