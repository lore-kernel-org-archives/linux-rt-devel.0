Received: from SN4PR0501CU005.outbound.protection.outlook.com (mail-southcentralusazon11011056.outbound.protection.outlook.com [40.93.194.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3EBAC8BE9
	for <linux-rt-devel@lists.linux.dev>; Thu,  9 Apr 2026 19:18:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.194.56
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775762299; cv=fail; b=ohaHtDXYdtrD9k8OqeWLoHcrQIVV5iL0iWoCZxh+NSz3Ih1nSLUDYhA8D868ryILDRHFnBQNAaZ3jgnIavEnFj93U6sH/QqIxn9LZ36j5NsDvheNNjg2IeUsgXIhqCL66rPSng3HSkUyx9UIGVOlbAGHS1ghQrbP/b1V5fbV7uE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775762299; c=relaxed/simple;
	bh=f3GbJ2ORhxKmb55/Tk28XZGepRfEU/gdz+VNJEgwhcg=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=SQIFywkNBuJqlvw368CCL02nflT4JAFTvX1bz3gJKVhhd8drO58So76B86DrARWOiAxluDfjr43Vx+lUitiiyAGg9XorzHgFytYVdl432ZFMAHQaJfPTAEzRXO68gt3EmJWIBmb990JZRfwkjwb2aijsUcGm41Zx/10FS+2QGlI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=JTD8q3Oq; arc=fail smtp.client-ip=40.93.194.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="JTD8q3Oq"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=hu97yGfts9YKcKgcgx90kPkMRFL5C5lQ0ZsrbhFpssLpARxcgR4nrfWmGFH3AEaR4BEFngOMkhHvEV7WCZR8lQzGKLpJcKMa/k4UI4GswDoDlYJk5t8SQMyRUSxQwBRGvqXvqsT4AIpeZNPI1d+CJcEJVbiu+f8osq6g+xY4DUct6oJ3jW8A0DUIxkF/K3Iqw2tCm2AniOc+hATKXtd2fKoq1wDpyw1VPVXj89UdFIqtQCdvwiMcNatK09aG8IbLxpufxgEvMk+vLtIu7RFeVHAtlL8VX7TsgzYofXKKfFu/nvx3GVqUfpw7stRYL2Wj7IVlZg42tLgDlgVmCv1aHw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=f3GbJ2ORhxKmb55/Tk28XZGepRfEU/gdz+VNJEgwhcg=;
 b=rZkLBGMUpj04RryYUkhs4sF2W2p5j4XI+7sV03wCQmUOoD04tHw8E1HIhPxnTEbVAAiP4FtHyC9kdFlCYO3WVIYGDp/XY/E0YPI5GwvoCrrSr3qjS0d1D51gL8hmTbmcqaX/eTfWPJnNSdxkR/fm2WPjC9ABlh6OZQyFE6Wnw4sVUMAbG0UAT+r7RFHPA2F78QSNjDB1YE0hvRyWo0Uunbe6yMF8wODARR5ZFM4l+FPKuUv/qrR4my5ZialBSLbt5pWqCkGSjklo/gDsKMriDdFqubRG0rY00A1jTD3bix0GaegJ7MczhMGW/psIxC0bfRlVOCp7zCIQJ8oqCdM+JA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=f3GbJ2ORhxKmb55/Tk28XZGepRfEU/gdz+VNJEgwhcg=;
 b=JTD8q3Oq6YGaOiTU7nsOdQBmxQUaMlFRlPPFemN9XaQCdAx5XcHdfb45W+6KvLCWhoaSoYxi7qdWp9Gn1KTWnO6cdN3aJdN7TN3pKJ0T0mZuRnYfb9trDNUaJCT2vmsozzdGQs6FWoVGzC/aMpHjz3UDWfvoXneBgUPxiYSSH/s=
Received: from IA1PR12MB6307.namprd12.prod.outlook.com (2603:10b6:208:3e5::22)
 by BN3PR12MB9571.namprd12.prod.outlook.com (2603:10b6:408:2ca::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9769.20; Thu, 9 Apr
 2026 19:18:15 +0000
Received: from IA1PR12MB6307.namprd12.prod.outlook.com
 ([fe80::4739:b181:8a2b:89b2]) by IA1PR12MB6307.namprd12.prod.outlook.com
 ([fe80::4739:b181:8a2b:89b2%3]) with mapi id 15.20.9769.018; Thu, 9 Apr 2026
 19:18:15 +0000
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
Thread-Index: AQHcyCLT+fim4XOC0kmlAbF0I1GUirXWuPGTgAAB0YCAAF84wA==
Date: Thu, 9 Apr 2026 19:18:15 +0000
Message-ID:
 <IA1PR12MB6307AC51F4C6E4A77BCB5EDDF8582@IA1PR12MB6307.namprd12.prod.outlook.com>
References: <20260409131411.10598-1-spasswolf@web.de>
	 <IA1PR12MB6307858BAECC7CC3AE8AA958F8582@IA1PR12MB6307.namprd12.prod.outlook.com>
 <a67b9159f69e8788a598fb459d8e6d99d1776f2f.camel@web.de>
In-Reply-To: <a67b9159f69e8788a598fb459d8e6d99d1776f2f.camel@web.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Enabled=True;MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SetDate=2026-04-09T19:18:14.701Z;MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Name=AMD
 Internal Distribution
 Only;MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_ContentBits=1;MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Method=Standard;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: IA1PR12MB6307:EE_|BN3PR12MB9571:EE_
x-ms-office365-filtering-correlation-id: e244ec53-9023-4e73-b0f8-08de966cbfc2
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|366016|376014|1800799024|22082099003|18002099003|56012099003|38070700021;
x-microsoft-antispam-message-info:
 SRCM1hVovrvkJHnG4Qdv0+982QAnAQEc8d97HXTunY8pCG8H1ikVj1t4B03TJ6c2Sr1FyM6t8l5zfXqcbwGKvbM+xY6iyA+7vMU7cCDMs0AY5EnRWDr99okeWaQFU2tWXq+P8G369rLK3+/4D7xptbs75IhQhxmMekM0TRdm7qXgWcIvVaPbiidNrcXGw0mrRuNvw0xGHYd2amXMVIQXOuyUa9ZUPNTDVsqCeDVE13dQBzACB2Bf+a9I5JVC01OI7xa/Qzc+nUp/sWTp9e2+/ve0YOXuCsC3yb/qKlfGVlFGTv7IBu2kD90Wi9H/icCSx5CzcX3RrXLrbk2YBgDniRLfQt0EJ54r1j6x+ZYp481+GYoUqcg13ixwULBacQ4bYpFRLu3GZFvXAHL5DUV3jLycSTqcRzr4VeUFz8LABujpebHFqWszMCjJVMYQ1TlNgl9GYG9XHHKg6ZV7siR+ZkGfk/tenmHK6cxBOr0vjYjOrxMQk/jTzWICWVA1HCkK4HjOAQmlZid1t0n72xKfzFkcdydiERTK8jrIC+VZ8SkKwfEPhunQGwg0x6kW6dJC1RaTxIz/SOHYD5q6Nqv2owwHKTK4CWlBLXqz18k1BJ91X9NZuvODhGVTmtFFIDQ5sP1K8GNCQabP8NnLM1XGU/Xs3AeXyzvdGgzYOMSk5sDTsKKLIGsm2uo3MQR+hV8NJexbV3IU7akTIRKwLXNmhCkNMRNqrvgXzJjOA0QmBfBa84LNu5QyPPFmdoRVYcn2ZT+Twf/xBgdRWE9iTtdbNDhQXvd7WNM/ZN7can739k4=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA1PR12MB6307.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024)(22082099003)(18002099003)(56012099003)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?iso-8859-1?Q?ZTugNW+nAF5zgDwZVTlr4YZV2Eyq7+8aCLHOX/Y+yXIo6hvoBDv9dX9ZkQ?=
 =?iso-8859-1?Q?ufGm5YLiYYz9zREgUlqZbEraOUXDyoif+Nu47dGL9yXZl0NbH64vfItHiQ?=
 =?iso-8859-1?Q?+YEetVi7xOwqWcyQI28H5oGmMg53wp8yBqRihHNdEdi6Y+Oc/Ywce4EHEe?=
 =?iso-8859-1?Q?O8QFtPkFz0r1YUIn53ImbcAzUtatNoc1fKqC9NZbtbK+/MBv+CGX7rJeP/?=
 =?iso-8859-1?Q?DKZVBxjEkEATrgLrnCQyqkuvp6E2KYX4d6M8mmxnZ0lTn/ek9yiVXrfvb0?=
 =?iso-8859-1?Q?sUCi94lITS/dJ6JyBhc63J/Tif/3QtC+8SaXEtGhDfbX7OY6m3QpEheDmz?=
 =?iso-8859-1?Q?ERRpxmea3/NAu6/xG+08hm9faI7x0GmD5FgQVuvYN9WpsyrZx5A+fJwOYk?=
 =?iso-8859-1?Q?PZSkOxYwIGwHCOQWf+XHRQ9OQlFb0uTB+8fEnHOOr5c+xtrOQijiCPdvWX?=
 =?iso-8859-1?Q?DTpvrBIdirVVxWVhTmG7N/UUKevzIP22sbTjMdNcVgZg7wnlg8rB9Gj3Ka?=
 =?iso-8859-1?Q?K8rYYAr7Ym/R+BATs1C0BfOie7Dz4Y8unKEi4w7TRZZ7AZFtDsT03Vfrpw?=
 =?iso-8859-1?Q?wapC0kdQ3rUGhdF8Vo58rgY4jrwtPOGtRcmaGxpxBQ8AR1UnDOtP1dumm+?=
 =?iso-8859-1?Q?zKootLCaQbWBwyOkg5nDTjZKpqENWXz5ej3kI0KrsnYfsyxEM5N+4D/UK2?=
 =?iso-8859-1?Q?bNmFlcec5NScR5UK5Szo8ShiPSSbF8f5SjgyC3wj6Fy5vhlTeZuoX7lZ7/?=
 =?iso-8859-1?Q?VSz1HinxDFGb3iU7Qvy1wh8G1jtWISoSbV+qsO5KtEoGUANOzy//o4f4Vs?=
 =?iso-8859-1?Q?erq/z8QdwkssUaZWJlc7OlqFiVtY9UhOHnC1UKiS+7dRQeRuxEgBT4vgbh?=
 =?iso-8859-1?Q?QpnPd1+J3u4xqgZeLmsLAz5mXRhvIJYlwA9MYN4x91l5Ud0OpgrxqjXMTq?=
 =?iso-8859-1?Q?MLMtQhUsvPiOO9ivNCFFASj6Z5cugnJKiAHXoLQI9mzd9DAbBGvOm7R5Ii?=
 =?iso-8859-1?Q?SC7/TMaYJWrz8rHVQQxp6MWIyo9TBQkenphZLy0OmtLaxe1nBuPwK43A7l?=
 =?iso-8859-1?Q?XJAehc4GZo8FI7XEJ1RHkjTNpO7O5Pc1G/0T+Y1p4xQ7x6PHWIztMNXvBZ?=
 =?iso-8859-1?Q?gl88EosvKDa/rjRlXTLHguBG8qICz0HxCY3+82ex6oVgZBIbvI4YJJGzGk?=
 =?iso-8859-1?Q?Dj9pwfTx9QOw2weVKugEdEsXLqpukCY51NC6521j61IL0Fkd2ZkLvnJCYX?=
 =?iso-8859-1?Q?9Wh6tBmoHvZ3fsV5P4i7AgZSP6mEXPCt35D/1504/LOoMD0MXNGeXhn4uk?=
 =?iso-8859-1?Q?ZDAbRN9dT+swLTqyAakRwXB6v4YRt8VjN1Ba86x4QLXF2IW+KY6A3eF5nr?=
 =?iso-8859-1?Q?jsQwOPAuPIkmiixJ3YLxPKPwlcXI+p1WFMxU6ifkhTxz4OPNRS6pVQ32cW?=
 =?iso-8859-1?Q?xxgDIiVxI1tnAdOVQEtbfdUM/tN4ksaxrBcEMEm2tKPWGv+Tq0iEFbsumL?=
 =?iso-8859-1?Q?q57xWNwt/OYtROq4apGY7Q1bxwTGW6aK/4Y+ZIgZN4GzepyRRJqc9j2vvF?=
 =?iso-8859-1?Q?A7ohz8WBPmULf4+ph23gjZaKrVX6Em6JtlqMYUALG+5ZZLsl3/BILQVNNV?=
 =?iso-8859-1?Q?kFx4zyO8V/qHubC7RQTpCS/LXi4XwmsBmMFWBKauraysFbkr/vFwYNpM4a?=
 =?iso-8859-1?Q?+9KCOs1F9X3CsrQaydPYPFzekkc/tZ2vehe+fL+y3CgRIZhz+rVdIGw8OW?=
 =?iso-8859-1?Q?nvHMndpK3zR5VngxjujWd7fQq6gndBGgsK4rXOTe4fFFEa?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: e244ec53-9023-4e73-b0f8-08de966cbfc2
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Apr 2026 19:18:15.0926
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: rinBcc5jaLldt69klgQWioCnEZSHDUPXtXZI/mWqpv+X02+kIh6RbufcrqjCdQXh+Zim63bv970pLQVOY3mAAA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN3PR12MB9571

I was able to reproduce problem locally on Ubuntu 6.19.0+ #64 SMP PREEMPT_R=
T=0A=
=0A=
Tomorrow I will do my best to fix it. I will let you know by the end of day=
 tomorrow about my progress.=0A=
=0A=
Kind Regards,=0A=
Rafal Ostrowski=0A=
________________________________________=0A=
From: Bert Karwatzki <spasswolf@web.de>=0A=
Sent: Thursday, April 9, 2026 3:33 PM=0A=
To: Ostrowski, Rafal <Rafal.Ostrowski@amd.com>=0A=
Cc: Varone, Dillon <Dillon.Varone@amd.com>; spasswolf@web.de <spasswolf@web=
.de>; Hung, Alex <Alex.Hung@amd.com>; Deucher, Alexander <Alexander.Deucher=
@amd.com>; Sebastian Andrzej Siewior <bigeasy@linutronix.de>; Thomas Gleixn=
er <tglx@linutronix.de>; linux-kernel@vger.kernel.org <linux-kernel@vger.ke=
rnel.org>; linux-next@vger.kernel.org <linux-next@vger.kernel.org>; linux-r=
t-devel@lists.linux.dev <linux-rt-devel@lists.linux.dev>; amd-gfx@lists.fre=
edesktop.org <amd-gfx@lists.freedesktop.org>=0A=
Subject: Re: kernel panic when resuming from hibernate in next-20260406 wit=
h PREEMPT_RT=0A=
=0A=
=0A=
[You don't often get email from spasswolf@web.de. Learn why this is importa=
nt at https://aka.ms/LearnAboutSenderIdentification ]=0A=
=0A=
Am Donnerstag, dem 09.04.2026 um 13:30 +0000 schrieb Ostrowski, Rafal:=0A=
>=0A=
>=0A=
>=0A=
> [AMD Official Use Only - AMD Internal Distribution Only]=0A=
>=0A=
> Hi Bert,=0A=
>=0A=
>=0A=
> Sorry that you experience this issue.=0A=
>=0A=
>=0A=
> Do you have all these 3 patches?:=0A=
> "drm/amd/display: Move FPU Guards From DML To DC - Part 1"=0A=
> "drm/amd/display: Move FPU Guards From DML To DC - Part 2"=0A=
> "drm/amd/display: Move FPU Guards From DML To DC - Part 3"=0A=
>=0A=
>=0A=
> These are highly dependent on each other.=0A=
>=0A=
>=0A=
> Kind Regards,=0A=
> Rafal=0A=
>=0A=
=0A=
The crashes also occur when all three patches are applied.=0A=
=0A=
Bert Karwatzki=0A=
=0A=
=0A=
